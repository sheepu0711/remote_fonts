import 'package:flutter/material.dart';
import 'package:remote_fonts/remote_fonts.dart';

const _remoteFont = RemoteFont(
  family: 'Pacifico',
  assets: [
    RemoteFontAsset(
      'https://res.cloudinary.com/dwln2chzi/raw/upload/v1684216523/remote_fonts/Pacifico-Regular_n9wo0l.ttf',
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    RemoteFontsLoader.load([_remoteFont]);

    return const MaterialApp(
      title: 'Remote Fonts Example',
      home: Scaffold(
        body: Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}
