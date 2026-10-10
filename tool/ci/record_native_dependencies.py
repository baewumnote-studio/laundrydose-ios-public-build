"""Record actual native versions from this build for the final privacy review."""
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
lock=ROOT/'ios/Podfile.lock'
if not lock.is_file():
    raise SystemExit('The resolved native dependency lockfile is required.')
lines=lock.read_text().splitlines()
pods=[]
for line in lines:
    if line=='DEPENDENCIES:':
        break
    if line.startswith('  - '):
        pods.append(line[4:].rstrip(':'))
(ROOT/'verification/native-dependencies.json').write_text(json.dumps({'resolvedPods':pods},indent=2)+'\n')
print('Recorded actual native SDK dependency versions for release review.')
