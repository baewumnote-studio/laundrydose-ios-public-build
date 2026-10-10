import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Export original vector artwork at each iOS size without resampling a bitmap.
Future<void> exportAppIcons() async {
  final folder = Directory('ios/Runner/Assets.xcassets/AppIcon.appiconset');
  final spec =
      jsonDecode(File('${folder.path}/Contents.json').readAsStringSync())
          as Map;
  for (final entry in spec['images'] as List) {
    final pixels =
        (double.parse((entry['size'] as String).split('x').first) *
                double.parse((entry['scale'] as String).replaceAll('x', '')))
            .round();
    final recorder = ui.PictureRecorder();
    final c = Canvas(recorder)..scale(pixels / 1024);
    final p = Paint();
    c.drawRect(
      const Rect.fromLTWH(0, 0, 1024, 1024),
      p..color = const Color(0xFF24485D),
    );
    c.drawPath(
      Path()
        ..moveTo(276, 298)
        ..lineTo(310, 718)
        ..quadraticBezierTo(314, 766, 362, 766)
        ..lineTo(662, 766)
        ..quadraticBezierTo(710, 766, 714, 718)
        ..lineTo(748, 298)
        ..close(),
      p..color = const Color(0xFFF5E9CD),
    );
    c.drawPath(
      Path()
        ..moveTo(323, 346)
        ..lineTo(352, 708)
        ..quadraticBezierTo(354, 722, 370, 722)
        ..lineTo(654, 722)
        ..quadraticBezierTo(670, 722, 672, 708)
        ..lineTo(701, 346)
        ..close(),
      p..color = const Color(0xFF24485D),
    );
    c.drawPath(
      Path()
        ..moveTo(489, 399)
        ..cubicTo(464, 435, 416, 488, 416, 530)
        ..cubicTo(416, 579, 449, 610, 489, 610)
        ..cubicTo(529, 610, 562, 579, 562, 530)
        ..cubicTo(562, 488, 514, 435, 489, 399)
        ..close(),
      p..color = const Color(0xFF9BBFCF),
    );
    p
      ..color = const Color(0xFFF5E9CD)
      ..strokeWidth = 17
      ..strokeCap = StrokeCap.round;
    for (final line in [
      [608.0, 433.0, 690.0],
      [632.0, 492.0, 685.0],
      [608.0, 551.0, 680.0],
      [632.0, 610.0, 675.0],
    ]) {
      c.drawLine(Offset(line[0], line[1]), Offset(line[2], line[1]), p);
    }
    final picture = recorder.endRecording();
    final image = await picture.toImage(pixels, pixels);
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    File(
      '${folder.path}/${entry['filename']}',
    ).writeAsBytesSync(_opaquePng(data!, pixels));
    image.dispose();
    picture.dispose();
  }
}

// iOS marketing icons require a PNG with no alpha channel. Encode the fully
// opaque vector rendering as RGB without changing or resampling its pixels.
Uint8List _opaquePng(ByteData pixels, int size) {
  final scanlines = BytesBuilder();
  for (var y = 0; y < size; y++) {
    scanlines.addByte(0);
    for (var x = 0; x < size; x++) {
      final i = (y * size + x) * 4;
      if (pixels.getUint8(i + 3) != 255) {
        throw StateError('Icon is not opaque');
      }
      scanlines.add([
        pixels.getUint8(i),
        pixels.getUint8(i + 1),
        pixels.getUint8(i + 2),
      ]);
    }
  }
  final header = ByteData(13)
    ..setUint32(0, size)
    ..setUint32(4, size)
    ..setUint8(8, 8)
    ..setUint8(9, 2);
  final png = BytesBuilder()..add([137, 80, 78, 71, 13, 10, 26, 10]);
  void chunk(String type, List<int> data) {
    final content = [...utf8.encode(type), ...data];
    var crc = 0xffffffff;
    for (final byte in content) {
      crc ^= byte;
      for (var bit = 0; bit < 8; bit++) {
        crc = (crc & 1) == 1 ? (crc >> 1) ^ 0xedb88320 : crc >> 1;
      }
    }
    png.add((ByteData(4)..setUint32(0, data.length)).buffer.asUint8List());
    png.add(content);
    png.add(
      (ByteData(
        4,
      )..setUint32(0, (crc ^ 0xffffffff) & 0xffffffff)).buffer.asUint8List(),
    );
  }

  chunk('IHDR', header.buffer.asUint8List());
  chunk('IDAT', zlib.encode(scanlines.takeBytes()));
  chunk('IEND', []);
  return png.takeBytes();
}

Future<File> createTestLabel() async {
  final recorder = ui.PictureRecorder();
  final c = Canvas(recorder);
  c.drawRect(
    const Rect.fromLTWH(0, 0, 800, 470),
    Paint()..color = Colors.white,
  );
  const rows = [
    'EVERYDAY LIQUID',
    'DIRECTIONS',
    'Small load 1 tbsp',
    'Medium load 1 1/2 tbsp',
    'Large load 2 tbsp',
    'NET CONTENTS 64 FL OZ',
    'TEST LABEL — NOT A PRODUCT',
  ];
  for (var i = 0; i < rows.length; i++) {
    final painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: rows[i],
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: i == 0 ? 34 : 26,
          fontWeight: i < 2 ? FontWeight.w700 : FontWeight.w400,
          color: const Color(0xFF172D39),
        ),
      ),
    )..layout();
    painter.paint(c, Offset(40, 30 + i * 58.0));
  }
  final picture = recorder.endRecording();
  final image = await picture.toImage(800, 470);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  final file = File('.temp/scan-test.png');
  file.parent.createSync(recursive: true);
  file.writeAsBytesSync(data!.buffer.asUint8List());
  image.dispose();
  picture.dispose();
  return file;
}
