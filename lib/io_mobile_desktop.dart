import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class FileCompat {
  final File _file;
  final String path;
  final String? sha256sum;

  FileCompat(this.path, [this.sha256sum]) : _file = File(path);

  Future<Uint8List?> verifiedBytes() async {
    if (!await _file.exists()) {
      return null;
    }
    final fontBytes = await _file.readAsBytes();
    if (sha256sum != sha256.convert(fontBytes).toString()) {
      return null;
    }
    return fontBytes;
  }

  Future<void> cacheFile(Uint8List bytes) async {
    if (await _file.exists()) {
      await _file.delete();
    }
    await _file.create(recursive: true);
    await _file.writeAsBytes(bytes);
  }
}
