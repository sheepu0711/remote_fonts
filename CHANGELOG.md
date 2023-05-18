## 1.1.4

Url-fix 😅

## 1.1.3

Added nice screenshot of our example 🚀

## 1.1.2

Added cool example of usage 😎

## 1.1.1

Important hotfix for v1.1.0 🐞

## 1.1.0

BREAKING CHANGES:
- Removed `RemoteFonts` class
- Made `RemoteFont` class a const class
- Added `RemoteFontsLoader` class to load a list of `RemoteFont`s

## 1.0.7

Added support for  md5sum alongside existing sha256sum 🔥

## 1.0.6

Added some comments to README.md 🚀

## 1.0.5

Throws error when `cacheDirPath` is provided but `sha256sum` is not provided.
For caching to work, both `cacheDirPath` and `sha256sum` must be provided.

## 1.0.4

- Allow for parallel downloads when using multiple font families with `RemoteFonts`
- Added dartdoc 🔥

## 1.0.3

- Update README.md with better example 🚀

## 1.0.2

- Minor bugfix for caching
- Update README.md

## 1.0.1

Breaking changes!
- Made package web compatible
- Allow package to pass cache dir path as `Future<String>?`

## 1.0.0

Initial release with all basic functionalities.
- Load remote fonts into flutter at runtime
- Ability to cache fonts for future usage
