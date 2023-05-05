library remote_fonts;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'io_web_mock.dart' if (dart.library.io) 'io_mobile_desktop.dart';

class RemoteFontAsset {
  final String url;
  final String? sha256sum;

  const RemoteFontAsset(this.url, [this.sha256sum]);

  Uri get _uri => Uri.parse(url);

  Future<Uint8List> get _remoteBytes async {
    final httpClient = http.Client();
    final bytes = (await httpClient.get(_uri)).bodyBytes;
    httpClient.close();
    return bytes;
  }

  Future<ByteData> getFont([FutureOr<String>? cacheDirPath]) async {
    assert((cacheDirPath == null && sha256sum == null) ||
        (cacheDirPath != null && sha256sum != null));
    FileCompat? localFile;
    if (cacheDirPath != null) {
      localFile = FileCompat('${(await cacheDirPath)}/$sha256sum');
      final localBytes = await localFile.verifiedBytes();
      if (localBytes != null) {
        return ByteData.view(localBytes.buffer);
      }
    }
    final remoteBytes = await _remoteBytes;
    if (localFile != null) {
      await localFile.cacheFile(remoteBytes);
    }
    return ByteData.view(remoteBytes.buffer);
  }
}

class RemoteFont {
  final String family;
  final Iterable<RemoteFontAsset> assets;
  final FutureOr<String>? cacheDirPath;
  bool _loaded = false;

  RemoteFont({required this.family, required this.assets, this.cacheDirPath});

  Iterable<Future<ByteData>> loadableFonts() {
    return assets.map((asset) => asset.getFont(cacheDirPath));
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
  final FutureOr<String>? cacheDirPath;

  const RemoteFonts({required this.fonts, this.cacheDirPath});

  Future<void> load() async {
    for (final font in fonts) {
      await font.load();
    }
  }
}
