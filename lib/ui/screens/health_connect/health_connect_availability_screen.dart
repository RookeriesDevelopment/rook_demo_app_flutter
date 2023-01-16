import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:rook_extraction_demo/ui/screens/screens.dart';
import 'package:rook_extraction_demo/ui/widgets/widgets.dart';
import 'package:rook_health_connect/rook_health_connect.dart';
import 'package:url_launcher/url_launcher.dart';

const String healthConnectAvailabilityScreenRoute =
    '/health-connect/availability';

class HealthConnectAvailabilityScreen extends StatefulWidget {
  final RookHealthConnectManager manager = RookHealthConnectManager();

  HealthConnectAvailabilityScreen({Key? key}) : super(key: key);

  @override
  State<HealthConnectAvailabilityScreen> createState() =>
      _HealthConnectAvailabilityScreenState();
}

class _HealthConnectAvailabilityScreenState
    extends State<HealthConnectAvailabilityScreen> {
  AvailabilityStatus? availabilityStatus;
  String? availabilityError;

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      name: 'Health connect availability',
      child: FocusDetector(
        onFocusGained: updateAvailability,
        child: availabilityError != null
            ? ErrorMessageWithRetry(
                error: '$availabilityError',
                retry: updateAvailability,
              )
            : availabilityStatus != null
                ? Column(
                    children: [
                      Text('Health Connect: ${availabilityStatus?.name}'),
                      const SizedBox(height: 20),
                      if (availabilityStatus == AvailabilityStatus.notSupported)
                        ElevatedButton(
                          onPressed: Navigator.of(context).pop,
                          child: const Text('Go back'),
                        ),
                      if (availabilityStatus == AvailabilityStatus.notInstalled)
                        ElevatedButton(
                          onPressed: openPlayStore,
                          child: const Text('Install now'),
                        ),
                      if (availabilityStatus == AvailabilityStatus.installed)
                        ElevatedButton.icon(
                          onPressed: () => goToPermissions(context),
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: const Text('Continue'),
                        ),
                    ],
                  )
                : const CircularProgressIndicator(),
      ),
    );
  }

  void updateAvailability() async {
    try {
      final status = await widget.manager.checkAvailability();

      setState(() {
        availabilityStatus = status;
        availabilityError = null;
      });
    } catch (error) {
      setState(() {
        availabilityStatus = null;
        availabilityError = '$error';
      });
    }
  }

  void openPlayStore() async {
    try {
      final success = await launchUrl(Uri.parse(
        'https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata',
      ));
    } catch (ignored) {
      // Ignored
    }
  }

  void goToPermissions(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(
      healthConnectPermissionsScreenRoute,
      arguments: HealthConnectPermissionsScreenArgs(manager: widget.manager),
    );
  }
}
