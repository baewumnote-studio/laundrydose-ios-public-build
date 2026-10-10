#!/usr/bin/env python3
"""Prevent signing or upload during the user-requested Apple account hold."""
from datetime import datetime, timezone
import os
import re

NOT_BEFORE = datetime(2026, 10, 9, 5, 0, tzinfo=timezone.utc)


def validate(now, recovered, build_number, branch):
    if now < NOT_BEFORE:
        raise ValueError('Apple account work is held until 2026-10-09 14:00 KST.')
    if recovered != 'true':
        raise ValueError('Confirm Apple account recovery before signing or uploading.')
    if branch != 'refs/heads/main':
        raise ValueError('TestFlight builds must use the reviewed main branch.')
    if not re.fullmatch(r'[1-9][0-9]{0,5}', build_number):
        raise ValueError('Build number must be a positive integer with at most six digits.')


def check_environment():
    validate(datetime.now(timezone.utc), os.environ.get('ACCOUNT_RECOVERED', ''),
             os.environ.get('PROJECT_BUILD_NUMBER', ''), os.environ.get('GITHUB_REF', ''))


if __name__ == '__main__':
    check_environment()
    print('Account hold ended, recovery confirmed, main branch and build number verified.')
