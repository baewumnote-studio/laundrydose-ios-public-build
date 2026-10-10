import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/domain/enums.dart';
import '../../core/localization/l10n.dart';
import '../../core/localization/labels.dart';
import '../../widgets/app_scaffold_body.dart';
import '../../widgets/state_views.dart';
import 'about_page.dart';
import 'help_page.dart';
import 'privacy_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final async = ref.watch(settingsProvider);
    return SafeArea(
      child: AppScaffoldBody(
        child: ListView(
          padding: const EdgeInsets.only(top: 22, bottom: 28),
          children: [
            Text(
              l.settingsTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 22),
            async.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (_, _) => AppErrorCard(
                title: l.errorGenericTitle,
                body: l.errorGenericBody,
                retryLabel: l.retry,
                onRetry: () => ref.invalidate(settingsProvider),
              ),
              data: (s) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context, l.appearance),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.brightness_6_outlined),
                          title: Text(l.theme),
                          subtitle: Text(_themeLabel(context, s.themeMode)),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _theme(context, ref, s.themeMode),
                        ),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: Text(l.language),
                          subtitle: Text(
                            _languageLabel(context, s.localeOverride),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () =>
                              _language(context, ref, s.localeOverride),
                        ),
                        ListTile(
                          leading: const Icon(Icons.straighten),
                          title: Text(l.units),
                          subtitle: Text(_unitsLabel(context, s.unitSystem)),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _units(context, ref, s.unitSystem),
                        ),
                        SwitchListTile(
                          title: Text(l.reduceMotion),
                          value:
                              s.reducedMotionOverride ==
                              ReducedMotionChoice.reduce,
                          onChanged: (v) => ref
                              .read(settingsRepositoryProvider)
                              .update(
                                reducedMotionOverride: v
                                    ? ReducedMotionChoice.reduce
                                    : ReducedMotionChoice.system,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _header(context, l.defaults),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(l.defaultLoad),
                          subtitle: Text(
                            loadLabel(context, s.defaultLoadLevel),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () =>
                              _defaultLoad(context, ref, s.defaultLoadLevel),
                        ),
                        ListTile(
                          title: Text(l.defaultSoil),
                          subtitle: Text(
                            soilLabel(context, s.defaultSoilLevel),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () =>
                              _defaultSoil(context, ref, s.defaultSoilLevel),
                        ),
                        ListTile(
                          title: Text(l.defaultWater),
                          subtitle: Text(
                            waterLabel(context, s.defaultWaterLevel),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () =>
                              _defaultWater(context, ref, s.defaultWaterLevel),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.privacy_tip_outlined),
                          title: Text(l.privacy),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const PrivacyPage(),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.help_outline),
                          title: Text(l.help),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const HelpPage()),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: Text(l.about),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AboutPage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext c, String x) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: Text(x, style: Theme.of(c).textTheme.titleMedium),
    ),
  );
  String _themeLabel(BuildContext c, ThemeChoice v) => switch (v) {
    ThemeChoice.system => c.l10n.system,
    ThemeChoice.light => c.l10n.themeLight,
    ThemeChoice.dark => c.l10n.dark,
  };
  String _unitsLabel(BuildContext c, UnitSystemChoice v) => switch (v) {
    UnitSystemChoice.auto => c.l10n.unitSystemAuto,
    UnitSystemChoice.metric => c.l10n.unitSystemMetric,
    UnitSystemChoice.us => c.l10n.unitSystemUS,
  };
  String _languageLabel(BuildContext c, String? v) => switch (v) {
    'en' => c.l10n.languageEnglish,
    'ko' => c.l10n.languageKorean,
    'ja' => c.l10n.languageJapanese,
    'de' => c.l10n.languageGerman,
    'fr' => c.l10n.languageFrench,
    'es' => c.l10n.languageSpanish,
    _ => c.l10n.followSystem,
  };
  Future<T?> _pick<T>(
    BuildContext c,
    String title,
    T current,
    List<(T, String)> values,
  ) => showModalBottomSheet<T>(
    context: c,
    showDragHandle: true,
    builder: (b) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(title, style: Theme.of(c).textTheme.titleMedium),
          ),
          for (final x in values)
            ListTile(
              title: Text(x.$2),
              trailing: x.$1 == current ? const Icon(Icons.check) : null,
              onTap: () => Navigator.pop(b, x.$1),
            ),
        ],
      ),
    ),
  );
  Future<void> _theme(BuildContext c, WidgetRef ref, ThemeChoice cur) async {
    final x = await _pick(c, c.l10n.theme, cur, [
      (ThemeChoice.system, c.l10n.system),
      (ThemeChoice.light, c.l10n.themeLight),
      (ThemeChoice.dark, c.l10n.dark),
    ]);
    if (x != null) {
      await ref.read(settingsRepositoryProvider).update(themeMode: x);
    }
  }

  Future<void> _units(
    BuildContext c,
    WidgetRef ref,
    UnitSystemChoice cur,
  ) async {
    final x = await _pick(c, c.l10n.units, cur, [
      (UnitSystemChoice.auto, c.l10n.unitSystemAuto),
      (UnitSystemChoice.metric, c.l10n.unitSystemMetric),
      (UnitSystemChoice.us, c.l10n.unitSystemUS),
    ]);
    if (x != null) {
      await ref.read(settingsRepositoryProvider).update(unitSystem: x);
    }
  }

  Future<void> _language(BuildContext c, WidgetRef ref, String? cur) async {
    final sentinel = cur ?? 'system';
    final x = await _pick(c, c.l10n.selectLanguage, sentinel, [
      ('system', c.l10n.followSystem),
      ('en', c.l10n.languageEnglish),
      ('ko', c.l10n.languageKorean),
      ('ja', c.l10n.languageJapanese),
      ('de', c.l10n.languageGerman),
      ('fr', c.l10n.languageFrench),
      ('es', c.l10n.languageSpanish),
    ]);
    if (x == 'system') {
      await ref.read(settingsRepositoryProvider).update(clearLocale: true);
    } else if (x != null) {
      await ref.read(settingsRepositoryProvider).update(localeOverride: x);
    }
  }

  Future<void> _defaultLoad(
    BuildContext c,
    WidgetRef ref,
    LoadLevel cur,
  ) async {
    final x = await _pick(c, c.l10n.defaultLoad, cur, [
      for (final v in LoadLevel.values) (v, loadLabel(c, v)),
    ]);
    if (x != null) {
      await ref.read(settingsRepositoryProvider).update(defaultLoadLevel: x);
    }
  }

  Future<void> _defaultSoil(
    BuildContext c,
    WidgetRef ref,
    SoilLevel cur,
  ) async {
    final x = await _pick(c, c.l10n.defaultSoil, cur, [
      for (final v in SoilLevel.values) (v, soilLabel(c, v)),
    ]);
    if (x != null) {
      await ref.read(settingsRepositoryProvider).update(defaultSoilLevel: x);
    }
  }

  Future<void> _defaultWater(
    BuildContext c,
    WidgetRef ref,
    WaterLevel cur,
  ) async {
    const vals = [
      WaterLevel.unknown,
      WaterLevel.soft,
      WaterLevel.medium,
      WaterLevel.hard,
    ];
    final x = await _pick(c, c.l10n.defaultWater, cur, [
      for (final v in vals) (v, waterLabel(c, v)),
    ]);
    if (x != null) {
      await ref.read(settingsRepositoryProvider).update(defaultWaterLevel: x);
    }
  }
}
