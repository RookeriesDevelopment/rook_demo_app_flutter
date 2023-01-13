import 'package:flutter/material.dart';
import 'package:rook_extraction_demo/ui/screens/screens.dart';
import 'package:rook_extraction_demo/ui/widgets/widgets.dart';

const String homeScreenRoute = '/';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extraction sample')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const RookAuthStatus(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => navigate(context, healthConnectAvailabilityScreenRoute),
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
