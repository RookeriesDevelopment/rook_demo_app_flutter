import 'package:flutter/material.dart';
import 'package:rook_extraction_demo/ui/screens/screens.dart';
import 'package:rook_extraction_demo/ui/widgets/widgets.dart';

const String homeScreenRoute = '/';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      name: 'Extraction / Transmission sample',
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const RookAuthStatus(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () =>
                navigate(context, hcAvailabilityScreenRoute),
            child: const Text('Health Connect'),
          ),
        ],
      ),
    );
  }

  void navigate(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }
}
