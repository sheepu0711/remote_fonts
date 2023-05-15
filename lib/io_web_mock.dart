import 'dart:typed_data';

/// {@nodoc}
class FileCompat {
  final String path;
  final String? checksum;

  FileCompat(this.path, [this.checksum]);

  Future<Uint8List?> cachedBytes() => Future.value(null);

  Future<void> cacheFile(Uint8List bytes) async {}
}
