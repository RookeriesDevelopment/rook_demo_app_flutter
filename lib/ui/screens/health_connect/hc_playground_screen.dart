import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/secrets.dart';
import 'package:rook_demo_flutter/ui/widgets/widgets.dart';
import 'package:rook_demo_flutter/ui/screens/health_connect/hc_extensions.dart';
import 'package:rook_health_connect/rook_health_connect.dart';
import 'package:rook_transmission/rook_transmission.dart';

const String hcPlaygroundScreenRoute = '/health-connect/playground';

class HCPlaygroundScreenArgs {
  final RookHealthConnectManager healthConnect;

  const HCPlaygroundScreenArgs({required this.healthConnect});
}

class HCPlaygroundScreen extends StatefulWidget {
  final RookTransmissionManager transmission = RookTransmissionManager(
    Secrets.rookUrl,
    Secrets.userID,
    Secrets.clientUUID,
    Secrets.clientPassword,
  );

  final HCPlaygroundScreenArgs args;

  HCPlaygroundScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<HCPlaygroundScreen> createState() => _HCPlaygroundScreenState();
}

class _HCPlaygroundScreenState extends State<HCPlaygroundScreen> {

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
      final sleep = await widget.args.healthConnect.getSleepSummaryLastDate();

      setState(() => sleepDate = sleep);
    } catch (ignored) {
      // Ignored
    }

    try {
      final physical =
          await widget.args.healthConnect.getPhysicalSummaryLastDate();

      setState(() => physicalDate = physical);
    } catch (ignored) {
      // Ignored
    }

    try {
      final physical =
          await widget.args.healthConnect.getPhysicalEventsLastDate();

      setState(() => physicalEventsDate = physical);
    } catch (ignored) {
      // Ignored
    }

    try {
      final body = await widget.args.healthConnect.getBodySummaryLastDate();

      setState(() => bodyDate = body);
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
        final summary = await widget.args.healthConnect.getSleepSummary(
          selectedDate,
        );

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
        final item = sleepExtracted?.toItem();

        await widget.transmission.enqueueSleepSummary(item!);

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
        final summary = await widget.args.healthConnect.getPhysicalSummary(
          selectedDate,
        );

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
        final item = physicalExtracted?.toItem();

        await widget.transmission.enqueuePhysicalSummary(item!);

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
        final events = await widget.args.healthConnect.getPhysicalEvents(
          selectedDate,
        );

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
          final item = event.toItem();

          await widget.transmission.enqueuePhysicalEvent(item);
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
        final summary = await widget.args.healthConnect.getBodySummary(
          selectedDate,
        );

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
        final item = bodyExtracted?.toItem();

        await widget.transmission.enqueueBodySummary(item!);

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
      await widget.transmission.clearQueuedSleepSummaries();
      await widget.transmission.clearQueuedPhysicalSummaries();
      await widget.transmission.clearQueuedPhysicalEvents();
      await widget.transmission.clearQueuedBodySummaries();

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
      await widget.transmission.uploadAll();

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
