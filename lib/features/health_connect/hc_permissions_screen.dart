import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:rook_demo_flutter/common/widget/error_message_with_retry.dart';
import 'package:rook_demo_flutter/common/widget/scrollable_scaffold.dart';
import 'package:rook_demo_flutter/features/health_connect/hc_playground_screen.dart';
import 'package:rook_health_connect/rook_health_connect.dart';

const String hcPermissionsScreenRoute = '/health-connect/permissions';

class HCPermissionsScreenArgs {
  final RookHealthConnectManager manager;

  const HCPermissionsScreenArgs({required this.manager});
}

class HCPermissionsScreen extends StatefulWidget {
  final HCPermissionsScreenArgs args;

  const HCPermissionsScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<HCPermissionsScreen> createState() => _HCPermissionsScreenState();
}

class _HCPermissionsScreenState extends State<HCPermissionsScreen> {
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
      hcPlaygroundScreenRoute,
      arguments: HCPlaygroundScreenArgs(
        healthConnect: widget.args.manager,
      ),
    );
  }
}
