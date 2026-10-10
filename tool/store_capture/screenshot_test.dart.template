// A native Simulator capture harness. This file is never a shipping entrypoint.
// All data below is synthetic and independent of the owner's phone or database.
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:laundry_dose/app/app.dart';
import 'package:laundry_dose/app/providers.dart';
import 'package:laundry_dose/core/domain/detergent_draft.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/core/units/unit_converter.dart';
import 'package:laundry_dose/data/db/app_database.dart';
import 'package:laundry_dose/data/repositories/detergent_repository.dart';
import 'package:laundry_dose/data/repositories/settings_repository.dart';
import 'package:laundry_dose/l10n/generated/app_localizations.dart';
import 'package:laundry_dose/widgets/dose_result_card.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('native English Store screens from preserved app widgets', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final draft = DetergentDraft.newDraft()
      ..name = 'Everyday liquid'
      ..preferredDisplayUnit = DisplayUnit.usTbsp
      ..packageQuantityCanonical = 2100
      ..packagePrice = 12.99
      ..currencyCode = 'USD';
    draft.baseValues.addAll({
      'small': UnitConverter.usTbspMl,
      'medium': 1.5 * UnitConverter.usTbspMl,
      'large': 2 * UnitConverter.usTbspMl,
    });
    draft.markers.add(DraftMarker(
      id: 'synthetic-cap-1', label: 'Line 1',
      amountCanonical: 1.5 * UnitConverter.usTbspMl,
    ));
    await DetergentRepository(db).saveBundle(draft.toBundle());
    await DetergentRepository(db).ensureDefaultAndSelect(draft.id);
    final settings = SettingsRepository(db);
    await settings.update(onboardingCompleted: true, localeOverride: 'en',
      themeMode: ThemeChoice.light, unitSystem: UnitSystemChoice.us);
    await tester.pumpWidget(ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const LaundryDoseApp(),
    ));
    final l = lookupAppLocalizations(const Locale('en'));
    Future<void> waitFor(Finder finder) async {
      for (var i = 0; i < 100 && finder.evaluate().isEmpty; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(finder, findsWidgets);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
    Future<void> capture(String name) async {
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await binding.takeScreenshot(name);
    }
    await waitFor(find.byType(DoseResultCard));
    await capture('01-wash');
    await tester.tap(find.text(l.large));
    await tester.pumpAndSettle();
    expect(find.text('2'), findsOneWidget);
    await capture('02-load-size');
    await tester.tap(find.text(l.medium));
    await tester.pumpAndSettle();
    final log = find.widgetWithText(FilledButton, l.logWash);
    await tester.ensureVisible(log);
    await tester.pumpAndSettle();
    await tester.tap(log);
    await waitFor(find.text(l.washLogged));
    await tester.pump(const Duration(seconds: 5));
    await tester.tap(find.text(l.tabHistory));
    await waitFor(find.text('Everyday liquid'));
    await capture('03-journal');
    await tester.tap(find.text(l.tabDetergents));
    await tester.pumpAndSettle();
    await capture('04-detergents');
    await tester.tap(find.text(l.tabDose));
    await settings.update(themeMode: ThemeChoice.dark);
    await tester.pumpAndSettle();
    // Return the actual calculator's own scrolling content to its initial top.
    for (final scrollable in find.byType(Scrollable).evaluate()) {
      final state = tester.state<ScrollableState>(find.byElementPredicate((e) => e == scrollable));
      if (state.widget.axisDirection == AxisDirection.down) state.position.jumpTo(0);
    }
    await capture('05-dark-mode');
    await tester.pumpWidget(const SizedBox.shrink());
    await db.close();
  });
}
