import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_dose/services/label_scan_service.dart';

class SupportedReader extends LabelScanService {
  @override
  bool get isSupported => true;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  tearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(LabelScanService.channel, null),
  );
  test('native bridge retains original text and OCR confidence', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(LabelScanService.channel, (call) async {
          expect(call.method, 'readLabel');
          expect(call.arguments, {'path': '/owned/label_photos/test.jpg'});
          return [
            {'text': 'Medium load 35 mL', 'confidence': .92},
            {'bad': 'row'},
          ];
        });
    final lines = await SupportedReader().read('/owned/label_photos/test.jpg');
    expect(lines, hasLength(1));
    expect(lines.single.text, 'Medium load 35 mL');
    expect(lines.single.confidence, .92);
  });
  test(
    'native failures reach the review UI instead of a fabricated result',
    () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(LabelScanService.channel, (_) async {
            throw PlatformException(code: 'read_failed');
          });
      await expectLater(
        SupportedReader().read('/owned/photo.jpg'),
        throwsA(isA<PlatformException>()),
      );
    },
  );
}
