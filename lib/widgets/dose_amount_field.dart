import 'package:flutter/material.dart';
import '../core/domain/enums.dart';
import '../core/formatters/number_formatters.dart';
import '../core/localization/labels.dart';
import '../core/units/unit_converter.dart';

class DoseAmountField extends StatefulWidget {
  const DoseAmountField({
    super.key,
    required this.label,
    required this.displayUnit,
    required this.canonicalUnit,
    required this.locale,
    this.initialCanonical,
    required this.onCanonicalChanged,
    this.enabled = true,
    this.autofocus = false,
  });
  final String label;
  final DisplayUnit displayUnit;
  final CanonicalUnit canonicalUnit;
  final String locale;
  final double? initialCanonical;
  final ValueChanged<double?> onCanonicalChanged;
  final bool enabled;
  final bool autofocus;
  @override
  State<DoseAmountField> createState() => _DoseAmountFieldState();
}

class _DoseAmountFieldState extends State<DoseAmountField> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _text(widget.initialCanonical));
  }

  @override
  void didUpdateWidget(covariant DoseAmountField old) {
    super.didUpdateWidget(old);
    if (old.initialCanonical != widget.initialCanonical ||
        old.displayUnit != widget.displayUnit) {
      final t = _text(widget.initialCanonical);
      if (_controller.text != t) _controller.text = t;
    }
  }

  String _text(double? canonical) => canonical == null
      ? ''
      : DoseFormatter.numeric(canonical, widget.displayUnit, widget.locale);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: _controller,
    enabled: widget.enabled,
    autofocus: widget.autofocus,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
      labelText: widget.label,
      suffixText: displayUnitLabel(
        context,
        widget.displayUnit,
        canonical: widget.initialCanonical,
      ),
    ),
    onChanged: (raw) {
      final parsed = LocaleNumberParser.parse(raw, widget.locale);
      widget.onCanonicalChanged(
        parsed == null
            ? null
            : UnitConverter.toCanonical(parsed, widget.displayUnit),
      );
    },
  );
}
