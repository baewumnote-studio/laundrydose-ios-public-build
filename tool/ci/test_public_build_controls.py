"""Exercise public-run authorization and authenticated artifact encryption."""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest

from public_build_gate import OWNER, OWNER_ID, REPOSITORY, matching_unsigned, validate, validate_environment
from protect_artifacts import encrypt

class PublicGateTests(unittest.TestCase):
    def test_only_manual_owner_main_in_the_exact_repository(self):
        base=[REPOSITORY,OWNER,'workflow_dispatch','refs/heads/main','unsigned','4','false']
        validate(*base)
        for index,value in [(0,'someone/fork'),(1,'someone'),(2,'pull_request'),
                            (2,'push'),(3,'refs/heads/feature'),(4,'anything'),
                            (5,'0'),(5,'4;command'),(6,'true')]:
            inputs=base.copy();inputs[index]=value
            with self.subTest(index=index,value=value),self.assertRaises(ValueError):
                validate(*inputs)

    def test_upload_is_appstore_only(self):
        validate(REPOSITORY,OWNER,'workflow_dispatch','refs/heads/main','appstore','4','true')
        with self.assertRaises(ValueError):
            validate(REPOSITORY,OWNER,'workflow_dispatch','refs/heads/main','adhoc','4','true')

    def test_requires_successful_unsigned_for_exact_source(self):
        run={'id':1,'head_sha':'reviewed','head_branch':'main','event':'workflow_dispatch',
             'conclusion':'success','actor':{'login':OWNER}}
        jobs={1:[{'name':'unsigned','conclusion':'success'}]}
        self.assertEqual(matching_unsigned([run],jobs,'reviewed',2),1)
        for key,value in [('head_sha','different'),('head_branch','feature'),
                          ('event','pull_request'),('conclusion','failure'),
                          ('actor',{'login':'someone'})]:
            invalid={**run,key:value}
            with self.subTest(key=key),self.assertRaises(ValueError):
                matching_unsigned([invalid],jobs,'reviewed',2)
        for invalid_jobs in [{1:[{'name':'unsigned','conclusion':'skipped'}]},
                             {1:[{'name':'signed','conclusion':'success'}]}]:
            with self.assertRaises(ValueError):
                matching_unsigned([run],invalid_jobs,'reviewed',2)
        with self.assertRaises(ValueError):
            matching_unsigned([run],jobs,'reviewed',1)

    def test_only_ciphertext_is_in_signed_artifact_allowlist(self):
        path=Path(__file__).resolve().parents[2]/'.github/workflows/ios-build.yml'
        workflow=path.read_text()
        block=workflow.split('name: Upload ciphertext only',1)[1].split('name: Remove temporary',1)[0]
        self.assertIn('verification/private-build.cms',block)
        self.assertIn('verification/encrypted-output-receipt.json',block)
        for forbidden in ['*.ipa','*.p12','mobileprovision','xcarchive','signed-build.log']:
            self.assertNotIn(forbidden,block)
        self.assertNotIn('pull_request_target:',workflow)
        self.assertNotIn('  push:',workflow)
        self.assertEqual(workflow.count('environment: apple-distribution'),2)

    def test_actual_environment_must_require_owner_review_and_only_main(self):
        environment={'can_admins_bypass':False,'protection_rules':[{'type':'required_reviewers',
            'reviewers':[{'type':'User','reviewer':{'id':OWNER_ID}}]}],
            'deployment_branch_policy':{'protected_branches':False,'custom_branch_policies':True}}
        policies=[{'name':'main','type':'branch'}]
        validate_environment(environment,policies)
        for change in [{'can_admins_bypass':True},{'protection_rules':[]},
                       {'deployment_branch_policy':None}]:
            with self.subTest(change=change),self.assertRaises(ValueError):
                validate_environment({**environment,**change},policies)
        with self.assertRaises(ValueError):
            validate_environment(environment,[{'name':'*','type':'branch'}])
        with self.assertRaises(ValueError):
            validate_environment(environment,policies+[{'name':'main','type':'tag'}])

@unittest.skipUnless(shutil.which(os.environ.get('OPENSSL_EXECUTABLE','openssl')),'OpenSSL 3 required')
class ArtifactEncryptionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp=tempfile.TemporaryDirectory()
        cls.folder=Path(cls.temp.name)
        (cls.folder/'config.cnf').write_text('[req]\ndistinguished_name=dn\n[dn]\n')
        cls.openssl=os.environ.get('OPENSSL_EXECUTABLE','openssl')
        for name in ['recipient','other']:
            subprocess.run([cls.openssl,'req','-config','config.cnf','-x509','-newkey','rsa:2048',
                '-nodes','-days','2','-subj','/CN=CI encryption fixture','-keyout',name+'.key',
                '-out',name+'.crt'],cwd=cls.folder,check=True,capture_output=True)
        cls.input=cls.folder/'fixture.txt'
        cls.input.write_bytes(b'Signed IPA encryption fixture; this is not an app.')
        cls.output=cls.folder/'protected.cms'
        encrypt(cls.input,cls.output,cls.folder/'recipient.crt')

    @classmethod
    def tearDownClass(cls):
        cls.temp.cleanup()

    def decrypt(self,path,key):
        return subprocess.run([self.openssl,'cms','-decrypt','-binary','-inform','DER',
            '-in',str(path),'-recip',str(self.folder/(key+'.crt')),
            '-inkey',str(self.folder/(key+'.key'))],capture_output=True)

    def test_actual_round_trip_and_plaintext_absence(self):
        result=self.decrypt(self.output,'recipient')
        self.assertEqual(result.returncode,0)
        self.assertEqual(result.stdout,self.input.read_bytes())
        self.assertNotIn(self.input.read_bytes(),self.output.read_bytes())

    def test_wrong_private_key_rejected(self):
        self.assertNotEqual(self.decrypt(self.output,'other').returncode,0)

    def test_tampered_authentication_tag_rejected(self):
        data=bytearray(self.output.read_bytes());data[-1]^=1
        altered=self.folder/'altered.cms';altered.write_bytes(data)
        self.assertNotEqual(self.decrypt(altered,'recipient').returncode,0)

if __name__=='__main__':
    unittest.main()
