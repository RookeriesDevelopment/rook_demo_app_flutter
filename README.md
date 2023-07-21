# rook extraction demo

Demo app for rook connect data packages:

* Extraction
    * [rook_health_connect](https://pub.dev/packages/rook_health_connect)
    * [rook_apple_health](https://pub.dev/packages/rook_apple_health)
* Transmission
    * [rook_transmission](https://pub.dev/packages/rook_transmission)
* Users
    * [rook_users](https://pub.dev/packages/rook_users)

## Getting Started

1. In the lib folder create a secrets.dart file with a Secrets class and add the following
   constants:

```dart
class Secrets {
  static String rookAuthUrl = 'rookAuthUrl';
  static String userID = 'userID';
  static String clientUUID = 'clientUUID';
  static String clientPassword = 'clientPassword';
  static String rookUrl = 'rookUrl';
}
```

* `userID` is defined by you, so feel free to use the same ID your app uses to identify it's users.

* If you won't be using the [rook_transmission](https://pub.dev/packages/rook_transmission) package
  you can assign `google.com` to `rookUrl` and `N/A` to `clientUUID`, `clientPassword` and `userID`.

2. Run `flutter pub get`
