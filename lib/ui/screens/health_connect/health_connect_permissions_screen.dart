import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:rook_extraction_demo/ui/screens/screens.dart';
import 'package:rook_extraction_demo/ui/widgets/widgets.dart';
import 'package:rook_health_connect/rook_health_connect.dart';

const String healthConnectPermissionsScreenRoute =
    '/health-connect/permissions';

class HealthConnectPermissionsScreenArgs {
  final RookHealthConnectManager manager;

  const HealthConnectPermissionsScreenArgs({required this.manager});
}

class HealthConnectPermissionsScreen extends StatefulWidget {
  final HealthConnectPermissionsScreenArgs args;

  const HealthConnectPermissionsScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<HealthConnectPermissionsScreen> createState() =>
      _HealthConnectPermissionsScreenState();
}

class _HealthConnectPermissionsScreenState
    extends State<HealthConnectPermissionsScreen> {
  bool? permissionsGranted;
  String? permissionsError;

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      name: 'Health connect permissions',
      child: FocusDetector(
        onFocusGained: updatePermissions,
        child: permissionsError != null
            ? ErrorMessageWithRetry(
                error: '$permissionsError',
                retry: updatePermissions,
              )
            : permissionsGranted != null
                ? Column(
                    children: [
                      Text('Permissions granted: $permissionsGranted'),
                      const SizedBox(height: 20),
                      if (!permissionsGranted!)
                        const Text(
                          "'If the 'Request permissions' button does not work try to open health connect, locate 'rook extraction demo' app and grant and permissions'",
                        ),
                      if (!permissionsGranted!)
                        ElevatedButton(
                          onPressed: requestPermissions,
                          child: const Text('Request permissions'),
                        ),
                      if (!permissionsGranted!)
                        ElevatedButton(
                          onPressed: openSettings,
                          child: const Text('Open Health Connect'),
                        ),
                      if (permissionsGranted!)
                        ElevatedButton.icon(
                          onPressed: () => goToPlayGround(context),
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: const Text('Continue'),
                        ),
                    ],
                  )
                : const CircularProgressIndicator(),
      ),
    );
  }

  void updatePermissions() async {
    try {
      final granted = await widget.args.manager.hasAllPermissions();

      setState(() {
        permissionsGranted = granted;
        permissionsError = null;
      });
    } catch (error) {
      setState(() {
        permissionsGranted = null;
        permissionsError = '$error';
      });
    }
  }

  void requestPermissions() async {
    try {
      final success = await widget.args.manager.requestAllPermissions();
    } catch (ignored) {
      // Ignored
    }
  }

  void openSettings() async {
    try {
      final success = await widget.args.manager.openHealthConnectSettings();
    } catch (ignored) {
      // Ignored
    }
  }

  void goToPlayGround(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(
      healthConnectPlaygroundScreenRoute,
      arguments: HealthConnectPlaygroundScreenArgs(
        manager: widget.args.manager,
      ),
    );
  }
}
