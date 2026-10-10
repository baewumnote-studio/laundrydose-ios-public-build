import 'package:flutter/material.dart';
import '../core/domain/enums.dart';
import '../core/localization/l10n.dart';
import '../core/localization/labels.dart';

class LoadSizePicker extends StatelessWidget {
  const LoadSizePicker({
    super.key,
    required this.value,
    required this.values,
    required this.helper,
    required this.onChanged,
  });
  final LoadLevel value;
  final List<LoadLevel> values;
  final String helper;
  final ValueChanged<LoadLevel> onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.loadSize, style: theme.textTheme.titleMedium),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final level in values)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Semantics(
                    selected: value == level,
                    child: OutlinedButton(
                      onPressed: () => onChanged(level),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        minimumSize: const Size(86, 88),
                        backgroundColor: value == level
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.surface,
                        side: BorderSide(
                          color: value == level
                              ? theme.colorScheme.primary
                              : theme.dividerColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ExcludeSemantics(
                            child: SizedBox.square(
                              dimension: 34,
                              child: CustomPaint(
                                painter: _Drum(
                                  level,
                                  theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(loadLabel(context, level)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(helper, style: theme.textTheme.bodySmall),
        const SizedBox(height: 6),
        Text(
          context.l10n.loadVisualNote,
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _Drum extends CustomPainter {
  const _Drum(this.level, this.color);
  final LoadLevel level;
  final Color color;
  @override
  void paint(Canvas c, Size s) {
    final center = Offset(s.width / 2, s.height / 2);
    final r = s.width / 2 - 2;
    c.drawCircle(
      center,
      r,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    final inner = Path()
      ..addOval(Rect.fromCircle(center: center, radius: r - 3));
    c.save();
    c.clipPath(inner);
    final fraction = switch (level) {
      LoadLevel.small => .33,
      LoadLevel.medium => .5,
      LoadLevel.large => .75,
      LoadLevel.xl => .9,
    };
    final y = s.height * (1 - fraction);
    c.drawPath(
      Path()
        ..moveTo(0, y)
        ..quadraticBezierTo(s.width * .3, y - 4, s.width * .55, y)
        ..quadraticBezierTo(s.width * .8, y + 4, s.width, y)
        ..lineTo(s.width, s.height)
        ..lineTo(0, s.height)
        ..close(),
      Paint()..color = color.withValues(alpha: .7),
    );
    c.restore();
  }

  @override
  bool shouldRepaint(_Drum oldDelegate) =>
      oldDelegate.level != level || oldDelegate.color != color;
}
