library remote_fonts;

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class RemoteFontAsset {
  final String url;
  final String? sha256sum;

  const RemoteFontAsset(this.url, [this.sha256sum]);

  Uri get _uri => Uri.parse(url);

  Future<Uint8List?> _localBytes(File file) async {
    if (!await file.exists()) {
      return null;
    }
    final fontBytes = await file.readAsBytes();
    if (sha256sum != sha256.convert(fontBytes).toString()) {
      return null;
    }
    return fontBytes;
  }

  Future<Uint8List> get _remoteBytes async {
    final httpClient = http.Client();
    final bytes = (await httpClient.get(_uri)).bodyBytes;
    httpClient.close();
    return bytes;
  }

  Future<void> _cacheFont(File file, Uint8List bytes) async {
    if (await file.exists()) {
      await file.delete();
    }
    await file.create(recursive: true);
    await file.writeAsBytes(bytes);
  }

  Future<ByteData> getFont([Directory? cacheDir]) async {
    assert((cacheDir == null && sha256sum == null) ||
        (cacheDir != null && sha256sum != null));
    File? localFile;
    if (cacheDir != null) {
      localFile = File('${cacheDir.path}/$sha256sum');
      final localBytes = await _localBytes(localFile);
      if (localBytes != null) {
        return ByteData.view(localBytes.buffer);
      }
    }
    final remoteBytes = await _remoteBytes;
    if (localFile != null) {
      await _cacheFont(localFile, remoteBytes);
    }
    return ByteData.view(remoteBytes.buffer);
  }
}

class RemoteFont {
  final String family;
  final Iterable<RemoteFontAsset> assets;
  final Directory? cacheDir;
  bool _loaded = false;

  RemoteFont({required this.family, required this.assets, this.cacheDir});

  Iterable<Future<ByteData>> loadableFonts() {
    return assets.map((asset) => asset.getFont(cacheDir));
  }

  Future<void> load() async {
    if (_loaded) {
      return;
    }
    _loaded = true;

    final fontLoader = FontLoader(family);
    for (final fontData in loadableFonts()) {
      fontLoader.addFont(fontData);
    }
    await fontLoader.load();
  }
}

class RemoteFonts {
  final Iterable<RemoteFont> fonts;
  final Directory? cacheDir;

  const RemoteFonts({required this.fonts, this.cacheDir});

  Future<void> load() async {
    for (final font in fonts) {
      await font.load();
    }
  }
}
