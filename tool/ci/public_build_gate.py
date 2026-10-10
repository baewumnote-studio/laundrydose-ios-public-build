"""Reject forks, PR events, unknown branches and uncompiled signed inputs."""
import json
import os
import re
import sys
import urllib.request

REPOSITORY = 'baewumnote-studio/laundrydose-ios-public-build'
OWNER = 'baewumnote-studio'
OWNER_ID = 337203413

def validate(repository, actor, event, ref, mode, build_number, upload):
    if repository != REPOSITORY or actor != OWNER or event != 'workflow_dispatch' or ref != 'refs/heads/main':
        raise ValueError('Only owner-dispatched builds on this repository main branch are allowed.')
    if mode not in {'unsigned','adhoc','appstore'} or not re.fullmatch(r'[1-9][0-9]{0,5}',build_number):
        raise ValueError('Build mode or number is invalid.')
    if upload not in {'true','false'} or (upload=='true' and mode!='appstore'):
        raise ValueError('A TestFlight upload is opt-in and appstore-only.')

def api(path):
    token=os.environ.get('GH_READ_TOKEN','')
    if not token:
        raise ValueError('A read-only Actions token is required to check prior compilation.')
    req=urllib.request.Request('https://api.github.com/repos/'+REPOSITORY+path,
        headers={'Authorization':'Bearer '+token,'Accept':'application/vnd.github+json',
                 'X-GitHub-Api-Version':'2022-11-28'})
    with urllib.request.urlopen(req,timeout=30) as response:
        return json.load(response)

def matching_unsigned(runs, jobs_by_id, sha, current_id):
    for run in runs:
        if (str(run['id'])==str(current_id) or run.get('head_sha')!=sha
            or run.get('head_branch')!='main' or run.get('event')!='workflow_dispatch'
            or run.get('conclusion')!='success' or run.get('actor',{}).get('login')!=OWNER):
            continue
        if any(job.get('name')=='unsigned' and job.get('conclusion')=='success'
               for job in jobs_by_id.get(run['id'],[])):
            return run['id']
    raise ValueError('A successful unsigned compile of this exact source commit is required first.')

def validate_environment(environment, policies):
    rules=[rule for rule in environment.get('protection_rules',[]) if rule.get('type')=='required_reviewers']
    if len(rules)!=1 or environment.get('can_admins_bypass') is not False:
        raise ValueError('Protected owner approval without admin bypass must be configured first.')
    reviewers=rules[0].get('reviewers',[])
    if len(reviewers)!=1 or reviewers[0].get('type')!='User' or reviewers[0].get('reviewer',{}).get('id')!=OWNER_ID:
        raise ValueError('Only the actual repository owner may approve Apple distribution.')
    policy=environment.get('deployment_branch_policy',{})
    if policy!={'protected_branches':False,'custom_branch_policies':True}:
        raise ValueError('Explicit main-branch deployment restriction is required.')
    if len(policies)!=1 or policies[0].get('name')!='main' or policies[0].get('type')!='branch':
        raise ValueError('Only the main branch may access this distribution environment.')

def main():
    mode=os.environ.get('BUILD_MODE','')
    validate(os.environ.get('GITHUB_REPOSITORY',''),os.environ.get('GITHUB_ACTOR',''),
             os.environ.get('GITHUB_EVENT_NAME',''),os.environ.get('GITHUB_REF',''),mode,
             os.environ.get('PROJECT_BUILD_NUMBER',''),os.environ.get('UPLOAD_TO_TESTFLIGHT','false'))
    if mode!='unsigned':
        sha=os.environ['GITHUB_SHA']
        runs=api('/actions/workflows/ios-build.yml/runs?event=workflow_dispatch&branch=main&per_page=100')['workflow_runs']
        candidates=[r for r in runs if r.get('head_sha')==sha and r.get('conclusion')=='success']
        jobs={r['id']:api('/actions/runs/'+str(r['id'])+'/jobs')['jobs'] for r in candidates}
        matching_unsigned(candidates,jobs,sha,os.environ['GITHUB_RUN_ID'])
        environment=api('/environments/apple-distribution')
        policies=api('/environments/apple-distribution/deployment-branch-policies')['branch_policies']
        validate_environment(environment,policies)
    print('Trusted manual build inputs and required compile evidence passed.')

if __name__=='__main__':
    try:
        main()
    except Exception:
        raise SystemExit('Public build authorization or prior unsigned compilation check failed.') from None
