import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/providers.dart';
import '../../app/theme/design_tokens.dart';
import '../../core/calculation/dose_calculator.dart';
import '../../core/domain/enums.dart';
import '../../core/domain/models.dart';
import '../../core/formatters/number_formatters.dart';
import '../../core/localization/l10n.dart';
import '../../core/localization/labels.dart';
import '../../widgets/app_scaffold_body.dart';
import '../../widgets/condition_selector.dart';
import '../../widgets/dose_result_card.dart';
import '../../widgets/state_views.dart';
import '../detergents/detergent_actions.dart';
import '../../widgets/laundry_art.dart';
import '../../widgets/load_size_picker.dart';
import '../detergents/editor/dose_setup_page.dart';
import '../settings/help_page.dart';

class DosePage extends ConsumerStatefulWidget {
  const DosePage({super.key});
  @override
  ConsumerState<DosePage> createState() => _DosePageState();
}

class _DosePageState extends ConsumerState<DosePage> {
  String? _profileId;
  DoseSelection? _selection;
  bool _logging = false;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final profilesAsync = ref.watch(profilesProvider);
    final bundleAsync = ref.watch(selectedBundleProvider);
    final settings = ref.watch(settingsProvider).value;
    final profiles = profilesAsync.value ?? const <DetergentProfileModel>[];

    final bundle = bundleAsync.value;
    final selection = bundle == null
        ? null
        : _effectiveSelection(bundle, settings);
    final calculation = bundle == null || selection == null
        ? null
        : const DoseCalculator().calculate(bundle, selection);
    return SafeArea(
      child: AppScaffoldBody(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18, bottom: 18),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l.appName,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  l.homeTitle,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge,
                                ),
                                const SizedBox(height: 6),
                                Text(l.washSubtitle),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: l.help,
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const HelpPage(),
                              ),
                            ),
                            icon: const Icon(Icons.help_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (profilesAsync.isLoading || bundleAsync.isLoading)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  else if (profilesAsync.hasError || bundleAsync.hasError)
                    SliverToBoxAdapter(
                      child: AppErrorCard(
                        title: l.errorGenericTitle,
                        body: l.errorGenericBody,
                        retryLabel: l.retry,
                        onRetry: () {
                          ref.invalidate(profilesProvider);
                          ref.invalidate(selectedBundleProvider);
                        },
                      ),
                    )
                  else if (profiles.isEmpty)
                    const SliverToBoxAdapter(child: AddDetergentPanel())
                  else
                    _content(profiles, bundleAsync.value, settings),
                ],
              ),
            ),
            if (bundle != null &&
                selection != null &&
                calculation?.isOk == true)
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 12),
                child: FilledButton.icon(
                  onPressed: _logging
                      ? null
                      : () => _log(bundle, selection, calculation!),
                  icon: _logging
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check_circle_outline),
                  label: Text(l.logWash),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _content(
    List<DetergentProfileModel> profiles,
    DetergentBundle? bundle,
    AppSettingsModel? settings,
  ) {
    final l = context.l10n;
    if (bundle == null) {
      return SliverToBoxAdapter(
        child: AppErrorCard(
          title: l.errorGenericTitle,
          body: l.errorGenericBody,
          retryLabel: l.retry,
          onRetry: () => ref.invalidate(selectedBundleProvider),
        ),
      );
    }
    final p = bundle.profile;
    final availableLoads = _availableLoads(bundle);
    final fallback = _effectiveSelection(bundle, settings);
    if (p.doseBasis == DoseBasis.loadSize && availableLoads.isEmpty) {
      return SliverList.list(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppMetrics.card),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.invalidProfileTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(l.invalidProfileBody),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: () => _editInvalidProfile(bundle),
                    icon: const Icon(Icons.tune),
                    label: Text(l.reviewProfile),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    final selection = fallback;
    if (_profileId != p.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _profileId = p.id;
            _selection = fallback;
          });
        }
      });
    }
    final calc = const DoseCalculator().calculate(bundle, selection);

    return SliverList.list(
      children: [
        Card(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 5,
            ),
            leading: BottleMark(type: p.detergentType),
            title: Text(p.name, style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(
              [
                detergentTypeLabel(context, p.detergentType),
                if (p.brand?.isNotEmpty ?? false) p.brand!,
              ].join(' · '),
            ),
            trailing: const Icon(Icons.unfold_more, size: 20),
            onTap: () => _chooseDetergent(profiles, p.id),
          ),
        ),
        const SizedBox(height: 18),
        if (calc.isOk) ...[
          _result(bundle, selection, calc),
          const SizedBox(height: 22),
        ],
        if (p.doseBasis == DoseBasis.loadSize)
          LoadSizePicker(
            value: selection.load,
            values: availableLoads,
            helper: _loadHelp(selection.load),
            onChanged: (v) => _remember(selection.copyWith(load: v)),
          )
        else
          _standardLoadSize(bundle),
        if (p.soilEnabled)
          ConditionSelector<SoilLevel>(
            title: l.soil,
            value: selection.soil,
            values: SoilLevel.values,
            labelBuilder: (v) => soilLabel(context, v),
            onChanged: (v) => _remember(selection.copyWith(soil: v)),
          ),
        if (p.waterEnabled)
          ConditionSelector<WaterLevel>(
            title: l.water,
            value: selection.water,
            values: const [
              WaterLevel.unknown,
              WaterLevel.soft,
              WaterLevel.medium,
              WaterLevel.hard,
            ],
            labelBuilder: (v) => waterLabel(context, v),
            helper: selection.water == WaterLevel.unknown
                ? l.unknownWaterHelp
                : null,
            onChanged: (v) => _remember(selection.copyWith(water: v)),
          ),
        if (calc.status == DoseStatus.missingRule) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppMetrics.card),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.edit_note,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l.missingRuleTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(l.missingRuleBody),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: () => _editMissing(bundle, selection, calc),
                    icon: const Icon(Icons.add),
                    label: Text(l.addLabelValue),
                  ),
                ],
              ),
            ),
          ),
        ] else if (!calc.isOk) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppMetrics.card),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l.invalidProfileTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(l.invalidProfileBody),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: () => _editInvalidProfile(bundle),
                    icon: const Icon(Icons.tune),
                    label: Text(l.reviewProfile),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 28),
      ],
    );
  }

  DoseSelection _effectiveSelection(
    DetergentBundle bundle,
    AppSettingsModel? settings,
  ) {
    final p = bundle.profile;
    final availableLoads = _availableLoads(bundle);
    final requestedLoad = settings?.defaultLoadLevel ?? LoadLevel.medium;
    final resolvedLoad = availableLoads.contains(requestedLoad)
        ? requestedLoad
        : availableLoads.contains(LoadLevel.medium)
        ? LoadLevel.medium
        : availableLoads.isNotEmpty
        ? availableLoads.first
        : LoadLevel.medium;
    final fallback = DoseSelection(
      load: resolvedLoad,
      soil: settings?.defaultSoilLevel ?? SoilLevel.normal,
      water: settings?.defaultWaterLevel ?? WaterLevel.unknown,
    );
    final previous = _profileId == p.id ? _selection : null;
    final selection =
        previous != null &&
            (p.doseBasis == DoseBasis.standard ||
                availableLoads.contains(previous.load))
        ? previous
        : fallback;
    return selection;
  }

  Widget _standardLoadSize(DetergentBundle bundle) {
    final l = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.loadSize, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Text(l.oneStandardDose),
          const SizedBox(height: 6),
          Text(
            l.standardDoseLoadHelp,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _editInvalidProfile(bundle),
            icon: const Icon(Icons.tune),
            label: Text(l.addLoadSizeAmounts),
          ),
        ],
      ),
    );
  }

  Widget _result(
    DetergentBundle bundle,
    DoseSelection selection,
    DoseCalculation calc,
  ) {
    final l = context.l10n;
    final p = bundle.profile;
    final amount = calc.amountCanonical!;
    final numeric = DoseFormatter.numeric(
      amount,
      p.preferredDisplayUnit,
      Localizations.localeOf(context).toLanguageTag(),
    );
    final unit = displayUnitLabel(
      context,
      p.preferredDisplayUnit,
      canonical: amount,
    );
    final marker = DoseCalculator.markerMatch(bundle.markers, amount);
    final markerText = switch (marker?.type) {
      MarkerMatchType.near => l.nearMarker(marker!.first),
      MarkerMatchType.between => l.betweenMarkers(
        marker!.first,
        marker.second!,
      ),
      MarkerMatchType.below => l.belowFirstMarker(marker!.first),
      MarkerMatchType.above => l.aboveLastMarker(marker!.first),
      null => null,
    };
    final cost = DoseCalculator.costPerWash(p, amount);
    final costText = cost != null && p.currencyCode != null
        ? DoseFormatter.formatCost(
            cost,
            p.currencyCode!,
            Localizations.localeOf(context).toLanguageTag(),
          )
        : null;
    return DoseResultCard(
      title: l.forThisLoad,
      amount: numeric,
      unit: unit,
      marker: markerText,
      costLabel: l.costThisWash,
      cost: costText,
      caption: l.basedOnYourLabel,
    );
  }

  List<LoadLevel> _availableLoads(DetergentBundle bundle) {
    if (bundle.profile.doseBasis == DoseBasis.standard) {
      return const [LoadLevel.medium];
    }
    final present = <LoadLevel>{
      for (final rule in bundle.rules)
        if (rule.loadLevel != null) rule.loadLevel!,
    };
    return [
      for (final load in LoadLevel.values)
        if (present.contains(load)) load,
    ];
  }

  String _loadHelp(LoadLevel level) => switch (level) {
    LoadLevel.small => context.l10n.smallHelp,
    LoadLevel.medium => context.l10n.mediumHelp,
    LoadLevel.large => context.l10n.largeHelp,
    LoadLevel.xl => context.l10n.xlHelp,
  };

  void _remember(DoseSelection selection) {
    setState(() => _selection = selection);
    ref
        .read(settingsRepositoryProvider)
        .update(
          defaultLoadLevel: selection.load,
          defaultSoilLevel: selection.soil,
          defaultWaterLevel: selection.water,
        )
        .catchError((Object _) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.errorGenericBody)),
            );
          }
        });
  }

  Future<void> _chooseDetergent(
    List<DetergentProfileModel> profiles,
    String selected,
  ) async {
    final id = await showModalBottomSheet<String>(
      context: context,
      builder: (c) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(
                c.l10n.chooseDetergent,
                style: Theme.of(c).textTheme.headlineSmall,
              ),
            ),
            for (final profile in profiles)
              ListTile(
                leading: BottleMark(size: 40, type: profile.detergentType),
                title: Text(profile.name),
                trailing: profile.id == selected
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => Navigator.pop(c, profile.id),
              ),
            ListTile(
              leading: const Icon(Icons.add),
              title: Text(c.l10n.addDetergent),
              onTap: () => Navigator.pop(c, '__add__'),
            ),
          ],
        ),
      ),
    );
    if (!mounted || id == null) {
      return;
    }
    if (id == '__add__') {
      await showAddDetergent(context);
    } else {
      await ref
          .read(settingsRepositoryProvider)
          .update(selectedDetergentId: id);
    }
  }

  Future<void> _editMissing(
    DetergentBundle bundle,
    DoseSelection selection,
    DoseCalculation calculation,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DoseSetupPage.edit(
          bundle: bundle,
          focusSelection: selection,
          focusCode: calculation.messageCode,
        ),
      ),
    );
  }

  Future<void> _editInvalidProfile(DetergentBundle bundle) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DoseSetupPage.edit(bundle: bundle)),
    );
  }

  Future<void> _log(
    DetergentBundle bundle,
    DoseSelection selection,
    DoseCalculation calc,
  ) async {
    setState(() => _logging = true);
    final p = bundle.profile;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final amount = DoseFormatter.numeric(
      calc.amountCanonical!,
      p.preferredDisplayUnit,
      locale,
    );
    final unit = displayUnitLabel(
      context,
      p.preferredDisplayUnit,
      canonical: calc.amountCanonical!,
    );
    try {
      final outcome = await ref
          .read(logWashServiceProvider)
          .log(
            bundle: bundle,
            selection: selection,
            calculation: calc,
            displayAmount: amount,
            displayUnit: unit,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.washLogged),
          duration: const Duration(milliseconds: 900),
        ),
      );
      // The completed task is acknowledged before any eligible interstitial.
      await Future<void>.delayed(const Duration(milliseconds: 650));
      if (!mounted) return;
      await ref
          .read(logWashServiceProvider)
          .showEligibleAdAfterFeedback(outcome);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.errorGenericBody)));
      }
    } finally {
      if (mounted) setState(() => _logging = false);
    }
  }
}
