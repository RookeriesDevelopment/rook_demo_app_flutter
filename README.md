# rook extraction demo

Demo app of rook_extraction packages:

* [rook_health_connect](https://pub.dev/packages/rook_health_connect)

## Getting Started

1. In the lib folder create a secrets.dart file with a Secrets class and add the following
   constants:

```dart
class Secrets {
  static const String rookApiUrl = 'YOUR_API_URL';
  static const String rookClientUUID = 'YOUR_CLIENT_UUID';
}
```

2. Run `flutter pub get`
