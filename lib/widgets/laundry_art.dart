import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/domain/enums.dart';

/// Original vector illustrations. They stay sharp at every accessibility scale.
class LaundryArt extends StatelessWidget {
  const LaundryArt({super.key, this.height = 248});
  final double height;
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _LaundryPainter()),
    ),
  );
}

class _LaundryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = math.min(size.width / 340, size.height / 250);
    canvas.translate(
      (size.width - 340 * scale) / 2,
      (size.height - 250 * scale) / 2,
    );
    canvas.scale(scale);
    final p = Paint();
    void rounded(Rect r, double radius, Color color) => canvas.drawRRect(
      RRect.fromRectAndRadius(r, Radius.circular(radius)),
      p..color = color,
    );
    canvas.drawOval(
      const Rect.fromLTWH(18, 224, 310, 18),
      p..color = const Color(0xFFE1DED4),
    );
    rounded(const Rect.fromLTWH(64, 31, 191, 199), 22, const Color(0xFFD1E1E8));
    rounded(const Rect.fromLTWH(73, 40, 173, 181), 16, const Color(0xFFFAFCFA));
    canvas.drawLine(
      const Offset(74, 80),
      const Offset(245, 80),
      p
        ..color = const Color(0xFFD1E1E8)
        ..strokeWidth = 2,
    );
    rounded(const Rect.fromLTWH(87, 53, 50, 14), 4, const Color(0xFFD1E1E8));
    canvas.drawCircle(
      const Offset(219, 60),
      9,
      p..color = const Color(0xFF24485D),
    );
    canvas.drawCircle(
      const Offset(194, 60),
      3,
      p..color = const Color(0xFFDFA778),
    );
    canvas.drawCircle(
      const Offset(160, 147),
      57,
      p..color = const Color(0xFF24485D),
    );
    canvas.drawCircle(
      const Offset(160, 147),
      45,
      p..color = const Color(0xFF9BBFCF),
    );
    canvas.save();
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: Offset(160, 147), radius: 44)),
    );
    final cloth = Path()
      ..moveTo(106, 155)
      ..quadraticBezierTo(124, 128, 157, 159)
      ..quadraticBezierTo(180, 183, 211, 143)
      ..lineTo(213, 202)
      ..lineTo(106, 202)
      ..close();
    canvas.drawPath(cloth, p..color = const Color(0xFFF5E9CD));
    final cloth2 = Path()
      ..moveTo(107, 181)
      ..quadraticBezierTo(128, 151, 169, 180)
      ..quadraticBezierTo(195, 196, 219, 162)
      ..lineTo(219, 205)
      ..lineTo(107, 205)
      ..close();
    canvas.drawPath(cloth2, p..color = const Color(0xFFDFA778));
    canvas.restore();
    canvas.drawArc(
      Rect.fromCircle(center: Offset(160, 147), radius: 38),
      3.7,
      .8,
      false,
      p
        ..color = const Color(0xFFD7E8EF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
    p.style = PaintingStyle.fill;
    rounded(const Rect.fromLTWH(244, 157, 67, 72), 12, const Color(0xFF6E96A8));
    rounded(const Rect.fromLTWH(260, 138, 29, 25), 5, const Color(0xFF6E96A8));
    rounded(const Rect.fromLTWH(260, 133, 29, 11), 3, const Color(0xFF24485D));
    rounded(const Rect.fromLTWH(253, 174, 48, 34), 6, const Color(0xFFF5E9CD));
    canvas.drawPath(
      Path()
        ..moveTo(277, 179)
        ..quadraticBezierTo(292, 195, 277, 200)
        ..quadraticBezierTo(264, 195, 277, 179),
      p..color = const Color(0xFF24485D),
    );
    rounded(const Rect.fromLTWH(30, 186, 61, 17), 5, const Color(0xFFDFA778));
    rounded(const Rect.fromLTWH(21, 205, 76, 22), 6, const Color(0xFFF5E9CD));
    canvas.drawLine(
      const Offset(31, 215),
      const Offset(86, 215),
      p
        ..color = const Color(0xFFE6D5AC)
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(_LaundryPainter oldDelegate) => false;
}

class BottleMark extends StatelessWidget {
  const BottleMark({
    super.key,
    this.size = 48,
    this.type = DetergentType.liquid,
  });
  final double size;
  final DetergentType type;
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: CustomPaint(
        painter: _BottlePainter(Theme.of(context).colorScheme.primary, type),
      ),
    ),
  );
}

class _BottlePainter extends CustomPainter {
  const _BottlePainter(this.color, this.type);
  final Color color;
  final DetergentType type;
  @override
  void paint(Canvas c, Size s) {
    c.scale(s.width / 48, s.height / 48);
    final p = Paint()..color = color;
    if (type == DetergentType.powder) {
      c.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(13, 9, 23, 32),
          const Radius.circular(3),
        ),
        p,
      );
      c.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(17, 16, 15, 17),
          const Radius.circular(2),
        ),
        Paint()..color = const Color(0xFFF5E9CD),
      );
      for (final point in [
        const Offset(22, 23),
        const Offset(27, 23),
        const Offset(25, 28),
      ]) {
        c.drawCircle(point, 1.8, p);
      }
      return;
    }
    if (type == DetergentType.pod) {
      c.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(10, 12, 29, 25),
          const Radius.circular(12),
        ),
        Paint()..color = const Color(0xFFF5E9CD),
      );
      c.drawCircle(const Offset(20, 23), 7, p);
      c.drawCircle(
        const Offset(29, 27),
        6,
        Paint()..color = const Color(0xFF9BBFCF),
      );
      return;
    }
    if (type == DetergentType.sheet) {
      c.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(10, 17, 26, 25),
          const Radius.circular(3),
        ),
        p,
      );
      c.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(14, 9, 26, 25),
          const Radius.circular(3),
        ),
        Paint()..color = const Color(0xFFF5E9CD),
      );
      for (final y in [17.0, 22.0, 27.0]) {
        c.drawLine(
          Offset(20, y),
          Offset(34, y),
          Paint()
            ..color = color
            ..strokeWidth = 1.5,
        );
      }
      return;
    }
    c.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(15, 18, 19, 23),
        const Radius.circular(5),
      ),
      p,
    );
    c.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(20, 8, 9, 10),
        const Radius.circular(2),
      ),
      p,
    );
    c.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(19, 25, 11, 8),
        const Radius.circular(2),
      ),
      Paint()..color = const Color(0xFFF5E9CD),
    );
  }

  @override
  bool shouldRepaint(_BottlePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.type != type;
}
