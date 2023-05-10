## Features 💘

Fetch and load remote fonts during Flutter app runtime 💘 Also has ability to cache previously loaded fonts.

## Getting started

```bash
flutter pub add remote_fonts
```

## Usage

```dart
import 'package:remote_fonts/remote_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

RemoteFont _notoSansFont(Future<String> cacheDirPath) {
  return RemoteFont(
    family: 'NotoSans',
    cacheDirPath: cacheDirPath, // Optional but required for caching to work
    assets: [
      const RemoteFontAsset(
        'https://example.com/fonts/NotoSans/NotoSans-Regular.ttf',

        // Optional but required for caching to work
        'e6d03ebde2bb9c3cb5e9a932f394521233c39c42d57914f699193a9d9d2b546b', // sha256sum of font file
      ),
      const RemoteFontAsset(
        'https://example.com/fonts/NotoSans/NotoSans-Bold.ttf',

        // Optional but required for caching to work
        '5dd7fc028a59d98f1c87e58b70cc94077633ca0c33d2522c08985fee26334ee6', // sha256sum of font file
      ),
    ],
  );
}

class NiceText extends StatelessWidget {
  const NiceText({super.key});

  @override
  Widget build(BuildContext context) {
    final cacheDirPath = getTemporaryDirectory().then(
      (tempDir) => path.join(tempDir.path, 'font_cache'),
    );
    final font = _notoSansFont(cacheDirPath);
    font.load(); // No need to await the Future, fonts are automatically loaded to flutter engine

    return Text(
      'Some nice text',
      style: TextStyle(fontFamily: font.family),
    );
  }
}
```
