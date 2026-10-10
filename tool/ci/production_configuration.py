"""Validate the actual Laundry Dose production values and generate build inputs."""
import json, re, sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
def validate():
    values=json.loads((ROOT/'deployment/PRODUCTION_VALUES.json').read_text())
    assert values['ios_bundle_id']=='com.healthmanagementprepare.laundrydose'
    assert values['ios_deployment_target']=='15.0'
    assert values['app_store_id']=='6820179086'
    for name,pattern in [('admob_app_id_ios',r'ca-app-pub-9507165963073699~3173377027'),('admob_interstitial_id_ios',r'ca-app-pub-9507165963073699/6572642545')]:
        if not re.fullmatch(pattern,values.get(name,'')):raise ValueError('Use the actual Laundry Dose AdMob registration.')
    base='https://laundry-dose-support.kjo25400.chatgpt.site'
    for name,ending in [('marketing_url',''),('privacy_policy_url','/privacy.html'),('support_url','/support.html')]:
        if values.get(name)!=base+ending:raise ValueError('Use the approved published Laundry Dose website.')
    if values['support_email']!='healthmanagementprepare@gmail.com':raise ValueError('Use the approved public support contact.')
    return values
def configure():
    values=validate()
    (ROOT/'deployment/DEPLOYMENT_CONFIG.json').write_text(json.dumps(values,indent=2)+'\n')
    defines={'LAUNDRY_DOSE_TEST_ADS':False,'ADMOB_IOS_INTERSTITIAL_ID':values['admob_interstitial_id_ios'],
             'PRIVACY_POLICY_URL':values['privacy_policy_url'],'SUPPORT_URL':values['support_url'],'SUPPORT_EMAIL':values['support_email']}
    (ROOT/'deployment/dart_defines.release.json').write_text(json.dumps(defines,indent=2)+'\n')
    (ROOT/'ios/Flutter/Deployment.release.xcconfig').write_text('GAD_APPLICATION_IDENTIFIER='+values['admob_app_id_ios']+'\n')
    print('Validated Laundry Dose production advertising and approved public contact URLs.')
if __name__=='__main__':
    configure() if len(sys.argv)==2 and sys.argv[1]=='configure' else validate()
