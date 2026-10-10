import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/widgets/condition_selector.dart';

void main() {
  testWidgets(
    'selector tolerates long localized labels without overflow exception',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 320,
              child: ConditionSelector<String>(
                title: 'Load',
                value: 'small',
                values: const ['small', 'medium', 'large', 'xl'],
                labelBuilder: (v) => '$v — intentionally long localized label',
                helper: 'Helper text',
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('selector reports a changed value', (tester) async {
    String selected = 'a';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => ConditionSelector<String>(
              title: 'Choice',
              value: selected,
              values: const ['a', 'b'],
              labelBuilder: (v) => v.toUpperCase(),
              onChanged: (v) => setState(() => selected = v),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('B'));
    await tester.pump();
    expect(selected, 'b');
  });
}
