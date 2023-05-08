import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/ui/screens/screens.dart';

class AppRouter {
  Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case credentialsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const CredentialsScreen(),
        );
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case hcAvailabilityScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HCAvailabilityScreen(),
        );
      case hcPermissionsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HCPermissionsScreen(
            args: settings.arguments as HCPermissionsScreenArgs,
          ),
        );
      case hcPlaygroundScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HCPlaygroundScreen(
            args: settings.arguments as HCPlaygroundScreenArgs,
          ),
        );
      case ahAvailabilityScreenRoute:
        return MaterialPageRoute(
          builder: (context) => AHAvailabilityScreen(
            args: settings.arguments as AHAvailabilityScreenArgs,
          ),
        );
      case ahPermissionsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => AHPermissionsScreen(
            args: settings.arguments as AHPermissionsScreenArgs,
          ),
        );
      case ahPlaygroundScreenRoute:
        return MaterialPageRoute(
          builder: (context) => AHPlaygroundScreen(
            args: settings.arguments as AHPlaygroundScreenArgs,
          ),
        );
      default:
        return null;
    }
  }
}
