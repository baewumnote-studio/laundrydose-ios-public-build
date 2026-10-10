import 'package:flutter/material.dart';

class DoseResultCard extends StatelessWidget {
  const DoseResultCard({
    super.key,
    required this.title,
    required this.amount,
    required this.unit,
    required this.caption,
    this.marker,
    this.costLabel,
    this.cost,
  });
  final String title, amount, unit, caption;
  final String? marker, costLabel, cost;
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final ink = dark ? const Color(0xFF172D39) : const Color(0xFFF9F6EF);
    final muted = dark ? const Color(0xFF3D5967) : const Color(0xFFC8D8DF);
    return Container(
      decoration: BoxDecoration(
        color: dark ? const Color(0xFFAACBDD) : const Color(0xFF24485D),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: ink,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ExcludeSemantics(
                  child: Icon(Icons.water_drop_outlined, color: ink, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Semantics(
              container: true,
              label: '$amount $unit',
              excludeSemantics: true,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 10,
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 64,
                      height: 1.08,
                      letterSpacing: -2,
                      fontWeight: FontWeight.w600,
                      color: ink,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Text(
                      unit,
                      style: TextStyle(fontSize: 22, color: ink),
                    ),
                  ),
                ],
              ),
            ),
            if (marker != null) ...[
              const SizedBox(height: 8),
              Text(
                marker!,
                style: TextStyle(
                  color: ink,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              caption,
              style: TextStyle(fontSize: 12, height: 1.5, color: muted),
            ),
            if (cost != null) ...[
              const SizedBox(height: 14),
              Divider(color: muted.withValues(alpha: .35)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      costLabel ?? '',
                      style: TextStyle(color: muted, fontSize: 13),
                    ),
                  ),
                  Text(
                    cost!,
                    style: TextStyle(color: ink, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
