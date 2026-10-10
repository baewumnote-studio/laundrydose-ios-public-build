import 'dart:io';
import 'package:flutter/services.dart';
import '../core/scan/label_parser.dart';

class LabelScanService {
  static const channel = MethodChannel('laundry_dose/label_scan');
  bool get isSupported => Platform.isIOS;

  Future<List<LabelTextLine>> read(String localPath) async {
    if (!isSupported) {
      throw UnsupportedError('On-device label reading requires iOS.');
    }
    final rows =
        await channel.invokeListMethod<dynamic>('readLabel', {
          'path': localPath,
        }) ??
        [];
    return [
      for (final row in rows)
        if (row is Map && row['text'] is String && row['confidence'] is num)
          LabelTextLine(
            row['text'] as String,
            (row['confidence'] as num).toDouble(),
          ),
    ];
  }
}
