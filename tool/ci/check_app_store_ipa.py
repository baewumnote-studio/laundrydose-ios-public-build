"""Verify production IPA metadata, codesign and actual certificate without uploading."""
import subprocess
import check_adhoc_ipa
from app_store_signing import validate_profile
from production_configuration import validate
if __name__=='__main__':
    try:
        config=validate()
        check_adhoc_ipa.main(profile_validator=validate_profile,ad_app_id=config['admob_app_id_ios'],
            distribution='APP_STORE_CONNECT',report_file='app-store-ipa-check.json',ad_mode='LAUNDRY_DOSE_PRODUCTION_IDS')
    except (ValueError,KeyError,OSError,subprocess.CalledProcessError):
        raise SystemExit('Production IPA verification failed. Do not upload this file.') from None
