"""Single-device Ad Hoc validation, with no App Store or TestFlight upload."""
from datetime import datetime, timezone, timedelta
import hashlib
import os
import plistlib
import re
import subprocess
import sys

import ios_signing
from testflight_gate import NOT_BEFORE

TEAM = ios_signing.TEAM
BUNDLE = ios_signing.BUNDLE
PROFILE_NAME = 'Laundry Dose AdHoc iPhone 20261009'
CERTIFICATE_SHA256 = 'faa9fe5ba226b207869a5070716bfb41aa9b95f250c374a4ddffbcb996c981fc'


def check_environment():
    if datetime.now(timezone.utc) < NOT_BEFORE:
        raise ValueError('The Apple account hold has not ended.')
    if os.environ.get('GITHUB_REF') != 'refs/heads/main':
        raise ValueError('Use the reviewed main branch.')
    if not re.fullmatch(r'[1-9][0-9]{0,5}', os.environ.get('PROJECT_BUILD_NUMBER', '')):
        raise ValueError('A positive build number is required.')


def validate_profile(profile, now, udid=None):
    udid = udid or os.environ.get('IOS_ADHOC_DEVICE_UDID', '')
    if not re.fullmatch(r'(?:[a-fA-F0-9]{40}|[a-fA-F0-9]{8}-[a-fA-F0-9]{16})', udid):
        raise ValueError('A verified physical device identifier is required.')
    entitlements = profile.get('Entitlements', {})
    if (profile.get('TeamIdentifier') != [TEAM]
            or entitlements.get('com.apple.developer.team-identifier') != TEAM
            or entitlements.get('application-identifier') != f'{TEAM}.{BUNDLE}'):
        raise ValueError('The profile must belong to Laundry Dose and its Apple team.')
    if profile.get('Name') != PROFILE_NAME:
        raise ValueError('Use the Laundry Dose direct-install profile.')
    devices = profile.get('ProvisionedDevices', [])
    if (len(devices) != 1 or devices[0].upper() != udid.upper()
            or profile.get('ProvisionsAllDevices') or entitlements.get('get-task-allow', False)):
        raise ValueError('Only the selected single-device Ad Hoc profile is allowed.')
    if entitlements.get('com.apple.security.application-groups'):
        raise ValueError('Laundry Dose has no App Group or sharing extension.')
    expiry = profile.get('ExpirationDate')
    if not isinstance(expiry, datetime) or expiry.replace(tzinfo=timezone.utc) <= now + timedelta(days=1):
        raise ValueError('The profile must remain valid for at least one day.')
    if not re.fullmatch(r'[0-9A-Fa-f]{8}(?:-[0-9A-Fa-f]{4}){3}-[0-9A-Fa-f]{12}', profile.get('UUID', '')):
        raise ValueError('The profile UUID is invalid.')
    certificates = profile.get('DeveloperCertificates', [])
    if len(certificates) != 1 or hashlib.sha256(certificates[0]).hexdigest() != CERTIFICATE_SHA256:
        raise ValueError('Reuse the checked existing distribution certificate.')


def openssl(args, *, data=None, cwd=None):
    return subprocess.run([os.environ.get('OPENSSL_EXECUTABLE', 'openssl'), *args],
                          input=data, cwd=cwd, check=True, capture_output=True).stdout


def decode_profile(data):
    # This validates the content signature. Trust is restricted by the exact
    # reviewed certificate fingerprint, team, app and device checks above.
    return plistlib.loads(openssl(['cms', '-verify', '-noverify', '-inform', 'DER'], data=data))


def preflight(*, profile_secret='IOS_ADHOC_PROFILE_BASE64', profile_validator=validate_profile):
    check_environment()
    # Keep private-key material in process memory, never in plaintext files.
    raw_profile = ios_signing.decode_secret(profile_secret)
    profile = decode_profile(raw_profile)
    profile_validator(profile, datetime.now(timezone.utc))
    p12 = ios_signing.decode_secret('IOS_DISTRIBUTION_P12_BASE64')
    if not os.environ.get('IOS_DISTRIBUTION_P12_PASSWORD'):
        raise ValueError('The existing certificate password is required.')
    arguments = ['pkcs12', '-passin', 'env:IOS_DISTRIBUTION_P12_PASSWORD']
    try:
        certificate = openssl([*arguments, '-clcerts', '-nokeys'], data=p12)
    except subprocess.CalledProcessError:
        arguments.append('-legacy')
        certificate = openssl([*arguments, '-clcerts', '-nokeys'], data=p12)
    private_key = openssl([*arguments, '-nocerts', '-nodes'], data=p12)
    certificate_der = openssl(['x509', '-outform', 'DER'], data=certificate)
    if (hashlib.sha256(certificate_der).hexdigest() != CERTIFICATE_SHA256
            or certificate_der not in profile['DeveloperCertificates']):
        raise ValueError('The P12 certificate must match the profile and reviewed certificate.')
    openssl(['x509', '-checkend', '86400', '-noout'], data=certificate)
    public_pem = openssl(['x509', '-pubkey', '-noout'], data=certificate)
    public_der = openssl(['pkey', '-pubin', '-outform', 'DER'], data=public_pem)
    private_public = openssl(['pkey', '-pubout', '-outform', 'DER'], data=private_key)
    if public_der != private_public:
        raise ValueError('The P12 private key must match its certificate.')
    print('CMS signature, existing private key/certificate and Laundry Dose distribution profile passed.')


def install():
    ios_signing.install(profile_secret='IOS_ADHOC_PROFILE_BASE64',
                        profile_validator=validate_profile, export_method='ad-hoc',
                        preflight=check_environment)


if __name__ == '__main__':
    try:
        operation = sys.argv[1] if len(sys.argv) == 2 else ''
        if operation not in {'preflight', 'install', 'cleanup'}:
            raise ValueError('Usage: adhoc_signing.py preflight|install|cleanup')
        {'preflight': preflight, 'install': install, 'cleanup': ios_signing.cleanup}[operation]()
    except (ValueError, KeyError, OSError, subprocess.CalledProcessError):
        raise SystemExit('Direct-install signing check failed; no secret values are logged.') from None
