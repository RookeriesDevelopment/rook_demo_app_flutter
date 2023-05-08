import 'package:rook_apple_health/rook_apple_health.dart';
import 'package:rook_transmission/rook_transmission.dart';

extension AHSleepSummaryExtension on AHSleepSummary{
  SleepSummaryItem toItem() {
    return SleepSummaryItem(
      sourceOfData: sourceOfData,
      dateTime: dateTime,
      sleepStartDatetime: sleepStartDatetime,
      sleepEndDatetime: sleepEndDatetime,
      sleepDate: sleepDate,
      sleepDurationSeconds: sleepDurationSeconds,
      timeInBedSeconds: timeInBedSeconds,
      lightSleepDurationSeconds: lightSleepDurationSeconds,
      remSleepDurationSeconds: remSleepDurationSeconds,
      deepSleepDurationSeconds: deepSleepDurationSeconds,
      timeToFallAsleepSeconds: timeToFallAsleepSeconds,
      timeAwakeDuringSleepSeconds: timeAwakeDuringSleepSeconds,
      sleepQualityRating1To5Score: sleepQualityRating1To5Score,
      sleepEfficiency1To100Score: sleepEfficiency1To100Score,
      sleepGoalSeconds: sleepGoalSeconds,
      sleepContinuity1To5Score: sleepContinuity1To5Score,
      sleepContinuity1To5Rating: sleepContinuity1To5Rating,
      hrMaxBpm: hrMaxBpm,
      hrMinimumBpm: hrMinimumBpm,
      hrAvgBpm: hrAvgBpm,
      hrAvgRestingBpm: hrAvgRestingBpm,
      hrBasalBpm: hrBasalBpm,
      hrGranularDataBpm: hrGranularDataBpm?.map((e) => e.toItem()).toList(),
      hrvAvgRmssd: hrvAvgRmssd,
      hrvRmssdGranularData:
          hrvRmssdGranularData?.map((e) => e.toItem()).toList(),
      hrvAvgSdnn: hrvAvgSdnn,
      hrvSdnnGranularData: hrvSdnnGranularData?.map((e) => e.toItem()).toList(),
      temperatureMinimumCelsius: temperatureMinimumCelsius,
      temperatureAvgCelsius: temperatureAvgCelsius,
      temperatureMaxCelsius: temperatureMaxCelsius,
      temperatureDeltaCelsius: temperatureDeltaCelsius,
      temperatureGranularDataCelsius:
          temperatureGranularDataCelsius?.map((e) => e.toItem()).toList(),
      breathsMinimumPerMin: breathsMinimumPerMin,
      breathsAvgPerMin: breathsAvgPerMin,
      breathsMaxPerMin: breathsMaxPerMin,
      breathingGranularDataBreathsPerMin:
          breathingGranularDataBreathsPerMin?.map((e) => e.toItem()).toList(),
      snoringEventsCount: snoringEventsCount,
      snoringDurationTotalSeconds: snoringDurationTotalSeconds,
      snoringGranularData: snoringGranularData?.map((e) => e.toItem()).toList(),
      saturationAvgPercentage: saturationAvgPercentage,
      saturationGranularDataPercentage:
          saturationGranularDataPercentage?.map((e) => e.toItem()).toList(),
    );
  }
}

extension AHPhysicalSummaryExtension on AHPhysicalSummary{
  PhysicalSummaryItem toItem() {
    return PhysicalSummaryItem(
      sourceOfData: sourceOfData,
      dateTime: dateTime,
      stepsPerDay: stepsPerDay,
      stepsGranularDataStepsPerHr:
          stepsGranularDataStepsPerHr?.map((e) => e.toItem()).toList(),
      activeStepsPerDay: activeStepsPerDay,
      activeStepsGranularDataStepsPerHr:
          activeStepsGranularDataStepsPerHr?.map((e) => e.toItem()).toList(),
      walkedDistanceMeters: walkedDistanceMeters,
      traveledDistanceMeters: traveledDistanceMeters,
      traveledDistanceGranularDataMeters:
          traveledDistanceGranularDataMeters?.map((e) => e.toItem()).toList(),
      floorsClimbed: floorsClimbed,
      floorsClimbedGranularData:
          floorsClimbedGranularData?.map((e) => e.toItem()).toList(),
      elevationAvgAltitudeMeters: elevationAvgAltitudeMeters,
      elevationMinimumAltitudeMeters: elevationMinimumAltitudeMeters,
      elevationMaxAltitudeMeters: elevationMaxAltitudeMeters,
      elevationLossActualAltitudeMeters: elevationLossActualAltitudeMeters,
      elevationGainActualAltitudeMeters: elevationGainActualAltitudeMeters,
      elevationPlannedGainMeters: elevationPlannedGainMeters,
      elevationGranularDataMeters:
          elevationGranularDataMeters?.map((e) => e.toItem()).toList(),
      swimmingStrokes: swimmingStrokes,
      swimmingLaps: swimmingLaps,
      swimmingPoolLengthMeters: swimmingPoolLengthMeters,
      swimmingTotalDistanceMeters: swimmingTotalDistanceMeters,
      swimmingDistanceGranularDataMeters:
          swimmingDistanceGranularDataMeters?.map((e) => e.toItem()).toList(),
      saturationAvgPercentage: saturationAvgPercentage,
      saturationGranularDataPercentage:
          saturationGranularDataPercentage?.map((e) => e.toItem()).toList(),
      vo2MaxAvgMlPerMinPerKg: vo2MaxAvgMlPerMinPerKg,
      vo2GranularDataLiterPerMin:
          vo2GranularDataLiterPerMin?.map((e) => e.toItem()).toList(),
      activeSeconds: activeSeconds,
      restSeconds: restSeconds,
      lowIntensitySeconds: lowIntensitySeconds,
      moderateIntensitySeconds: moderateIntensitySeconds,
      vigorousIntensitySeconds: vigorousIntensitySeconds,
      inactivitySeconds: inactivitySeconds,
      activityLevelGranularData:
          activityLevelGranularData?.map((e) => e.toItem()).toList(),
      continuousInactivePeriods: continuousInactivePeriods,
      caloriesNetIntakeKilocalories: caloriesNetIntakeKilocalories,
      caloriesExpenditureKilocalories: caloriesExpenditureKilocalories,
      caloriesNetActiveKilocalories: caloriesNetActiveKilocalories,
      caloriesBasalMetabolicRateKilocalories:
          caloriesBasalMetabolicRateKilocalories,
      hrMaxBpm: hrMaxBpm,
      hrMinimumBpm: hrMinimumBpm,
      hrAvgBpm: hrAvgBpm,
      hrAvgRestingBpm: hrAvgRestingBpm,
      hrGranularDataBpm: hrGranularDataBpm?.map((e) => e.toItem()).toList(),
      hrvAvgRmssd: hrvAvgRmssd,
      hrvRmssdGranularData:
          hrvRmssdGranularData?.map((e) => e.toItem()).toList(),
      hrvAvgSdnn: hrvAvgSdnn,
      hrvSdnnGranularData: hrvSdnnGranularData?.map((e) => e.toItem()).toList(),
      stressAtRestDurationSeconds: stressAtRestDurationSeconds,
      stressDurationSeconds: stressDurationSeconds,
      lowStressDurationSeconds: lowStressDurationSeconds,
      mediumStressDurationSeconds: mediumStressDurationSeconds,
      highStressDurationSeconds: highStressDurationSeconds,
      stressAvgLevel: stressAvgLevel,
      stressMaxLevel: stressMaxLevel,
      stressGranularDataScore:
          stressGranularDataScore?.map((e) => e.toItem()).toList(),
    );
  }
}

extension AHBodySummaryExtension on AHBodySummary{
  BodySummaryItem toItem() {
    return BodySummaryItem(
      sourceOfData: sourceOfData,
      dateTime: dateTime,
      waistCircumferenceCm: waistCircumferenceCm,
      hipCircumferenceCm: hipCircumferenceCm,
      chestCircumferenceCm: chestCircumferenceCm,
      boneCompositionPercentage: boneCompositionPercentage,
      muscleCompositionPercentage: muscleCompositionPercentage,
      weightKg: weightKg,
      heightCm: heightCm,
      bloodGlucoseDayAvgMgPerDl: bloodGlucoseDayAvgMgPerDl,
      bloodGlucoseGranularDataMgPerDL:
          bloodGlucoseGranularDataMgPerDL?.map((e) => e.toItem()).toList(),
      bloodPressureDayAvgSystolicDiastolic:
          bloodPressureDayAvgSystolicDiastolic?.toItem(),
      bloodPressureGranularDataSystolicDiastolic:
          bloodPressureGranularDataSystolicDiastolic
              ?.map((e) => e.toItem())
              .toList(),
      waterTotalConsumptionMl: waterTotalConsumptionMl,
      hydrationAmountGranularDataMl:
          hydrationAmountGranularDataMl?.map((e) => e.toItem()).toList(),
      hydrationLevelGranularDataPercentage:
          hydrationLevelGranularDataPercentage?.map((e) => e.toItem()).toList(),
      hrMaxBpm: hrMaxBpm,
      hrMinimumBpm: hrMinimumBpm,
      hrAvgBpm: hrAvgBpm,
      hrAvgRestingBpm: hrAvgRestingBpm,
      hrGranularDataBpm: hrGranularDataBpm?.map((e) => e.toItem()).toList(),
      hrvAvgRmssd: hrvAvgRmssd,
      hrvRmssdGranularData:
          hrvRmssdGranularData?.map((e) => e.toItem()).toList(),
      hrvAvgSdnn: hrvAvgSdnn,
      hrvSdnnGranularData: hrvSdnnGranularData?.map((e) => e.toItem()).toList(),
      moodMinimumScale: moodMinimumScale,
      moodAvgScale: moodAvgScale,
      moodMaxScale: moodMaxScale,
      moodDeltaScale: moodDeltaScale,
      moodGranularDataScale:
          moodGranularDataScale?.map((e) => e.toItem()).toList(),
      foodIntake: foodIntake,
      caloriesIntake: caloriesIntake,
      proteinIntakeG: proteinIntakeG,
      sugarIntakeG: sugarIntakeG,
      fatIntakeG: fatIntakeG,
      transFatIntakeG: transFatIntakeG,
      carbohydratesIntakeG: carbohydratesIntakeG,
      fiberIntakeG: fiberIntakeG,
      alcoholIntakeG: alcoholIntakeG,
      sodiumIntakeMg: sodiumIntakeMg,
      cholesterolIntakeMg: cholesterolIntakeMg,
      saturationAvgPercentage: saturationAvgPercentage,
      saturationGranularDataPercentage:
          saturationGranularDataPercentage?.map((e) => e.toItem()).toList(),
      vo2MaxAvgMlPerMinPerKg: vo2MaxAvgMlPerMinPerKg,
      vo2GranularDataLiterPerMin:
          vo2GranularDataLiterPerMin?.map((e) => e.toItem()).toList(),
      temperatureMinimumCelsius: temperatureMinimumCelsius,
      temperatureAvgCelsius: temperatureAvgCelsius,
      temperatureMaxCelsius: temperatureMaxCelsius,
      temperatureDeltaCelsius: temperatureDeltaCelsius,
      temperatureGranularDataCelsius:
          temperatureGranularDataCelsius?.map((e) => e.toItem()).toList(),
    );
  }
}

extension AHBloodGlucoseGranularDataMgPerDLExtension
    on AHBloodGlucoseGranularDataMgPerDL{
  BloodGlucoseGranularDataMgPerDLItem toItem() {
    return BloodGlucoseGranularDataMgPerDLItem(
      dateTime: dateTime,
      bloodGlucoseMgPerDL: bloodGlucoseMgPerDL,
    );
  }
}

extension AHBloodPressureGranularDataSystolicDiastolicExtension
    on AHBloodPressureGranularDataSystolicDiastolic{
  BloodPressureGranularDataSystolicDiastolicItem toItem() {
    return BloodPressureGranularDataSystolicDiastolicItem(
      dateTime: dateTime,
      systolicBp: bloodPressureSystolicDiastolic.systolicBp,
      diastolicBp: bloodPressureSystolicDiastolic.diastolicBp,
    );
  }
}

extension AHBloodPressureSystolicDiastolicExtension
    on AHBloodPressureSystolicDiastolic{
  BloodPressureSystolicDiastolicItem toItem() {
    return BloodPressureSystolicDiastolicItem(
      systolicBp: systolicBp,
      diastolicBp: diastolicBp,
    );
  }
}

extension AHBreathingGranularDataBreathsPerMinExtension
    on AHBreathingGranularDataBreathsPerMin{
  BreathingGranularDataBreathsPerMinItem toItem() {
    return BreathingGranularDataBreathsPerMinItem(
      dateTime: dateTime,
      breathsPerMin: breathsPerMin,
    );
  }
}

extension AHHrGranularDataBpmExtension on AHHrGranularDataBpm{
  HrGranularDataBpmItem toItem() {
    return HrGranularDataBpmItem(
      dateTime: dateTime,
      hrBpm: hrBpm,
    );
  }
}

extension AHHrvRmssdGranularDataExtension on AHHrvRmssdGranularData{
  HrvRmssdGranularDataItem toItem() {
    return HrvRmssdGranularDataItem(
      dateTime: dateTime,
      hrvRmssd: hrvRmssd,
    );
  }
}

extension AHHrvSdnnGranularDataExtension on AHHrvSdnnGranularData{
  HrvSdnnGranularDataItem toItem() {
    return HrvSdnnGranularDataItem(
      dateTime: dateTime,
      hrvSdnn: hrvSdnn,
    );
  }
}

extension AHHydrationAmountGranularDataMlExtension
    on AHHydrationAmountGranularDataMl{
  HydrationAmountGranularDataMlItem toItem() {
    return HydrationAmountGranularDataMlItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      hydrationAmountMl: hydrationAmountMl,
    );
  }
}

extension AHHydrationLevelGranularDataPercentageExtension
    on AHHydrationLevelGranularDataPercentage{
  HydrationLevelGranularDataPercentageItem toItem() {
    return HydrationLevelGranularDataPercentageItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      hydrationLevelPercentage: hydrationLevelPercentage,
    );
  }
}

extension AHMoodGranularDataScaleExtension on AHMoodGranularDataScale{
  MoodGranularDataScaleItem toItem() {
    return MoodGranularDataScaleItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      moodScale: moodScale,
    );
  }
}

extension AHSaturationGranularDataPercentageExtension
    on AHSaturationGranularDataPercentage{
  SaturationGranularDataPercentageItem toItem() {
    return SaturationGranularDataPercentageItem(
      dateTime: dateTime,
      saturationPercentage: saturationPercentage,
    );
  }
}

extension AHSnoringGranularDataExtension on AHSnoringGranularData{
  SnoringGranularDataItem toItem() {
    return SnoringGranularDataItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      snoringEventsCountNumber: snoringEventsCountNumber,
    );
  }
}

extension AHTemperatureGranularDataCelsiusExtension
    on AHTemperatureGranularDataCelsius{
  TemperatureGranularDataCelsiusItem toItem() {
    return TemperatureGranularDataCelsiusItem(
      dateTime: dateTime,
      temperatureCelsius: temperatureCelsius,
    );
  }
}

extension AHVo2GranularDataLiterPerMinExtension
    on AHVo2MaxGranularDataMlPerMinPerKg{
  Vo2GranularDataLiterPerMinItem toItem() {
    return Vo2GranularDataLiterPerMinItem(
      dateTime: dateTime,
      vo2MlPerMinPerKg: vo2MaxMlPerMinPerKg,
    );
  }
}

extension AHActiveStepsGranularDataStepsPerHrExtension
    on AHActiveStepsGranularDataStepsPerHr{
  ActiveStepsGranularDataStepsPerHrItem toItem() {
    return ActiveStepsGranularDataStepsPerHrItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      steps: steps,
    );
  }
}

extension AHActivityLevelGranularDataExtension on AHActivityLevelGranularData{
  ActivityLevelGranularDataItem toItem() {
    return ActivityLevelGranularDataItem(
      dateTime: dateTime,
      activityLevel: activityLevel,
    );
  }
}

extension AHElevationGranularDataMetersExtension
    on AHElevationGranularDataMeters{
  ElevationGranularDataMetersItem toItem() {
    return ElevationGranularDataMetersItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      elevationChange: elevationChange,
    );
  }
}

extension AHFloorsClimbedGranularDataExtension on AHFloorsClimbedGranularData{
  FloorsClimbedGranularDataItem toItem() {
    return FloorsClimbedGranularDataItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      floorsClimbed: floorsClimbed,
    );
  }
}

extension AHStepsGranularDataStepsPerHrExtension
    on AHStepsGranularDataStepsPerHr{
  StepsGranularDataStepsPerHrItem toItem() {
    return StepsGranularDataStepsPerHrItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      steps: steps,
    );
  }
}

extension AHStressGranularDataScoreExtension on AHStressGranularDataScore{
  StressGranularDataScoreItem toItem() {
    return StressGranularDataScoreItem(
      dateTime: dateTime,
      stressScore: stressScore,
    );
  }
}

extension AHSwimmingDistanceGranularDataMetersExtension
    on AHSwimmingDistanceGranularDataMeters{
  SwimmingDistanceGranularDataMetersItem toItem() {
    return SwimmingDistanceGranularDataMetersItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      swimmingDistanceMeters: swimmingDistanceMeters,
    );
  }
}

extension AHTraveledDistanceGranularDataMetersExtension
    on AHTraveledDistanceGranularDataMeters{
  TraveledDistanceGranularDataMetersItem toItem() {
    return TraveledDistanceGranularDataMetersItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      traveledDistanceMeters: traveledDistanceMeters,
    );
  }
}
