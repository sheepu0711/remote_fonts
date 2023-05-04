## Features 💘

Fetch and load remote fonts during Flutter app runtime 💘 Also has ability to cache previously loaded fonts.

## Getting started

```bash
flutter pub add remote_fonts
```

## Usage

```dart
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hide_in_cloud/helpers.dart';

RemoteFont _notoSans(Directory cacheDir) =>
    RemoteFont(family: 'NotoSans', cacheDir: cacheDir, assets: [
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-Thin.ttf',
        '446753b64013666728add7c992f0fbc927cd9defce46584b1f4406603b7875c9',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-ExtraLight.ttf',
        '9e0e9267399653d6a48eb2cf58f9874fbc343b43d100de0be8528a0c5fbb7293',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-Light.ttf',
        '6a201c008fa202919db794350afb48737a07ea3b1fb4c5ac2a1b09c495843e76',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-Regular.ttf',
        'e6d03ebde2bb9c3cb5e9a932f394521233c39c42d57914f699193a9d9d2b546b',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-Medium.ttf',
        'ea32ff1f3c3668a125a80d461a19e27e60c56ff2e48b701179e39ed4b3e97144',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-SemiBold.ttf',
        'd70c0625e3c0e9c85b07e39c164f9657662de9afa3c089a51162155b4f2ba546',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-Bold.ttf',
        '5dd7fc028a59d98f1c87e58b70cc94077633ca0c33d2522c08985fee26334ee6',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-ExtraBold.ttf',
        '564239056e05fccca1fcfc50ef92e92cd999a3fc2ff8a41a21e55fb0ca650e82',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-Black.ttf',
        '78998f949afd41f9262da8c07f8c7c4679f62134e94b447c7520bcc99ae3b539',
      ),
    ]);

RemoteFont _notoSansKR(Directory cacheDir) =>
    RemoteFont(family: 'NotoSansKR', cacheDir: cacheDir, assets: [
      const RemoteFontAsset(
        'https://example.com/NotoSansKR/NotoSansKR-Thin.otf',
        '8446ad83ed53bad39a6a388e8d3ded6acc6decdf6ae13cd4520c1f57aa1ebf16',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSansKR/NotoSansKR-Light.otf',
        '2c1b9b342fb55735ff795d3feb537c73a24e69ee0c049e5e6dc7ab00449d2b64',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSansKR/NotoSansKR-Regular.otf',
        'e1dc57d7fb8bd20c6dfa969710cdf5c57b9d49a9cb66709e28bdc434970641df',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSansKR/NotoSansKR-Medium.otf',
        '2b808f68157d15e93ed16a0405ed19b029f783618c08bfe8ab1bfd85c8bfebf6',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSansKR/NotoSansKR-Bold.otf',
        'ffe8359b48542771a6042a63a2feb4734520c74fdc27b9b37eb0496c41a6fe48',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSansKR/NotoSansKR-Black.otf',
        '108a88992d7540bb6dce4f8b64f6f8fb9da92d68404ae3e7b5a4f8adfffdc715',
      ),
    ]);

String _getFont(String languageCode, String? scriptCode, Directory tempDir) {
  Directory fontCacheDir = Directory(path.join(tempDir.path, 'font_cache'));

  switch (languageCode) {
    case 'ko':
      final font = _notoSansKR(fontCacheDir)..load();
      return font.family;
    default:
      final font = _notoSans(fontCacheDir)..load();
      return font.family;
  }
}

ThemeData getTheme(Brightness brightness, Locale locale, Directory tempDir) {
  final font = _getFont(locale.languageCode, locale.scriptCode, tempDir);
  final flexThemeData =
      brightness == Brightness.light ? FlexThemeData.light : FlexThemeData.dark;

  return flexThemeData(
    scheme: FlexScheme.materialBaseline,
    useMaterial3: true,
    fontFamily: font,
    // swapLegacyOnMaterial3: true,
  );
}
```
