import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:receive_intent/receive_intent.dart';
import 'package:rook_extraction_demo/ui/app_router.dart';
import 'package:rook_extraction_demo/ui/screens/screens.dart';

const String hc = 'androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  WidgetsFlutterBinding.ensureInitialized();

  runAppFromIntent();
}

void runAppFromIntent() async {
  Widget app = RookExtractionDemoApp();

  try {
    final receivedIntent = await ReceiveIntent.getInitialIntent();

    if (receivedIntent?.action == hc) {
      app = const HCPrivacyPolicyApp();
    }
  } catch (error) {
    // Ignored
  } finally {
    runApp(app);
  }
}

class RookExtractionDemoApp extends StatelessWidget {
  final AppRouter _router = AppRouter();

  RookExtractionDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rook extraction demo',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: homeScreenRoute,
      onGenerateRoute: _router.onGenerateRoute,
    );
  }
}

class HCPrivacyPolicyApp extends StatelessWidget {
  const HCPrivacyPolicyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Privacy policy',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HCPrivacyPolicyScreen(),
    );
  }
}
