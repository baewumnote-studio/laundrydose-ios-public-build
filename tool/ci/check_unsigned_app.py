#!/usr/bin/env python3
"""Record compile evidence without claiming an installable or signed beta."""
from pathlib import Path
import json
import os
import plistlib

root = Path(__file__).resolve().parents[2]
app = root / 'build/ios/iphoneos/Runner.app'
info = plistlib.loads((app / 'Info.plist').read_bytes())
assert info['CFBundleIdentifier'] == 'com.healthmanagementprepare.laundrydose'
assert info['GADApplicationIdentifier'] == 'ca-app-pub-3940256099942544~1458002511'
assert info['ITSAppUsesNonExemptEncryption'] is False
assert (app / info['CFBundleExecutable']).is_file()
assert (app / 'Assets.car').is_file()
assert (app / 'PrivacyInfo.xcprivacy').is_file()
result = {
    'status': 'PASS', 'nativeCompilation': 'RELEASE_NO_CODESIGN',
    'sourceCommit': os.environ.get('GITHUB_SHA'), 'bundleId': info['CFBundleIdentifier'],
    'signedIPA': 'NOT_BUILT', 'testFlightUpload': 'NOT_UPLOADED',
    'actualIPhoneTest': 'NOT_RUN', 'installableOnIPhone': False,
}
out = root / 'verification/ios-compile-check.json'
out.parent.mkdir(exist_ok=True)
out.write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
print(json.dumps(result, indent=2))
