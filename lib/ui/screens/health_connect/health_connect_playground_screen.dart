import 'package:flutter/material.dart';
import 'package:rook_extraction_demo/ui/widgets/predefined.dart';
import 'package:rook_extraction_demo/ui/widgets/scrollable_scaffold.dart';
import 'package:rook_extraction_demo/ui/widgets/section_title.dart';
import 'package:rook_health_connect/rook_health_connect.dart';

const String healthConnectPlaygroundScreenRoute = '/health-connect/playground';

class HealthConnectPlaygroundScreenArgs {
  final RookHealthConnectManager manager;

  const HealthConnectPlaygroundScreenArgs({required this.manager});
}

class HealthConnectPlaygroundScreen extends StatefulWidget {
  final HealthConnectPlaygroundScreenArgs args;

  const HealthConnectPlaygroundScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<HealthConnectPlaygroundScreen> createState() =>
      _HealthConnectPlaygroundScreenState();
}

class _HealthConnectPlaygroundScreenState
    extends State<HealthConnectPlaygroundScreen> {
  DateTime oldestDate = DateTime.now().subtract(const Duration(days: 29));
  DateTime soonestDate = DateTime.now().subtract(const Duration(days: 1));

  DateTime sleepSummaryDate = DateTime.now().subtract(const Duration(days: 1));
  bool sleepFetching = false;
  SleepSummary? sleepSummary;
  String? sleepError;

  @override
  void initState() {
    getLastDate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      name: 'Health connect playground',
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SectionTitle('Sleep'),
          ElevatedButton(
            onPressed: sleepFetching ? null : showSleepSelector,
            child: const Text('Select a date'),
          ),
          const SizedBox(height: 10),
          if (sleepSummary != null) Text('Sleep summary: $sleepSummary'),
          if (sleepError != null) Text('Error: $sleepError'),
          sectionDivider,
        ],
      ),
    );
  }

  void getLastDate() async {
    try {
      final sleepSummaryLastDate = await widget.args.manager.getSleepSummaryLastDate();

      setState(() => sleepSummaryDate = sleepSummaryLastDate);
    } catch (ignored) {
      // Ignored
    }
  }

  void showSleepSelector() {
    showDatePicker(
      context: context,
      initialDate: sleepSummaryDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => getSleep(selected));
  }

  void getSleep(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        sleepFetching = true;
        sleepSummary = null;
        sleepError = null;
      });

      try {
        final summary = await widget.args.manager.getSleepSummary(selectedDate);

        setState(() {
          sleepFetching = false;
          sleepSummary = summary;
          sleepError = null;
        });
      } catch (error) {
        setState(() {
          sleepFetching = false;
          sleepSummary = null;
          sleepError = '$error';
        });
      }
    }
  }
}
