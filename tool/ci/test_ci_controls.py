"""Exercise account hold and wrong/expired signing material rejection offline."""
from copy import deepcopy
from datetime import datetime, timedelta, timezone
from pathlib import Path
import unittest

from ios_signing import BUNDLE, TEAM, configure_project, validate_profile
from testflight_gate import NOT_BEFORE, validate


class AccountHoldTests(unittest.TestCase):
    def test_rejects_before_deadline_even_if_confirmed(self):
        with self.assertRaisesRegex(ValueError, 'held until'):
            validate(NOT_BEFORE - timedelta(seconds=1), 'true', '1', 'refs/heads/main')

    def test_deadline_alone_does_not_confirm_recovery(self):
        with self.assertRaisesRegex(ValueError, 'recovery'):
            validate(NOT_BEFORE, 'false', '1', 'refs/heads/main')

    def test_allows_after_deadline_with_confirmation(self):
        validate(NOT_BEFORE, 'true', '1', 'refs/heads/main')

    def test_rejects_other_branch_and_malformed_build(self):
        for build, branch in [('1', 'refs/heads/feature'), ('0', 'refs/heads/main'),
                              ('1; command', 'refs/heads/main'), ('1000000', 'refs/heads/main')]:
            with self.subTest(build=build, branch=branch), self.assertRaises(ValueError):
                validate(NOT_BEFORE, 'true', build, branch)


class SigningProfileTests(unittest.TestCase):
    def setUp(self):
        self.now = datetime(2026, 10, 10, tzinfo=timezone.utc)
        self.profile = {
            'TeamIdentifier': [TEAM], 'Name': 'Laundry Dose App Store',
            'UUID': '12345678-1234-1234-1234-123456789abc',
            'ExpirationDate': datetime(2027, 10, 3), 'DeveloperCertificates': [b'fixture'],
            'Entitlements': {'application-identifier': f'{TEAM}.{BUNDLE}', 'get-task-allow': False},
        }

    def test_accepts_matching_store_profile(self):
        validate_profile(self.profile, self.now)

    def test_rejects_wrong_team_bundle_expiry_and_device_distribution(self):
        changes = [
            {'TeamIdentifier': ['OTHERTEAM1']}, {'Name': 'Another app'},
            {'ExpirationDate': datetime(2026, 10, 9)}, {'ProvisionedDevices': ['device']},
            {'ProvisionsAllDevices': True}, {'DeveloperCertificates': []},
            {'Entitlements': {'application-identifier': f'{TEAM}.other'}},
            {'Entitlements': {'application-identifier': f'{TEAM}.{BUNDLE}', 'get-task-allow': True}},
        ]
        for change in changes:
            with self.subTest(change=list(change)), self.assertRaises(ValueError):
                profile = deepcopy(self.profile)
                profile.update(change)
                validate_profile(profile, self.now)

    def test_signing_patch_only_changes_runner_and_is_repeatable(self):
        project = Path(__file__).resolve().parents[2] / 'ios/Runner.xcodeproj/project.pbxproj'
        text = project.read_text(encoding='utf-8')
        signed = configure_project(text, self.profile['Name'])
        self.assertEqual(signed.count('PROVISIONING_PROFILE_SPECIFIER = "Laundry Dose App Store";'), 3)
        self.assertEqual(signed.count('CODE_SIGN_STYLE = Automatic;'), text.count('CODE_SIGN_STYLE = Automatic;'))
        self.assertEqual(configure_project(signed, self.profile['Name']), signed)

    def test_unknown_project_structure_fails_instead_of_silently_signing(self):
        with self.assertRaisesRegex(ValueError, 'three Runner'):
            configure_project('buildSettings = { PRODUCT_BUNDLE_IDENTIFIER = another.app; };', self.profile['Name'])


if __name__ == '__main__':
    unittest.main()
