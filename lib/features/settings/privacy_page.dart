import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app/providers.dart';
import '../../core/config/app_links.dart';
import '../../core/localization/l10n.dart';
import '../../widgets/app_scaffold_body.dart';

class PrivacyPage extends ConsumerWidget {
  const PrivacyPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.privacyTitle)),
      body: SafeArea(
        child: AppScaffoldBody(
          child: ListView(
            padding: const EdgeInsets.only(top: 10, bottom: 28),
            children: [
              _section(
                context,
                Icons.phone_iphone,
                l.privacyLocalTitle,
                l.privacyLocalBody,
              ),
              const SizedBox(height: 12),
              _section(
                context,
                Icons.ads_click,
                l.privacyAdsTitle,
                l.privacyAdsBody,
              ),
              const SizedBox(height: 12),
              Text(l.privacyNoSaleClaim),
              const SizedBox(height: 20),
              FutureBuilder<bool>(
                future: ref
                    .read(consentServiceProvider)
                    .isPrivacyOptionsRequired(),
                builder: (c, s) => s.data == true
                    ? OutlinedButton.icon(
                        onPressed: () => ref
                            .read(consentServiceProvider)
                            .showPrivacyOptions(),
                        icon: const Icon(Icons.tune),
                        label: Text(l.manageConsent),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: AppLinks.privacyPolicyUri == null
                    ? null
                    : () => launchUrl(
                        AppLinks.privacyPolicyUri!,
                        mode: LaunchMode.externalApplication,
                      ),
                icon: const Icon(Icons.open_in_new),
                label: Text(l.privacyPolicy),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(BuildContext c, IconData i, String t, String b) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(i, color: Theme.of(c).colorScheme.primary),
          const SizedBox(height: 10),
          Text(t, style: Theme.of(c).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(b),
        ],
      ),
    ),
  );
}
