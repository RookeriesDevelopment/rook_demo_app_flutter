import 'package:flutter/material.dart';
import 'package:rook_extraction_demo/transmission_secrets.dart';
import 'package:rook_extraction_demo/ui/widgets/predefined.dart';
import 'package:rook_extraction_demo/ui/widgets/scrollable_scaffold.dart';
import 'package:rook_extraction_demo/ui/widgets/section_title.dart';
import 'package:rook_health_connect/rook_health_connect.dart';
import 'package:rook_transmission/rook_transmission.dart';

const String hcPlaygroundScreenRoute = '/health-connect/playground';

class HCPlaygroundScreenArgs {
  final RookHealthConnectManager manager;

  const HCPlaygroundScreenArgs({required this.manager});
}

class HCPlaygroundScreen extends StatefulWidget {
  final HCPlaygroundScreenArgs args;

  const HCPlaygroundScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<HCPlaygroundScreen> createState() => _HCPlaygroundScreenState();
}

class _HCPlaygroundScreenState extends State<HCPlaygroundScreen> {
  final RookTransmissionManager manager = RookTransmissionManager(
    TransmissionSecrets.url,
    'daniel.nolasco@rookmotion.com',
    TransmissionSecrets.clientUUID,
    TransmissionSecrets.clientPassword,
  );

  DateTime oldestDate = DateTime.now().subtract(const Duration(days: 29));
  DateTime soonestDate = DateTime.now().subtract(const Duration(days: 1));

  DateTime sleepDate = DateTime.now().subtract(const Duration(days: 1));
  bool sleepExtracting = false;
  SleepSummary? sleepExtracted;
  String? sleepExtractError;

  bool sleepEnqueueing = false;
  bool? sleepEnqueued;
  String? sleepSEnqueueError;

  bool syncing = false;
  bool? synced;
  String? syncError;

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
          ...hcData<SleepSummary>(
            name: 'Sleep',
            extract: showSleepSelector,
            extracting: sleepExtracting,
            extracted: sleepExtracted,
            extractError: sleepExtractError,
            enqueue: enqueueSleep,
            enqueueing: sleepEnqueueing,
            enqueued: sleepEnqueued,
            enqueueError: sleepSEnqueueError,
          ),
          const SectionTitle('Sync'),
          ElevatedButton(
            onPressed: syncing ? null : syncAll,
            child: const Text('Sync all'),
          ),
          if (synced == true) const Text('All synced!'),
          if (synced == false) Text('Error: $syncError'),
        ],
      ),
    );
  }

  List<Widget> hcData<D>({
    required String name,
    required Function() extract,
    required bool extracting,
    D? extracted,
    String? extractError,
    required Function() enqueue,
    required bool enqueueing,
    bool? enqueued,
    String? enqueueError,
  }) {
    return [
      SectionTitle(name),
      ElevatedButton(
        onPressed: extracting ? null : extract,
        child: const Text('Select a date'),
      ),
      const SizedBox(height: 10),
      if (extracted != null) Text('$name: $extracted'),
      if (extractError != null) Text('Error: $extractError'),
      const SizedBox(height: 10),
      ElevatedButton(
        onPressed: (enqueueing || extracted == null) ? null : enqueue,
        child: const Text('Enqueue this'),
      ),
      if (enqueued == true) Text('$name enqueued!'),
      if (enqueued == false) Text('Error: $enqueueError'),
      sectionDivider,
    ];
  }

  void getLastDate() async {
    try {
      final sleepSummaryLastDate =
          await widget.args.manager.getSleepSummaryLastDate();

      setState(() => sleepDate = sleepSummaryLastDate);
    } catch (ignored) {
      // Ignored
    }
  }

  void showSleepSelector() {
    showDatePicker(
      context: context,
      initialDate: sleepDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => getSleep(selected));
  }

  void getSleep(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        sleepExtracting = true;
        sleepExtracted = null;
        sleepExtractError = null;
      });

      try {
        final summary = await widget.args.manager.getSleepSummary(selectedDate);

        setState(() {
          sleepExtracting = false;
          sleepExtracted = summary;
          sleepExtractError = null;
        });
      } catch (error) {
        setState(() {
          sleepExtracting = false;
          sleepExtracted = null;
          sleepExtractError = '$error';
        });
      }
    }
  }

  void enqueueSleep() async {
    if (sleepExtracted != null) {
      setState(() {
        sleepEnqueueing = true;
        sleepEnqueued = null;
        sleepSEnqueueError = null;
      });

      try {
        final item = SleepSummaryItem(
          sourceOfData: 'Health Connect',
          sleepStartDatetime: DateTimeFormatter.fromIso8601ToRook(
            sleepExtracted!.sleepStartDatetime,
          ),
          sleepEndDatetime: DateTimeFormatter.fromIso8601ToRook(
            sleepExtracted!.sleepEndDatetime,
          ),
          sleepDate: sleepExtracted!.sleepDate,
          sleepDurationSeconds: sleepExtracted!.sleepDurationSeconds,
          timeInBedSeconds: sleepExtracted!.timeInBedSeconds,
        );

        await manager.enqueueSleepSummary(item);

        setState(() {
          sleepEnqueueing = false;
          sleepEnqueued = true;
          sleepSEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          sleepEnqueueing = false;
          sleepEnqueued = false;
          sleepSEnqueueError = '$error';
        });
      }
    }
  }

  void syncAll() async {
    setState(() {
      syncing = true;
      synced = null;
      syncError = null;
    });

    try {
      await manager.syncAll();

      setState(() {
        syncing = false;
        synced = true;
        syncError = null;
      });
    } catch (error) {
      setState(() {
        syncing = false;
        synced = false;
        syncError = '$error';
      });
    }
  }
}
