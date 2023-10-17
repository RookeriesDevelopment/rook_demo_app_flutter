import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/features/apple_health/ah_availability_screen.dart';
import 'package:rook_demo_flutter/features/apple_health/ah_permissions_screen.dart';
import 'package:rook_demo_flutter/features/apple_health/ah_playground_screen.dart';
import 'package:rook_demo_flutter/features/connections_page/data/repository/default_data_source_repository.dart';
import 'package:rook_demo_flutter/features/connections_page/screen/connections_page_screen.dart';
import 'package:rook_demo_flutter/features/health_connect/hc_availability_screen.dart';
import 'package:rook_demo_flutter/features/health_connect/hc_permissions_screen.dart';
import 'package:rook_demo_flutter/features/health_connect/hc_playground_screen.dart';
import 'package:rook_demo_flutter/features/home_screen.dart';

class AppRouter {
  Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
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
          builder: (context) => AHAvailabilityScreen(),
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
      case connectionsPageRoute:
        return MaterialPageRoute(
          builder: (context) => ConnectionsPageScreen(
            dataSourceRepository: DefaultDataSourceRepository(),
          ),
        );
      default:
        return null;
    }
  }
}
