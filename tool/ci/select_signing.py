"""Select the existing signing validators, without replacing their checks."""
import os
import sys
import adhoc_signing
import app_store_signing

if __name__=='__main__':
    try:
        mode=os.environ.get('BUILD_MODE','')
        operation=sys.argv[1]
        if mode not in {'adhoc','appstore'} or operation not in {'preflight','install'}:
            raise ValueError('Invalid signed mode or operation.')
        module=adhoc_signing if mode=='adhoc' else app_store_signing
        getattr(module,operation)()
    except Exception:
        raise SystemExit('Approved signing identity or profile verification failed. No secret was logged.') from None
