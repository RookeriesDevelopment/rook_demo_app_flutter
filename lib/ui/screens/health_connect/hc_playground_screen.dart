import 'package:flutter/material.dart';
import 'package:rook_extraction_demo/transmission_secrets.dart';
import 'package:rook_extraction_demo/ui/widgets/widgets.dart';
import 'package:rook_extraction_demo/users_secrets.dart';
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
    UsersSecrets.userID,
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
  String? sleepEnqueueError;

  DateTime physicalDate = DateTime.now().subtract(const Duration(days: 1));
  bool physicalExtracting = false;
  PhysicalSummary? physicalExtracted;
  String? physicalExtractError;

  bool physicalEnqueueing = false;
  bool? physicalEnqueued;
  String? physicalEnqueueError;

  DateTime physicalEventsDate =
      DateTime.now().subtract(const Duration(days: 1));
  bool physicalEventsExtracting = false;
  PhysicalEvents? physicalEventsExtracted;
  String? physicalEventsExtractError;

  bool physicalEventsEnqueueing = false;
  bool? physicalEventsEnqueued;
  String? physicalEventsEnqueueError;

  DateTime bodyDate = DateTime.now().subtract(const Duration(days: 1));
  bool bodyExtracting = false;
  BodySummary? bodyExtracted;
  String? bodyExtractError;

  bool bodyEnqueueing = false;
  bool? bodyEnqueued;
  String? bodyEnqueueError;

  bool syncing = false;
  bool? synced;
  String? syncError;

  bool clearing = false;
  bool? cleared;
  String? clearError;

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
            enqueueError: sleepEnqueueError,
          ),
          ...hcData<PhysicalSummary>(
            name: 'Physical',
            extract: showPhysicalSelector,
            extracting: physicalExtracting,
            extracted: physicalExtracted,
            extractError: physicalExtractError,
            enqueue: enqueuePhysical,
            enqueueing: physicalEnqueueing,
            enqueued: physicalEnqueued,
            enqueueError: physicalEnqueueError,
          ),
          ...hcData<PhysicalEvents>(
            name: 'Physical (Events)',
            extract: showPhysicalEventsSelector,
            extracting: physicalEventsExtracting,
            extracted: physicalEventsExtracted,
            extractError: physicalEventsExtractError,
            enqueue: enqueuePhysicalEvents,
            enqueueing: physicalEventsEnqueueing,
            enqueued: physicalEventsEnqueued,
            enqueueError: physicalEventsEnqueueError,
          ),
          ...hcData<BodySummary>(
            name: 'Body',
            extract: showBodySelector,
            extracting: bodyExtracting,
            extracted: bodyExtracted,
            extractError: bodyExtractError,
            enqueue: enqueueBody,
            enqueueing: bodyEnqueueing,
            enqueued: bodyEnqueued,
            enqueueError: bodyEnqueueError,
          ),
          const SectionTitle('Sync'),
          ElevatedButton(
            onPressed: syncing ? null : syncAll,
            child: const Text('Sync all'),
          ),
          if (synced == true) const Text('All synced!'),
          if (synced == false) Text('Error: $syncError'),
          sectionDivider,
          const SectionTitle('Clear'),
          ElevatedButton(
            onPressed: clearing ? null : clearAllQueues,
            child: const Text('Clear all queues'),
          ),
          if (cleared == true) const Text('All cleared!'),
          if (cleared == false) Text('Error: $clearError'),
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
      final sleepSLD = await widget.args.manager.getSleepSummaryLastDate();
      final physicalSLD =
          await widget.args.manager.getPhysicalSummaryLastDate();
      final physicalELD = await widget.args.manager.getPhysicalEventsLastDate();
      final bodySLD = await widget.args.manager.getBodySummaryLastDate();

      setState(() {
        sleepDate = sleepSLD;
        physicalDate = physicalSLD;
        physicalEventsDate = physicalELD;
        bodyDate = bodySLD;
      });
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
        sleepEnqueueError = null;
      });

      try {
        final item = SleepSummaryItem(
          sourceOfData: 'Health Connect',
          dateTime: sleepExtracted!.dateTime,
          sleepStartDatetime: sleepExtracted!.sleepStartDatetime,
          sleepEndDatetime: sleepExtracted!.sleepEndDatetime,
          sleepDate: sleepExtracted!.sleepDate,
          sleepDurationSeconds: sleepExtracted!.sleepDurationSeconds,
          timeInBedSeconds: sleepExtracted!.timeInBedSeconds,
          deepSleepDurationSeconds: sleepExtracted!.deepSleepDurationSeconds,
          remSleepDurationSeconds: sleepExtracted!.remSleepDurationSeconds,
          lightSleepDurationSeconds: sleepExtracted!.lightSleepDurationSeconds,
          timeAwakeDuringSleepSeconds:
              sleepExtracted!.timeAwakeDuringSleepSeconds,
        );

        await manager.enqueueSleepSummary(item);

        setState(() {
          sleepExtracted = null;

          sleepEnqueueing = false;
          sleepEnqueued = true;
          sleepEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          sleepEnqueueing = false;
          sleepEnqueued = false;
          sleepEnqueueError = '$error';
        });
      }
    }
  }

  void showPhysicalSelector() {
    showDatePicker(
      context: context,
      initialDate: physicalDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => getPhysical(selected));
  }

  void getPhysical(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        physicalExtracting = true;
        physicalExtracted = null;
        physicalExtractError = null;
      });

      try {
        final summary =
            await widget.args.manager.getPhysicalSummary(selectedDate);

        setState(() {
          physicalExtracting = false;
          physicalExtracted = summary;
          physicalExtractError = null;
        });
      } catch (error) {
        setState(() {
          physicalExtracting = false;
          physicalExtracted = null;
          physicalExtractError = '$error';
        });
      }
    }
  }

  void enqueuePhysical() async {
    if (physicalExtracted != null) {
      setState(() {
        physicalEnqueueing = true;
        physicalEnqueued = null;
        physicalEnqueueError = null;
      });

      try {
        final item = PhysicalSummaryItem(
          sourceOfData: 'Health Connect',
          dateTime: physicalExtracted!.dateTime,
          stepsPerDay: physicalExtracted!.stepsPerDay,
          traveledDistanceMeters: physicalExtracted!.traveledDistanceMeters,
          floorsClimbed: physicalExtracted!.floorsClimbed,
          elevationAvgAltitudeMeters:
              physicalExtracted!.elevationAvgAltitudeMeters,
          elevationMinimumAltitudeMeters:
              physicalExtracted!.elevationMinimumAltitudeMeters,
          elevationMaxAltitudeMeters:
              physicalExtracted!.elevationMaxAltitudeMeters,
          saturationAvgPercentage: physicalExtracted!.saturationAvgPercentage,
          vo2MaxAvgMlPerMinPerKg: physicalExtracted!.vo2MaxAvgMlPerMinPerKg,
          caloriesExpenditureKilocalories:
              physicalExtracted!.caloriesExpenditureKilocalories,
          caloriesNetActiveKilocalories:
              physicalExtracted!.caloriesNetActiveKilocalories,
          hrMaxBpm: physicalExtracted!.hrMaxBpm,
          hrMinimumBpm: physicalExtracted!.hrMinimumBpm,
          hrAvgBpm: physicalExtracted!.hrAvgBpm,
          hrAvgRestingBpm: physicalExtracted!.hrAvgRestingBpm,
          hrvAvgRmssd: physicalExtracted!.hrvAvgRmssd,
        );

        await manager.enqueuePhysicalSummary(item);

        setState(() {
          physicalExtracted = null;

          physicalEnqueueing = false;
          physicalEnqueued = true;
          physicalEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          physicalEnqueueing = false;
          physicalEnqueued = false;
          physicalEnqueueError = '$error';
        });
      }
    }
  }

  void showPhysicalEventsSelector() {
    showDatePicker(
      context: context,
      initialDate: physicalEventsDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => getPhysicalEvents(selected));
  }

  void getPhysicalEvents(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        physicalEventsExtracting = true;
        physicalEventsExtracted = null;
        physicalEventsExtractError = null;
      });

      try {
        final events =
            await widget.args.manager.getPhysicalEvents(selectedDate);

        setState(() {
          physicalEventsExtracting = false;
          physicalEventsExtracted = events;
          physicalEventsExtractError = null;
        });
      } catch (error) {
        setState(() {
          physicalEventsExtracting = false;
          physicalEventsExtracted = null;
          physicalEventsExtractError = '$error';
        });
      }
    }
  }

  void enqueuePhysicalEvents() async {
    if (physicalEventsExtracted != null) {
      setState(() {
        physicalEventsEnqueueing = true;
        physicalEventsEnqueued = null;
        physicalEventsEnqueueError = null;
      });

      try {
        for (PhysicalEvent event in physicalEventsExtracted?.events ?? []) {
          final item = PhysicalEventItem(
            sourceOfData: 'Health Connect',
            dateTime: event.dateTime,
            activityStartDatetime: event.activityStartDatetime,
            activityEndDatetime: event.activityEndDatetime,
            activityDurationSeconds: event.activityDurationSeconds,
            activityTypeName: event.activityTypeName,
            caloriesExpenditureKilocalories:
                event.caloriesExpenditureKilocalories,
            caloriesNetActiveKilocalories: event.caloriesNetActiveKilocalories,
            steps: event.steps,
            traveledDistanceMeters: event.traveledDistanceMeters,
            floorsClimbed: event.floorsClimbed,
            elevationAvgAltitudeMeters: event.elevationAvgAltitudeMeters,
            elevationMinimumAltitudeMeters:
                event.elevationMinimumAltitudeMeters,
            elevationMaxAltitudeMeters: event.elevationMaxAltitudeMeters,
            hrMaxBpm: event.hrMaxBpm,
            hrMinimumBpm: event.hrMinimumBpm,
            hrAvgBpm: event.hrAvgBpm,
            hrAvgRestingBpm: event.hrAvgRestingBpm,
            hrvAvgRmssd: event.hrvAvgRmssd,
            speedAvgMetersPerSecond: event.speedAvgMetersPerSecond,
            speedMaxMetersPerSecond: event.speedMaxMetersPerSecond,
            cadenceAvgRpm: event.cadenceAvgRpm,
            cadenceMaxRpm: event.cadenceMaxRpm,
            saturationAvgPercentage: event.saturationAvgPercentage,
            vo2MaxAvgMlPerMinPerKg: event.vo2MaxAvgMlPerMinPerKg,
          );

          await manager.enqueuePhysicalEvent(item);
        }

        setState(() {
          physicalEventsExtracted = null;

          physicalEventsEnqueueing = false;
          physicalEventsEnqueued = true;
          physicalEventsEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          physicalEventsEnqueueing = false;
          physicalEventsEnqueued = false;
          physicalEventsEnqueueError = '$error';
        });
      }
    }
  }

  void showBodySelector() {
    showDatePicker(
      context: context,
      initialDate: bodyDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => getBody(selected));
  }

  void getBody(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        bodyExtracting = true;
        bodyExtracted = null;
        bodyExtractError = null;
      });

      try {
        final summary = await widget.args.manager.getBodySummary(selectedDate);

        setState(() {
          bodyExtracting = false;
          bodyExtracted = summary;
          bodyExtractError = null;
        });
      } catch (error) {
        setState(() {
          bodyExtracting = false;
          bodyExtracted = null;
          bodyExtractError = '$error';
        });
      }
    }
  }

  void enqueueBody() async {
    if (bodyExtracted != null) {
      setState(() {
        bodyEnqueueing = true;
        bodyEnqueued = null;
        bodyEnqueueError = null;
      });

      try {
        final item = BodySummaryItem(
          sourceOfData: 'Health Connect',
          dateTime: bodyExtracted!.dateTime,
          weightKg: bodyExtracted!.weightKg,
          heightCm: bodyExtracted!.heightCm,
          bloodGlucoseDayAvgMgPerDl: bodyExtracted!.bloodGlucoseDayAvgMgPerDl,
          hrMaxBpm: bodyExtracted!.hrMaxBpm,
          hrMinimumBpm: bodyExtracted!.hrMinimumBpm,
          hrAvgBpm: bodyExtracted!.hrAvgBpm,
          hrvAvgRmssd: bodyExtracted!.hrvAvgRmssd,
          saturationAvgPercentage: bodyExtracted!.saturationAvgPercentage,
          vo2MaxAvgMlPerMinPerKg: bodyExtracted!.vo2MaxAvgMlPerMinPerKg,
          temperatureMinimumCelsius: bodyExtracted!.temperatureMinimumCelsius,
          temperatureAvgCelsius: bodyExtracted!.temperatureAvgCelsius,
          temperatureMaxCelsius: bodyExtracted!.temperatureMaxCelsius,
        );

        await manager.enqueueBodySummary(item);

        setState(() {
          bodyExtracted = null;

          bodyEnqueueing = false;
          bodyEnqueued = true;
          bodyEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          bodyEnqueueing = false;
          bodyEnqueued = false;
          bodyEnqueueError = '$error';
        });
      }
    }
  }

  void clearAllQueues() async {
    setState(() {
      clearing = true;
      cleared = null;
      clearError = null;
    });

    try {
      await manager.clearQueuedSleepSummaries();
      await manager.clearQueuedPhysicalSummaries();
      await manager.clearQueuedPhysicalEvents();
      await manager.clearQueuedBodySummaries();

      setState(() {
        clearing = false;
        cleared = true;
        clearError = null;
      });
    } catch (error) {
      setState(() {
        clearing = false;
        cleared = false;
        clearError = '$error';
      });
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
