import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/providers.dart';
import '../../core/localization/l10n.dart';
import '../../widgets/app_scaffold_body.dart';
import '../../widgets/laundry_art.dart';
import '../detergents/editor/detergent_basics_page.dart';
import '../detergents/scan/label_scan_page.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: AppScaffoldBody(
          child: ListView(
            padding: const EdgeInsets.only(top: 20, bottom: 24),
            children: [
              Row(
                children: [
                  const BottleMark(size: 36),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l.appName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () => ref
                        .read(settingsRepositoryProvider)
                        .update(onboardingCompleted: true),
                    child: Text(l.notNow),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const LaundryArt(height: 240),
              const SizedBox(height: 28),
              Text(
                l.welcomeTitle,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(fontSize: 36, height: 1.16),
              ),
              const SizedBox(height: 16),
              Text(l.welcomeBody, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: () => _start(context, ref, const LabelScanPage()),
                icon: const Icon(Icons.document_scanner_outlined),
                label: Text(l.scanLabel),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () =>
                    _start(context, ref, const DetergentBasicsPage()),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text(l.enterManually),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l.localScanNote,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _start(BuildContext c, WidgetRef ref, Widget page) async {
    await Navigator.of(c).push(MaterialPageRoute<void>(builder: (_) => page));
    if (c.mounted) {
      await ref
          .read(settingsRepositoryProvider)
          .update(onboardingCompleted: true);
    }
  }
}
