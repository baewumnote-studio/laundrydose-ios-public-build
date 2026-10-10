import 'package:flutter/material.dart';
import '../../core/localization/l10n.dart';
import '../../widgets/laundry_art.dart';
import 'editor/detergent_basics_page.dart';
import 'scan/label_scan_page.dart';

Future<void> showAddDetergent(BuildContext context) async {
  final scan = await showModalBottomSheet<bool>(
    context: context,
    builder: (c) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.l10n.addDetergent,
              style: Theme.of(c).textTheme.headlineSmall,
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: () => Navigator.pop(c, true),
              icon: const Icon(Icons.document_scanner_outlined),
              label: Text(c.l10n.scanLabel),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop(c, false),
              child: Text(c.l10n.enterManually),
            ),
            const SizedBox(height: 14),
            Text(c.l10n.localScanNote, style: Theme.of(c).textTheme.bodySmall),
          ],
        ),
      ),
    ),
  );
  if (scan == null || !context.mounted) {
    return;
  }
  await Navigator.of(context).push(
    MaterialPageRoute<bool>(
      builder: (_) =>
          scan ? const LabelScanPage() : const DetergentBasicsPage(),
    ),
  );
}

class AddDetergentPanel extends StatelessWidget {
  const AddDetergentPanel({super.key});
  @override
  Widget build(BuildContext c) => Padding(
    padding: const EdgeInsets.only(top: 14, bottom: 28),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LaundryArt(height: 230),
        const SizedBox(height: 22),
        Text(c.l10n.firstDetergent, style: Theme.of(c).textTheme.headlineLarge),
        const SizedBox(height: 12),
        Text(c.l10n.welcomeBody),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () => Navigator.of(c).push(
            MaterialPageRoute<bool>(builder: (_) => const LabelScanPage()),
          ),
          icon: const Icon(Icons.document_scanner_outlined),
          label: Text(c.l10n.scanLabel),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () => Navigator.of(c).push(
            MaterialPageRoute<bool>(
              builder: (_) => const DetergentBasicsPage(),
            ),
          ),
          child: Text(c.l10n.enterManually),
        ),
      ],
    ),
  );
}
