import 'package:rook_demo_flutter/domain/datetime/rook_datetime.dart';
import 'package:rook_health_connect/rook_health_connect.dart';
import 'package:rook_transmission/rook_transmission.dart';

extension SleepSummaryExtension on SleepSummary {
  SleepSummaryItem toItem() {
    return SleepSummaryItem(
      sourceOfData: sourceOfData,
      dateTime: toUTCDateTime(dateTime),
      sleepStartDatetime: toUTCDateTime(sleepStartDatetime),
      sleepEndDatetime: toUTCDateTime(sleepEndDatetime),
      sleepDate: toDate(sleepDate),
      sleepDurationSeconds: sleepDurationSeconds,
      timeInBedSeconds: timeInBedSeconds,
      lightSleepDurationSeconds: lightSleepDurationSeconds,
      remSleepDurationSeconds: remSleepDurationSeconds,
      deepSleepDurationSeconds: deepSleepDurationSeconds,
      timeAwakeDuringSleepSeconds: timeAwakeDuringSleepSeconds,
    );
  }
}

extension PhysicalSummaryExtension on PhysicalSummary {
  PhysicalSummaryItem toItem() {
    return PhysicalSummaryItem(
      sourceOfData: sourceOfData,
      dateTime: toUTCDateTime(dateTime),
      stepsPerDay: stepsPerDay,
      stepsGranularDataStepsPerHr:
          stepsGranularDataStepsPerHr?.map((e) => e.toItem()).toList(),
      traveledDistanceMeters: traveledDistanceMeters,
      traveledDistanceGranularDataMeters:
          traveledDistanceGranularDataMeters?.map((e) => e.toItem()).toList(),
      floorsClimbed: floorsClimbed,
      floorsClimbedGranularData:
          floorsClimbedGranularData?.map((e) => e.toItem()).toList(),
      elevationAvgAltitudeMeters: elevationAvgAltitudeMeters,
      elevationMinimumAltitudeMeters: elevationMinimumAltitudeMeters,
      elevationMaxAltitudeMeters: elevationMaxAltitudeMeters,
      elevationGranularDataMeters:
          elevationGranularDataMeters?.map((e) => e.toItem()).toList(),
      saturationAvgPercentage: saturationAvgPercentage,
      saturationGranularDataPercentage:
          saturationGranularDataPercentage?.map((e) => e.toItem()).toList(),
      vo2MaxAvgMlPerMinPerKg: vo2MaxAvgMlPerMinPerKg,
      vo2GranularDataLiterPerMin:
          vo2MaxGranularDataMlPerMinPerKg?.map((e) => e.toItem()).toList(),
      caloriesExpenditureKilocalories: caloriesExpenditureKilocalories,
      caloriesNetActiveKilocalories: caloriesNetActiveKilocalories,
      hrMaxBpm: hrMaxBpm,
      hrMinimumBpm: hrMinimumBpm,
      hrAvgBpm: hrAvgBpm,
      hrAvgRestingBpm: hrAvgRestingBpm,
      hrGranularDataBpm: hrGranularDataBpm?.map((e) => e.toItem()).toList(),
      hrvAvgRmssd: hrvAvgRmssd,
      hrvRmssdGranularData:
          hrvRmssdGranularData?.map((e) => e.toItem()).toList(),
    );
  }
}

extension PhysicalEventExtension on PhysicalEvent {
  PhysicalEventItem toItem() {
    return PhysicalEventItem(
        sourceOfData: sourceOfData,
        dateTime: toUTCDateTime(dateTime),
        activityStartDatetime: toUTCDateTime(activityStartDatetime),
        activityEndDatetime: toUTCDateTime(activityEndDatetime),
        activityDurationSeconds: activityDurationSeconds,
        activityTypeName: activityTypeName,
        caloriesExpenditureKilocalories: caloriesExpenditureKilocalories,
        caloriesNetActiveKilocalories: caloriesNetActiveKilocalories,
        steps: steps,
        traveledDistanceMeters: traveledDistanceMeters,
        traveledDistanceGranularDataMeters:
            traveledDistanceGranularDataMeters?.map((e) => e.toItem()).toList(),
        floorsClimbed: floorsClimbed,
        floorsClimbedGranularData:
            floorsClimbedGranularData?.map((e) => e.toItem()).toList(),
        elevationAvgAltitudeMeters: elevationAvgAltitudeMeters,
        elevationMinimumAltitudeMeters: elevationMinimumAltitudeMeters,
        elevationMaxAltitudeMeters: elevationMaxAltitudeMeters,
        elevationGranularDataMeters:
            elevationGranularDataMeters?.map((e) => e.toItem()).toList(),
        hrMaxBpm: hrMaxBpm,
        hrMinimumBpm: hrMinimumBpm,
        hrAvgBpm: hrAvgBpm,
        hrAvgRestingBpm: hrAvgRestingBpm,
        hrGranularDataBpm: hrGranularDataBpm?.map((e) => e.toItem()).toList(),
        hrvAvgRmssd: hrvAvgRmssd,
        hrvRmssdGranularData:
            hrvRmssdGranularData?.map((e) => e.toItem()).toList(),
        speedAvgMetersPerSecond: speedAvgMetersPerSecond,
        speedMaxMetersPerSecond: speedMaxMetersPerSecond,
        speedGranularDataMetersPerSecond:
            speedGranularDataMetersPerSecond?.map((e) => e.toItem()).toList(),
        cadenceAvgRpm: cadenceAvgRpm,
        cadenceMaxRpm: cadenceMaxRpm,
        cadenceGranularDataRpm:
            cadenceGranularDataRpm?.map((e) => e.toItem()).toList(),
        saturationAvgPercentage: saturationAvgPercentage,
        saturationGranularDataPercentage:
            saturationGranularDataPercentage?.map((e) => e.toItem()).toList(),
        vo2MaxAvgMlPerMinPerKg: vo2MaxAvgMlPerMinPerKg,
        vo2GranularDataLiterPerMin:
            vo2MaxGranularDataMlPerMinPerKg?.map((e) => e.toItem()).toList());
  }
}

extension BodySummaryExtension on BodySummary {
  BodySummaryItem toItem() {
    return BodySummaryItem(
        sourceOfData: sourceOfData,
        dateTime: toUTCDateTime(dateTime),
        weightKg: weightKg,
        heightCm: heightCm,
        bloodGlucoseDayAvgMgPerDl: bloodGlucoseDayAvgMgPerDl,
        bloodGlucoseGranularDataMgPerDL:
            bloodGlucoseGranularDataMgPerDl?.map((e) => e.toItem()).toList(),
        bloodPressureDayAvgSystolicDiastolic:
            bloodPressureDayAvgSystolicDiastolic?.toItem(),
        bloodPressureGranularDataSystolicDiastolic:
            bloodPressureGranularDataSystolicDiastolic
                ?.map((e) => e.toItem())
                .toList(),
        hydrationAmountGranularDataMl:
            hydrationAmountGranularDataMl?.map((e) => e.toItem()).toList(),
        hrMaxBpm: hrMaxBpm,
        hrMinimumBpm: hrMinimumBpm,
        hrAvgBpm: hrAvgBpm,
        hrAvgRestingBpm: hrAvgRestingBpm,
        hrGranularDataBpm: hrGranularDataBpm?.map((e) => e.toItem()).toList(),
        hrvAvgRmssd: hrvAvgRmssd,
        hrvRmssdGranularData:
            hrvRmssdGranularData?.map((e) => e.toItem()).toList(),
        saturationAvgPercentage: saturationAvgPercentage,
        saturationGranularDataPercentage:
            saturationGranularDataPercentage?.map((e) => e.toItem()).toList(),
        vo2MaxAvgMlPerMinPerKg: vo2MaxAvgMlPerMinPerKg,
        vo2GranularDataLiterPerMin:
            vo2MaxGranularDataMlPerMinPerKg?.map((e) => e.toItem()).toList(),
        temperatureMinimumCelsius: temperatureMinimumCelsius,
        temperatureAvgCelsius: temperatureAvgCelsius,
        temperatureMaxCelsius: temperatureMaxCelsius,
        temperatureGranularDataCelsius:
            temperatureGranularDataCelsius?.map((e) => e.toItem()).toList());
  }
}

extension BloodGlucoseGranularDataMgPerDLExtension
    on BloodGlucoseGranularDataMgPerDL {
  BloodGlucoseGranularDataMgPerDLItem toItem() {
    return BloodGlucoseGranularDataMgPerDLItem(
      dateTime: toUTCDateTime(dateTime),
      bloodGlucoseMgPerDL: bloodGlucoseMgPerDl,
    );
  }
}

extension BloodPressureGranularDataSystolicDiastolicExtension
    on BloodPressureGranularDataSystolicDiastolic {
  BloodPressureGranularDataSystolicDiastolicItem toItem() {
    return BloodPressureGranularDataSystolicDiastolicItem(
      dateTime: toUTCDateTime(dateTime),
      systolicBp: bloodPressureSystolicDiastolic.systolicBp ?? 0,
      diastolicBp: bloodPressureSystolicDiastolic.diastolicBp ?? 0,
    );
  }
}

extension BloodPressureSystolicDiastolicExtension
    on BloodPressureSystolicDiastolic {
  BloodPressureSystolicDiastolicItem toItem() {
    return BloodPressureSystolicDiastolicItem(
      systolicBp: systolicBp ?? 0,
      diastolicBp: diastolicBp ?? 0,
    );
  }
}

extension CadenceGranularDataRpmExtension on CadenceGranularDataRpm {
  CadenceGranularDataRpmItem toItem() {
    return CadenceGranularDataRpmItem(
      dateTime: toUTCDateTime(dateTime),
      intervalDurationSeconds: 0,
      cadenceRpm: cadenceRpm,
    );
  }
}

extension ElevationGranularDataMetersExtension
    on ElevationGranularDataMeters {
  ElevationGranularDataMetersItem toItem() {
    return ElevationGranularDataMetersItem(
      dateTime: toUTCDateTime(dateTime),
      intervalDurationSeconds: 0,
      elevationChange: elevationChange,
    );
  }
}

extension FloorsClimbedGranularDataExtension on FloorsClimbedGranularData {
  FloorsClimbedGranularDataItem toItem() {
    return FloorsClimbedGranularDataItem(
      dateTime: toUTCDateTime(dateTime),
      intervalDurationSeconds: 0,
      floorsClimbed: floorsClimbed,
    );
  }
}

extension HrGranularDataBpmExtension on HrGranularDataBpm {
  HrGranularDataBpmItem toItem() {
    return HrGranularDataBpmItem(
      dateTime: toUTCDateTime(dateTime),
      hrBpm: hrBpm,
    );
  }
}

extension HrvRmssdGranularDataExtension on HrvRmssdGranularData {
  HrvRmssdGranularDataItem toItem() {
    return HrvRmssdGranularDataItem(
      dateTime: toUTCDateTime(dateTime),
      hrvRmssd: hrvRmssd,
    );
  }
}

extension HydrationAmountGranularDataMlExtension
    on HydrationAmountGranularDataMl {
  HydrationAmountGranularDataMlItem toItem() {
    return HydrationAmountGranularDataMlItem(
      dateTime: toUTCDateTime(dateTime),
      intervalDurationSeconds: 0,
      hydrationAmountMl: hydrationAmountMl,
    );
  }
}

extension SaturationGranularDataPercentageExtension
    on SaturationGranularDataPercentage {
  SaturationGranularDataPercentageItem toItem() {
    return SaturationGranularDataPercentageItem(
      dateTime: toUTCDateTime(dateTime),
      saturationPercentage: saturationPercentage,
    );
  }
}

extension SpeedGranularDataMetersPerSecondExtension
    on SpeedGranularDataMetersPerSecond {
  SpeedGranularDataMetersPerSecondItem toItem() {
    return SpeedGranularDataMetersPerSecondItem(
      dateTime: toUTCDateTime(dateTime),
      intervalDurationSeconds: 0,
      speedMetersPerSecond: speedMetersPerSecond,
    );
  }
}

extension StepsGranularDataStepsPerHrExtension
    on StepsGranularDataStepsPerHr {
  StepsGranularDataStepsPerHrItem toItem() {
    return StepsGranularDataStepsPerHrItem(
      dateTime: toUTCDateTime(dateTime),
      intervalDurationSeconds: 0,
      steps: steps,
    );
  }
}

extension TemperatureGranularDataCelsiusExtension
    on TemperatureGranularDataCelsius {
  TemperatureGranularDataCelsiusItem toItem() {
    return TemperatureGranularDataCelsiusItem(
      dateTime: toUTCDateTime(dateTime),
      temperatureCelsius: temperatureCelsius,
    );
  }
}

extension TraveledDistanceGranularDataMetersExtension
    on TraveledDistanceGranularDataMeters {
  TraveledDistanceGranularDataMetersItem toItem() {
    return TraveledDistanceGranularDataMetersItem(
      dateTime: toUTCDateTime(dateTime),
      intervalDurationSeconds: 0,
      traveledDistanceMeters: traveledDistanceMeters,
    );
  }
}

extension Vo2GranularDataLiterPerMinExtension
    on Vo2MaxGranularDataMlPerMinPerKg {
  Vo2GranularDataLiterPerMinItem toItem() {
    return Vo2GranularDataLiterPerMinItem(
      dateTime: toUTCDateTime(dateTime),
      vo2MlPerMinPerKg: vo2MaxMlPerMinPerKg,
    );
  }
}
