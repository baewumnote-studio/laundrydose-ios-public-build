import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundry_dose/app/app.dart';
import 'package:laundry_dose/app/providers.dart';
import 'package:laundry_dose/core/domain/detergent_draft.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/core/scan/label_parser.dart';
import 'package:laundry_dose/core/units/unit_converter.dart';
import 'package:laundry_dose/data/db/app_database.dart';
import 'package:laundry_dose/data/repositories/detergent_repository.dart';
import 'package:laundry_dose/data/repositories/settings_repository.dart';
import 'package:laundry_dose/features/detergents/editor/dose_setup_page.dart';
import 'package:laundry_dose/l10n/generated/app_localizations.dart';
import 'package:laundry_dose/services/photo_service.dart';
import 'package:laundry_dose/services/label_scan_service.dart';
import 'package:laundry_dose/widgets/dose_result_card.dart';
import 'app_smoke_test.dart' as smoke;
import '../helpers/preview_assets.dart';

class FakePhotos extends PhotoService {
  FakePhotos(this.file);
  final File file;
  final List<String?> deleted = [];
  @override
  Future<String?> pickAndStore(ImageSource source) async =>
      'label_photos/example.png';
  @override
  Future<File?> resolve(String? relative) async => file;
  @override
  Future<void> delete(String? relative) async {
    deleted.add(relative);
  }
}

class FakeReader extends LabelScanService {
  @override
  bool get isSupported => true;
  @override
  Future<List<LabelTextLine>> read(String path) async => const [
    LabelTextLine('NET 64 fl oz', .99),
    LabelTextLine('Small load 1 tbsp', .99),
    LabelTextLine('Medium load 1 1/2 tbsp', .99),
    LabelTextLine('Large load 2 tbsp', .99),
  ];
}

Future<void> reveal(WidgetTester tester, Finder target) async {
  final scrollable = find
      .byWidgetPredicate(
        (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
      )
      .last;
  if (target.evaluate().isEmpty) {
    tester.state<ScrollableState>(scrollable).position.jumpTo(0);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      target,
      140,
      scrollable: scrollable,
      maxScrolls: 30,
    );
  } else {
    await tester.ensureVisible(target);
  }
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    if (smoke.capture) {
      await exportAppIcons();
    }
    if (!smoke.capture || !Platform.isWindows) {
      return;
    }
    final font = FontLoader('Roboto')
      ..addFont(
        File(
          'C:/Windows/Fonts/segoeui.ttf',
        ).readAsBytes().then(ByteData.sublistView),
      );
    await font.load();
    final sdk = Platform.environment['FLUTTER_ROOT'];
    if (sdk != null) {
      final icons = FontLoader('MaterialIcons')
        ..addFont(
          File(
            '$sdk/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
          ).readAsBytes().then(ByteData.sublistView),
        );
      await icons.load();
    }
  });
  testWidgets(
    'US wash, remembered load, shelf shortcut, journal and dark mode',
    (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      await tester.runAsync(() async {
        final d = DetergentDraft.newDraft()
          ..name = 'Everyday liquid'
          ..preferredDisplayUnit = DisplayUnit.usTbsp
          ..packageQuantityCanonical = 2100
          ..packagePrice = 12.99
          ..currencyCode = 'USD';
        d.baseValues.addAll({
          'small': UnitConverter.usTbspMl,
          'medium': 1.5 * UnitConverter.usTbspMl,
          'large': 2 * UnitConverter.usTbspMl,
        });
        d.markers.add(
          DraftMarker(
            id: 'cap-1',
            label: 'Line 1',
            amountCanonical: 1.5 * UnitConverter.usTbspMl,
          ),
        );
        await DetergentRepository(db).saveBundle(d.toBundle());
        await DetergentRepository(db).ensureDefaultAndSelect(d.id);
        await SettingsRepository(db).update(
          onboardingCompleted: true,
          localeOverride: 'en',
          unitSystem: UnitSystemChoice.us,
        );
      });
      await smoke.startApp(tester, db);
      final l = lookupAppLocalizations(const Locale('en'));
      await smoke.waitFor(tester, find.byType(DoseResultCard));
      expect(find.text('1.5'), findsOneWidget);
      expect(find.text('tbsp'), findsWidgets);
      expect(tester.takeException(), isNull);
      await smoke.screenshot(tester, 'wash-en');
      await tester.tap(find.text(l.large));
      await tester.pumpAndSettle();
      expect(find.text('2'), findsOneWidget);
      final settings = await smoke.databaseTask(
        tester,
        SettingsRepository(db).get(),
      );
      expect(settings.defaultLoadLevel, LoadLevel.large);
      await tester.tap(find.text(l.medium));
      await tester.pumpAndSettle();
      final log = find.widgetWithText(FilledButton, l.logWash);
      await reveal(tester, log);
      await tester.tap(log);
      await smoke.waitFor(tester, find.text(l.washLogged));
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(find.text(l.tabHistory));
      await tester.pumpAndSettle();
      await smoke.screenshot(tester, 'journal-en');
      await tester.tap(find.text(l.tabDetergents));
      await tester.pumpAndSettle();
      await smoke.screenshot(tester, 'shelf-en');
      await tester.tap(find.widgetWithText(TextButton, l.useForWash));
      await smoke.waitFor(tester, find.text(l.homeTitle));
      await smoke.databaseTask(
        tester,
        SettingsRepository(db).update(themeMode: ThemeChoice.dark),
      );
      await tester.pumpAndSettle();
      await smoke.screenshot(tester, 'wash-dark-en');
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      for (final tab in [l.tabDetergents, l.tabHistory, l.tabSettings]) {
        await tester.tap(find.text(tab));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      await tester.pumpWidget(const SizedBox.shrink());
      await smoke.databaseTask(tester, db.close());
    },
  );

  testWidgets(
    'scan requires evidence confirmation, saves reviewed values, retains photo',
    (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      late File file;
      await tester.runAsync(() async {
        file = await createTestLabel();
        await SettingsRepository(
          db,
        ).update(onboardingCompleted: true, localeOverride: 'en');
      });
      final photos = FakePhotos(file);
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(db),
            photoServiceProvider.overrideWithValue(photos),
            labelScanServiceProvider.overrideWithValue(FakeReader()),
          ],
          child: RepaintBoundary(
            key: smoke.boundaryKey,
            child: const LaundryDoseApp(),
          ),
        ),
      );
      final l = lookupAppLocalizations(const Locale('en'));
      await smoke.waitFor(tester, find.text(l.scanLabel));
      await tester.runAsync(
        () => precacheImage(
          FileImage(file),
          tester.element(find.byType(Scaffold).first),
        ),
      );
      await reveal(tester, find.text(l.scanLabel));
      await tester.tap(find.text(l.scanLabel));
      await tester.pumpAndSettle();
      await reveal(tester, find.text(l.takePhoto));
      await tester.tap(find.text(l.takePhoto));
      await tester.pumpAndSettle();
      expect(find.text(l.reviewScan), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Everyday liquid');
      final next = find.widgetWithText(FilledButton, l.continueReview);
      await reveal(tester, next);
      expect(tester.widget<FilledButton>(next).onPressed, isNull);
      expect(
        await smoke.databaseTask(tester, DetergentRepository(db).getProfiles()),
        isEmpty,
      );
      for (final text in [
        'Small load 1 tbsp',
        'Medium load 1 1/2 tbsp',
        'Large load 2 tbsp',
      ]) {
        final row = find.widgetWithText(CheckboxListTile, text);
        await reveal(tester, row);
        await tester.tap(row);
        await tester.pump();
      }
      if (smoke.capture) {
        tester
            .state<ScrollableState>(
              find
                  .byWidgetPredicate(
                    (w) =>
                        w is Scrollable &&
                        w.axisDirection == AxisDirection.down,
                  )
                  .last,
            )
            .position
            .jumpTo(0);
        await tester.pumpAndSettle();
        await smoke.screenshot(tester, 'label-review-en');
      }
      await reveal(tester, next);
      await tester.tap(next);
      await tester.pumpAndSettle();
      expect(find.byType(DoseSetupPage), findsOneWidget);
      final save = find.widgetWithText(FilledButton, l.save);
      await reveal(tester, save);
      await tester.tap(save);
      await smoke.waitFor(tester, find.byType(DoseResultCard));
      final profiles = await smoke.databaseTask(
        tester,
        DetergentRepository(db).getProfiles(),
      );
      expect(profiles, hasLength(1));
      expect(profiles.single.preferredDisplayUnit, DisplayUnit.usTbsp);
      expect(profiles.single.photoRelativePath, 'label_photos/example.png');
      expect(photos.deleted.where((x) => x != null), isEmpty);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      await smoke.databaseTask(tester, db.close());
    },
  );
  testWidgets(
    'one saved dose exposes load setup and only uses confirmed size amounts',
    (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      final draft = DetergentDraft.newDraft()
        ..name = 'Single-dose detergent'
        ..doseBasis = DoseBasis.standard;
      draft.baseValues['standard'] = 35;
      await tester.runAsync(() async {
        await DetergentRepository(db).saveBundle(draft.toBundle());
        await DetergentRepository(db).ensureDefaultAndSelect(draft.id);
        await SettingsRepository(
          db,
        ).update(onboardingCompleted: true, localeOverride: 'en');
      });
      await smoke.startApp(tester, db);
      tester.view.physicalSize = const Size(375, 812);
      await tester.pumpAndSettle();
      final l = lookupAppLocalizations(const Locale('en'));
      await smoke.waitFor(tester, find.byType(DoseResultCard));
      expect(find.text('35'), findsOneWidget);
      await reveal(tester, find.text(l.addLoadSizeAmounts));
      expect(find.text(l.loadSize), findsOneWidget);
      expect(find.text(l.standardDoseLoadHelp), findsOneWidget);
      expect(find.text(l.small), findsNothing);
      await smoke.screenshot(tester, 'single-dose-load-size-en');
      await tester.tap(find.text(l.addLoadSizeAmounts));
      await tester.pumpAndSettle();
      expect(find.byType(DoseSetupPage), findsOneWidget);
      expect(find.text(l.oneStandardDose), findsOneWidget);
      // Opening and cancelling the editor must preserve the saved single dose.
      await tester.pageBack();
      await smoke.waitFor(tester, find.byType(DoseResultCard));
      final unchanged = await smoke.databaseTask(
        tester,
        DetergentRepository(db).getBundle(draft.id),
      );
      expect(unchanged!.profile.doseBasis, DoseBasis.standard);
      expect(unchanged.rules.single.amountCanonical, 35);
      await reveal(tester, find.text(l.addLoadSizeAmounts));
      await tester.tap(find.text(l.addLoadSizeAmounts));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text(l.byLoadSize));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l.byLoadSize));
      await tester.pumpAndSettle();
      for (final entry in {
        l.small: '15',
        l.medium: '35',
        l.large: '50',
      }.entries) {
        final field = find.widgetWithText(TextField, entry.key);
        await reveal(tester, field);
        await tester.enterText(field, entry.value);
      }
      final save = find.widgetWithText(FilledButton, l.save);
      await reveal(tester, save);
      await tester.tap(save);
      await smoke.waitFor(tester, find.byType(DoseResultCard));
      await reveal(tester, find.text(l.small));
      await tester.tap(find.text(l.small));
      await tester.pumpAndSettle();
      expect(find.text('15'), findsOneWidget);
      await tester.tap(find.text(l.large));
      await tester.pumpAndSettle();
      expect(find.text('50'), findsOneWidget);
      expect(find.text(l.addLoadSizeAmounts), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      await smoke.databaseTask(tester, db.close());
    },
  );
  testWidgets(
    'English welcome and scan fallback remain usable at 200 percent type',
    (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      await tester.runAsync(
        () => SettingsRepository(db).update(localeOverride: 'en'),
      );
      await smoke.startApp(tester, db);
      final l = lookupAppLocalizations(const Locale('en'));
      await smoke.waitFor(tester, find.text(l.welcomeTitle));
      await smoke.screenshot(tester, 'welcome-en');
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await reveal(tester, find.text(l.scanLabel));
      await tester.tap(find.text(l.scanLabel));
      await tester.pumpAndSettle();
      await reveal(tester, find.text(l.scanUnavailable));
      expect(find.text(l.scanUnavailable), findsOneWidget);
      await reveal(tester, find.text(l.enterManually));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      await smoke.databaseTask(tester, db.close());
    },
  );
}
