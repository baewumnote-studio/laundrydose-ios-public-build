"""Protect signed files with a public recipient; its private key never enters CI."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import tarfile
import tempfile

ROOT = Path(__file__).resolve().parents[2]
RECIPIENT = ROOT/'tool/ci/artifact-recipient.crt'

def encrypt(input_file, output_file, recipient=RECIPIENT):
    subprocess.run([os.environ.get('OPENSSL_EXECUTABLE','openssl'),'cms','-encrypt','-binary',
        '-aes-256-gcm','-in',str(input_file),'-outform','DER','-out',str(output_file),
        '-recip',str(recipient),'-keyopt','rsa_padding_mode:oaep',
        '-keyopt','rsa_oaep_md:sha256'],check=True,capture_output=True)

def main():
    verification=ROOT/'verification'
    verification.mkdir(exist_ok=True)
    candidates=list((ROOT/'build/ios/ipa').glob('*.ipa'))
    candidates += [verification/name for name in ['adhoc-ipa-check.json','app-store-ipa-check.json',
        'app-store-privacy-manifests.json','signed-build.log','signed-build-error.json',
        'original-xcarchive.tar.gz','testflight-upload.json','native-dependencies.json']]
    candidates=[p for p in candidates if p.is_file()]
    if not candidates:
        raise ValueError('No signed output or diagnostic file exists to protect.')
    temporary_root=Path(os.environ.get('RUNNER_TEMP',str(verification)))
    with tempfile.TemporaryDirectory(dir=temporary_root) as directory:
        payload=Path(directory)/'private-output.tar.gz'
        with tarfile.open(payload,'w:gz') as archive:
            for path in candidates:
                if path.is_symlink() or not path.resolve().is_relative_to(ROOT.resolve()):
                    raise ValueError('Unexpected private output path.')
                archive.add(path,arcname=path.relative_to(ROOT).as_posix(),recursive=False)
        output=verification/'private-build.cms'
        encrypt(payload,output)
    receipt={'encrypted':True,'encryption':'CMS AES-256-GCM with RSA-OAEP SHA-256',
             'sourceCommit':os.environ.get('GITHUB_SHA'),
             'ciphertextSha256':hashlib.sha256(output.read_bytes()).hexdigest(),
             'decryptionPrivateKeyPresentInCI':False}
    (verification/'encrypted-output-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print('Signed outputs encrypted. Only ciphertext and its receipt may be uploaded.')

if __name__=='__main__':
    try:
        main()
    except (ValueError,OSError,subprocess.CalledProcessError):
        raise SystemExit('Artifact protection failed; do not upload any plaintext signed output.') from None
