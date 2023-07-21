import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/common/widget/scrollable_scaffold.dart';
import 'package:rook_demo_flutter/common/widget/section_divider.dart';
import 'package:rook_demo_flutter/common/widget/section_title.dart';
import 'package:rook_demo_flutter/features/health_connect/hc_extensions.dart';
import 'package:rook_demo_flutter/secrets.dart';
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
  DateTime oldestDate = DateTime.now().subtract(twentyNineDays);
  DateTime soonestDate = DateTime.now().subtract(oneDay);

  DateTime sleepSummaryDate = DateTime.now().subtract(oneDay);
  bool sleepSummaryExtracting = false;
  HCSleepSummary? sleepSummaryExtracted;
  String? sleepSummaryExtractError;

  bool sleepSummaryEnqueueing = false;
  bool sleepSummaryEnqueued = false;
  String? sleepSummaryEnqueueError;

  DateTime physicalSummaryDate = DateTime.now().subtract(oneDay);
  bool physicalSummaryExtracting = false;
  HCPhysicalSummary? physicalSummaryExtracted;
  String? physicalSummaryExtractError;

  bool physicalSummaryEnqueueing = false;
  bool physicalSummaryEnqueued = false;
  String? physicalSummaryEnqueueError;

  DateTime physicalEventDate = DateTime.now().subtract(oneDay);
  bool physicalEventExtracting = false;
  List<HCPhysicalEvent>? physicalEventExtracted;
  String? physicalEventExtractError;

  bool physicalEventEnqueueing = false;
  bool physicalEventEnqueued = false;
  String? physicalEventEnqueueError;

  DateTime bodySummaryDate = DateTime.now().subtract(oneDay);
  bool bodySummaryExtracting = false;
  HCBodySummary? bodySummaryExtracted;
  String? bodySummaryExtractError;

  bool bodySummaryEnqueueing = false;
  bool bodySummaryEnqueued = false;
  String? bodySummaryEnqueueError;

  DateTime bloodGlucoseEventDate = DateTime.now().subtract(oneDay);
  bool bloodGlucoseEventExtracting = false;
  HCBloodGlucoseEvent? bloodGlucoseEventExtracted;
  String? bloodGlucoseEventExtractError;

  bool bloodGlucoseEventEnqueueing = false;
  bool bloodGlucoseEventEnqueued = false;
  String? bloodGlucoseEventEnqueueError;

  DateTime bloodPressureEventDate = DateTime.now().subtract(oneDay);
  bool bloodPressureEventExtracting = false;
  HCBloodPressureEvent? bloodPressureEventExtracted;
  String? bloodPressureEventExtractError;

  bool bloodPressureEventEnqueueing = false;
  bool bloodPressureEventEnqueued = false;
  String? bloodPressureEventEnqueueError;

  DateTime bodyMetricsEventDate = DateTime.now().subtract(oneDay);
  bool bodyMetricsEventExtracting = false;
  HCBodyMetricsEvent? bodyMetricsEventExtracted;
  String? bodyMetricsEventExtractError;

  bool bodyMetricsEventEnqueueing = false;
  bool bodyMetricsEventEnqueued = false;
  String? bodyMetricsEventEnqueueError;

  DateTime heartRateBodyEventDate = DateTime.now().subtract(oneDay);
  bool heartRateBodyEventExtracting = false;
  HCHeartRateEvent? heartRateBodyEventExtracted;
  String? heartRateBodyEventExtractError;

  bool heartRateBodyEventEnqueueing = false;
  bool heartRateBodyEventEnqueued = false;
  String? heartRateBodyEventEnqueueError;

  DateTime heartRatePhysicalEventDate = DateTime.now().subtract(oneDay);
  bool heartRatePhysicalEventExtracting = false;
  List<HCHeartRateEvent>? heartRatePhysicalEventExtracted;
  String? heartRatePhysicalEventExtractError;

  bool heartRatePhysicalEventEnqueueing = false;
  bool heartRatePhysicalEventEnqueued = false;
  String? heartRatePhysicalEventEnqueueError;

  DateTime hydrationEventDate = DateTime.now().subtract(oneDay);
  bool hydrationEventExtracting = false;
  HCHydrationEvent? hydrationEventExtracted;
  String? hydrationEventExtractError;

  bool hydrationEventEnqueueing = false;
  bool hydrationEventEnqueued = false;
  String? hydrationEventEnqueueError;

  DateTime moodEventDate = DateTime.now().subtract(oneDay);
  bool moodEventExtracting = false;
  HCMoodEvent? moodEventExtracted;
  String? moodEventExtractError;

  bool moodEventEnqueueing = false;
  bool moodEventEnqueued = false;
  String? moodEventEnqueueError;

  DateTime nutritionEventDate = DateTime.now().subtract(oneDay);
  bool nutritionEventExtracting = false;
  HCNutritionEvent? nutritionEventExtracted;
  String? nutritionEventExtractError;

  bool nutritionEventEnqueueing = false;
  bool nutritionEventEnqueued = false;
  String? nutritionEventEnqueueError;

  DateTime oxygenationBodyEventDate = DateTime.now().subtract(oneDay);
  bool oxygenationBodyEventExtracting = false;
  HCOxygenationEvent? oxygenationBodyEventExtracted;
  String? oxygenationBodyEventExtractError;

  bool oxygenationBodyEventEnqueueing = false;
  bool oxygenationBodyEventEnqueued = false;
  String? oxygenationBodyEventEnqueueError;

  DateTime oxygenationPhysicalEventDate = DateTime.now().subtract(oneDay);
  bool oxygenationPhysicalEventExtracting = false;
  List<HCOxygenationEvent>? oxygenationPhysicalEventExtracted;
  String? oxygenationPhysicalEventExtractError;

  bool oxygenationPhysicalEventEnqueueing = false;
  bool oxygenationPhysicalEventEnqueued = false;
  String? oxygenationPhysicalEventEnqueueError;

  DateTime stressEventDate = DateTime.now().subtract(oneDay);
  bool stressEventExtracting = false;
  List<HCStressEvent>? stressEventExtracted;
  String? stressEventExtractError;

  bool stressEventEnqueueing = false;
  bool stressEventEnqueued = false;
  String? stressEventEnqueueError;

  DateTime temperatureEventDate = DateTime.now().subtract(oneDay);
  bool temperatureEventExtracting = false;
  HCTemperatureEvent? temperatureEventExtracted;
  String? temperatureEventExtractError;

  bool temperatureEventEnqueueing = false;
  bool temperatureEventEnqueued = false;
  String? temperatureEventEnqueueError;

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
          ...healthDataType<HCSleepSummary>(
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
          ...healthDataType<HCPhysicalSummary>(
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
          ...healthDataType<List<HCPhysicalEvent>>(
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
          ...healthDataType<HCBodySummary>(
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
          ...healthDataType<HCBloodGlucoseEvent>(
            name: 'Blood Glucose Event',
            extract: bloodGlucoseEventSelector,
            extracting: bloodGlucoseEventExtracting,
            extracted: bloodGlucoseEventExtracted,
            extractError: bloodGlucoseEventExtractError,
            enqueue: bloodGlucoseEventEnqueue,
            enqueueing: bloodGlucoseEventEnqueueing,
            enqueued: bloodGlucoseEventEnqueued,
            enqueueError: bloodGlucoseEventEnqueueError,
          ),
          ...healthDataType<HCBloodPressureEvent>(
            name: 'Blood Pressure Event',
            extract: bloodPressureEventSelector,
            extracting: bloodPressureEventExtracting,
            extracted: bloodPressureEventExtracted,
            extractError: bloodPressureEventExtractError,
            enqueue: bloodPressureEventEnqueue,
            enqueueing: bloodPressureEventEnqueueing,
            enqueued: bloodPressureEventEnqueued,
            enqueueError: bloodPressureEventEnqueueError,
          ),
          ...healthDataType<HCBodyMetricsEvent>(
            name: 'Body Metrics Event',
            extract: bodyMetricsEventSelector,
            extracting: bodyMetricsEventExtracting,
            extracted: bodyMetricsEventExtracted,
            extractError: bodyMetricsEventExtractError,
            enqueue: bodyMetricsEventEnqueue,
            enqueueing: bodyMetricsEventEnqueueing,
            enqueued: bodyMetricsEventEnqueued,
            enqueueError: bodyMetricsEventEnqueueError,
          ),
          ...healthDataType<HCHeartRateEvent>(
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
          ...healthDataType<List<HCHeartRateEvent>>(
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
          ...healthDataType<HCHydrationEvent>(
            name: 'Hydration Event',
            extract: hydrationEventSelector,
            extracting: hydrationEventExtracting,
            extracted: hydrationEventExtracted,
            extractError: hydrationEventExtractError,
            enqueue: hydrationEventEnqueue,
            enqueueing: hydrationEventEnqueueing,
            enqueued: hydrationEventEnqueued,
            enqueueError: hydrationEventEnqueueError,
          ),
          ...healthDataType<HCMoodEvent>(
            name: 'Mood Event',
            extract: moodEventSelector,
            extracting: moodEventExtracting,
            extracted: moodEventExtracted,
            extractError: moodEventExtractError,
            enqueue: moodEventEnqueue,
            enqueueing: moodEventEnqueueing,
            enqueued: moodEventEnqueued,
            enqueueError: moodEventEnqueueError,
          ),
          ...healthDataType<HCNutritionEvent>(
            name: 'Nutrition Event',
            extract: nutritionEventSelector,
            extracting: nutritionEventExtracting,
            extracted: nutritionEventExtracted,
            extractError: nutritionEventExtractError,
            enqueue: nutritionEventEnqueue,
            enqueueing: nutritionEventEnqueueing,
            enqueued: nutritionEventEnqueued,
            enqueueError: nutritionEventEnqueueError,
          ),
          ...healthDataType<HCOxygenationEvent>(
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
          ...healthDataType<List<HCOxygenationEvent>>(
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
          ...healthDataType<List<HCStressEvent>>(
            name: 'Stress Event',
            extract: stressEventSelector,
            extracting: stressEventExtracting,
            extracted: stressEventExtracted,
            extractError: stressEventExtractError,
            enqueue: stressEventEnqueue,
            enqueueing: stressEventEnqueueing,
            enqueued: stressEventEnqueued,
            enqueueError: stressEventEnqueueError,
          ),
          ...healthDataType<HCTemperatureEvent>(
            name: 'Temperature Event',
            extract: temperatureEventSelector,
            extracting: temperatureEventExtracting,
            extracted: temperatureEventExtracted,
            extractError: temperatureEventExtractError,
            enqueue: temperatureEventEnqueue,
            enqueueing: temperatureEventEnqueueing,
            enqueued: temperatureEventEnqueued,
            enqueueError: temperatureEventEnqueueError,
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
      HCRookDataType.sleepSummary,
    );
    final physicalSummaryDate = await _getLastExtractionDate(
      HCRookDataType.physicalSummary,
    );
    final physicalEventDate = await _getLastExtractionDate(
      HCRookDataType.physicalEvent,
    );
    final bodySummaryDate = await _getLastExtractionDate(
      HCRookDataType.bodySummary,
    );
    final bloodGlucoseEventDate = await _getLastExtractionDate(
      HCRookDataType.bloodGlucoseBodyEvent,
    );
    final bloodPressureEventDate = await _getLastExtractionDate(
      HCRookDataType.bloodPressureBodyEvent,
    );
    final bodyMetricsEventDate = await _getLastExtractionDate(
      HCRookDataType.bodyMetricsEvent,
    );
    final heartRateBodyEventDate = await _getLastExtractionDate(
      HCRookDataType.heartRateBodyEvent,
    );
    final heartRatePhysicalEventDate = await _getLastExtractionDate(
      HCRookDataType.heartRatePhysicalEvent,
    );
    final hydrationEventDate = await _getLastExtractionDate(
      HCRookDataType.hydrationBodyEvent,
    );
    final moodEventDate = await _getLastExtractionDate(
      HCRookDataType.moodBodyEvent,
    );
    final nutritionEventDate = await _getLastExtractionDate(
      HCRookDataType.nutritionBodyEvent,
    );
    final oxygenationBodyEventDate = await _getLastExtractionDate(
      HCRookDataType.oxygenationBodyEvent,
    );
    final oxygenationPhysicalEventDate = await _getLastExtractionDate(
      HCRookDataType.oxygenationPhysicalEvent,
    );
    final stressEventDate = await _getLastExtractionDate(
      HCRookDataType.stressPhysicalEvent,
    );
    final temperatureEventDate = await _getLastExtractionDate(
      HCRookDataType.temperatureBodyEvent,
    );

    setState(() {
      this.sleepSummaryDate = sleepSummaryDate;
      this.physicalSummaryDate = physicalSummaryDate;
      this.physicalEventDate = physicalEventDate;
      this.bodySummaryDate = bodySummaryDate;
      this.bloodGlucoseEventDate = bloodGlucoseEventDate;
      this.bloodPressureEventDate = bloodPressureEventDate;
      this.bodyMetricsEventDate = bodyMetricsEventDate;
      this.heartRateBodyEventDate = heartRateBodyEventDate;
      this.heartRatePhysicalEventDate = heartRatePhysicalEventDate;
      this.hydrationEventDate = hydrationEventDate;
      this.moodEventDate = moodEventDate;
      this.nutritionEventDate = nutritionEventDate;
      this.oxygenationBodyEventDate = oxygenationBodyEventDate;
      this.oxygenationPhysicalEventDate = oxygenationPhysicalEventDate;
      this.stressEventDate = stressEventDate;
      this.temperatureEventDate = temperatureEventDate;
    });
  }

  Future<DateTime> _getLastExtractionDate(HCRookDataType rookDataType) async {
    try {
      return await widget.args.healthConnect.getLastExtractionDate(
        rookDataType,
      );
    } catch (ignored) {
      return DateTime.now().subtract(oneDay);
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
        final summary = await widget.args.healthConnect.getSleepSummary(
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
        final summary = await widget.args.healthConnect.getPhysicalSummary(
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
        final events = await widget.args.healthConnect.getPhysicalEvents(
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
        final summary = await widget.args.healthConnect.getBodySummary(
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

  void bloodGlucoseEventSelector() {
    showDatePicker(
      context: context,
      initialDate: bloodGlucoseEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => bloodGlucoseEventExtract(selected));
  }

  void bloodGlucoseEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        bloodGlucoseEventExtracting = true;
        bloodGlucoseEventExtracted = null;
        bloodGlucoseEventExtractError = null;
      });

      try {
        final event = await widget.args.healthConnect.getBodyBloodGlucoseEvents(
          selectedDate,
        );

        setState(() {
          bloodGlucoseEventExtracting = false;
          bloodGlucoseEventExtracted = event;
          bloodGlucoseEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          bloodGlucoseEventExtracting = false;
          bloodGlucoseEventExtracted = null;
          bloodGlucoseEventExtractError = '$error';
        });
      }
    }
  }

  void bloodGlucoseEventEnqueue() async {
    if (bloodGlucoseEventExtracted != null) {
      setState(() {
        bloodGlucoseEventEnqueueing = true;
        bloodGlucoseEventEnqueued = false;
        bloodGlucoseEventEnqueueError = null;
      });

      try {
        final item = bloodGlucoseEventExtracted?.toItem();

        await widget.transmission.enqueueBloodGlucoseEvent(item!);

        setState(() {
          bloodGlucoseEventExtracted = null;

          bloodGlucoseEventEnqueueing = false;
          bloodGlucoseEventEnqueued = true;
          bloodGlucoseEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          bloodGlucoseEventEnqueueing = false;
          bloodGlucoseEventEnqueued = false;
          bloodGlucoseEventEnqueueError = '$error';
        });
      }
    }
  }

  void bloodPressureEventSelector() {
    showDatePicker(
      context: context,
      initialDate: bloodPressureEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => bloodPressureEventExtract(selected));
  }

  void bloodPressureEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        bloodPressureEventExtracting = true;
        bloodPressureEventExtracted = null;
        bloodPressureEventExtractError = null;
      });

      try {
        final event = await widget.args.healthConnect.getBodyBloodPressureEvents(
          selectedDate,
        );

        setState(() {
          bloodPressureEventExtracting = false;
          bloodPressureEventExtracted = event;
          bloodPressureEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          bloodPressureEventExtracting = false;
          bloodPressureEventExtracted = null;
          bloodPressureEventExtractError = '$error';
        });
      }
    }
  }

  void bloodPressureEventEnqueue() async {
    if (bloodPressureEventExtracted != null) {
      setState(() {
        bloodPressureEventEnqueueing = true;
        bloodPressureEventEnqueued = false;
        bloodPressureEventEnqueueError = null;
      });

      try {
        final item = bloodPressureEventExtracted?.toItem();

        await widget.transmission.enqueueBloodPressureEvent(item!);

        setState(() {
          bloodPressureEventExtracted = null;

          bloodPressureEventEnqueueing = false;
          bloodPressureEventEnqueued = true;
          bloodPressureEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          bloodPressureEventEnqueueing = false;
          bloodPressureEventEnqueued = false;
          bloodPressureEventEnqueueError = '$error';
        });
      }
    }
  }

  void bodyMetricsEventSelector() {
    showDatePicker(
      context: context,
      initialDate: bodyMetricsEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => bodyMetricsEventExtract(selected));
  }

  void bodyMetricsEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        bodyMetricsEventExtracting = true;
        bodyMetricsEventExtracted = null;
        bodyMetricsEventExtractError = null;
      });

      try {
        final event = await widget.args.healthConnect.getBodyMetricsEvents(
          selectedDate,
        );

        setState(() {
          bodyMetricsEventExtracting = false;
          bodyMetricsEventExtracted = event;
          bodyMetricsEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          bodyMetricsEventExtracting = false;
          bodyMetricsEventExtracted = null;
          bodyMetricsEventExtractError = '$error';
        });
      }
    }
  }

  void bodyMetricsEventEnqueue() async {
    if (bodyMetricsEventExtracted != null) {
      setState(() {
        bodyMetricsEventEnqueueing = true;
        bodyMetricsEventEnqueued = false;
        bodyMetricsEventEnqueueError = null;
      });

      try {
        final item = bodyMetricsEventExtracted?.toItem();

        await widget.transmission.enqueueBodyMetricsEvent(item!);

        setState(() {
          bodyMetricsEventExtracted = null;

          bodyMetricsEventEnqueueing = false;
          bodyMetricsEventEnqueued = true;
          bodyMetricsEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          bodyMetricsEventEnqueueing = false;
          bodyMetricsEventEnqueued = false;
          bodyMetricsEventEnqueueError = '$error';
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
        final event = await widget.args.healthConnect.getBodyHeartRateEvents(
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
        final item = heartRateBodyEventExtracted?.toItem();

        await widget.transmission.enqueueHeartRateEvent(item!);

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
        final event = await widget.args.healthConnect.getPhysicalHeartRateEvents(
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

  void hydrationEventSelector() {
    showDatePicker(
      context: context,
      initialDate: hydrationEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => hydrationEventExtract(selected));
  }

  void hydrationEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        hydrationEventExtracting = true;
        hydrationEventExtracted = null;
        hydrationEventExtractError = null;
      });

      try {
        final event = await widget.args.healthConnect.getBodyHydrationEvents(
          selectedDate,
        );

        setState(() {
          hydrationEventExtracting = false;
          hydrationEventExtracted = event;
          hydrationEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          hydrationEventExtracting = false;
          hydrationEventExtracted = null;
          hydrationEventExtractError = '$error';
        });
      }
    }
  }

  void hydrationEventEnqueue() async {
    if (hydrationEventExtracted != null) {
      setState(() {
        hydrationEventEnqueueing = true;
        hydrationEventEnqueued = false;
        hydrationEventEnqueueError = null;
      });

      try {
        final item = hydrationEventExtracted?.toItem();

        await widget.transmission.enqueueHydrationEvent(item!);

        setState(() {
          hydrationEventExtracted = null;

          hydrationEventEnqueueing = false;
          hydrationEventEnqueued = true;
          hydrationEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          hydrationEventEnqueueing = false;
          hydrationEventEnqueued = false;
          hydrationEventEnqueueError = '$error';
        });
      }
    }
  }

  void moodEventSelector() {
    showDatePicker(
      context: context,
      initialDate: moodEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => moodEventExtract(selected));
  }

  void moodEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        moodEventExtracting = true;
        moodEventExtracted = null;
        moodEventExtractError = null;
      });

      try {
        final event = await widget.args.healthConnect.getBodyMoodEvents(
          selectedDate,
        );

        setState(() {
          moodEventExtracting = false;
          moodEventExtracted = event;
          moodEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          moodEventExtracting = false;
          moodEventExtracted = null;
          moodEventExtractError = '$error';
        });
      }
    }
  }

  void moodEventEnqueue() async {
    if (moodEventExtracted != null) {
      setState(() {
        moodEventEnqueueing = true;
        moodEventEnqueued = false;
        moodEventEnqueueError = null;
      });

      try {
        final item = moodEventExtracted?.toItem();

        await widget.transmission.enqueueMoodEvent(item!);

        setState(() {
          moodEventExtracted = null;

          moodEventEnqueueing = false;
          moodEventEnqueued = true;
          moodEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          moodEventEnqueueing = false;
          moodEventEnqueued = false;
          moodEventEnqueueError = '$error';
        });
      }
    }
  }

  void nutritionEventSelector() {
    showDatePicker(
      context: context,
      initialDate: nutritionEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => nutritionEventExtract(selected));
  }

  void nutritionEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        nutritionEventExtracting = true;
        nutritionEventExtracted = null;
        nutritionEventExtractError = null;
      });

      try {
        final event = await widget.args.healthConnect.getBodyNutritionEvents(
          selectedDate,
        );

        setState(() {
          nutritionEventExtracting = false;
          nutritionEventExtracted = event;
          nutritionEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          nutritionEventExtracting = false;
          nutritionEventExtracted = null;
          nutritionEventExtractError = '$error';
        });
      }
    }
  }

  void nutritionEventEnqueue() async {
    if (nutritionEventExtracted != null) {
      setState(() {
        nutritionEventEnqueueing = true;
        nutritionEventEnqueued = false;
        nutritionEventEnqueueError = null;
      });

      try {
        final item = nutritionEventExtracted?.toItem();

        await widget.transmission.enqueueNutritionEvent(item!);

        setState(() {
          nutritionEventExtracted = null;

          nutritionEventEnqueueing = false;
          nutritionEventEnqueued = true;
          nutritionEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          nutritionEventEnqueueing = false;
          nutritionEventEnqueued = false;
          nutritionEventEnqueueError = '$error';
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
        final event = await widget.args.healthConnect.getBodyOxygenationEvents(
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
        final item = oxygenationBodyEventExtracted?.toItem();

        await widget.transmission.enqueueOxygenationEvent(item!);

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
        final event = await widget.args.healthConnect.getPhysicalOxygenationEvents(
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

  void stressEventSelector() {
    showDatePicker(
      context: context,
      initialDate: stressEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => stressEventExtract(selected));
  }

  void stressEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        stressEventExtracting = true;
        stressEventExtracted = null;
        stressEventExtractError = null;
      });

      try {
        final event = await widget.args.healthConnect.getPhysicalStressEvents(
          selectedDate,
        );

        setState(() {
          stressEventExtracting = false;
          stressEventExtracted = event;
          stressEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          stressEventExtracting = false;
          stressEventExtracted = null;
          stressEventExtractError = '$error';
        });
      }
    }
  }

  void stressEventEnqueue() async {
    if (stressEventExtracted != null) {
      setState(() {
        stressEventEnqueueing = true;
        stressEventEnqueued = false;
        stressEventEnqueueError = null;
      });

      try {
        for (final event in stressEventExtracted!) {
          final item = event.toItem();

          await widget.transmission.enqueueStressEvent(item);
        }

        setState(() {
          stressEventExtracted = null;

          stressEventEnqueueing = false;
          stressEventEnqueued = true;
          stressEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          stressEventEnqueueing = false;
          stressEventEnqueued = false;
          stressEventEnqueueError = '$error';
        });
      }
    }
  }

  void temperatureEventSelector() {
    showDatePicker(
      context: context,
      initialDate: temperatureEventDate,
      firstDate: oldestDate,
      lastDate: soonestDate,
    ).then((selected) => temperatureEventExtract(selected));
  }

  void temperatureEventExtract(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        temperatureEventExtracting = true;
        temperatureEventExtracted = null;
        temperatureEventExtractError = null;
      });

      try {
        final event = await widget.args.healthConnect.getBodyTemperatureEvents(
          selectedDate,
        );

        setState(() {
          temperatureEventExtracting = false;
          temperatureEventExtracted = event;
          temperatureEventExtractError = null;
        });
      } catch (error) {
        setState(() {
          temperatureEventExtracting = false;
          temperatureEventExtracted = null;
          temperatureEventExtractError = '$error';
        });
      }
    }
  }

  void temperatureEventEnqueue() async {
    if (temperatureEventExtracted != null) {
      setState(() {
        temperatureEventEnqueueing = true;
        temperatureEventEnqueued = false;
        temperatureEventEnqueueError = null;
      });

      try {
        final item = temperatureEventExtracted?.toItem();

        await widget.transmission.enqueueTemperatureEvent(item!);

        setState(() {
          temperatureEventExtracted = null;

          temperatureEventEnqueueing = false;
          temperatureEventEnqueued = true;
          temperatureEventEnqueueError = null;
        });
      } catch (error) {
        setState(() {
          temperatureEventEnqueueing = false;
          temperatureEventEnqueued = false;
          temperatureEventEnqueueError = '$error';
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
      await widget.transmission.clearQueuedBloodGlucoseEvents();
      await widget.transmission.clearQueuedBloodPressureEvents();
      await widget.transmission.clearQueuedBodyMetricsEvents();
      await widget.transmission.clearQueuedHeartRateEvents();
      await widget.transmission.clearQueuedHydrationEvents();
      await widget.transmission.clearQueuedMoodEvents();
      await widget.transmission.clearQueuedNutritionEvents();
      await widget.transmission.clearQueuedOxygenationEvents();
      await widget.transmission.clearQueuedStressEvents();
      await widget.transmission.clearQueuedTemperatureEvents();

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
      await widget.transmission.uploadBloodGlucoseEvents();
      await widget.transmission.uploadBloodPressureEvents();
      await widget.transmission.uploadBodyMetricsEvents();
      await widget.transmission.uploadHeartRateEvents();
      await widget.transmission.uploadHydrationEvents();
      await widget.transmission.uploadMoodEvents();
      await widget.transmission.uploadNutritionEvents();
      await widget.transmission.uploadOxygenationEvents();
      await widget.transmission.uploadStressEvents();
      await widget.transmission.uploadTemperatureEvents();

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

const oneDay = Duration(days: 1);
const twentyNineDays = Duration(days: 29);
