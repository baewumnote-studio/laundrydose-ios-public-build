"""Verify the downloaded IPA before installing it on the recorded physical iPhone."""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import plistlib
import subprocess
import sys
import zipfile

sys.path.insert(0, str(Path(__file__).resolve().parent / 'ci'))
from adhoc_signing import BUNDLE, CERTIFICATE_SHA256, validate_profile

ROOT = Path(__file__).resolve().parents[1]
TOOLS = ROOT.parent / 'gollabom_app/assembly/tmp/iphone-tools/bin'


def validate_ipa(ipa, report, device, openssl):
    if (report.get('status') != 'PASS' or report.get('codesignVerification') != 'PASS'
            or report.get('bundleId') != BUNDLE
            or report.get('distribution') != 'AD_HOC_SINGLE_REGISTERED_IPHONE'
            or report.get('actualCertificateSha256') != CERTIFICATE_SHA256
            or report.get('sha256') != hashlib.sha256(ipa.read_bytes()).hexdigest()):
        raise ValueError('The downloaded IPA must match the successful Mac signature report.')
    with zipfile.ZipFile(ipa) as archive:
        infos = [name for name in archive.namelist() if name.startswith('Payload/')
                 and name.endswith('.app/Info.plist') and name.count('/') == 2]
        if len(infos) != 1 or any('.appex/' in name for name in archive.namelist()):
            raise ValueError('Expected only the Laundry Dose app.')
        info = plistlib.loads(archive.read(infos[0]))
        if (info.get('CFBundleIdentifier') != BUNDLE
                or info.get('CFBundleShortVersionString') != report.get('version')
                or info.get('CFBundleVersion') != report.get('build')
                or info.get('GADApplicationIdentifier') != 'ca-app-pub-3940256099942544~1458002511'):
            raise ValueError('Downloaded app metadata or sample ads differ.')
        data = archive.read(infos[0].removesuffix('Info.plist') + 'embedded.mobileprovision')
        decoded = subprocess.run([str(openssl), 'cms', '-verify', '-noverify', '-inform', 'DER'],
                                 input=data, check=True, capture_output=True).stdout
        profile = plistlib.loads(decoded)
        validate_profile(profile, datetime.now(timezone.utc), device['udid'])
        if profile['UUID'] != report.get('profileUuid'):
            raise ValueError('Downloaded app profile differs from the Mac verification report.')


def run_installer(ipa, udid, tools):
    if not ipa.name.isascii():
        raise ValueError('The prepared installer needs an ASCII IPA filename.')
    # The verified 1.1.1 Windows binary accepts -i and fails on Korean absolute
    # file paths. Relative ASCII filenames preserve the original IPA in place.
    return subprocess.run([str(tools.resolve() / 'ideviceinstaller.exe'), '-u', udid, '-i', ipa.name],
                          cwd=ipa.resolve().parent, capture_output=True, text=True,
                          encoding='utf-8', errors='replace', timeout=180)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--ipa', required=True, type=Path)
    parser.add_argument('--report', required=True, type=Path)
    parser.add_argument('--device-file', type=Path, default=ROOT / '.temp/direct-iphone/iphone-device.json')
    parser.add_argument('--tools', type=Path, default=TOOLS)
    parser.add_argument('--check-only', action='store_true')
    args = parser.parse_args()
    device = json.loads(args.device_file.read_text(encoding='utf-8-sig'))
    if device.get('trustedSessionVerified') is not True:
        raise ValueError('A real trusted Apple device session is required.')
    report = json.loads(args.report.read_text())
    validate_ipa(args.ipa, report, device, args.tools / 'openssl.exe')
    print('IPA integrity, app metadata, certificate and single-device profile passed.')
    if args.check_only:
        return
    udid = device['udid']
    devices = subprocess.run([str(args.tools / 'idevice_id.exe'), '-l'], check=True,
                             capture_output=True, text=True, timeout=20).stdout.splitlines()
    if len(devices) != 1 or devices[0].strip().upper() != udid.upper():
        raise ValueError('The live phone differs from the recorded device.')
    result = run_installer(args.ipa, udid, args.tools)
    output = result.stdout + result.stderr
    destination = ROOT / '.temp/direct-iphone'
    (destination / 'install.log').write_text(output, encoding='utf-8')
    evidence = {'checkedAtUtc': datetime.now(timezone.utc).isoformat(),
                'installation': 'COMMAND_SUCCESS' if result.returncode == 0 else 'FAILED',
                'returnCode': result.returncode, 'appLaunch': 'NOT_VERIFIED',
                'functionalTest': 'NOT_VERIFIED', 'existingAppDeleted': False}
    (ROOT / 'verification/direct-iphone-install.json').write_text(json.dumps(evidence, indent=2))
    print(output.replace(udid, '<registered iPhone>')[-2500:])
    if result.returncode:
        raise ValueError('Installation failed; the error has been preserved.')
    print('Installation command succeeded. App launch and functional checks still require the iPhone.')


if __name__ == '__main__':
    try:
        main()
    except (ValueError, KeyError, OSError, zipfile.BadZipFile,
            subprocess.CalledProcessError, subprocess.TimeoutExpired):
        raise SystemExit('Direct iPhone installation failed. Existing apps were not deleted.') from None
