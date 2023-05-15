import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

/// {@nodoc}
class FileCompat {
  final File _file;
  final String path;
  final String? checksum;

  FileCompat(this.path, [this.checksum]) : _file = File(path);

  Future<Uint8List?> cachedBytes() async {
    if (checksum == null || !await _file.exists()) return null;

    final fontBytes = await _file.readAsBytes();

    final computedChecksum =
        (checksum!.length == 64 ? sha256 : md5).convert(fontBytes).toString();
    if (checksum != computedChecksum) return null;

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
