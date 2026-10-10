"""Capture native Simulator PNGs using only isolated synthetic app data."""
import hashlib,json,os,signal
from pathlib import Path
import shutil,struct,subprocess

ROOT=Path.cwd()
OUT=ROOT/'verification/store-screenshots'
OUT.mkdir(parents=True,exist_ok=True)
def run(args,**kw): return subprocess.run(args,check=True,**kw)

def drive(args,source,env,device,label,timeout):
    # Bound a stalled Simulator launch and retain actual evidence from this
    # synthetic-only runner. No signing material is available to this job.
    log=OUT/(label+'-driver.log')
    with log.open('w') as output:
        process=subprocess.Popen(args,cwd=source,env=env,stdout=output,
            stderr=subprocess.STDOUT,start_new_session=True)
        try:
            code=process.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            os.killpg(process.pid,signal.SIGTERM)
            try: process.wait(timeout=15)
            except subprocess.TimeoutExpired:
                os.killpg(process.pid,signal.SIGKILL);process.wait()
            code=-1
    print(log.read_text(),flush=True)
    if code:
        diagnostics=OUT/(label+'-diagnostics');diagnostics.mkdir(exist_ok=True)
        subprocess.run(['xcrun','simctl','io',device['udid'],'screenshot',
            str(diagnostics/'current-simulator-screen.png')],timeout=45,check=False)
        result=subprocess.run(['xcrun','simctl','spawn',device['udid'],'log','show',
            '--last','10m','--style','compact','--predicate','process == "Runner"'],
            timeout=60,check=False,capture_output=True,text=True)
        (diagnostics/'runner-native.log').write_text(result.stdout+result.stderr)
        raise ValueError(label+' native capture failed or launch timed out; actual Simulator evidence retained.')
    log.unlink()

def capture():
    # Integration-test dependencies belong only to this discarded capture copy.
    source=Path(os.environ['RUNNER_TEMP'])/'laundrydose-store-capture'
    if source.exists(): raise ValueError('Capture copy already exists; inspect before retrying.')
    shutil.copytree(ROOT,source,ignore=shutil.ignore_patterns('.git','build','.dart_tool','verification'))
    run(['flutter','pub','add','dev:integration_test@{sdk: flutter}'],cwd=source)
    for template in (source/'tool/store_capture').glob('*.dart.template'):
        template.rename(template.with_suffix(''))
    run(['flutter','analyze','--no-pub','tool/store_capture'],cwd=source)
    inventory=json.loads(subprocess.check_output(['xcrun','simctl','list','-j','devices','available']))
    runtimes=json.loads(subprocess.check_output(['xcrun','simctl','list','-j','runtimes']))['runtimes']
    runtime_candidates=[r for r in runtimes if r.get('isAvailable') and '.iOS-' in r['identifier']]
    runtime=max(runtime_candidates,key=lambda r:tuple(int(v) for v in r['version'].split('.')))
    devices=inventory['devices'][runtime['identifier']]
    phone=next((d for d in devices if d['name'] in {'iPhone 17 Pro','iPhone 16 Pro'}),None)
    tablet=next((d for d in devices if 'iPad Pro 13-inch' in d['name']),None)
    if not phone or not tablet: raise ValueError('A supported medium Dynamic Island iPhone and 13-inch iPad Simulator are required.')
    receipt={'sourceCommit':os.environ['GITHUB_SHA'],'captureType':'NATIVE_IOS_SIMULATOR',
        'syntheticDataOnly':True,'shippingAppSourceUnchanged':True,'runtimeVersion':runtime['version'],'devices':[]}
    for label,device in [('iphone',phone),('ipad',tablet)]:
        if device['state']!='Booted': run(['xcrun','simctl','boot',device['udid']])
        run(['xcrun','simctl','bootstatus',device['udid'],'-b'])
        run(['xcrun','simctl','status_bar',device['udid'],'override','--time','9:41',
            '--batteryState','charged','--batteryLevel','100','--wifiMode','active','--wifiBars','3'])
        folder=OUT/label
        env=os.environ|{'STORE_CAPTURE_OUTPUT':str(folder)}
        command=['flutter','drive','--verbose','--driver=tool/store_capture/driver.dart',
            '--target=tool/store_capture/screenshot_test.dart','-d',device['udid'],
            '--dart-define=LAUNDRY_DOSE_TEST_ADS=true']
        if label=='ipad':
            binary=source/'build/ios/iphonesimulator/Runner.app'
            if not binary.is_dir(): raise ValueError('Reuse requires the successfully built synthetic capture app.')
            command.append('--use-application-binary='+str(binary))
        drive(command,source,env,device,label,720 if label=='iphone' else 300)
        files=[]
        for path in sorted(folder.glob('*.png')):
            data=path.read_bytes()
            if data[:8]!=b'\x89PNG\r\n\x1a\n': raise ValueError('Capture is not a native PNG.')
            width,height=struct.unpack('>II',data[16:24])
            allowed={(1179,2556),(1206,2622)} if label=='iphone' else {(2048,2732),(2064,2752)}
            if (width,height) not in allowed: raise ValueError('Actual capture pixels do not match Apple Store dimensions.')
            files.append({'name':path.name,'width':width,'height':height,'sha256':hashlib.sha256(data).hexdigest()})
        if len(files)!=5: raise ValueError('Five actual screen captures are required for each device.')
        receipt['devices'].append({'category':label,'model':device['name'],'screenshots':files})
        # Preserve successful native captures even if the next device fails.
        (OUT/'capture-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
        run(['xcrun','simctl','shutdown',device['udid']])
    (OUT/'capture-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')

if __name__=='__main__': capture()
