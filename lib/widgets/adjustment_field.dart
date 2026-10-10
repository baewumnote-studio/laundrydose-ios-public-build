import 'package:flutter/material.dart';

import '../core/domain/enums.dart';
import '../core/formatters/number_formatters.dart';
import '../core/localization/l10n.dart';
import '../core/localization/labels.dart';
import '../core/units/unit_converter.dart';

class AdjustmentField extends StatefulWidget {
  const AdjustmentField({
    super.key,
    required this.title,
    required this.displayUnit,
    required this.locale,
    required this.deltaCanonical,
    required this.onChanged,
    this.emphasized = false,
  });

  final String title;
  final DisplayUnit displayUnit;
  final String locale;
  final double? deltaCanonical;
  final ValueChanged<double?> onChanged;
  final bool emphasized;

  @override
  State<AdjustmentField> createState() => _AdjustmentFieldState();
}

class _AdjustmentFieldState extends State<AdjustmentField> {
  AdjustmentDirection? direction;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    direction = _directionFor(widget.deltaCanonical);
    controller = TextEditingController(text: _textFor(widget.deltaCanonical));
  }

  @override
  void didUpdateWidget(covariant AdjustmentField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.deltaCanonical != widget.deltaCanonical ||
        oldWidget.displayUnit != widget.displayUnit) {
      direction = _directionFor(widget.deltaCanonical);
      controller.text = _textFor(widget.deltaCanonical);
    }
  }

  AdjustmentDirection? _directionFor(double? value) {
    if (value == null) return null;
    if (value > 0) return AdjustmentDirection.increase;
    if (value < 0) return AdjustmentDirection.decrease;
    return AdjustmentDirection.noChange;
  }

  String _textFor(double? value) {
    if (value == null || value == 0) return '';
    return DoseFormatter.numeric(
      value.abs(),
      widget.displayUnit,
      widget.locale,
    );
  }

  void _emit() {
    final selected = direction;
    if (selected == null) {
      widget.onChanged(null);
      return;
    }
    if (selected == AdjustmentDirection.noChange) {
      widget.onChanged(0);
      return;
    }
    final parsed = LocaleNumberParser.parse(controller.text, widget.locale);
    if (parsed == null) {
      widget.onChanged(null);
      return;
    }
    final canonical = UnitConverter.toCanonical(parsed, widget.displayUnit);
    widget.onChanged(
      selected == AdjustmentDirection.decrease ? -canonical : canonical,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Card(
      shape: widget.emphasized
          ? RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            DropdownButtonFormField<AdjustmentDirection>(
              initialValue: direction,
              decoration: InputDecoration(hintText: l.selectAdjustment),
              items: [
                DropdownMenuItem(
                  value: AdjustmentDirection.increase,
                  child: Text(l.increase),
                ),
                DropdownMenuItem(
                  value: AdjustmentDirection.decrease,
                  child: Text(l.decrease),
                ),
                DropdownMenuItem(
                  value: AdjustmentDirection.noChange,
                  child: Text(l.noChange),
                ),
              ],
              onChanged: (value) {
                setState(() => direction = value);
                _emit();
              },
            ),
            if (direction != null &&
                direction != AdjustmentDirection.noChange) ...[
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: l.amount,
                  suffixText: displayUnitLabel(context, widget.displayUnit),
                ),
                onChanged: (_) => _emit(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
