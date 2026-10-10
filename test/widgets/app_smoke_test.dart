import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/app/app.dart';
import 'package:laundry_dose/app/providers.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/data/db/app_database.dart';
import 'package:laundry_dose/data/repositories/detergent_repository.dart';
import 'package:laundry_dose/data/repositories/history_repository.dart';
import 'package:laundry_dose/data/repositories/settings_repository.dart';
import 'package:laundry_dose/features/detergents/editor/detergent_basics_page.dart';
import 'package:laundry_dose/l10n/generated/app_localizations.dart';
import 'package:laundry_dose/widgets/dose_result_card.dart';

import '../helpers/fixtures.dart';

const capture = bool.fromEnvironment('CAPTURE_SMOKE_SCREENSHOTS');
final boundaryKey = GlobalKey();

Future<T> databaseTask<T>(WidgetTester tester, Future<T> task) async {
  var completed = false;
  late T result;
  Object? error;
  task.then(
    (value) {
      result = value;
      completed = true;
    },
    onError: (Object value) {
      error = value;
      completed = true;
    },
  );
  for (var i = 0; i < 50 && !completed; i++) {
    await tester.pump(const Duration(milliseconds: 20));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
  }
  expect(
    completed,
    isTrue,
    reason: 'Database task did not finish while pumping stream updates',
  );
  if (error != null) throw error!;
  return result;
}

Future<void> waitFor(WidgetTester tester, Finder finder) async {
  for (var i = 0; i < 50; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) {
      await tester.pumpAndSettle();
      return;
    }
  }
  expect(finder, findsWidgets);
}

Future<void> screenshot(WidgetTester tester, String name) async {
  if (!capture) return;
  final boundary =
      boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 2);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    final folder = Directory('verification/screenshots')
      ..createSync(recursive: true);
    File(
      '${folder.path}/$name.png',
    ).writeAsBytesSync(data!.buffer.asUint8List());
    image.dispose();
  });
}

Future<void> startApp(WidgetTester tester, AppDatabase db) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: RepaintBoundary(key: boundaryKey, child: const LaundryDoseApp()),
    ),
  );
}

void main() {
  setUpAll(() async {
    if (!capture || !Platform.isWindows) return;
    final font = FontLoader('Roboto');
    font.addFont(
      File(
        'C:/Windows/Fonts/malgun.ttf',
      ).readAsBytes().then(ByteData.sublistView),
    );
    await font.load();
    final sdkRoot = Platform.environment['FLUTTER_ROOT'];
    if (sdkRoot != null) {
      final icons = FontLoader('MaterialIcons');
      icons.addFont(
        File(
          '$sdkRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
        ).readAsBytes().then(ByteData.sublistView),
      );
      await icons.load();
    }
  });

  testWidgets(
    'first launch reaches detergent setup without advertising interruption',
    (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      await tester.runAsync(
        () => SettingsRepository(db).update(localeOverride: 'ko'),
      );
      await startApp(tester, db);
      final l = lookupAppLocalizations(const Locale('ko'));
      await waitFor(tester, find.text(l.enterManually));
      await screenshot(tester, 'onboarding-ko');
      await tester.ensureVisible(find.text(l.enterManually));
      await tester.tap(find.text(l.enterManually));
      await waitFor(tester, find.byType(DetergentBasicsPage));
      expect(find.text(l.addDetergentTitle), findsOneWidget);
      expect(tester.takeException(), isNull);
      final adState = await databaseTask(tester, AdStateRepository(db).get());
      expect(adState.adsShownToday, 0);
      await tester.pumpWidget(const SizedBox.shrink());
      await databaseTask(tester, db.close());
    },
  );

  for (final locale in ['en', 'ko', 'ja', 'de', 'fr', 'es']) {
    testWidgets(
      '$locale starts, calculates 35 mL, logs a wash and shows history/settings',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await tester.runAsync(() async {
          final repository = DetergentRepository(db);
          final bundle = liquidBundle();
          await repository.saveBundle(bundle);
          await repository.ensureDefaultAndSelect(bundle.profile.id);
          await SettingsRepository(
            db,
          ).update(onboardingCompleted: true, localeOverride: locale);
        });
        await startApp(tester, db);
        final l = lookupAppLocalizations(Locale(locale));
        await waitFor(tester, find.byType(DoseResultCard));
        expect(find.text('35'), findsOneWidget);
        expect(find.text('mL'), findsWidgets);
        expect(tester.takeException(), isNull);
        if (locale == 'ko') await screenshot(tester, 'calculator-ko');
        final logButton = find.widgetWithText(FilledButton, l.logWash);
        await tester.ensureVisible(logButton);
        await tester.tap(logButton);
        await waitFor(tester, find.text(l.washLogged));
        final logs = await databaseTask(
          tester,
          HistoryRepository(db).watchLogs().first,
        );
        expect(logs, hasLength(1));
        expect(logs.single.amountCanonical, 35);
        expect(logs.single.detergentNameSnapshot, 'Test');
        await tester.pump(const Duration(seconds: 2));
        await tester.tap(find.text(l.tabHistory));
        await tester.pumpAndSettle();
        expect(find.text('Test'), findsWidgets);
        expect(tester.takeException(), isNull);
        if (locale == 'ko') await screenshot(tester, 'history-ko');
        await tester.tap(find.text(l.tabSettings));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await databaseTask(
          tester,
          SettingsRepository(db).update(themeMode: ThemeChoice.dark),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        if (locale == 'ko') await screenshot(tester, 'settings-dark-ko');
        await tester.pumpWidget(const SizedBox.shrink());
        await databaseTask(tester, db.close());
      },
    );
  }
}
