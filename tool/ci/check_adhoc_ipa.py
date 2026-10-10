"""Verify the exported app signature on macOS and record a download integrity check."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import plistlib
import re
import subprocess
import tempfile

from adhoc_signing import BUNDLE, TEAM, CERTIFICATE_SHA256, validate_profile

ROOT = Path(__file__).resolve().parents[2]


def main(*, profile_validator=validate_profile,
         ad_app_id='ca-app-pub-3940256099942544~1458002511',
         distribution='AD_HOC_SINGLE_REGISTERED_IPHONE',
         report_file='adhoc-ipa-check.json', ad_mode='GOOGLE_SAMPLE_IDS'):
    ipas = list((ROOT / 'build/ios/ipa').glob('*.ipa'))
    if len(ipas) != 1:
        raise ValueError('Expected exactly one exported IPA.')
    ipa = ipas[0]
    with tempfile.TemporaryDirectory() as directory:
        subprocess.run(['ditto', '-x', '-k', str(ipa), directory], check=True, capture_output=True)
        apps = list((Path(directory) / 'Payload').glob('*.app'))
        if len(apps) != 1 or list(apps[0].glob('PlugIns/*.appex')):
            raise ValueError('Laundry Dose must contain one app with no extension.')
        app = apps[0]
        info = plistlib.loads((app / 'Info.plist').read_bytes())
        expected = {'CFBundleIdentifier': BUNDLE, 'CFBundleShortVersionString': '1.0.0',
                    'CFBundleVersion': os.environ['PROJECT_BUILD_NUMBER'],
                    'GADApplicationIdentifier': ad_app_id,
                    'ITSAppUsesNonExemptEncryption': False, 'MinimumOSVersion': '15.0'}
        if any(info.get(k) != v for k, v in expected.items()):
            raise ValueError('IPA app, version, OS or sample ad configuration differs.')
        for name in ('Assets.car', 'PrivacyInfo.xcprivacy'):
            if not (app / name).is_file():
                raise ValueError('Compiled assets or privacy manifest is missing.')
        if not info.get('NSCameraUsageDescription') or not info.get('NSPhotoLibraryUsageDescription'):
            raise ValueError('The camera and photo permission explanations are required.')
        subprocess.run(['codesign', '--verify', '--deep', '--strict', str(app)],
                       check=True, capture_output=True)
        result = subprocess.run(['codesign', '-d', '--entitlements', ':-', str(app)],
                                check=True, capture_output=True)
        entitlements = plistlib.loads(result.stdout)
        if (entitlements.get('application-identifier') != f'{TEAM}.{BUNDLE}'
                or entitlements.get('com.apple.developer.team-identifier') != TEAM
                or entitlements.get('get-task-allow', False)):
            raise ValueError('Exported signing entitlements differ from the reviewed application.')
        decoded = subprocess.run(['security', 'cms', '-D', '-i', str(app / 'embedded.mobileprovision')],
                                 check=True, capture_output=True).stdout
        profile = plistlib.loads(decoded)
        profile_validator(profile, datetime.now(timezone.utc))
        prefix = str(Path(directory) / 'actual-signing-certificate')
        subprocess.run(['codesign', '-d', f'--extract-certificates={prefix}', str(app)],
                       check=True, capture_output=True)
        certificate = Path(prefix + '0').read_bytes()
        if hashlib.sha256(certificate).hexdigest() != CERTIFICATE_SHA256:
            raise ValueError('The actual IPA signer is not the approved existing certificate.')
        report = {'status': 'PASS', 'distribution': distribution,
                  'ipa': ipa.name, 'sha256': hashlib.sha256(ipa.read_bytes()).hexdigest(),
                  'sizeBytes': ipa.stat().st_size, 'bundleId': BUNDLE, 'teamId': TEAM,
                  'version': '1.0.0', 'build': os.environ['PROJECT_BUILD_NUMBER'],
                  'sourceCommit': os.environ.get('GITHUB_SHA'),
                  'actualCertificateSha256': CERTIFICATE_SHA256,
                  'profileName': profile['Name'], 'profileUuid': profile['UUID'],
                  'profileExpires': profile['ExpirationDate'].isoformat(),
                  'singleDeviceVerified': distribution == 'AD_HOC_SINGLE_REGISTERED_IPHONE', 'codesignVerification': 'PASS',
                  'adMode': ad_mode, 'installation': 'NOT_RUN', 'appLaunch': 'NOT_RUN'}
        if distribution == 'APP_STORE_CONNECT':
            manifests = {p.relative_to(app).as_posix(): plistlib.loads(p.read_bytes())
                         for p in app.rglob('PrivacyInfo.xcprivacy')}
            (ROOT / 'verification/app-store-privacy-manifests.json').write_text(json.dumps(manifests, indent=2))
    (ROOT / ('verification/' + report_file)).write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    try:
        main()
    except (ValueError, KeyError, OSError, subprocess.CalledProcessError) as error:
        # Report the failed check while retaining secrets only in GitHub's encrypted store.
        detail = str(error) if isinstance(error, ValueError) else type(error).__name__
        if isinstance(error, subprocess.CalledProcessError):
            detail += ': ' + error.stderr.decode('utf-8', 'replace')[-2000:]
        detail = re.sub(r'\b[a-fA-F0-9]{8}-[a-fA-F0-9]{16}\b', '<device identifier>', detail)
        for name in ('IOS_ADHOC_DEVICE_UDID', 'IOS_DISTRIBUTION_P12_PASSWORD'):
            if os.environ.get(name):
                detail = detail.replace(os.environ[name], '<private value>')
        report = {'status': 'FAIL', 'checkFailure': detail, 'installation': 'NOT_RUN'}
        (ROOT / 'verification/adhoc-verify-failure.json').write_text(json.dumps(report, indent=2))
        raise SystemExit('Exported IPA verification failed: ' + detail) from None
