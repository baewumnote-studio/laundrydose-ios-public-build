"""Ensure the app snapshot stays unchanged during build preparation."""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

def main():
    files = json.loads((ROOT/'deployment/PUBLIC_APP_BASELINE.json').read_text())['files']
    changed = [name for name,digest in files.items()
               if not (ROOT/name).is_file() or hashlib.sha256((ROOT/name).read_bytes()).hexdigest()!=digest]
    if changed:
        raise ValueError('Preserved app snapshot changed: '+', '.join(changed))
    print(f'Unchanged app snapshot: {len(files)} files passed.')

if __name__=='__main__':
    main()
