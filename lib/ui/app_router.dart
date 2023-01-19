import 'package:flutter/material.dart';
import 'package:rook_extraction_demo/ui/screens/screens.dart';

class AppRouter {
  Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
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
      default:
        return null;
    }
  }
}
