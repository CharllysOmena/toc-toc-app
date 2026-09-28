import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class PhotoStorage {
  Future<String?> save(String sourcePath, String itemId);
  Future<void> delete(String? path);
  Future<void> deleteAllForItem(String itemId);
}

class PhotoStorageImpl implements PhotoStorage {
  @override
  Future<String?> save(String sourcePath, String itemId) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final photoDir = Directory('${dir.path}/toc_photos');
      if (!photoDir.existsSync()) await photoDir.create(recursive: true);
      await deleteAllForItem(itemId);
      final ext = sourcePath.split('.').last;
      final dest = '${photoDir.path}/${itemId}_${DateTime.now().millisecondsSinceEpoch}.$ext';
      await File(sourcePath).copy(dest);
      return dest;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> delete(String? path) async {
    if (path == null) return;
    try {
      final file = File(path);
      if (file.existsSync()) await file.delete();
    } catch (_) {}
  }

  @override
  Future<void> deleteAllForItem(String itemId) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final photoDir = Directory('${dir.path}/toc_photos');
      if (!photoDir.existsSync()) return;
      for (final file in photoDir.listSync()) {
        if (file.path.contains(itemId)) {
          try {
            await File(file.path).delete();
          } catch (_) {}
        }
      }
    } catch (_) {}
  }
}
