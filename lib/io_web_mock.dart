import 'dart:typed_data';

class FileCompat {
  final String path;
  final String? sha256sum;

  FileCompat(this.path, [this.sha256sum]);

  Future<Uint8List?> verifiedBytes() => Future.value(null);

  Future<void> cacheFile(Uint8List bytes) async {}
}
