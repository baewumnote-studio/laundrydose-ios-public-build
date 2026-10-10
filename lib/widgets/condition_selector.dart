import 'package:flutter/material.dart';
import '../app/theme/design_tokens.dart';

class ConditionSelector<T> extends StatelessWidget {
  const ConditionSelector({
    super.key,
    required this.title,
    required this.value,
    required this.values,
    required this.labelBuilder,
    required this.onChanged,
    this.helper,
  });
  final String title;
  final T value;
  final List<T> values;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onChanged;
  final String? helper;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<T>(
            segments: [
              for (final v in values)
                ButtonSegment(value: v, label: Text(labelBuilder(v))),
            ],
            selected: {value},
            showSelectedIcon: false,
            onSelectionChanged: (s) {
              if (s.isNotEmpty) onChanged(s.first);
            },
          ),
        ),
        if (helper != null) ...[
          const SizedBox(height: 8),
          Text(helper!, style: Theme.of(context).textTheme.bodySmall),
        ],
        const SizedBox(height: AppMetrics.sectionGap),
      ],
    );
  }
}
