# Laundry Dose iOS build source

This separate repository contains the current Laundry Dose Flutter app, native
iOS label reader, app artwork, localization and regression tests. It starts with
a new Git history. The existing private project remains the original and backup.

The app uses its existing Bundle ID and App Store Connect record. No new app or
advertising policy is introduced here. Core calculations, storage, UI and artwork
are preserved by a checked file manifest.

## Manual builds

Only `.github/workflows/ios-build.yml` can run, through `workflow_dispatch` on
`main`, initiated by the repository owner. Pushes and external pull requests do
not start builds. The runner is standard `macos-26`, with the Flutter and Xcode
versions previously used to build this app successfully.

1. Run `unsigned` first. It restores locked packages, runs analysis and tests, and
   compiles a Release iOS app with no code signing. The public result contains a
   compile report and native dependency versions, without an installable binary.
2. `adhoc` and `appstore` require a successful unsigned run for the exact same
   source commit, matching signed profiles, and the protected
   `apple-distribution` environment. Only the owner can approve this environment;
   it is limited to `main` and does not allow administrator bypass.
3. `adhoc` uses test ads and the previously registered physical iPhone. `appstore`
   applies the existing Laundry Dose production ad IDs and published support
   URLs. A TestFlight upload is separately opt-in and requires approved Apple API
   credentials. This workflow never submits an App Store review or releases an
   app automatically.

Signed IPA files, original archives and signing diagnostics are encrypted with
AES-256-GCM and an RSA-OAEP recipient before artifact upload. Only the public
encryption certificate is in this repository. Its private decryption key stays
on the owner's computer and is never sent to GitHub. Plain signed IPA files,
archives, profiles and private keys must never be uploaded as public artifacts.

## Environment configuration

After the unsigned compile succeeds, verify the environment protection rules
before registering any signing secrets. The existing private repository's
secrets are retained. Register new destination secrets only with the owner's
explicit approval:

- `IOS_DISTRIBUTION_P12_BASE64` and `IOS_DISTRIBUTION_P12_PASSWORD`
- `IOS_ADHOC_PROFILE_BASE64` and `IOS_ADHOC_DEVICE_UDID` for direct testing
- `IOS_RELEASE_APP_STORE_PROFILE_BASE64` for production distribution
- `IOS_APP_STORE_API_KEY_BASE64`, `IOS_APP_STORE_API_KEY_ID` and
  `IOS_APP_STORE_ISSUER_ID` only for an approved TestFlight upload

No credential values or real device identifiers belong in repository files.
The signed-build gate checks GitHub's actual environment configuration before
allowing a signing job. Workflow text alone does not establish this protection.

## Rights and notices

This build repository does not grant a new license for app-owned source or
artwork. Existing third-party licenses continue to apply. Flutter's generated
license registry and in-app acknowledgements are retained. Dependency source
and native SDK licenses must be reviewed with the final archive before release.

Repository preparation, a successful compile, a signed IPA, installation,
physical-device QA, TestFlight processing and App Store approval are separate
results. None should be inferred from the others.
