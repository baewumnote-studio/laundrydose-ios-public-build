import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class PhotoService {
  PhotoService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();
  final ImagePicker _picker;
  final _uuid = const Uuid();

  Future<String?> pickAndStore(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 88,
      maxWidth: 2400,
    );
    if (picked == null) return null;
    final support = await getApplicationSupportDirectory();
    final dir = Directory(p.join(support.path, 'label_photos'));
    if (!await dir.exists()) await dir.create(recursive: true);
    final ext = p.extension(picked.path).isEmpty
        ? '.jpg'
        : p.extension(picked.path).toLowerCase();
    final file = File(p.join(dir.path, '${_uuid.v4()}$ext'));
    await File(picked.path).copy(file.path);
    return p.relative(file.path, from: support.path);
  }

  Future<String?> duplicate(String? relative) async {
    final source = await resolve(relative);
    if (source == null) return null;
    final support = await getApplicationSupportDirectory();
    final dir = Directory(p.join(support.path, 'label_photos'));
    if (!await dir.exists()) await dir.create(recursive: true);
    final ext = p.extension(source.path).isEmpty
        ? '.jpg'
        : p.extension(source.path).toLowerCase();
    final target = File(p.join(dir.path, '${_uuid.v4()}$ext'));
    await source.copy(target.path);
    return p.relative(target.path, from: support.path);
  }

  Future<File?> resolve(String? relative) async {
    if (relative == null || relative.isEmpty) return null;
    final support = await getApplicationSupportDirectory();
    final f = File(p.join(support.path, relative));
    return await f.exists() ? f : null;
  }

  Future<void> delete(String? relative) async {
    final f = await resolve(relative);
    if (f != null) await f.delete();
  }
}
