import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/widgets/dose_result_card.dart';

Widget host({ThemeMode mode = ThemeMode.light, double textScale = 1}) =>
    MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: mode,
      home: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
        child: const Scaffold(
          body: DoseResultCard(
            title: 'Label dose',
            amount: '45',
            unit: 'mL',
            caption: 'Saved label',
            marker: '≈ Line 2',
            costLabel: 'This wash',
            cost: r'$0.33',
          ),
        ),
      ),
    );

void main() {
  testWidgets('result card renders amount marker and cost', (tester) async {
    await tester.pumpWidget(host());
    expect(find.text('45'), findsOneWidget);
    expect(find.text('mL'), findsOneWidget);
    expect(find.text('≈ Line 2'), findsOneWidget);
    expect(find.text(r'$0.33'), findsOneWidget);
  });

  testWidgets('result card survives dark mode and large dynamic type', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(host(mode: ThemeMode.dark, textScale: 2));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('45'), findsOneWidget);
  });

  testWidgets('amount exposes a combined semantic label', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(host());
    expect(find.bySemanticsLabel('45 mL'), findsOneWidget);
    semantics.dispose();
  });
}
