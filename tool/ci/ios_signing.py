#!/usr/bin/env python3
"""Install an existing distribution identity on an ephemeral GitHub Mac runner."""
import base64
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import plistlib
import re
import secrets
import shlex
import subprocess
import sys

from testflight_gate import check_environment

TEAM = '39762JRYD4'
BUNDLE = 'com.healthmanagementprepare.laundrydose'
PROFILE_NAME = 'Laundry Dose App Store'
ROOT = Path(__file__).resolve().parents[2]


def validate_profile(profile, now):
    entitlements = profile.get('Entitlements', {})
    if profile.get('TeamIdentifier') != [TEAM]:
        raise ValueError('Profile belongs to a different Apple team.')
    if entitlements.get('application-identifier') != f'{TEAM}.{BUNDLE}':
        raise ValueError('Profile belongs to a different application.')
    if profile.get('Name') != PROFILE_NAME:
        raise ValueError('Use the existing Laundry Dose App Store profile.')
    if ('ProvisionedDevices' in profile or profile.get('ProvisionsAllDevices')
            or entitlements.get('get-task-allow', False)):
        raise ValueError('An App Store distribution profile is required.')
    expiration = profile.get('ExpirationDate')
    if not isinstance(expiration, datetime):
        raise ValueError('Profile expiration is missing.')
    if expiration.replace(tzinfo=timezone.utc) <= now:
        raise ValueError('Profile has expired.')
    if not re.fullmatch(r'[0-9A-Fa-f]{8}(?:-[0-9A-Fa-f]{4}){3}-[0-9A-Fa-f]{12}',
                        profile.get('UUID', '')):
        raise ValueError('Profile UUID is invalid.')
    if not profile.get('DeveloperCertificates'):
        raise ValueError('Profile contains no distribution certificates.')


def configure_project(text, profile_name):
    if not re.fullmatch(r'[A-Za-z0-9 ._-]+', profile_name):
        raise ValueError('Unexpected profile name.')
    count = 0

    def update(match):
        nonlocal count
        body = match.group(1)
        if f'PRODUCT_BUNDLE_IDENTIFIER = {BUNDLE};' not in body:
            return match.group(0)
        count += 1
        for setting in ['CODE_SIGN_STYLE', 'DEVELOPMENT_TEAM', 'PROVISIONING_PROFILE_SPECIFIER',
                        'CODE_SIGN_IDENTITY', '"CODE_SIGN_IDENTITY[sdk=iphoneos*]"']:
            body = re.sub(r'\n[ \t]*' + re.escape(setting) + r'[ \t]*=[^;]*;', '', body)
        body = body.rstrip()
        body += (f'\n\t\t\t\tCODE_SIGN_STYLE = Manual;'
                 f'\n\t\t\t\tDEVELOPMENT_TEAM = {TEAM};'
                 f'\n\t\t\t\tPROVISIONING_PROFILE_SPECIFIER = "{profile_name}";'
                 '\n\t\t\t\tCODE_SIGN_IDENTITY = "Apple Distribution";'
                 '\n\t\t\t\t"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "Apple Distribution";\n\t\t\t')
        return 'buildSettings = {' + body + '};'

    result = re.sub(r'buildSettings = \{(.*?)\};', update, text, flags=re.DOTALL)
    if count != 3:
        raise ValueError(f'Expected three Runner configurations, found {count}.')
    return result


def command(args):
    return subprocess.run(args, check=True, capture_output=True).stdout


def private_write(path, content):
    path.write_bytes(content)
    path.chmod(0o600)


def decode_secret(name):
    value = os.environ.get(name, '')
    if not value:
        raise ValueError(f'Missing encrypted repository secret: {name}')
    try:
        return base64.b64decode(value, validate=True)
    except ValueError:
        raise ValueError(f'Invalid base64 in repository secret: {name}') from None


def runner_directory():
    if sys.platform != 'darwin' or os.environ.get('RUNNER_ENVIRONMENT') != 'github-hosted':
        raise ValueError('Signing setup is only supported on an ephemeral GitHub Mac runner.')
    return Path(os.environ['RUNNER_TEMP']) / 'laundry-dose-signing'


def install(*, profile_secret='IOS_APP_STORE_PROFILE_BASE64',
            profile_validator=validate_profile, export_method='app-store-connect',
            preflight=check_environment):
    preflight()
    directory = runner_directory()
    directory.mkdir(mode=0o700)
    certificate = directory / 'distribution.p12'
    profile_file = directory / 'LaundryDose.mobileprovision'
    private_write(certificate, decode_secret('IOS_DISTRIBUTION_P12_BASE64'))
    private_write(profile_file, decode_secret(profile_secret))
    password = os.environ.get('IOS_DISTRIBUTION_P12_PASSWORD', '')
    if not password:
        raise ValueError('A password-protected distribution P12 is required.')
    profile = plistlib.loads(command(['security', 'cms', '-D', '-i', str(profile_file)]))
    profile_validator(profile, datetime.now(timezone.utc))
    keychain = directory / 'laundry-dose.keychain-db'
    previous_keychains = shlex.split(command(['security', 'list-keychains', '-d', 'user']).decode())
    destinations = [
        Path.home() / 'Library/MobileDevice/Provisioning Profiles' / f"{profile['UUID']}.mobileprovision",
        Path.home() / 'Library/Developer/Xcode/UserData/Provisioning Profiles' / f"{profile['UUID']}.mobileprovision",
    ]
    for destination in destinations:
        if destination.exists():
            raise ValueError('Refusing to overwrite a pre-existing provisioning profile.')
    state = {'keychain': str(keychain), 'previousKeychains': previous_keychains,
             'installedProfiles': [str(p) for p in destinations]}
    private_write(directory / 'cleanup.json', json.dumps(state).encode())
    keychain_password = secrets.token_urlsafe(32)
    command(['security', 'create-keychain', '-p', keychain_password, str(keychain)])
    command(['security', 'set-keychain-settings', '-lut', '3600', str(keychain)])
    command(['security', 'unlock-keychain', '-p', keychain_password, str(keychain)])
    command(['security', 'import', str(certificate), '-P', password, '-A', '-t', 'cert',
             '-f', 'pkcs12', '-k', str(keychain)])
    certificate.unlink()
    command(['security', 'set-key-partition-list', '-S', 'apple-tool:,apple:', '-k',
             keychain_password, str(keychain)])
    command(['security', 'list-keychains', '-d', 'user', '-s', str(keychain), *previous_keychains])
    identities = command(['security', 'find-identity', '-v', '-p', 'codesigning', str(keychain)]).decode()
    fingerprints = [hashlib.sha1(cert).hexdigest().upper() for cert in profile['DeveloperCertificates']]
    if not any(fingerprint in identities for fingerprint in fingerprints):
        raise ValueError('Imported private signing identity does not match the profile certificate.')
    for destination in destinations:
        destination.parent.mkdir(parents=True, exist_ok=True)
        private_write(destination, profile_file.read_bytes())
    project = ROOT / 'ios/Runner.xcodeproj/project.pbxproj'
    project.write_text(configure_project(project.read_text(encoding='utf-8'), profile['Name']),
                       encoding='utf-8')
    export_options = {
        'method': export_method, 'teamID': TEAM, 'signingStyle': 'manual',
        'signingCertificate': 'Apple Distribution',
        'provisioningProfiles': {BUNDLE: profile['Name']},
        'manageAppVersionAndBuildNumber': False, 'uploadSymbols': export_method == 'app-store-connect',
        'destination': 'export',
    }
    private_write(directory / 'ExportOptions.plist', plistlib.dumps(export_options))
    print('Existing distribution identity and matching distribution profile installed.')


def cleanup():
    directory = runner_directory()
    state_file = directory / 'cleanup.json'
    if state_file.exists():
        state = json.loads(state_file.read_text(encoding='utf-8'))
        command(['security', 'list-keychains', '-d', 'user', '-s', *state['previousKeychains']])
        keychain = directory / 'laundry-dose.keychain-db'
        if keychain.exists():
            command(['security', 'delete-keychain', str(keychain)])
        for value in state['installedProfiles']:
            path = Path(value)
            allowed_parents = [Path.home() / 'Library/MobileDevice/Provisioning Profiles',
                               Path.home() / 'Library/Developer/Xcode/UserData/Provisioning Profiles']
            if path.parent not in allowed_parents or path.suffix != '.mobileprovision':
                raise ValueError('Unexpected cleanup profile path.')
            path.unlink(missing_ok=True)
    for name in ['distribution.p12', 'LaundryDose.mobileprovision', 'cleanup.json', 'ExportOptions.plist']:
        (directory / name).unlink(missing_ok=True)
    print('Temporary signing assets removed.')


if __name__ == '__main__':
    if len(sys.argv) != 2 or sys.argv[1] not in {'install', 'cleanup'}:
        raise SystemExit('Usage: ios_signing.py install|cleanup')
    try:
        install() if sys.argv[1] == 'install' else cleanup()
    except subprocess.CalledProcessError as error:
        # Never echo security command arguments (they contain P12/keychain passwords).
        raise SystemExit(f'Apple signing utility failed with exit code {error.returncode}.') from None
