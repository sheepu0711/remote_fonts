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
