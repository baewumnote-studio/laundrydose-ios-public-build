import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(onScreenshot: (String name, List<int> bytes,
      [Map<String, Object?>? args]) async {
    const allowed = {'01-wash', '02-load-size', '03-journal', '04-detergents', '05-dark-mode'};
    if (!allowed.contains(name)) return false;
    final folder = Directory(Platform.environment['STORE_CAPTURE_OUTPUT']!);
    await folder.create(recursive: true);
    await File('${folder.path}/$name.png').writeAsBytes(bytes, flush: true);
    return bytes.length > 10000;
  });
}
