import 'package:flutter/material.dart';
import 'package:rook_apple_health/rook_apple_health.dart';
import 'package:rook_demo_flutter/common/widget/scrollable_scaffold.dart';
import 'package:rook_demo_flutter/common/widget/section_divider.dart';
import 'package:rook_demo_flutter/common/widget/section_title.dart';
import 'package:rook_demo_flutter/features/apple_health/ah_extensions.dart';
import 'package:rook_demo_flutter/secrets.dart';
import 'package:rook_transmission/rook_transmission.dart';

const String ahPlaygroundScreenRoute = '/apple-health/playground';

class AHPlaygroundScreenArgs {
  final RookAppleHealthManager appleHealth;

  const AHPlaygroundScreenArgs({required this.appleHealth});
}

class AHPlaygroundScreen extends StatefulWidget {
  final RookTransmissionManager transmission = RookTransmissionManager(
    Secrets.rookUrl,
    Secrets.userID,
    Secrets.clientUUID,
    Secrets.clientPassword,
  );

  final AHPlaygroundScreenArgs args;

  AHPlaygroundScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<AHPlaygroundScreen> createState() => _AHPlaygroundScreenState();
}

class _AHPlaygroundScreenState extends State<AHPlaygroundScreen> {
  DateTime oldestDate = DateTime.now().subtract(twentyNineDays);
  DateTime soonestDate = DateTime.now();

  bool userTimeZoneExtracting = false;
  AHUserTimeZone? userTimeZoneExtracted;
  String? userTimeZoneExtractError;

  bool userTimeZoneUploading = false;
  bool userTimeZoneUploaded = false;
  String? userTimeZoneUploadError;

  DateTime sleepSummaryDate = DateTime.now();
  bool sleepSummaryExtracting = false;
  AHSleepSummary? sleepSummaryExtracted;
  String? sleepSummaryExtractError;

  bool sleepSummaryEnqueueing = false;
  bool sleepSummaryEnqueued = false;
  String? sleepSummaryEnqueueError;

  DateTime physicalSummaryDate = DateTime.now();
  bool physicalSummaryExtracting = false;
  AHPhysicalSummary? physicalSummaryExtracted;
  String? physicalSummaryExtractError;

  bool physicalSummaryEnqueueing = false;
  bool physicalSummaryEnqueued = false;
  String? physicalSummaryEnqueueError;

  DateTime physicalEventDate = DateTime.now();
  bool physicalEventExtracting = false;
  List<AHPhysicalEvent>? physicalEventExtracted;
  String? physicalEventExtractError;

  bool physicalEventEnqueueing = false;
  bool physicalEventEnqueued = false;
  String? physicalEventEnqueueError;

  DateTime bodySummaryDate = DateTime.now();
  bool bodySummaryExtracting = false;
  AHBodySummary? bodySummaryExtracted;
  String? bodySummaryExtractError;

  bool bodySummaryEnqueueing = false;
  bool bodySummaryEnqueued = false;
  String? bodySummaryEnqueueError;

  DateTime heartRateBodyEventDate = DateTime.now();
  bool heartRateBodyEventExtracting = false;
  List<AHHeartRateEvent>? heartRateBodyEventExtracted;
  String? heartRateBodyEventExtractError;

  bool heartRateBodyEventEnqueueing = false;
  bool heartRateBodyEventEnqueued = false;
  String? heartRateBodyEventEnqueueError;

  DateTime heartRatePhysicalEventDate = DateTime.now();
  bool heartRatePhysicalEventExtracting = false;
  List<AHHeartRateEvent>? heartRatePhysicalEventExtracted;
  String? heartRatePhysicalEventExtractError;

  bool heartRatePhysicalEventEnqueueing = false;
  bool heartRatePhysicalEventEnqueued = false;
  String? heartRatePhysicalEventEnqueueError;

  DateTime oxygenationBodyEventDate = DateTime.now();
  bool oxygenationBodyEventExtracting = false;
  List<AHOxygenationEvent>? oxygenationBodyEventExtracted;
  String? oxygenationBodyEventExtractError;

  bool oxygenationBodyEventEnqueueing = false;
  bool oxygenationBodyEventEnqueued = false;
  String? oxygenationBodyEventEnqueueError;

  DateTime oxygenationPhysicalEventDate = DateTime.now();
  bool oxygenationPhysicalEventExtracting = false;
  List<AHOxygenationEvent>? oxygenationPhysicalEventExtracted;
  String? oxygenationPhysicalEventExtractError;

  bool oxygenationPhysicalEventEnqueueing = false;
  bool oxygenationPhysicalEventEnqueued = false;
  String? oxygenationPhysicalEventEnqueueError;

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
          const SectionTitle('User Time Zone'),
          ElevatedButton(
            onPressed: userTimeZoneExtracting ? null : userTimeZoneExtract,
            child: const Text('Extract'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: userTimeZoneUploading ? null : userTimeZoneUpload,
            child: const Text('Upload this'),
          ),
          if (userTimeZoneUploaded) const Text('uploaded!'),
          if (userTimeZoneUploadError != null) Text('Error: $userTimeZoneUploadError'),
          const SizedBox(height: 10),
          if (userTimeZoneExtracted != null) Text('$userTimeZoneExtracted'),
          if (userTimeZoneExtractError != null) Text('Error: $userTimeZoneExtractError'),
          sectionDivider,
          ...healthDataType<AHSleepSummary>(
            name: 'Sleep Summary',
            extract: sleepSummarySelector,
            extracting: sleepSummaryExtracting,
            extracted: sleepSummaryExtracted,
            extractError: sleepSummaryExtractError,
            enqueue: sleepSummaryEnqueue,
            enqueueing: sleepSummaryEnqueueing,
            enqueued: sleepSummaryEnqueued,
            enqueueError: sleepSummaryEnqueueError,
          ),
          ...healthDataType<AHPhysicalSummary>(
            name: 'Physical Summary',
            extract: physicalSummarySelector,
            extracting: physicalSummaryExtracting,
            extracted: physicalSummaryExtracted,
            extractError: physicalSummaryExtractError,
            enqueue: physicalSummaryEnqueue,
            enqueueing: physicalSummaryEnqueueing,
            enqueued: physicalSummaryEnqueued,
            enqueueError: physicalSummaryEnqueueError,
          ),
          ...healthDataType<List<AHPhysicalEvent>>(
            name: 'Physical Event',
            extract: physicalEventSelector,
            extracting: physicalEventExtracting,
            extracted: physicalEventExtracted,
            extractError: physicalEventExtractError,
            enqueue: physicalEventEnqueue,
            enqueueing: physicalEventEnqueueing,
            enqueued: physicalEventEnqueued,
            enqueueError: physicalEventEnqueueError,
          ),
          ...healthDataType<AHBodySummary>(
            name: 'Body Summary',
            extract: bodySummarySelector,
            extracting: bodySummaryExtracting,
            extracted: bodySummaryExtracted,
            extractError: bodySummaryExtractError,
            enqueue: bodySummaryEnqueue,
            enqueueing: bodySummaryEnqueueing,
            enqueued: bodySummaryEnqueued,
            enqueueError: bodySummaryEnqueueError,
          ),
          ...healthDataType<List<AHHeartRateEvent>>(
            name: 'Heart Rate Body Event',
            extract: heartRateBodyEventSelector,
            extracting: heartRateBodyEventExtracting,
            extracted: heartRateBodyEventExtracted,
            extractError: heartRateBodyEventExtractError,
            enqueue: heartRateBodyEventEnqueue,
            enqueueing: heartRateBodyEventEnqueueing,
            enqueued: heartRateBodyEventEnqueued,
            enqueueError: heartRateBodyEventEnqueueError,
          ),
          ...healthDataType<List<AHHeartRateEvent>>(
            name: 'Heart Rate Physical Event',
            extract: heartRatePhysicalEventSelector,
            extracting: heartRatePhysicalEventExtracting,
            extracted: heartRatePhysicalEventExtracted,
            extractError: heartRatePhysicalEventExtractError,
            enqueue: heartRatePhysicalEventEnqueue,
            enqueueing: heartRatePhysicalEventEnqueueing,
            enqueued: heartRatePhysicalEventEnqueued,
            enqueueError: heartRatePhysicalEventEnqueueError,
          ),
          ...healthDataType<List<AHOxygenationEvent>>(
            name: 'Oxygenation Body Event',
            extract: oxygenationBodyEventSelector,
            extracting: oxygenationBodyEventExtracting,
            extracted: oxygenationBodyEventExtracted,
            extractError: oxygenationBodyEventExtractError,
            enqueue: oxygenationBodyEventEnqueue,
            enqueueing: oxygenationBodyEventEnqueueing,
            enqueued: oxygenationBodyEventEnqueued,
            enqueueError: oxygenationBodyEventEnqueueError,
          ),
          ...healthDataType<List<AHOxygenationEvent>>(
            name: 'Oxygenation Physical Event',
            extract: oxygenationPhysicalEventSelector,
            extracting: oxygenationPhysicalEventExtracting,
            extracted: oxygenationPhysicalEventExtracted,
            extractError: oxygenationPhysicalEventExtractError,
            enqueue: oxygenationPhysicalEventEnqueue,
            enqueueing: oxygenationPhysicalEventEnqueueing,
            enqueued: oxygenationPhysicalEventEnqueued,
            enqueueError: oxygenationPhysicalEventEnqueueError,
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

  List<Widget> healthDataType<D>({
    required String name,
    required Function() extract,
    required bool extracting,
    required D? extracted,
    required String? extractError,
    required Function() enqueue,
    required bool enqueueing,
    required bool enqueued,
    required String? enqueueError,
  }) {
    return [
      SectionTitle(name),
      ElevatedButton(
        onPressed: extracting ? null : extract,
        child: const Text('Select a date'),
      ),
      const SizedBox(height: 10),
      ElevatedButton(
        onPressed: enqueueing ? null : enqueue,
        child: const Text('Enqueue this'),
      ),
      if (enqueued) Text('$name enqueued!'),
      if (enqueueError != null) Text('Error: $enqueueError'),
      const SizedBox(height: 10),
      if (extracted != null) Text('$name: $extracted'),
      if (extractError != null) Text('Error: $extractError'),
      sectionDivider,
    ];
  }

  void getLastDate() async {
    final sleepSummaryDate = await _getLastExtractionDate(
      AHRookDataType.sleepSummary,
    );
    final physicalSummaryDate = await _getLastExtractionDate(
      AHRookDataType.physicalSummary,
    );
    final physicalEventDate = await _getLastExtractionDate(
      AHRookDataType.physicalEvent,
    );
    final bodySummaryDate = await _getLastExtractionDate(
      AHRookDataType.bodySummary,
    );
    final heartRateBodyEventDate = await _getLastExtractionDate(
      AHRookDataType.heartRateBodyEvent,
    );
    final heartRatePhysicalEventDate = await _getLastExtractionDate(
      AHRookDataType.heartRatePhysicalEvent,
    );
    final oxygenationBodyEventDate = await _getLastExtractionDate(
      AHRookDataType.oxygenationBodyEvent,
    );
    final oxygenationPhysicalEventDate = await _getLastExtractionDate(
      AHRookDataType.oxygenationPhysicalEvent,
    );

    setState(() {
      this.sleepSummaryDate = sleepSummaryDate;
      this.physicalSummaryDate = physicalSummaryDate;
      this.physicalEventDate = physicalEventDate;
      this.bodySummaryDate = bodySummaryDate;
      this.heartRateBodyEventDate = heartRateBodyEventDate;
      this.heartRatePhysicalEventDate = heartRatePhysicalEventDate;
      this.oxygenationBodyEventDate = oxygenationBodyEventDate;
      this.oxygenationPhysicalEventDate = oxygenationPhysicalEventDate;
    });
  }

  Future<DateTime> _getLastExtractionDate(AHRookDataType rookDataType) async {
    try {
      return await widget.args.appleHealth.getLastExtractionDate(
        rookDataType,
      );
    } catch (ignored) {
      return DateTime.now();
    }
  }

  void userTimeZoneExtract() async {
    setState(() {
      userTimeZoneExtracting = true;
      userTimeZoneExtracted = null;
      userTimeZoneExtractError = null;
    });

    try {
      final userTimeZone = await widget.args.appleHealth.getUserTimeZone();

      setState(() {
        userTimeZoneExtracting = false;
        userTimeZoneExtracted = userTimeZone;
        userTimeZoneExtractError = null;
      });
    } catch (error) {
      setState(() {
        userTimeZoneExtracting = false;
        userTimeZoneExtracted = null;
        userTimeZoneExtractError = '$error';
      });
    }
  }

  void userTimeZoneUpload() async {
    if (userTimeZoneExtracted != null) {
      setState(() {
        userTimeZoneUploading = true;
        userTimeZoneUploaded = false;
        userTimeZoneUploadError = null;
      });

      try {
        await widget.transmission.uploadUserTimeZone(
          userTimeZoneExtracted!.timezone,
          userTimeZoneExtracted!.offset,
        );

        setState(() {
          userTimeZoneExtracted = null;

          userTimeZoneUploading = false;
          userTimeZoneUploaded = true;
          userTimeZoneUploadError = null;
        });
      } catch (error) {
        setState(() {
          userTimeZoneUploading = false;
          userTimeZoneUploaded = false;
          userTimeZoneUploadError = '$error';
        });
      }
    }
  }

  void sleepSummarySelector() {
    showDatePicker(
      context: context,
      initialDate: sleepSummaryDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => sleepSummaryExtract(selected));
  }

  void sleepSummaryExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        sleepSummaryExtracting = true;
        sleepSummaryExtracted = null;
        sleepSummaryExtractError = null;
      });

      try {
        final summary = await widget.args.appleHealth.getSleepSummary(
          selectedDate,
        );

        setState(() {
          sleepSummaryExtracting = false;
          sleepSummaryExtracted = summary;
          sleepSummaryExtractError = null;
        });
      } catch (error) {
        setState(() {
          sleepSummaryExtracting = false;
          sleepSummaryExtracted = null;
          sleepSummaryExtractError = '$error';
        });
      }
    }
  }

  void sleepSummaryEnqueue() async {
    if (sleepSummaryExtracted != null) {
      setState(() {
        sleepSummaryEnqueueing = true;
        sleepSummaryEnqueued = false;
        sleepSummaryEnqueueError = null;
      });

      try {
        final item = sleepSummaryExtracted?.toItem();

        await widget.transmission.enqueueSleepSummary(item!);

        setState(() {
          sleepSummaryExtracted = null;

          sleepSummaryEnqueueing = false;
          sleepSummaryEnqueued = true;
          sleepSummaryEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          sleepSummaryEnqueueing = false;
          sleepSummaryEnqueued = false;
          sleepSummaryEnqueueError = '$error';
        });
      }
    }
  }

  void physicalSummarySelector() {
    showDatePicker(
      context: context,
      initialDate: physicalSummaryDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => physicalSummaryExtract(selected));
  }

  void physicalSummaryExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        physicalSummaryExtracting = true;
        physicalSummaryExtracted = null;
        physicalSummaryExtractError = null;
      });

      try {
        final summary = await widget.args.appleHealth.getPhysicalSummary(
          selectedDate,
        );

        setState(() {
          physicalSummaryExtracting = false;
          physicalSummaryExtracted = summary;
          physicalSummaryExtractError = null;
        });
      } catch (error) {
        setState(() {
          physicalSummaryExtracting = false;
          physicalSummaryExtracted = null;
          physicalSummaryExtractError = '$error';
        });
      }
    }
  }

  void physicalSummaryEnqueue() async {
    if (physicalSummaryExtracted != null) {
      setState(() {
        physicalSummaryEnqueueing = true;
        physicalSummaryEnqueued = false;
        physicalSummaryEnqueueError = null;
      });

      try {
        final item = physicalSummaryExtracted?.toItem();

        await widget.transmission.enqueuePhysicalSummary(item!);

        setState(() {
          physicalSummaryExtracted = null;

          physicalSummaryEnqueueing = false;
          physicalSummaryEnqueued = true;
          physicalSummaryEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          physicalSummaryEnqueueing = false;
          physicalSummaryEnqueued = false;
          physicalSummaryEnqueueError = '$error';
        });
      }
    }
  }

  void physicalEventSelector() {
    showDatePicker(
      context: context,
      initialDate: physicalEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => physicalEventExtract(selected));
  }

  void physicalEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        physicalEventExtracting = true;
        physicalEventExtracted = null;
        physicalEventExtractError = null;
      });

      try {
        final events = await widget.args.appleHealth.getPhysicalEvents(
          selectedDate,
        );

        setState(() {
          physicalEventExtracting = false;
          physicalEventExtracted = events;
          physicalEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          physicalEventExtracting = false;
          physicalEventExtracted = null;
          physicalEventExtractError = '$error';
        });
      }
    }
  }

  void physicalEventEnqueue() async {
    if (physicalEventExtracted != null) {
      setState(() {
        physicalEventEnqueueing = true;
        physicalEventEnqueued = false;
        physicalEventEnqueueError = null;
      });

      try {
        for (final event in physicalEventExtracted!) {
          final item = event.toItem();

          await widget.transmission.enqueuePhysicalEvent(item);
        }

        setState(() {
          physicalEventExtracted = null;

          physicalEventEnqueueing = false;
          physicalEventEnqueued = true;
          physicalEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          physicalEventEnqueueing = false;
          physicalEventEnqueued = false;
          physicalEventEnqueueError = '$error';
        });
      }
    }
  }

  void bodySummarySelector() {
    showDatePicker(
      context: context,
      initialDate: bodySummaryDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => bodySummaryExtract(selected));
  }

  void bodySummaryExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        bodySummaryExtracting = true;
        bodySummaryExtracted = null;
        bodySummaryExtractError = null;
      });

      try {
        final summary = await widget.args.appleHealth.getBodySummary(
          selectedDate,
        );

        setState(() {
          bodySummaryExtracting = false;
          bodySummaryExtracted = summary;
          bodySummaryExtractError = null;
        });
      } catch (error) {
        setState(() {
          bodySummaryExtracting = false;
          bodySummaryExtracted = null;
          bodySummaryExtractError = '$error';
        });
      }
    }
  }

  void bodySummaryEnqueue() async {
    if (bodySummaryExtracted != null) {
      setState(() {
        bodySummaryEnqueueing = true;
        bodySummaryEnqueued = false;
        bodySummaryEnqueueError = null;
      });

      try {
        final item = bodySummaryExtracted?.toItem();

        await widget.transmission.enqueueBodySummary(item!);

        setState(() {
          bodySummaryExtracted = null;

          bodySummaryEnqueueing = false;
          bodySummaryEnqueued = true;
          bodySummaryEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          bodySummaryEnqueueing = false;
          bodySummaryEnqueued = false;
          bodySummaryEnqueueError = '$error';
        });
      }
    }
  }

  void heartRateBodyEventSelector() {
    showDatePicker(
      context: context,
      initialDate: heartRateBodyEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => heartRateBodyEventExtract(selected));
  }

  void heartRateBodyEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        heartRateBodyEventExtracting = true;
        heartRateBodyEventExtracted = null;
        heartRateBodyEventExtractError = null;
      });

      try {
        final event = await widget.args.appleHealth.getBodyHeartRateEvents(
          selectedDate,
        );

        setState(() {
          heartRateBodyEventExtracting = false;
          heartRateBodyEventExtracted = event;
          heartRateBodyEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          heartRateBodyEventExtracting = false;
          heartRateBodyEventExtracted = null;
          heartRateBodyEventExtractError = '$error';
        });
      }
    }
  }

  void heartRateBodyEventEnqueue() async {
    if (heartRateBodyEventExtracted != null) {
      setState(() {
        heartRateBodyEventEnqueueing = true;
        heartRateBodyEventEnqueued = false;
        heartRateBodyEventEnqueueError = null;
      });

      try {
        for (final event in heartRateBodyEventExtracted!) {
          final item = event.toItem();
          await widget.transmission.enqueueHeartRateEvent(item);
        }

        setState(() {
          heartRateBodyEventExtracted = null;

          heartRateBodyEventEnqueueing = false;
          heartRateBodyEventEnqueued = true;
          heartRateBodyEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          heartRateBodyEventEnqueueing = false;
          heartRateBodyEventEnqueued = false;
          heartRateBodyEventEnqueueError = '$error';
        });
      }
    }
  }

  void heartRatePhysicalEventSelector() {
    showDatePicker(
      context: context,
      initialDate: heartRatePhysicalEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => heartRatePhysicalEventExtract(selected));
  }

  void heartRatePhysicalEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        heartRatePhysicalEventExtracting = true;
        heartRatePhysicalEventExtracted = null;
        heartRatePhysicalEventExtractError = null;
      });

      try {
        final event = await widget.args.appleHealth.getPhysicalHeartRateEvents(
          selectedDate,
        );

        setState(() {
          heartRatePhysicalEventExtracting = false;
          heartRatePhysicalEventExtracted = event;
          heartRatePhysicalEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          heartRatePhysicalEventExtracting = false;
          heartRatePhysicalEventExtracted = null;
          heartRatePhysicalEventExtractError = '$error';
        });
      }
    }
  }

  void heartRatePhysicalEventEnqueue() async {
    if (heartRatePhysicalEventExtracted != null) {
      setState(() {
        heartRatePhysicalEventEnqueueing = true;
        heartRatePhysicalEventEnqueued = false;
        heartRatePhysicalEventEnqueueError = null;
      });

      try {
        for (final event in heartRatePhysicalEventExtracted!) {
          final item = event.toItem();

          await widget.transmission.enqueueHeartRateEvent(item);
        }

        setState(() {
          heartRatePhysicalEventExtracted = null;

          heartRatePhysicalEventEnqueueing = false;
          heartRatePhysicalEventEnqueued = true;
          heartRatePhysicalEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          heartRatePhysicalEventEnqueueing = false;
          heartRatePhysicalEventEnqueued = false;
          heartRatePhysicalEventEnqueueError = '$error';
        });
      }
    }
  }

  void oxygenationBodyEventSelector() {
    showDatePicker(
      context: context,
      initialDate: oxygenationBodyEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => oxygenationBodyEventExtract(selected));
  }

  void oxygenationBodyEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        oxygenationBodyEventExtracting = true;
        oxygenationBodyEventExtracted = null;
        oxygenationBodyEventExtractError = null;
      });

      try {
        final event = await widget.args.appleHealth.getBodyOxygenationEvents(
          selectedDate,
        );

        setState(() {
          oxygenationBodyEventExtracting = false;
          oxygenationBodyEventExtracted = event;
          oxygenationBodyEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          oxygenationBodyEventExtracting = false;
          oxygenationBodyEventExtracted = null;
          oxygenationBodyEventExtractError = '$error';
        });
      }
    }
  }

  void oxygenationBodyEventEnqueue() async {
    if (oxygenationBodyEventExtracted != null) {
      setState(() {
        oxygenationBodyEventEnqueueing = true;
        oxygenationBodyEventEnqueued = false;
        oxygenationBodyEventEnqueueError = null;
      });

      try {
        for (final event in oxygenationBodyEventExtracted!) {
          final item = event.toItem();
          await widget.transmission.enqueueOxygenationEvent(item);
        }

        setState(() {
          oxygenationBodyEventExtracted = null;

          oxygenationBodyEventEnqueueing = false;
          oxygenationBodyEventEnqueued = true;
          oxygenationBodyEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          oxygenationBodyEventEnqueueing = false;
          oxygenationBodyEventEnqueued = false;
          oxygenationBodyEventEnqueueError = '$error';
        });
      }
    }
  }

  void oxygenationPhysicalEventSelector() {
    showDatePicker(
      context: context,
      initialDate: oxygenationPhysicalEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => oxygenationPhysicalEventExtract(selected));
  }

  void oxygenationPhysicalEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        oxygenationPhysicalEventExtracting = true;
        oxygenationPhysicalEventExtracted = null;
        oxygenationPhysicalEventExtractError = null;
      });

      try {
        final event = await widget.args.appleHealth.getPhysicalOxygenationEvents(
          selectedDate,
        );

        setState(() {
          oxygenationPhysicalEventExtracting = false;
          oxygenationPhysicalEventExtracted = event;
          oxygenationPhysicalEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          oxygenationPhysicalEventExtracting = false;
          oxygenationPhysicalEventExtracted = null;
          oxygenationPhysicalEventExtractError = '$error';
        });
      }
    }
  }

  void oxygenationPhysicalEventEnqueue() async {
    if (oxygenationPhysicalEventExtracted != null) {
      setState(() {
        oxygenationPhysicalEventEnqueueing = true;
        oxygenationPhysicalEventEnqueued = false;
        oxygenationPhysicalEventEnqueueError = null;
      });

      try {
        for (final event in oxygenationPhysicalEventExtracted!) {
          final item = event.toItem();

          await widget.transmission.enqueueOxygenationEvent(item);
        }

        setState(() {
          oxygenationPhysicalEventExtracted = null;

          oxygenationPhysicalEventEnqueueing = false;
          oxygenationPhysicalEventEnqueued = true;
          oxygenationPhysicalEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          oxygenationPhysicalEventEnqueueing = false;
          oxygenationPhysicalEventEnqueued = false;
          oxygenationPhysicalEventEnqueueError = '$error';
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
      await widget.transmission.clearQueuedHeartRateEvents();
      await widget.transmission.clearQueuedOxygenationEvents();

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
      await widget.transmission.uploadSleepSummaries();
      await widget.transmission.uploadPhysicalSummaries();
      await widget.transmission.uploadPhysicalEvents();
      await widget.transmission.uploadBodySummaries();
      await widget.transmission.uploadHeartRateEvents();
      await widget.transmission.uploadOxygenationEvents();

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

const twentyNineDays = Duration(days: 29);
