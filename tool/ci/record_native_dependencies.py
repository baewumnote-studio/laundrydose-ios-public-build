"""Record CocoaPods, Swift packages and embedded SDK privacy manifests."""
import json
from pathlib import Path
import plistlib


def read_pods(lock):
    if not lock.is_file():
        return []
    pods=[]
    for line in lock.read_text().splitlines():
        if line=='DEPENDENCIES:':
            break
        if line.startswith('  - '):
            pods.append(line[4:].rstrip(':'))
    return pods


def read_swift_resolutions(root):
    packages={}
    for folder in (root/'ios',root/'build'):
        if not folder.exists():
            continue
        for path in sorted(folder.rglob('Package.resolved')):
            resolved=json.loads(path.read_text())
            pins=resolved.get('pins',resolved.get('object',{}).get('pins',[]))
            for pin in pins:
                identity=pin.get('identity',pin.get('package',''))
                state=pin.get('state',{})
                version=state.get('version')
                revision=state.get('revision')
                if identity:
                    key=(identity,version,revision)
                    packages[key]={'identity':identity,'version':version,'revision':revision}
    return sorted(packages.values(),key=lambda row:(row['identity'],row['version'] or '',row['revision'] or ''))


def read_frameworks(app):
    frameworks=[]
    for framework in sorted((app/'Frameworks').glob('*.framework')):
        info_path=framework/'Info.plist'
        if not info_path.is_file():
            continue
        info=plistlib.loads(info_path.read_bytes())
        row={'name':framework.stem,'version':info.get('CFBundleShortVersionString'),
             'buildVersion':info.get('CFBundleVersion')}
        privacy=framework/'PrivacyInfo.xcprivacy'
        if privacy.is_file():
            row['privacyManifest']=plistlib.loads(privacy.read_bytes())
        frameworks.append(row)
    return frameworks


def require_ad_sdk_evidence(packages,frameworks):
    for framework_name,package_fragment in (
        ('GoogleMobileAds','google-mobile-ads'),
        ('UserMessagingPlatform','user-messaging-platform')):
        framework_found=any(row['name']==framework_name and row.get('version') for row in frameworks)
        package_found=any(package_fragment in row['identity'] and row.get('version') for row in packages)
        if not framework_found and not package_found:
            raise ValueError('The actual '+framework_name+' version was not recorded.')


def record(root):
    app=root/'build/ios/archive/Runner.xcarchive/Products/Applications/Runner.app'
    if not app.is_dir():
        app=root/'build/ios/iphoneos/Runner.app'
    if not (app/'Info.plist').is_file():
        raise ValueError('A compiled app is required for actual SDK evidence.')
    pods=read_pods(root/'ios/Podfile.lock')
    packages=read_swift_resolutions(root)
    frameworks=read_frameworks(app)
    require_ad_sdk_evidence(packages,frameworks)
    result={'resolvedPods':pods,'swiftPackages':packages,'embeddedFrameworks':frameworks,
            'adSdkEvidenceComplete':True}
    output=root/'verification/native-dependencies.json'
    output.parent.mkdir(exist_ok=True)
    output.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    return result


if __name__=='__main__':
    record(Path(__file__).resolve().parents[2])
    print('Recorded actual CocoaPods and Swift SDK versions and embedded privacy manifests.')
