"""Reject wrong devices, altered profiles, mismatched certificates and modified IPAs."""
import base64
from copy import deepcopy
from datetime import datetime, timezone, timedelta
import hashlib
import json
import os
from pathlib import Path
import plistlib
import shutil
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch
import zipfile

import adhoc_signing as signing
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import install_iphone_adhoc as installer

NOW = datetime.now(timezone.utc)
DEVICE = '12345678-1234567890ABCDEF'


def profile(certificate):
    return {'TeamIdentifier': [signing.TEAM], 'Name': signing.PROFILE_NAME,
            'UUID': '89a55938-681a-46aa-b32e-064216c5f9f8',
            'ProvisionedDevices': [DEVICE], 'ExpirationDate': NOW.replace(tzinfo=None) + timedelta(days=3),
            'DeveloperCertificates': [certificate],
            'Entitlements': {'application-identifier': f'{signing.TEAM}.{signing.BUNDLE}',
                             'com.apple.developer.team-identifier': signing.TEAM,
                             'get-task-allow': False}}


class ProfileTests(unittest.TestCase):
    def setUp(self):
        self.data = profile(b'checked-certificate')
        self.fingerprint = patch.object(signing, 'CERTIFICATE_SHA256', hashlib.sha256(b'checked-certificate').hexdigest())
        self.fingerprint.start()
        self.addCleanup(self.fingerprint.stop)

    def test_correct_single_device(self):
        signing.validate_profile(self.data, NOW, DEVICE)

    def test_wrong_or_extra_device(self):
        for devices in ([], ['FFFFFFFF-1234567890ABCDEF'], [DEVICE, DEVICE]):
            with self.subTest(devices=len(devices)):
                data = deepcopy(self.data)
                data['ProvisionedDevices'] = devices
                with self.assertRaises(ValueError):
                    signing.validate_profile(data, NOW, DEVICE)

    def test_store_enterprise_and_development_profiles_rejected(self):
        for change in ('store', 'enterprise', 'development'):
            data = deepcopy(self.data)
            if change == 'store': data.pop('ProvisionedDevices')
            if change == 'enterprise': data['ProvisionsAllDevices'] = True
            if change == 'development': data['Entitlements']['get-task-allow'] = True
            with self.subTest(change=change), self.assertRaises(ValueError):
                signing.validate_profile(data, NOW, DEVICE)

    def test_other_app_team_and_extension_group_rejected(self):
        for change in ('app', 'team', 'group'):
            data = deepcopy(self.data)
            if change == 'app': data['Entitlements']['application-identifier'] += '.other'
            if change == 'team': data['TeamIdentifier'] = ['OTHERTEAM']
            if change == 'group': data['Entitlements']['com.apple.security.application-groups'] = ['group.other']
            with self.subTest(change=change), self.assertRaises(ValueError):
                signing.validate_profile(data, NOW, DEVICE)

    def test_expiring_profile_rejected(self):
        self.data['ExpirationDate'] = NOW.replace(tzinfo=None) + timedelta(hours=1)
        with self.assertRaises(ValueError): signing.validate_profile(self.data, NOW, DEVICE)

    def test_wrong_existing_certificate_rejected(self):
        self.data['DeveloperCertificates'] = [b'other-certificate']
        with self.assertRaises(ValueError): signing.validate_profile(self.data, NOW, DEVICE)

    def test_branch_and_build_gate(self):
        for ref, number in (('refs/heads/other', '1'), ('refs/heads/main', '0'), ('refs/heads/main', '1;other')):
            with patch.dict(os.environ, {'GITHUB_REF': ref, 'PROJECT_BUILD_NUMBER': number}), self.assertRaises(ValueError):
                signing.check_environment()

    def test_modified_download_rejected_before_profile_decode(self):
        with tempfile.TemporaryDirectory() as directory:
            ipa = Path(directory) / 'laundry.ipa'
            ipa.write_bytes(b'changed-ipa')
            report = {'status': 'PASS', 'codesignVerification': 'PASS', 'bundleId': signing.BUNDLE,
                      'distribution': 'AD_HOC_SINGLE_REGISTERED_IPHONE',
                      'actualCertificateSha256': installer.CERTIFICATE_SHA256, 'sha256': '0' * 64}
            with self.assertRaises(ValueError): installer.validate_ipa(ipa, report, {'udid': DEVICE}, 'openssl')

    def test_installer_uses_ascii_basename_in_unicode_folder(self):
        ipa = Path('C:/사용자/프로젝트/LaundryDose.ipa')
        with patch.object(installer.subprocess, 'run') as run:
            installer.run_installer(ipa, DEVICE, Path('tools'))
        args, kwargs = run.call_args
        self.assertEqual(args[0][-2:], ['-i', 'LaundryDose.ipa'])
        self.assertEqual(kwargs['cwd'], ipa.resolve().parent)


@unittest.skipUnless(shutil.which(os.environ.get('OPENSSL_EXECUTABLE', 'openssl')), 'OpenSSL is required for cryptographic fixture tests')
class CryptographicTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temporary = tempfile.TemporaryDirectory()
        cls.directory = Path(cls.temporary.name)
        cls.key = cls.directory / 'key.pem'
        cls.cert = cls.directory / 'cert.pem'
        cls.p12 = cls.directory / 'test.p12'
        (cls.directory / 'fixture.cnf').write_text('[req]\ndistinguished_name = dn\n[dn]\n')
        signing.openssl(['req', '-config', 'fixture.cnf', '-x509', '-newkey', 'rsa:2048', '-nodes', '-days', '3',
                         '-subj', '/CN=CI fixture/OU=39762JRYD4', '-keyout', 'key.pem', '-out', 'cert.pem'], cwd=cls.directory)
        cls.der = signing.openssl(['x509', '-in', 'cert.pem', '-outform', 'DER'], cwd=cls.directory)
        cls.data = profile(cls.der)
        cls.signed = signing.openssl(['cms', '-sign', '-binary', '-nodetach', '-outform', 'DER',
                                      '-signer', 'cert.pem', '-inkey', 'key.pem'], data=plistlib.dumps(cls.data), cwd=cls.directory)
        signing.openssl(['pkcs12', '-export', '-inkey', 'key.pem', '-in', 'cert.pem',
                         '-out', 'test.p12', '-passout', 'pass:fixture-password'], cwd=cls.directory)

    @classmethod
    def tearDownClass(cls): cls.temporary.cleanup()

    def environment(self):
        return {'GITHUB_REF': 'refs/heads/main', 'PROJECT_BUILD_NUMBER': '1',
                'IOS_DISTRIBUTION_P12_BASE64': base64.b64encode(self.p12.read_bytes()).decode(),
                'IOS_DISTRIBUTION_P12_PASSWORD': 'fixture-password',
                'IOS_ADHOC_PROFILE_BASE64': base64.b64encode(self.signed).decode(),
                'IOS_ADHOC_DEVICE_UDID': DEVICE}

    def test_actual_cms_and_private_key_preflight(self):
        with patch.dict(os.environ, self.environment()), patch.object(signing, 'CERTIFICATE_SHA256', hashlib.sha256(self.der).hexdigest()):
            signing.preflight()

    def test_tampered_cms_content_fails(self):
        altered = self.signed.replace(b'Laundry Dose', b'Laundrx Dose', 1)
        self.assertNotEqual(altered, self.signed)
        with self.assertRaises(subprocess.CalledProcessError): signing.decode_profile(altered)

    def test_wrong_p12_password_fails(self):
        environment = self.environment()
        environment['IOS_DISTRIBUTION_P12_PASSWORD'] = 'wrong-password'
        with patch.dict(os.environ, environment), patch.object(signing, 'CERTIFICATE_SHA256', hashlib.sha256(self.der).hexdigest()), self.assertRaises(subprocess.CalledProcessError):
            signing.preflight()

    def test_p12_without_private_key_fails(self):
        cert_only = self.directory / 'cert-only.p12'
        signing.openssl(['pkcs12', '-export', '-nokeys', '-in', 'cert.pem',
                         '-out', 'cert-only.p12', '-passout', 'pass:fixture-password'], cwd=self.directory)
        environment = self.environment()
        environment['IOS_DISTRIBUTION_P12_BASE64'] = base64.b64encode(cert_only.read_bytes()).decode()
        with patch.dict(os.environ, environment), patch.object(signing, 'CERTIFICATE_SHA256', hashlib.sha256(self.der).hexdigest()), self.assertRaises(subprocess.CalledProcessError):
            signing.preflight()


if __name__ == '__main__': unittest.main()
