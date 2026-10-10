import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/config/app_links.dart';
import '../../core/localization/l10n.dart';
import '../../widgets/app_scaffold_body.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.about)),
      body: SafeArea(
        child: AppScaffoldBody(
          child: ListView(
            padding: const EdgeInsets.only(top: 16, bottom: 28),
            children: [
              CircleAvatar(
                radius: 34,
                child: Icon(
                  Icons.water_drop,
                  size: 36,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l.appName,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(l.aboutBody, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) => ListTile(
                  title: Text(l.version),
                  trailing: Text(
                    snapshot.data == null
                        ? '—'
                        : '${snapshot.data!.version} (${snapshot.data!.buildNumber})',
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: Text(l.privacyPolicy),
                enabled: AppLinks.privacyPolicyUri != null,
                onTap: AppLinks.privacyPolicyUri == null
                    ? null
                    : () => launchUrl(
                        AppLinks.privacyPolicyUri!,
                        mode: LaunchMode.externalApplication,
                      ),
              ),
              ListTile(
                leading: const Icon(Icons.support_agent),
                title: Text(l.help),
                enabled: AppLinks.supportUri != null,
                onTap: AppLinks.supportUri == null
                    ? null
                    : () => launchUrl(
                        AppLinks.supportUri!,
                        mode: LaunchMode.externalApplication,
                      ),
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: Text(l.supportEmailAction),
                enabled: AppLinks.supportEmailUri != null,
                onTap: AppLinks.supportEmailUri == null
                    ? null
                    : () => launchUrl(AppLinks.supportEmailUri!),
              ),
              ListTile(
                leading: const Icon(Icons.article_outlined),
                title: Text(l.licenses),
                onTap: () => showLicensePage(
                  context: context,
                  applicationName: l.appName,
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person_off_outlined),
                title: Text(l.noAccount),
              ),
              ListTile(
                leading: const Icon(Icons.money_off),
                title: Text(l.noSubscription),
              ),
              ListTile(
                leading: const Icon(Icons.offline_bolt_outlined),
                title: Text(l.offlineCore),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
