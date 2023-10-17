import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:rook_demo_flutter/features/apple_health/ah_availability_screen.dart';
import 'package:rook_demo_flutter/features/auth/widget/rook_auth_status.dart';
import 'package:rook_demo_flutter/features/health_connect/hc_availability_screen.dart';

const String homeScreenRoute = '/home';

class HomeScreen extends StatelessWidget {
  final Logger logger = Logger('HomeScreen');

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Package selection')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const RookAuthStatus(),
              const SizedBox(height: 20),
              if (defaultTargetPlatform == TargetPlatform.iOS)
                ElevatedButton(
                  child: const Text('Apple Health'),
                  onPressed: () => navigate(context, ahAvailabilityScreenRoute),
                ),
              if (defaultTargetPlatform == TargetPlatform.android)
                ElevatedButton(
                  onPressed: () => navigate(context, hcAvailabilityScreenRoute),
                  child: const Text('Health Connect'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void navigate(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }
}
