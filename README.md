## Features 💘

Fetch and load remote fonts during Flutter app runtime 💘 Also has ability to cache previously loaded fonts.

## Getting started

```bash
flutter pub add remote_fonts
```

## Usage

```dart
import 'package:remote_fonts/remote_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

RemoteFont _notoSans(Future<String> cacheDir) =>
    RemoteFont(family: 'NotoSans', cacheDir: cacheDir, assets: [
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-Regular.ttf',
        'e6d03ebde2bb9c3cb5e9a932f394521233c39c42d57914f699193a9d9d2b546b',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSans/NotoSans-Bold.ttf',
        '5dd7fc028a59d98f1c87e58b70cc94077633ca0c33d2522c08985fee26334ee6',
      ),
    ]);

RemoteFont _notoSansKR(Future<String> cacheDir) =>
    RemoteFont(family: 'NotoSansKR', cacheDir: cacheDir, assets: [
      const RemoteFontAsset(
        'https://example.com/NotoSansKR/NotoSansKR-Regular.otf',
        'e1dc57d7fb8bd20c6dfa969710cdf5c57b9d49a9cb66709e28bdc434970641df',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSansKR/NotoSansKR-Bold.otf',
        'ffe8359b48542771a6042a63a2feb4734520c74fdc27b9b37eb0496c41a6fe48',
      ),
    ]);

String getFont(String languageCode, [String? scriptCode]) {
  Future<String> fontCacheDir = getTemporaryDirectory()
      .then((tempDir) => path.join(tempDir.path, 'font_cache'));

  switch (languageCode) {
    case 'ko':
      final font = _notoSansKR(fontCacheDir)..load();
      return font.family;
    default:
      final font = _notoSans(fontCacheDir)..load();
      return font.family;
  }
}
```
