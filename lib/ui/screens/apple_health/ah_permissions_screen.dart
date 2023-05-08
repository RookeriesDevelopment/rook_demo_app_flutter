import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:rook_demo_flutter/ui/screens/screens.dart';
import 'package:rook_demo_flutter/ui/widgets/widgets.dart';
import 'package:rook_apple_health/rook_apple_health.dart';

const String ahPermissionsScreenRoute = '/apple-health/permissions';

class AHPermissionsScreenArgs {
  final RookAppleHealthManager manager;

  const AHPermissionsScreenArgs({required this.manager});
}

class AHPermissionsScreen extends StatefulWidget {
  final AHPermissionsScreenArgs args;

  const AHPermissionsScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<AHPermissionsScreen> createState() => _AHPermissionsScreenState();
}

class _AHPermissionsScreenState extends State<AHPermissionsScreen> {
  bool permissionsRequested = false;
  String? permissionsError;

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      name: 'Permissions',
      child: FocusDetector(
        onFocusGained: updatePermissions,
        child: permissionsError != null
            ? ErrorMessageWithRetry(
                error: '$permissionsError',
                retry: updatePermissions,
              )
            : Column(
                children: [
                  Text('Permissions requested: $permissionsRequested'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: requestPermissions,
                    child: const Text('Request permissions'),
                  ),
                  if (permissionsRequested)
                    ElevatedButton.icon(
                      onPressed: () => goToPlayGround(context),
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text('Continue'),
                    ),
                ],
              ),
      ),
    );
  }

  void updatePermissions() async {
    // Not used in Apple health
  }

  void requestPermissions() async {
    try {
      final success = await widget.args.manager.requestAllPermissions();

      setState(() {
        permissionsRequested = success;
        permissionsError = null;
      });
    } catch (ignored) {
      setState(() {
        permissionsRequested = false;
        permissionsError = '$ignored';
      });
    }
  }

  void goToPlayGround(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(
      ahPlaygroundScreenRoute,
      arguments: AHPlaygroundScreenArgs(appleHealth: widget.args.manager),
    );
  }
}
