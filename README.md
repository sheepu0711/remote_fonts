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
    cacheDirPath: cacheDirPath,
    assets: [
      const RemoteFontAsset(
        'https://example.com/NotoSans-Regular.ttf',
        'e6d03ebde2bb9c3cb5e9a932f394521233c39c42d57914f699193a9d9d2b546b',
      ),
      const RemoteFontAsset(
        'https://example.com/NotoSans-Bold.ttf',
        '5dd7fc028a59d98f1c87e58b70cc94077633ca0c33d2522c08985fee26334ee6',
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
    font.load();

    return Text(
      'Some nice text',
      style: TextStyle(fontFamily: font.family),
    );
  }
}
```
