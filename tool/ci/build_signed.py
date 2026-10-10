"""Build and verify a signed app while retaining raw diagnostics privately."""
import json
import os
from pathlib import Path
import subprocess
import sys
import tarfile

ROOT=Path(__file__).resolve().parents[2]

def command(args, output):
    result=subprocess.run(args,cwd=ROOT,stdout=output,stderr=subprocess.STDOUT)
    if result.returncode:
        raise ValueError('A signed-build operation failed; encrypted diagnostics will retain its output.')

def main():
    mode=os.environ['BUILD_MODE']
    if mode not in {'adhoc','appstore'}:
        raise ValueError('Only signed distribution modes are allowed.')
    verification=ROOT/'verification'
    verification.mkdir(exist_ok=True)
    with (verification/'signed-build.log').open('wb') as output:
        args=['flutter','build','ipa','--release','--no-pub',
              '--build-number='+os.environ['PROJECT_BUILD_NUMBER'],
              '--export-options-plist='+str(Path(os.environ['RUNNER_TEMP'])/'laundry-dose-signing/ExportOptions.plist')]
        args += ['--dart-define-from-file=deployment/dart_defines.release.json'] if mode=='appstore' else ['--dart-define=LAUNDRY_DOSE_TEST_ADS=true']
        command(args,output)
        with tarfile.open(verification/'original-xcarchive.tar.gz','w:gz') as archive:
            archive.add(ROOT/'build/ios/archive/Runner.xcarchive',arcname='Runner.xcarchive')
        check='check_app_store_ipa.py' if mode=='appstore' else 'check_adhoc_ipa.py'
        command([sys.executable,'tool/ci/'+check],output)
    print('Signed IPA, original archive and signature verification completed. Raw diagnostics remain private.')

if __name__=='__main__':
    try:
        main()
    except (ValueError,OSError,KeyError,subprocess.CalledProcessError):
        (ROOT/'verification/signed-build-error.json').write_text(json.dumps({'status':'FAIL','rawDetails':'signed-build.log'}))
        raise SystemExit('Signed build failed. Review the encrypted diagnostics before retrying.') from None
