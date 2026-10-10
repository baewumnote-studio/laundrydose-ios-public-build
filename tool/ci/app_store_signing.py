"""Production signing with the verified existing certificate; no Apple API key or upload."""
from datetime import timedelta, timezone
import hashlib, re, sys, subprocess
import adhoc_signing, ios_signing
PROFILE_NAME='Laundry Dose App Store GitHub 20261009'
def validate_profile(profile,now):
    ent=profile.get('Entitlements',{})
    if (profile.get('TeamIdentifier')!=[ios_signing.TEAM]
        or ent.get('com.apple.developer.team-identifier')!=ios_signing.TEAM
        or ent.get('application-identifier')!=ios_signing.TEAM+'.'+ios_signing.BUNDLE
        or profile.get('Name')!=PROFILE_NAME):raise ValueError('Use the verified Laundry Dose App Store profile.')
    if ('ProvisionedDevices' in profile or profile.get('ProvisionsAllDevices') or ent.get('get-task-allow') or ent.get('com.apple.security.application-groups')):raise ValueError('An App Store profile without extensions is required.')
    if not profile.get('ExpirationDate') or profile['ExpirationDate'].replace(tzinfo=timezone.utc)<=now+timedelta(days=1):raise ValueError('Profile expiry is too near.')
    if not re.fullmatch(r'[0-9a-fA-F]{8}(?:-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}',profile.get('UUID','')):raise ValueError('Profile UUID is invalid.')
    certificates=profile.get('DeveloperCertificates',[])
    if len(certificates)!=1 or hashlib.sha256(certificates[0]).hexdigest()!=adhoc_signing.CERTIFICATE_SHA256:raise ValueError('Reuse the approved existing distribution certificate.')
def preflight():
    adhoc_signing.preflight(profile_secret='IOS_RELEASE_APP_STORE_PROFILE_BASE64',profile_validator=validate_profile)
def install():
    ios_signing.install(profile_secret='IOS_RELEASE_APP_STORE_PROFILE_BASE64',profile_validator=validate_profile,preflight=adhoc_signing.check_environment)
if __name__=='__main__':
    try:
        {'preflight':preflight,'install':install,'cleanup':ios_signing.cleanup}[sys.argv[1]]()
    except (ValueError,KeyError,IndexError,OSError,subprocess.CalledProcessError):
        raise SystemExit('App Store signing verification failed. No private signing values are logged.') from None
