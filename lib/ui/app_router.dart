import 'package:flutter/material.dart';
import 'package:rook_extraction_demo/ui/screens/screens.dart';

class AppRouter {
  Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case healthConnectAvailabilityScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HealthConnectAvailabilityScreen(),
        );
      case healthConnectPermissionsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HealthConnectPermissionsScreen(
            args: settings.arguments as HealthConnectPermissionsScreenArgs,
          ),
        );
      case healthConnectPlaygroundScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HealthConnectPlaygroundScreen(
            args: settings.arguments as HealthConnectPlaygroundScreenArgs,
          ),
        );
      default:
        return null;
    }
  }
}
