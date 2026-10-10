import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/core/domain/enums.dart';
import 'package:laundry_dose/core/scan/label_parser.dart';
import 'package:laundry_dose/core/units/unit_converter.dart';

void main() {
  List<LabelDoseCandidate> parse(
    List<String> text, {
    DetergentType type = DetergentType.liquid,
  }) => LabelParser().parse(
    text.map((x) => LabelTextLine(x, .99)).toList(),
    type,
  );

  test('extracts explicit load rows and converts US tablespoons exactly', () {
    final result = parse([
      'Small load: 1 tbsp',
      'Medium load: 1 1/2 tbsp',
      'Large load: 2 tbsp',
    ]);
    expect(result.map((x) => x.load), [
      LoadLevel.small,
      LoadLevel.medium,
      LoadLevel.large,
    ]);
    expect(result[1].amount, 1.5);
    expect(result[1].canonical, closeTo(1.5 * UnitConverter.usTbspMl, 1e-10));
    expect(result[1].evidence, 'Medium load: 1 1/2 tbsp');
  });
  test('supports fractional US fluid ounces and teaspoons', () {
    expect(
      parse(['Use 1/2 fl. oz. per load']).single.canonical,
      closeTo(UnitConverter.usFlOzMl / 2, 1e-10),
    );
    expect(parse(['Use ¾ tsp per load']).single.amount, .75);
  });
  test('reads standard dosing without manufacturing load sizes', () {
    final result = parse(['Use 35 mL per load']);
    expect(result.single.load, isNull);
    expect(result.single.amount, 35);
  });
  test('plural load instructions are distinguished from advertised counts', () {
    expect(parse(['Medium loads: 35 mL']).single.load, LoadLevel.medium);
    expect(parse(['64 loads, use 35 mL']), isEmpty);
  });
  test('mixed standard and size-specific schemes require manual review', () {
    expect(parse(['Use 35 mL per load', 'Medium load 45 mL']), isEmpty);
  });
  test('rejects package volume and advertised wash counts', () {
    expect(
      parse([
        'NET 64 fl oz',
        '64 loads',
        'Bottle contains 2 fl oz per load',
        'Contents 100 mL',
        '64 wash loads 35 mL',
      ]),
      isEmpty,
    );
  });
  test('never turns cap markers or unscoped amounts into a dose', () {
    expect(
      parse(['Medium load: Line 2', 'Fill cap to 3', '35 mL', '60 oz']),
      isEmpty,
    );
  });
  test('leaves competing machine and soil instructions to manual entry', () {
    expect(
      parse([
        'HE medium load 20 mL',
        'Medium heavy soil 40 mL',
        'Hard water small 30 mL',
        'Top load use 60 mL',
        'Use 20 or 35 mL',
        'Use 20–35 mL',
        'Use 20 to 35 mL',
      ]),
      isEmpty,
    );
  });
  test(
    'standalone conditional table headings prevent automatic row assignment',
    () {
      expect(
        parse(['HE washers', 'Small load 20 mL', 'Medium load 35 mL']),
        isEmpty,
      );
      expect(parse(['Hard water', 'Small load 20 mL']), isEmpty);
    },
  );
  test('does not join split table headings and numbers', () {
    expect(parse(['Small Medium Large', '20 mL 35 mL 50 mL']), isEmpty);
  });
  test('duplicate load rows remain unresolved even with the same number', () {
    expect(parse(['Medium load 35 mL', 'Medium load 35 mL']), isEmpty);
  });
  test('rejects dual units in one row instead of picking one silently', () {
    expect(parse(['Medium load 2 tbsp (30 mL)']), isEmpty);
  });
  test('rejects low OCR confidence and zero amounts', () {
    expect(
      LabelParser().parse([
        const LabelTextLine('Medium load 35 mL', .79),
      ], DetergentType.liquid),
      isEmpty,
    );
    expect(parse(['Use 0 mL', 'Use 1/0 tbsp']), isEmpty);
  });
  test(
    'does not misread a decimal comma or partial fraction as a new number',
    () {
      expect(parse(['Medium load 12,5 mL', 'Use 1½ tbsp']), isEmpty);
    },
  );
  test('powder units cannot become liquid quantities', () {
    expect(parse(['Medium load 35 g']), isEmpty);
    expect(
      parse(['Medium load 35 g'], type: DetergentType.powder).single.amount,
      35,
    );
  });
  test('pods must be whole and sheets must be half increments', () {
    expect(parse(['Use 1/2 pod per load'], type: DetergentType.pod), isEmpty);
    expect(
      parse(['Use 2 pods per load'], type: DetergentType.pod).single.amount,
      2,
    );
    expect(
      parse([
        'Use 1/2 sheet per load',
      ], type: DetergentType.sheet).single.amount,
      .5,
    );
    expect(
      parse(['Use 1/3 sheet per load'], type: DetergentType.sheet),
      isEmpty,
    );
  });
}
