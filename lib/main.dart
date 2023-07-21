import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:receive_intent/receive_intent.dart';
import 'package:rook_demo_flutter/app_router.dart';
import 'package:rook_demo_flutter/features/credentials_screen.dart';
import 'package:rook_demo_flutter/features/health_connect/hc_privacy_policy_screen.dart';

import 'color_schemes.g.dart';

const String hc = 'androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runAppFromIntent());
}

void runAppFromIntent() async {
  Widget app = RookApp();

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

class RookApp extends StatelessWidget {
  final AppRouter _router = AppRouter();

  RookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rook demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      initialRoute: credentialsScreenRoute,
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
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const HCPrivacyPolicyScreen(),
    );
  }
}
