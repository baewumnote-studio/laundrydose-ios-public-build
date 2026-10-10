import 'package:flutter/material.dart';

import '../../../app/theme/design_tokens.dart';
import '../../../core/domain/detergent_draft.dart';
import '../../../core/domain/enums.dart';
import '../../../core/domain/models.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/localization/labels.dart';
import '../../../widgets/adjustment_field.dart';
import '../../../widgets/app_scaffold_body.dart';
import '../../../widgets/dose_amount_field.dart';

class AdvancedRulesPage extends StatefulWidget {
  const AdvancedRulesPage({
    super.key,
    required this.draft,
    this.focusSelection,
    this.focusCode,
  });

  final DetergentDraft draft;
  final DoseSelection? focusSelection;
  final String? focusCode;

  @override
  State<AdvancedRulesPage> createState() => _AdvancedRulesPageState();
}

class _AdvancedRulesPageState extends State<AdvancedRulesPage> {
  DetergentDraft get draft => widget.draft;
  String get locale => Localizations.localeOf(context).toLanguageTag();

  WaterLevel? get _focusedWater {
    final selected = widget.focusSelection?.water;
    if (selected == null) return null;
    if (selected != WaterLevel.unknown) return selected;
    return switch (draft.unknownWaterFallback) {
      'soft' => WaterLevel.soft,
      'hard' => WaterLevel.hard,
      'medium' || 'medium_if_present' => WaterLevel.medium,
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.advancedRules)),
      body: SafeArea(
        child: AppScaffoldBody(
          child: ListView(
            padding: const EdgeInsets.only(top: 8, bottom: 28),
            children: [
              if (widget.focusCode != null) ...[
                _focusCard(),
                const SizedBox(height: 16),
              ],
              Text(
                l.useOnlyPrintedValues,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.enableSoil),
                value: draft.soilEnabled,
                onChanged: (value) => setState(() {
                  draft.soilEnabled = value;
                  draft.soilAdjustments.clear();
                  _dimensionsChanged();
                }),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.enableWater),
                value: draft.waterEnabled,
                onChanged: (value) => setState(() {
                  draft.waterEnabled = value;
                  draft.waterAdjustments.clear();
                  draft.unknownWaterFallback = value
                      ? 'medium_if_present'
                      : null;
                  _dimensionsChanged();
                }),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<MachineVariant>(
                initialValue: draft.machineVariant,
                decoration: InputDecoration(
                  labelText: l.machineVariant,
                  helperText: l.machineVariantHelp,
                ),
                items: [
                  for (final machine in MachineVariant.values)
                    DropdownMenuItem(
                      value: machine,
                      child: Text(machineLabel(context, machine)),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => draft.machineVariant = value);
                  }
                },
              ),
              const SizedBox(height: AppMetrics.sectionGap),
              Text(l.ruleStyle, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              SegmentedButton<RuleStrategy>(
                segments: [
                  ButtonSegment(
                    value: RuleStrategy.basePlusAdjustments,
                    label: Text(l.simpleAdjustments),
                  ),
                  ButtonSegment(
                    value: RuleStrategy.matrix,
                    label: Text(l.fullTable),
                  ),
                ],
                selected: {draft.ruleStrategy},
                showSelectedIcon: false,
                onSelectionChanged: (selection) {
                  if (selection.isEmpty ||
                      selection.first == draft.ruleStrategy) {
                    return;
                  }
                  setState(() {
                    if (selection.first == RuleStrategy.matrix) {
                      _seedMatrix();
                    }
                    draft.ruleStrategy = selection.first;
                  });
                },
              ),
              const SizedBox(height: AppMetrics.sectionGap),
              if (draft.ruleStrategy == RuleStrategy.basePlusAdjustments)
                _adjustments()
              else
                _matrix(),
              const SizedBox(height: AppMetrics.sectionGap),
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

  Widget _focusCard() {
    final l = context.l10n;
    final selection = widget.focusSelection;
    final labels = <String>[];
    if (selection != null) {
      if (draft.doseBasis == DoseBasis.loadSize) {
        labels.add(loadLabel(context, selection.load));
      }
      if (draft.soilEnabled) {
        labels.add(soilLabel(context, selection.soil));
      }
      if (draft.waterEnabled) {
        labels.add(waterLabel(context, selection.water));
      }
    }
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(AppMetrics.card),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.missingRuleTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (labels.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(labels.join(' · ')),
            ],
            const SizedBox(height: 6),
            Text(l.missingRuleBody),
          ],
        ),
      ),
    );
  }

  void _dimensionsChanged() {
    if (draft.ruleStrategy == RuleStrategy.matrix) {
      draft.matrixValues.clear();
      draft.matrixNotListed.clear();
    }
  }

  void _seedMatrix() {
    if (draft.matrixValues.isNotEmpty) return;
    for (final load in draft.activeLoads) {
      final base = draft.baseValues[DetergentDraft.baseKey(load)];
      if (base == null) continue;
      for (final soil in draft.activeSoils) {
        final soilDelta = soil == null ? 0.0 : draft.soilAdjustments[soil.name];
        if (soilDelta == null) continue;
        for (final water in draft.activeWaters) {
          final waterDelta = water == null
              ? 0.0
              : draft.waterAdjustments[water.name];
          if (waterDelta == null) continue;
          final value = base + soilDelta + waterDelta;
          if (value > 0) {
            draft.matrixValues[DetergentDraft.matrixKey(load, soil, water)] =
                value;
          }
        }
      }
    }
  }

  Widget _adjustments() {
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (draft.soilEnabled) ...[
          Text(
            l.soilAdjustment,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          for (final soil in SoilLevel.values) ...[
            AdjustmentField(
              key: ValueKey(
                'soil-${soil.name}-${draft.preferredDisplayUnit.name}',
              ),
              title: soilLabel(context, soil),
              displayUnit: draft.preferredDisplayUnit,
              locale: locale,
              deltaCanonical: draft.soilAdjustments[soil.name],
              emphasized:
                  widget.focusCode == 'soil_adjustment_missing' &&
                  widget.focusSelection?.soil == soil,
              onChanged: (value) {
                if (value == null) {
                  draft.soilAdjustments.remove(soil.name);
                } else {
                  draft.soilAdjustments[soil.name] = value;
                }
              },
            ),
            const SizedBox(height: 10),
          ],
        ],
        if (draft.waterEnabled) ...[
          const SizedBox(height: 8),
          Text(
            l.waterAdjustment,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          for (final water in [
            WaterLevel.soft,
            WaterLevel.medium,
            WaterLevel.hard,
          ]) ...[
            AdjustmentField(
              key: ValueKey(
                'water-${water.name}-${draft.preferredDisplayUnit.name}',
              ),
              title: waterLabel(context, water),
              displayUnit: draft.preferredDisplayUnit,
              locale: locale,
              deltaCanonical: draft.waterAdjustments[water.name],
              emphasized:
                  widget.focusCode == 'water_adjustment_missing' &&
                  _focusedWater == water,
              onChanged: (value) {
                if (value == null) {
                  draft.waterAdjustments.remove(water.name);
                } else {
                  draft.waterAdjustments[water.name] = value;
                }
              },
            ),
            const SizedBox(height: 10),
          ],
          DropdownButtonFormField<String>(
            initialValue: draft.unknownWaterFallback,
            decoration: InputDecoration(
              labelText: l.unknown,
              helperText: l.unknownWaterHelp,
            ),
            items: [
              DropdownMenuItem(
                value: 'medium_if_present',
                child: Text(l.mediumFallbackNote),
              ),
              DropdownMenuItem(value: 'soft', child: Text(l.soft)),
              DropdownMenuItem(value: 'medium', child: Text(l.medium)),
              DropdownMenuItem(value: 'hard', child: Text(l.hard)),
            ],
            onChanged: (value) => draft.unknownWaterFallback = value,
          ),
        ],
      ],
    );
  }

  Widget _matrix() {
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.customMatrix, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 6),
        Text(l.matrixHelp, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 12),
        for (final key in draft.requiredMatrixKeys()) ...[
          _matrixRow(key),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  Widget _matrixRow(String key) {
    final l = context.l10n;
    final parts = key.split('|');
    final load = parts[0] == 'standard'
        ? null
        : enumFromDb(LoadLevel.values, parts[0]);
    final soil = parts[1] == 'none'
        ? null
        : enumFromDb(SoilLevel.values, parts[1]);
    final water = parts[2] == 'none'
        ? null
        : enumFromDb(WaterLevel.values, parts[2]);
    final labels = <String>[
      if (load != null) loadLabel(context, load),
      if (soil != null) soilLabel(context, soil),
      if (water != null) waterLabel(context, water),
    ];
    final focused =
        widget.focusCode == 'matrix_exact_match_missing' &&
        _matchesFocus(load, soil, water);
    final notListed = draft.matrixNotListed.contains(key);

    return Card(
      shape: focused
          ? RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labels.isEmpty ? l.baseDose : labels.join(' · '),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l.notListed),
              value: notListed,
              onChanged: (value) => setState(() {
                if (value == true) {
                  draft.matrixNotListed.add(key);
                  draft.matrixValues.remove(key);
                } else {
                  draft.matrixNotListed.remove(key);
                }
              }),
            ),
            if (!notListed)
              DoseAmountField(
                key: ValueKey('matrix-$key-${draft.preferredDisplayUnit.name}'),
                label: l.dose,
                displayUnit: draft.preferredDisplayUnit,
                canonicalUnit: draft.canonicalUnit,
                locale: locale,
                initialCanonical: draft.matrixValues[key],
                autofocus: focused,
                onCanonicalChanged: (value) {
                  if (value == null) {
                    draft.matrixValues.remove(key);
                  } else {
                    draft.matrixValues[key] = value;
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  bool _matchesFocus(LoadLevel? load, SoilLevel? soil, WaterLevel? water) {
    final selection = widget.focusSelection;
    if (selection == null) return false;
    final loadMatches = draft.doseBasis == DoseBasis.standard
        ? load == null
        : load == selection.load;
    final soilMatches = !draft.soilEnabled
        ? soil == null
        : soil == selection.soil;
    final waterMatches = !draft.waterEnabled
        ? water == null
        : water == _focusedWater;
    return loadMatches && soilMatches && waterMatches;
  }
}
