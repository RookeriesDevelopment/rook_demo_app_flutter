# Rook demo app flutter

Demo app for ROOK modular packages:

* [rook-auth](https://pub.dev/packages/rook_users)
* [rook_users](https://pub.dev/packages/rook_users)
* [rook_health_connect](https://pub.dev/packages/rook_health_connect)
* [rook_apple_health](https://pub.dev/packages/rook_apple_health)
* [rook_transmission](https://pub.dev/packages/rook_transmission)

## Configure & Run

1. In the lib folder create a secrets.dart file with a Secrets class and add the following
   constants:

```dart
class Secrets {
  static String userID = 'userID';
  static String clientUUID = 'clientUUID';
  static String clientPassword = 'clientPassword';
  static String rookUrl = 'rookUrl';
  static String connectionsPageUrl = 'connectionsPageUrl';
}
```

2. Run `flutter pub get`
3. In the ios folder, ensure that your Podfile is targeted to ios 13+ (`platform :ios, '13.0'`)
4. In the ios folder, run `pod install`
