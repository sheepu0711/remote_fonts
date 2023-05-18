## Features 💘

Fetch and load remote fonts during Flutter app runtime 💘 Also has ability to cache previously loaded fonts.

## Getting started

```bash
flutter pub add remote_fonts
```

## Screenshot

<img src="https://raw.githubusercontent.com/giriss/remote_fonts/53a25aee0834751873b673ad2e80bfb33d30c60d/example/screenshot.png" alt="Example screenshot" style="height: 550px" />

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
        // md5sum (or sha256sum) of font file
        'b9ba72dfa580114ddb2ccf06f93b31b1',
      ),
      const RemoteFontAsset(
        'https://example.com/fonts/NotoSans/NotoSans-Bold.ttf',

        // Optional but required for caching to work
        // sha256sum (or md5sum) of font file
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
    RemoteFontsLoader.load([font]); // No need to await the Future, fonts are
                                    // automatically loaded to flutter engine

    return Text(
      'Some nice text',
      style: TextStyle(fontFamily: font.family),
    );
  }
}
```
