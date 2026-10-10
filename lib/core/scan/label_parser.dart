import '../domain/enums.dart';
import '../units/unit_converter.dart';

class LabelTextLine {
  const LabelTextLine(this.text, this.confidence);
  final String text;
  final double confidence;
}

class LabelDoseCandidate {
  const LabelDoseCandidate({
    required this.load,
    required this.amount,
    required this.unit,
    required this.evidence,
  });
  final LoadLevel? load;
  final double amount;
  final DisplayUnit unit;
  final String evidence;
  double get canonical => UnitConverter.toCanonical(amount, unit);
}

/// A conservative extraction step after on-device OCR. Never invents a dose,
/// joins table columns, resolves competing amounts, or converts cap lines.
class LabelParser {
  static final _amount = RegExp(
    r'(?<![\d.,/])(\d+\s+\d+/\d+|\d+/\d+|\d+(?:\.\d+)?|[¼½¾])\s*(ml|fl\.?\s*oz\.?|tbsp\.?|tablespoons?|tsp\.?|teaspoons?|grams?|g|pods?|sheets?)\b',
    caseSensitive: false,
  );
  static final _package = RegExp(
    r'\b(net|contents|bottle|package|ingredients|warning|caution|keep out|per bottle)\b|\b\d+\s+(?:wash\s+)?loads?\b',
    caseSensitive: false,
  );
  static final _conditional = RegExp(
    r'\b(he|non-he|top|front|hard|soft|heavy|heavily|soil|prewash|hand|stain|add|extra|maximum|max)\b|\bor\b|\bto\b|[-–—]',
    caseSensitive: false,
  );

  List<LabelDoseCandidate> parse(
    List<LabelTextLine> lines,
    DetergentType type,
  ) {
    // Flattened OCR loses table columns. Conditional headings make automatic
    // row assignment unsafe, so leave those labels to manual review.
    if (lines.any(
      (line) =>
          RegExp(
            r'^\s*(he|non[ -]?he|hard water|soft water|heavy soil|heavily soiled)\b',
            caseSensitive: false,
          ).hasMatch(line.text) &&
          !_amount.hasMatch(line.text),
    )) {
      return [];
    }
    final found = <String, List<LabelDoseCandidate>>{};
    for (final line in lines) {
      final text = line.text.trim();
      if (line.confidence < .80 ||
          _package.hasMatch(text) ||
          _conditional.hasMatch(text)) {
        continue;
      }
      final matches = _amount.allMatches(text).toList();
      if (matches.length != 1) {
        continue;
      }
      final match = matches.single;
      final unit = _unit(match[2]!);
      if (unit == null ||
          !UnitConverter.validDisplayUnits(
            type,
            type == DetergentType.liquid
                ? CanonicalUnit.ml
                : type == DetergentType.powder
                ? CanonicalUnit.g
                : CanonicalUnit.count,
          ).contains(unit)) {
        continue;
      }
      final loadMatches = RegExp(
        r'\b(extra large|xl|small|medium|large)\b',
        caseSensitive: false,
      ).allMatches(text).toList();
      if (loadMatches.length > 1) {
        continue;
      }
      final LoadLevel? load;
      if (loadMatches.isNotEmpty) {
        load = switch (loadMatches.single[0]!.toLowerCase()) {
          'small' => LoadLevel.small,
          'medium' => LoadLevel.medium,
          'large' => LoadLevel.large,
          _ => LoadLevel.xl,
        };
      } else {
        if (!RegExp(
          r'\b(per loads?|each load|standard dose|use|normal loads?|regular loads?)\b',
          caseSensitive: false,
        ).hasMatch(text)) {
          continue;
        }
        load = null;
      }
      final value = _number(match[1]!);
      if (value == null || value <= 0 || !value.isFinite) {
        continue;
      }
      if (type == DetergentType.pod && value != value.roundToDouble()) {
        continue;
      }
      if (type == DetergentType.sheet &&
          value * 2 != (value * 2).roundToDouble()) {
        continue;
      }
      final candidate = LabelDoseCandidate(
        load: load,
        amount: value,
        unit: unit,
        evidence: text,
      );
      found.putIfAbsent(load?.name ?? 'standard', () => []).add(candidate);
    }
    // Even identical repeated lines require manual review; they may belong to
    // different machine/soil columns whose headings were not read by OCR.
    final candidates = [
      for (final group in found.values)
        if (group.length == 1) group.single,
    ];
    if (candidates.any((x) => x.load == null) &&
        candidates.any((x) => x.load != null)) {
      return [];
    }
    return candidates;
  }

  DisplayUnit? _unit(String raw) {
    final x = raw.toLowerCase().replaceAll(RegExp(r'[\s.]'), '');
    if (x == 'ml') {
      return DisplayUnit.ml;
    }
    if (x == 'floz') {
      return DisplayUnit.usFlOz;
    }
    if (x == 'tbsp' || x.startsWith('tablespoon')) {
      return DisplayUnit.usTbsp;
    }
    if (x == 'tsp' || x.startsWith('teaspoon')) {
      return DisplayUnit.usTsp;
    }
    if (x == 'g' || x.startsWith('gram')) {
      return DisplayUnit.g;
    }
    if (x.startsWith('pod')) {
      return DisplayUnit.count;
    }
    if (x.startsWith('sheet')) {
      return DisplayUnit.sheet;
    }
    return null;
  }

  double? _number(String raw) {
    final x = raw.trim();
    if (x == '¼') {
      return .25;
    }
    if (x == '½') {
      return .5;
    }
    if (x == '¾') {
      return .75;
    }
    if (!x.contains('/')) {
      return double.tryParse(x);
    }
    final pieces = x.split(RegExp(r'\s+'));
    final fraction = pieces.last.split('/');
    final denominator = double.tryParse(fraction.last);
    final numerator = double.tryParse(fraction.first);
    if (denominator == null || denominator == 0 || numerator == null) {
      return null;
    }
    return (pieces.length == 2 ? double.tryParse(pieces.first) ?? 0 : 0) +
        numerator / denominator;
  }
}
