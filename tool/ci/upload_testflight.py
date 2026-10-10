"""Optional verified production upload; never submit a review or release."""
import base64
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile

ROOT=Path(__file__).resolve().parents[2]

def main():
    if os.environ.get('BUILD_MODE')!='appstore' or os.environ.get('UPLOAD_TO_TESTFLIGHT')!='true':
        raise ValueError('An explicit production TestFlight upload input is required.')
    report=json.loads((ROOT/'verification/app-store-ipa-check.json').read_text())
    if report.get('status')!='PASS' or report.get('distribution')!='APP_STORE_CONNECT' or report.get('sourceCommit')!=os.environ.get('GITHUB_SHA'):
        raise ValueError('The verified IPA must belong to this exact production source.')
    key_id=os.environ.get('IOS_APP_STORE_API_KEY_ID','')
    issuer=os.environ.get('IOS_APP_STORE_ISSUER_ID','')
    if not re.fullmatch(r'[A-Z0-9]{10}',key_id) or not re.fullmatch(r'[0-9a-fA-F-]{36}',issuer):
        raise ValueError('Approved Apple upload identifiers are required.')
    key=base64.b64decode(os.environ.get('IOS_APP_STORE_API_KEY_BASE64',''),validate=True)
    if not key.startswith(b'-----BEGIN PRIVATE KEY-----'):
        raise ValueError('An approved Apple API private key is required.')
    ipa=ROOT/'build/ios/ipa'/report['ipa']
    import hashlib
    if hashlib.sha256(ipa.read_bytes()).hexdigest()!=report['sha256']:
        raise ValueError('The verified IPA changed before upload.')
    with tempfile.TemporaryDirectory(dir=os.environ['RUNNER_TEMP']) as directory:
        path=Path(directory)/('AuthKey_'+key_id+'.p8')
        path.write_bytes(key)
        path.chmod(0o600)
        env={**os.environ,'API_PRIVATE_KEYS_DIR':directory}
        result=subprocess.run(['xcrun','altool','--upload-app','--type','ios','--file',str(ipa),
            '--apiKey',key_id,'--apiIssuer',issuer],env=env,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    (ROOT/'verification/testflight-upload.json').write_text(json.dumps({'commandAccepted':result.returncode==0,
        'processingStillRequiresAppleVerification':True,'reviewSubmitted':False,'released':False},indent=2))
    with (ROOT/'verification/signed-build.log').open('ab') as output:
        output.write(result.stdout)
    if result.returncode:
        raise ValueError('Apple upload was not accepted; inspect encrypted diagnostics.')
    print('Apple accepted the upload command. Processing and TestFlight usability are not yet verified.')

if __name__=='__main__':
    try:
        main()
    except (ValueError,OSError,KeyError,subprocess.CalledProcessError):
        raise SystemExit('TestFlight upload failed; no API credential or raw private response was logged.') from None
