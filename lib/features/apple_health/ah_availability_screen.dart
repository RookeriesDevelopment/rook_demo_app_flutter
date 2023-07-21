import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:rook_apple_health/rook_apple_health.dart';
import 'package:rook_demo_flutter/common/widget/error_message_with_retry.dart';
import 'package:rook_demo_flutter/common/widget/scrollable_scaffold.dart';
import 'package:rook_demo_flutter/features/apple_health/ah_permissions_screen.dart';
import 'package:url_launcher/url_launcher.dart';

const String ahAvailabilityScreenRoute = '/apple-health/availability';

class AHAvailabilityScreenArgs {
  final RookAppleHealthManager manager;

  const AHAvailabilityScreenArgs({required this.manager});
}

class AHAvailabilityScreen extends StatefulWidget {
  final AHAvailabilityScreenArgs args;

  const AHAvailabilityScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<AHAvailabilityScreen> createState() => _AHAvailabilityScreenState();
}

class _AHAvailabilityScreenState extends State<AHAvailabilityScreen> {
  bool? available;
  String? availabilityError;

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      name: 'Availability',
      child: FocusDetector(
        onFocusGained: updateAvailability,
        child: availabilityError != null
            ? ErrorMessageWithRetry(
                error: '$availabilityError',
                retry: updateAvailability,
              )
            : available != null
                ? Column(
                    children: [
                      Text('Apple Health: $available'),
                      const SizedBox(height: 20),
                      if (!available!)
                        ElevatedButton(
                          onPressed: openAppStore,
                          child: const Text('Install now'),
                        ),
                      if (available!)
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
      final result = await widget.args.manager.checkAvailability();

      setState(() {
        available = result;
        availabilityError = null;
      });
    } catch (error) {
      setState(() {
        available = null;
        availabilityError = '$error';
      });
    }
  }

  void openAppStore() async {
    try {
      await launchUrl(Uri.parse('https://apps.apple.com/app/apple-health/id1242545199'));
    } catch (ignored) {
      // Ignored
    }
  }

  void goToPermissions(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(
      ahPermissionsScreenRoute,
      arguments: AHPermissionsScreenArgs(manager: widget.args.manager),
    );
  }
}
