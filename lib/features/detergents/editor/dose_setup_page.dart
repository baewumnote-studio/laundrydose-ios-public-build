import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../app/theme/design_tokens.dart';
import '../../../core/domain/detergent_draft.dart';
import '../../../core/domain/enums.dart';
import '../../../core/domain/models.dart';
import '../../../core/formatters/number_formatters.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/localization/labels.dart';
import '../../../core/localization/validation_messages.dart';
import '../../../core/validation/draft_validator.dart';
import '../../../widgets/app_scaffold_body.dart';
import '../../../widgets/dose_amount_field.dart';
import 'advanced_rules_page.dart';
import 'measure_markers_page.dart';

class DoseSetupPage extends ConsumerStatefulWidget {
  const DoseSetupPage({super.key, required this.draft})
    : bundle = null,
      focusSelection = null,
      focusCode = null;
  const DoseSetupPage.edit({
    super.key,
    required this.bundle,
    this.focusSelection,
    this.focusCode,
  }) : draft = null;
  final DetergentDraft? draft;
  final DetergentBundle? bundle;
  final DoseSelection? focusSelection;
  final String? focusCode;
  @override
  ConsumerState<DoseSetupPage> createState() => _S();
}

class _S extends ConsumerState<DoseSetupPage> {
  late DetergentDraft d;
  late TextEditingController priceC;
  late String _initialSignature;
  bool busy = false;
  bool _saved = false;
  bool _allowPop = false;
  bool _discardOpen = false;
  @override
  void initState() {
    super.initState();
    d = widget.draft ?? DetergentDraft.fromBundle(widget.bundle!);
    priceC = TextEditingController(text: d.packagePrice?.toString() ?? '');
    _initialSignature = d.changeSignature;
    if (_focusAdvanced) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _advanced();
      });
    }
  }

  bool get _focusAdvanced => const {
    'matrix_exact_match_missing',
    'soil_adjustment_missing',
    'water_adjustment_missing',
    'water_fallback_missing',
  }.contains(widget.focusCode);
  @override
  void dispose() {
    priceC.dispose();
    super.dispose();
  }

  String get locale => Localizations.localeOf(context).toLanguageTag();
  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final directEdit = widget.bundle != null;
    final dirty = d.changeSignature != _initialSignature;
    return PopScope<Object?>(
      canPop: !busy && (!directEdit || _saved || _allowPop || !dirty),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && !busy) _confirmDiscard();
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l.doseSetupTitle)),
        body: SafeArea(
          child: AppScaffoldBody(
            child: ListView(
              padding: const EdgeInsets.only(top: 8, bottom: 28),
              children: [
                Text(
                  l.copyFromPackage,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 18),
                Text(
                  l.ruleStyle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SegmentedButton<DoseBasis>(
                    segments: [
                      ButtonSegment(
                        value: DoseBasis.standard,
                        label: Text(l.oneStandardDose),
                      ),
                      ButtonSegment(
                        value: DoseBasis.loadSize,
                        label: Text(l.byLoadSize),
                      ),
                    ],
                    selected: {d.doseBasis},
                    showSelectedIcon: false,
                    onSelectionChanged: (s) {
                      if (s.isEmpty || s.first == d.doseBasis) return;
                      setState(() {
                        d.doseBasis = s.first;
                        d.baseValues.clear();
                        d.matrixValues.clear();
                        d.matrixNotListed.clear();
                      });
                    },
                  ),
                ),
                const SizedBox(height: AppMetrics.sectionGap),
                _unitPicker(),
                const SizedBox(height: AppMetrics.sectionGap),
                if (d.ruleStrategy == RuleStrategy.basePlusAdjustments)
                  _baseRules()
                else
                  _matrixSummary(),
                const SizedBox(height: AppMetrics.sectionGap),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(l.measurementTitle),
                  initiallyExpanded: d.markers.isNotEmpty,
                  children: [
                    if (d.type == DetergentType.liquid ||
                        d.type == DetergentType.powder)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: OutlinedButton.icon(
                          onPressed: _markers,
                          icon: const Icon(Icons.straighten),
                          label: Text(l.measurementTitle),
                        ),
                      ),
                  ],
                ),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(l.packageCostTitle),
                  initiallyExpanded: d.packagePrice != null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _packageCost(),
                    ),
                  ],
                ),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(l.advancedRules),
                  initiallyExpanded:
                      d.soilEnabled ||
                      d.waterEnabled ||
                      d.ruleStrategy == RuleStrategy.matrix,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: OutlinedButton.icon(
                        onPressed: _advanced,
                        icon: const Icon(Icons.tune),
                        label: Text(l.advancedRules),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  l.useOnlyPrintedValues,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 14),
                FilledButton(
                  onPressed: busy ? null : _save,
                  child: busy
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDiscard() async {
    if (_discardOpen || _allowPop || _saved) return;
    _discardOpen = true;
    final l = context.l10n;
    final yes =
        await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: Text(l.unsavedChangesTitle),
            content: Text(l.unsavedChangesBody),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: Text(l.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(c, true),
                child: Text(l.discard),
              ),
            ],
          ),
        ) ??
        false;
    _discardOpen = false;
    if (!yes || !mounted) return;
    setState(() => _allowPop = true);
    Navigator.of(context).pop(false);
  }

  Widget _unitPicker() {
    final l = context.l10n;
    final choices = switch (d.type) {
      DetergentType.liquid => const [
        DisplayUnit.ml,
        DisplayUnit.usFlOz,
        DisplayUnit.usTbsp,
        DisplayUnit.usTsp,
      ],
      DetergentType.powder => const [
        DisplayUnit.g,
        DisplayUnit.ozMass,
        DisplayUnit.scoop,
      ],
      DetergentType.pod => const [DisplayUnit.count],
      DetergentType.sheet => const [DisplayUnit.sheet],
    };
    return DropdownButtonFormField<DisplayUnit>(
      initialValue: d.preferredDisplayUnit,
      decoration: InputDecoration(labelText: l.unit),
      items: [
        for (final u in choices)
          DropdownMenuItem(value: u, child: Text(displayUnitLabel(context, u))),
      ],
      onChanged: (u) {
        if (u == null) return;
        final canonical = switch (u) {
          DisplayUnit.scoop => CanonicalUnit.scoop,
          DisplayUnit.g || DisplayUnit.ozMass => CanonicalUnit.g,
          DisplayUnit.count || DisplayUnit.sheet => CanonicalUnit.count,
          _ => CanonicalUnit.ml,
        };
        setState(() {
          if (canonical != d.canonicalUnit) {
            d.canonicalUnit = canonical;
            d.baseValues.clear();
            d.matrixValues.clear();
            d.matrixNotListed.clear();
            d.markers.clear();
            d.packageQuantityCanonical = null;
          }
          d.preferredDisplayUnit = u;
        });
      },
    );
  }

  Widget _baseRules() {
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.baseDose, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        for (final load in d.activeLoads) ...[
          DoseAmountField(
            key: ValueKey(
              'base-${DetergentDraft.baseKey(load)}-${d.preferredDisplayUnit.name}',
            ),
            label: load == null ? l.baseDose : loadLabel(context, load),
            displayUnit: d.preferredDisplayUnit,
            canonicalUnit: d.canonicalUnit,
            locale: locale,
            initialCanonical: d.baseValues[DetergentDraft.baseKey(load)],
            autofocus:
                widget.focusCode == 'base_missing' &&
                (d.doseBasis == DoseBasis.standard ||
                    load == widget.focusSelection?.load),
            onCanonicalChanged: (v) {
              if (v == null) {
                d.baseValues.remove(DetergentDraft.baseKey(load));
              } else {
                d.baseValues[DetergentDraft.baseKey(load)] = v;
              }
            },
          ),
          const SizedBox(height: 10),
        ],
        if (d.doseBasis == DoseBasis.loadSize)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.extraLarge),
            subtitle: Text(l.xlHelp),
            value: d.includeXl,
            onChanged: (v) => setState(() => d.includeXl = v),
          ),
      ],
    );
  }

  Widget _matrixSummary() {
    final l = context.l10n;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppMetrics.card),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.customMatrix,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(l.matrixHelp),
            const SizedBox(height: 12),
            Text(
              '${d.matrixValues.length} / ${d.requiredMatrixKeys().length}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            OutlinedButton(onPressed: _advanced, child: Text(l.edit)),
          ],
        ),
      ),
    );
  }

  Widget _packageCost() {
    final l = context.l10n;
    const currencies = ['USD', 'CAD', 'GBP', 'AUD', 'EUR', 'KRW', 'JPY'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.costOptionalHelp, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 12),
        DoseAmountField(
          key: ValueKey('package-${d.preferredDisplayUnit.name}'),
          label: l.packageQuantity,
          displayUnit: d.preferredDisplayUnit,
          canonicalUnit: d.canonicalUnit,
          locale: locale,
          initialCanonical: d.packageQuantityCanonical,
          onCanonicalChanged: (v) => d.packageQuantityCanonical = v,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: priceC,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: l.packagePrice),
          onChanged: (v) =>
              d.packagePrice = LocaleNumberParser.parse(v, locale),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          initialValue: d.currencyCode,
          decoration: InputDecoration(labelText: l.currency),
          items: [
            for (final c in currencies)
              DropdownMenuItem(value: c, child: Text(c)),
          ],
          onChanged: (v) => d.currencyCode = v,
        ),
      ],
    );
  }

  Future<void> _advanced() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AdvancedRulesPage(
          draft: d,
          focusSelection: widget.focusSelection,
          focusCode: widget.focusCode,
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> _markers() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => MeasureMarkersPage(draft: d)));
    if (mounted) setState(() {});
  }

  Future<void> _save() async {
    final l = context.l10n;
    d.packagePrice = LocaleNumberParser.parse(priceC.text, locale);
    final result = DraftValidator.validate(d);
    if (!result.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationMessage(context, result.errors.first)),
        ),
      );
      return;
    }
    if (result.warnings.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.checkLabelWarning)));
    }
    setState(() => busy = true);
    try {
      final repo = ref.read(detergentRepositoryProvider);
      final existing = await repo.getProfiles();
      if (existing.isEmpty) d.isDefault = true;
      await repo.saveBundle(d.toBundle());
      await repo.ensureDefaultAndSelect(d.id);
      if (d.originalPhotoRelativePath != null &&
          d.originalPhotoRelativePath != d.photoRelativePath) {
        await ref
            .read(photoServiceProvider)
            .delete(d.originalPhotoRelativePath);
      }
      if (mounted) {
        _saved = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.bundle == null ? l.setupComplete : l.changesSaved,
            ),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.errorSaveTitle)));
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }
}
