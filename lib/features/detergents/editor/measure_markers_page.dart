import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../core/domain/detergent_draft.dart';
import '../../../core/formatters/number_formatters.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/localization/labels.dart';
import '../../../core/units/unit_converter.dart';
import '../../../widgets/app_scaffold_body.dart';

class MeasureMarkersPage extends StatefulWidget {
  const MeasureMarkersPage({super.key, required this.draft});
  final DetergentDraft draft;

  @override
  State<MeasureMarkersPage> createState() => _MeasureMarkersPageState();
}

class _MeasureMarkersPageState extends State<MeasureMarkersPage> {
  DetergentDraft get d => widget.draft;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final sorted = [...d.markers]
      ..sort((a, b) => a.amountCanonical.compareTo(b.amountCanonical));
    return Scaffold(
      appBar: AppBar(title: Text(l.measurementTitle)),
      body: SafeArea(
        child: AppScaffoldBody(
          child: ListView(
            padding: const EdgeInsets.only(top: 8, bottom: 28),
            children: [
              Text(l.measurementBody),
              const SizedBox(height: 14),
              for (final marker in sorted)
                Card(
                  child: ListTile(
                    title: Text(marker.label),
                    subtitle: Text(
                      '${DoseFormatter.numeric(marker.amountCanonical, d.preferredDisplayUnit, Localizations.localeOf(context).toLanguageTag())} '
                      '${displayUnitLabel(context, d.preferredDisplayUnit, canonical: marker.amountCanonical)}',
                    ),
                    trailing: IconButton(
                      tooltip: l.delete,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => setState(
                        () => d.markers.removeWhere((x) => x.id == marker.id),
                      ),
                    ),
                    onTap: () => _edit(marker),
                  ),
                ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _edit(null),
                icon: const Icon(Icons.add),
                label: Text(l.addMarker),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l.done),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _edit(DraftMarker? marker) async {
    final l = context.l10n;
    final name = TextEditingController(text: marker?.label ?? '');
    final locale = Localizations.localeOf(context).toLanguageTag();
    final amount = TextEditingController(
      text: marker == null
          ? ''
          : DoseFormatter.numeric(
              marker.amountCanonical,
              d.preferredDisplayUnit,
              locale,
            ),
    );

    final ok =
        await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(marker == null ? l.addMarker : l.edit),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  maxLength: 24,
                  decoration: InputDecoration(
                    labelText: l.markerName,
                    hintText: l.markerNamePlaceholder,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: amount,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l.markerAmount,
                    suffixText: displayUnitLabel(
                      context,
                      d.preferredDisplayUnit,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(l.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(l.save),
              ),
            ],
          ),
        ) ??
        false;

    if (ok) {
      final parsed = LocaleNumberParser.parse(amount.text, locale);
      if (name.text.trim().isEmpty || parsed == null || parsed <= 0) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l.validationPositive)));
        }
      } else {
        final canonical = UnitConverter.toCanonical(
          parsed,
          d.preferredDisplayUnit,
        );
        setState(() {
          if (marker == null) {
            d.markers.add(
              DraftMarker(
                id: const Uuid().v4(),
                label: name.text.trim(),
                amountCanonical: canonical,
              ),
            );
          } else {
            marker.label = name.text.trim();
            marker.amountCanonical = canonical;
          }
        });
      }
    }
    name.dispose();
    amount.dispose();
  }
}
