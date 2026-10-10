"""Check the publication allowlist and exact reviewed file bytes."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]

def main():
    manifest = json.loads((ROOT/'PUBLIC_FILE_MANIFEST.json').read_text())
    expected = manifest['files']
    changed = [name for name,item in expected.items()
               if not (ROOT/name).is_file() or hashlib.sha256((ROOT/name).read_bytes()).hexdigest()!=item['sha256']]
    if changed:
        raise ValueError('Reviewed publication file changed: '+', '.join(changed))
    tracked = set(subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0'))-{''}
    if tracked != set(expected)|{'PUBLIC_FILE_MANIFEST.json'}:
        raise ValueError('Tracked files differ from the exact publication allowlist.')
    print(f'Reviewed public allowlist: {len(tracked)} files passed.')

if __name__=='__main__':
    main()
