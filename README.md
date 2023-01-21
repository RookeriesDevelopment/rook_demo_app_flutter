# rook extraction demo

Demo app for rook connect data packages:

* Extraction
  * [rook_health_connect](https://pub.dev/packages/rook_health_connect)
* Transmission
  * [rook_transmission](https://pub.dev/packages/rook_transmission/example)

## Getting Started

1. In the lib folder create a secrets.dart file with a Secrets class and add the following
   constants:

```dart
class Secrets {
   static const String rookApiUrl = 'YOUR_API_URL';
   static const String rookClientUUID = 'YOUR_CLIENT_UUID';
}
```

2. In the lib folder create a transmission_secrets.dart file with a TransmissionSecrets class and
   add the following constants:

```dart
class TransmissionSecrets {
  static const String url = 'API_URL';
  static const String clientUUID = 'CLIENT_UUID';
  static const String clientPassword = 'CLIENT_PASSWORD';
}
```

* If you won't be using the [rook_transmission](https://pub.dev/packages/rook_transmission) package
  you can assign `google.com` to `url` and `N/A` to `clientUUID` and `clientPassword`.

3. Run `flutter pub get`
