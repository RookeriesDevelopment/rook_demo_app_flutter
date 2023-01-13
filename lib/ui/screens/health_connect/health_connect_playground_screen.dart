import 'package:flutter/material.dart';
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
  SleepSummary? sleepSummary;
  String? sleepSummaryError;

  @override
  void initState() {
    getSleepSummaryLastDate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health connect playground')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              title('Sleep summary'),
              ElevatedButton(
                onPressed: () => showDatePicker(
                  context: context,
                  initialDate: sleepSummaryDate,
                  firstDate: oldestDate,
                  lastDate: soonestDate,
                ).then((selected) => getSleepSummary(selected)),
                child: const Text('Select a date'),
              ),
              const SizedBox(height: 10),
              if (sleepSummary != null) Text('Sleep summary: $sleepSummary'),
              if (sleepSummaryError != null) Text('Error: $sleepSummaryError'),
              const SizedBox(height: 10),
              divider,
            ],
          ),
        ),
      ),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget get divider {
    return const Divider(thickness: 1, height: 40, color: Colors.black54);
  }

  void getSleepSummary(DateTime? selectedDate) async {
    if (selectedDate != null) {
      try {
        final summary = await widget.args.manager.getSleepSummary(selectedDate);

        setState(() {
          sleepSummary = summary;
          sleepSummaryError = null;
        });
      } catch (error) {
        setState(() {
          sleepSummary = null;
          sleepSummaryError = '$error';
        });
      }
    }
  }

  void getSleepSummaryLastDate() async {
    try {
      final date = await widget.args.manager.getSleepSummaryLastDate();

      setState(() => sleepSummaryDate = date);
    } catch (ignored) {
      // Ignored
    }
  }
}
