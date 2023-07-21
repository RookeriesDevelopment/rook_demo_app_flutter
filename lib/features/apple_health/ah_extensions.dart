import 'package:rook_apple_health/rook_apple_health.dart';
import 'package:rook_transmission/rook_transmission.dart';

extension AHExtensions on AHSleepSummary {
  SleepSummaryItem toItem() {
    return SleepSummaryItem(
      dateTime: sleepRelatedData.metadata.dateTime,
      sourceOfData: sleepRelatedData.metadata.sourceOfData,
      sleepStartDateTime: sleepRelatedData.sleepDurationRelatedData.sleepStartDateTime,
      sleepEndDateTime: sleepRelatedData.sleepDurationRelatedData.sleepEndDateTime,
      sleepDate: sleepRelatedData.sleepDurationRelatedData.sleepDate,
      sleepDurationSeconds: sleepRelatedData.sleepDurationRelatedData.sleepDurationSeconds,
      timeInBedSeconds: sleepRelatedData.sleepDurationRelatedData.timeInBedSeconds,
      lightSleepDurationSeconds:
          sleepRelatedData.sleepDurationRelatedData.lightSleepDurationSeconds,
      remSleepDurationSeconds: sleepRelatedData.sleepDurationRelatedData.remSleepDurationSeconds,
      deepSleepDurationSeconds: sleepRelatedData.sleepDurationRelatedData.deepSleepDurationSeconds,
      timeToFallAsleepSeconds: sleepRelatedData.sleepDurationRelatedData.timeToFallAsleepSeconds,
      timeAwakeDuringSleepSeconds:
          sleepRelatedData.sleepDurationRelatedData.timeAwakeDuringSleepSeconds,
      sleepQualityRating1To5Score: sleepRelatedData.sleepScores.sleepQualityRating1To5Score,
      sleepEfficiency1To100Score: sleepRelatedData.sleepScores.sleepEfficiency1To100Score,
      sleepGoalSeconds: sleepRelatedData.sleepScores.sleepGoalSeconds,
      sleepContinuity1To5Score: sleepRelatedData.sleepScores.sleepContinuity1To5Score,
      sleepContinuity1To5Rating: sleepRelatedData.sleepScores.sleepContinuity1To5Rating,
      hrMaxBpm: sleepRelatedData.sleepHeartRateRelatedData.hrMaxBpm,
      hrMinimumBpm: sleepRelatedData.sleepHeartRateRelatedData.hrMinimumBpm,
      hrAvgBpm: sleepRelatedData.sleepHeartRateRelatedData.hrAvgBpm,
      hrRestingBpm: sleepRelatedData.sleepHeartRateRelatedData.hrRestingBpm,
      hrBasalBpm: sleepRelatedData.sleepHeartRateRelatedData.hrBasalBpm,
      hrGranularDataBpm: sleepRelatedData.sleepHeartRateRelatedData.hrGranularDataBpm
          ?.map((element) => element.toItem())
          .toList(),
      hrvAvgRmssdNumber: sleepRelatedData.sleepHeartRateRelatedData.hrvAvgRmssdNumber,
      hrvAvgSdnnNumber: sleepRelatedData.sleepHeartRateRelatedData.hrvAvgSdnnNumber,
      hrvSdnnGranularDataNumber: sleepRelatedData
          .sleepHeartRateRelatedData.hrvSdnnGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
      hrvRmssdGranularDataNumber: sleepRelatedData
          .sleepHeartRateRelatedData.hrvRmssdGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
      temperatureMinimumCelsius:
          sleepRelatedData.temperatureRelatedData.temperatureMinimumCelsius?.toItem(),
      temperatureAvgCelsius:
          sleepRelatedData.temperatureRelatedData.temperatureAvgCelsius?.toItem(),
      temperatureMaxCelsius:
          sleepRelatedData.temperatureRelatedData.temperatureMaxCelsius?.toItem(),
      temperatureGranularDataCelsius: sleepRelatedData
          .temperatureRelatedData.temperatureGranularDataCelsius
          ?.map((element) => element.toItem())
          .toList(),
      temperatureDeltaCelsius:
          sleepRelatedData.temperatureRelatedData.temperatureDeltaCelsius?.toItem(),
      breathsMinimumPerMin: sleepRelatedData.breathingRelatedData.breathsMinimumPerMin,
      breathsAvgPerMin: sleepRelatedData.breathingRelatedData.breathsAvgPerMin,
      breathsMaxPerMin: sleepRelatedData.breathingRelatedData.breathsMaxPerMin,
      breathingGranularDataBreathsPerMin: sleepRelatedData
          .breathingRelatedData.breathingGranularDataBreathsPerMin
          ?.map((element) => element.toItem())
          .toList(),
      snoringEventsCountNumber: sleepRelatedData.breathingRelatedData.snoringEventsCountNumber,
      snoringDurationTotalSeconds:
          sleepRelatedData.breathingRelatedData.snoringDurationTotalSeconds,
      snoringGranularDataSnores: sleepRelatedData.breathingRelatedData.snoringGranularDataSnores
          ?.map((element) => element.toItem())
          .toList(),
      saturationAvgPercentage: sleepRelatedData.breathingRelatedData.saturationAvgPercentage,
      saturationMinPercentage: sleepRelatedData.breathingRelatedData.saturationMinPercentage,
      saturationMaxPercentage: sleepRelatedData.breathingRelatedData.saturationMaxPercentage,
      saturationGranularDataPercentage: sleepRelatedData
          .breathingRelatedData.saturationGranularDataPercentage
          ?.map((element) => element.toItem())
          .toList(),
    );
  }
}

extension AHExtensions2 on AHPhysicalSummary {
  PhysicalSummaryItem toItem() {
    return PhysicalSummaryItem(
      dateTime: dailyActivityRelatedData.metadata.dateTime,
      sourceOfData: dailyActivityRelatedData.metadata.sourceOfData,
      stepsPerDayNumber: dailyActivityRelatedData.distanceData.stepsPerDayNumber,
      stepsGranularDataStepsPerHr: dailyActivityRelatedData.distanceData.stepsGranularDataStepsPerHr
          ?.map((element) => element.toItem())
          .toList(),
      activeStepsPerDayNumber: dailyActivityRelatedData.distanceData.activeStepsPerDayNumber,
      activeStepsGranularDataStepsPerHr: dailyActivityRelatedData
          .distanceData.activeStepsGranularDataStepsPerHr
          ?.map((element) => element.toItem())
          .toList(),
      walkedDistanceMeters: dailyActivityRelatedData.distanceData.walkedDistanceMeters,
      traveledDistanceMeters: dailyActivityRelatedData.distanceData.traveledDistanceMeters,
      traveledDistanceGranularDataMeters: dailyActivityRelatedData
          .distanceData.traveledDistanceGranularDataMeters
          ?.map((element) => element.toItem())
          .toList(),
      floorsClimbedNumber: dailyActivityRelatedData.distanceData.floorsClimbedNumber,
      floorsClimbedGranularDataFloors: dailyActivityRelatedData
          .distanceData.floorsClimbedGranularDataFloors
          ?.map((element) => element.toItem())
          .toList(),
      elevationAvgAltitudeMeters: dailyActivityRelatedData.distanceData.elevationAvgAltitudeMeters,
      elevationMinimumAltitudeMeters:
          dailyActivityRelatedData.distanceData.elevationMinimumAltitudeMeters,
      elevationMaxAltitudeMeters: dailyActivityRelatedData.distanceData.elevationMaxAltitudeMeters,
      elevationLossActualAltitudeMeters:
          dailyActivityRelatedData.distanceData.elevationLossActualAltitudeMeters,
      elevationGainActualAltitudeMeters:
          dailyActivityRelatedData.distanceData.elevationGainActualAltitudeMeters,
      elevationPlannedGainMeters: dailyActivityRelatedData.distanceData.elevationPlannedGainMeters,
      elevationGranularDataMeters: dailyActivityRelatedData.distanceData.elevationGranularDataMeters
          ?.map((element) => element.toItem())
          .toList(),
      swimmingStrokesNumber: dailyActivityRelatedData.distanceData.swimmingStrokesNumber,
      swimmingNumLapsNumber: dailyActivityRelatedData.distanceData.swimmingNumLapsNumber,
      swimmingPoolLengthMeters: dailyActivityRelatedData.distanceData.swimmingPoolLengthMeters,
      swimmingTotalDistanceMeters:
          dailyActivityRelatedData.distanceData.swimmingTotalDistanceMeters,
      swimmingDistanceGranularDataMeters: dailyActivityRelatedData
          .distanceData.swimmingDistanceGranularDataMeters
          ?.map((element) => element.toItem())
          .toList(),
      saturationAvgPercentage: dailyActivityRelatedData.oxygenationData.saturationAvgPercentage,
      saturationGranularDataPercentage: dailyActivityRelatedData
          .oxygenationData.saturationGranularDataPercentage
          ?.map((element) => element.toItem())
          .toList(),
      vo2MaxMlPerMinPerKg: dailyActivityRelatedData.oxygenationData.vo2MaxMlPerMinPerKg,
      vo2GranularDataMlPerMin: dailyActivityRelatedData.oxygenationData.vo2GranularDataMlPerMin
          ?.map((element) => element.toItem())
          .toList(),
      activeSeconds: dailyActivityRelatedData.activityData.activeSeconds,
      restSeconds: dailyActivityRelatedData.activityData.restSeconds,
      lowIntensitySeconds: dailyActivityRelatedData.activityData.lowIntensitySeconds,
      moderateIntensitySeconds: dailyActivityRelatedData.activityData.moderateIntensitySeconds,
      vigorousIntensitySeconds: dailyActivityRelatedData.activityData.vigorousIntensitySeconds,
      inactivitySeconds: dailyActivityRelatedData.activityData.inactivitySeconds,
      activityLevelGranularDataNumber: dailyActivityRelatedData
          .activityData.activityLevelGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
      continuousInactivePeriodsNumber:
          dailyActivityRelatedData.activityData.continuousInactivePeriodsNumber,
      caloriesNetIntakeKilocalories:
          dailyActivityRelatedData.caloriesData.caloriesNetIntakeKilocalories,
      caloriesExpenditureKilocalories:
          dailyActivityRelatedData.caloriesData.caloriesExpenditureKilocalories,
      caloriesNetActiveKilocalories:
          dailyActivityRelatedData.caloriesData.caloriesNetActiveKilocalories,
      caloriesBasalMetabolicRateKilocalories:
          dailyActivityRelatedData.caloriesData.caloriesBasalMetabolicRateKilocalories,
      hrMaxBpm: dailyActivityRelatedData.heartRateData.hrMaxBpm,
      hrMinimumBpm: dailyActivityRelatedData.heartRateData.hrMinimumBpm,
      hrAvgBpm: dailyActivityRelatedData.heartRateData.hrAvgBpm,
      hrRestingBpm: dailyActivityRelatedData.heartRateData.hrRestingBpm,
      hrGranularDataBpm: dailyActivityRelatedData.heartRateData.hrGranularDataBpm
          ?.map((element) => element.toItem())
          .toList(),
      hrvAvgRmssdNumber: dailyActivityRelatedData.heartRateData.hrvAvgRmssdNumber,
      hrvAvgSdnnNumber: dailyActivityRelatedData.heartRateData.hrvAvgSdnnNumber,
      hrvSdnnGranularDataNumber: dailyActivityRelatedData.heartRateData.hrvSdnnGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
      hrvRmssdGranularDataNumber: dailyActivityRelatedData.heartRateData.hrvRmssdGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
      stressAtRestDurationSeconds: dailyActivityRelatedData.stressData.stressAtRestDurationSeconds,
      stressDurationSeconds: dailyActivityRelatedData.stressData.stressDurationSeconds,
      lowStressDurationSeconds: dailyActivityRelatedData.stressData.lowStressDurationSeconds,
      mediumStressDurationSeconds: dailyActivityRelatedData.stressData.mediumStressDurationSeconds,
      highStressDurationSeconds: dailyActivityRelatedData.stressData.highStressDurationSeconds,
      stressGranularDataScoreNumber: dailyActivityRelatedData
          .stressData.stressGranularDataScoreNumber
          ?.map((element) => element.toItem())
          .toList(),
      stressAvgLevelNumber: dailyActivityRelatedData.stressData.stressAvgLevelNumber,
      stressMaxLevelNumber: dailyActivityRelatedData.stressData.stressMaxLevelNumber,
    );
  }
}

extension AHExtensions3 on AHPhysicalEvent {
  PhysicalEventItem toItem() {
    return PhysicalEventItem(
      dateTime: activity.metadata.dateTime,
      sourceOfData: activity.metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: activity.metadata.wasTheUserUnderPhysicalActivity,
      activityStartTimeDateTime: activity.activityData.activityStartTimeDateTime,
      activityEndTimeDateTime: activity.activityData.activityEndTimeDateTime,
      activityDurationSeconds: activity.activityData.activityDurationSeconds,
      activityTypeName: activity.activityData.activityTypeName,
      activeSeconds: activity.activityData.activeSeconds,
      restSeconds: activity.activityData.restSeconds,
      lowIntensitySeconds: activity.activityData.lowIntensitySeconds,
      moderateIntensitySeconds: activity.activityData.moderateIntensitySeconds,
      vigorousIntensitySeconds: activity.activityData.vigorousIntensitySeconds,
      inactivitySeconds: activity.activityData.inactivitySeconds,
      activityLevelGranularDataNumber: activity.activityData.activityLevelGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
      continuousInactivePeriodsNumber: activity.activityData.continuousInactivePeriodsNumber,
      activityStrainLevelNumber: activity.activityData.activityStrainLevelNumber,
      activityWorkKilojoules: activity.activityData.activityWorkKilojoules,
      activityEnergyKilojoules: activity.activityData.activityEnergyKilojoules,
      activityEnergyPlannedKilojoules: activity.activityData.activityEnergyPlannedKilojoules,
      caloriesNetIntakeKilocalories: activity.caloriesData.caloriesNetIntakeKilocalories,
      caloriesExpenditureKilocalories: activity.caloriesData.caloriesExpenditureKilocalories,
      caloriesNetActiveKilocalories: activity.caloriesData.caloriesNetActiveKilocalories,
      caloriesBasalMetabolicRateKilocalories:
          activity.caloriesData.caloriesBasalMetabolicRateKilocalories,
      fatPercentageOfCaloriesPercentage: activity.caloriesData.fatPercentageOfCaloriesPercentage,
      carbohydratePercentageOfCaloriesPercentage:
          activity.caloriesData.carbohydratePercentageOfCaloriesPercentage,
      proteinPercentageOfCaloriesPercentage:
          activity.caloriesData.proteinPercentageOfCaloriesPercentage,
      stepsNumber: activity.distanceData.stepsNumber,
      stepsGranularDataStepsPerMin: activity.distanceData.stepsGranularDataStepsPerMin
          ?.map((element) => element.toItem())
          .toList(),
      walkedDistanceMeters: activity.distanceData.walkedDistanceMeters,
      traveledDistanceMeters: activity.distanceData.traveledDistanceMeters,
      traveledDistanceGranularDataMeters: activity.distanceData.traveledDistanceGranularDataMeters
          ?.map((element) => element.toItem())
          .toList(),
      floorsClimbedNumber: activity.distanceData.floorsClimbedNumber,
      floorsClimbedGranularDataFloors: activity.distanceData.floorsClimbedGranularDataFloorsNumber
          ?.map((element) => element.toItem())
          .toList(),
      elevationAvgAltitudeMeters: activity.distanceData.elevationAvgAltitudeMeters,
      elevationMinimumAltitudeMeters: activity.distanceData.elevationMinimumAltitudeMeters,
      elevationMaxAltitudeMeters: activity.distanceData.elevationMaxAltitudeMeters,
      elevationLossActualAltitudeMeters: activity.distanceData.elevationLossActualAltitudeMeters,
      elevationGainActualAltitudeMeters: activity.distanceData.elevationGainActualAltitudeMeters,
      elevationPlannedGainMeters: activity.distanceData.elevationPlannedGainMeters,
      elevationGranularDataMeters: activity.distanceData.elevationGranularDataMeters
          ?.map((element) => element.toItem())
          .toList(),
      swimmingNumStrokesNumber: activity.distanceData.swimmingNumStrokesNumber,
      swimmingNumLapsNumber: activity.distanceData.swimmingNumLapsNumber,
      swimmingPoolLengthMeters: activity.distanceData.swimmingPoolLengthMeters,
      swimmingTotalDistanceMeters: activity.distanceData.swimmingTotalDistanceMeters,
      swimmingDistanceGranularDataMeters: activity.distanceData.swimmingDistanceGranularDataMeters
          ?.map((element) => element.toItem())
          .toList(),
      hrMaxBpm: activity.heartRateData.hrMaxBpm,
      hrMinimumBpm: activity.heartRateData.hrMinimumBpm,
      hrAvgBpm: activity.heartRateData.hrAvgBpm,
      hrRestingBpm: activity.heartRateData.hrRestingBpm,
      hrGranularDataBpm:
          activity.heartRateData.hrGranularDataBpm?.map((element) => element.toItem()).toList(),
      hrvAvgRmssdNumber: activity.heartRateData.hrvAvgRmssdNumber,
      hrvAvgSdnnNumber: activity.heartRateData.hrvAvgSdnnNumber,
      hrvSdnnGranularDataNumber: activity.heartRateData.hrvSdnnGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
      hrvRmssdGranularDataNumber: activity.heartRateData.hrvRmssdGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
      speedNormalizedMetersPerSecond: activity.movementData.speedNormalizedMetersPerSecond,
      speedAvgMetersPerSecond: activity.movementData.speedAvgMetersPerSecond,
      speedMaxMetersPerSecond: activity.movementData.speedMaxMetersPerSecond,
      speedGranularDataMetersPerSecond: activity.movementData.speedGranularDataMetersPerSecond
          ?.map((element) => element.toItem())
          .toList(),
      velocityVectorAvgSpeedAndDirection:
          activity.movementData.velocityVectorAvgSpeedAndDirection?.toItem(),
      velocityVectorMaxSpeedAndDirection:
          activity.movementData.velocityVectorMaxSpeedAndDirection?.toItem(),
      paceAvgMinutesPerKilometer: activity.movementData.paceAvgMinutesPerKilometer,
      paceMaxMinutesPerKilometer: activity.movementData.paceMaxMinutesPerKilometer,
      cadenceAvgRpm: activity.movementData.cadenceAvgRpm,
      cadenceMaxRpm: activity.movementData.cadenceMaxRpm,
      cadenceGranularDataRpm:
          activity.movementData.cadenceGranularDataRpm?.map((element) => element.toItem()).toList(),
      torqueAvgNewtonMeters: activity.movementData.torqueAvgNewtonMeters,
      torqueMaxNewtonMeters: activity.movementData.torqueMaxNewtonMeters,
      torqueGranularDataNewtonMeters: activity.movementData.torqueGranularDataNewtonMeters
          ?.map((element) => element.toItem())
          .toList(),
      lapGranularDataLapsNumber: activity.movementData.lapGranularDataLapsNumber
          ?.map((element) => element.toItem())
          .toList(),
      powerAvgWattsNumber: activity.powerData.powerAvgWattsNumber,
      powerMaxWattsNumber: activity.powerData.powerMaxWattsNumber,
      powerGranularDataWattsNumber: activity.powerData.powerGranularDataWattsNumber
          ?.map((element) => element.toItem())
          .toList(),
      positionStartLatLngDeg: activity.positionData.positionStartLatLngDeg?.toItem(),
      positionCentroidLatLngDeg: activity.positionData.positionCentroidLatLngDeg?.toItem(),
      positionEndLatLngDeg: activity.positionData.positionEndLatLngDeg?.toItem(),
      positionGranularDataLatLngDeg: activity.positionData.positionGranularDataLatLngDeg
          ?.map((element) => element.toItem())
          .toList(),
      positionPolylineMapDataSummaryString:
          activity.positionData.positionPolylineMapDataSummaryString,
      saturationAvgPercentage: activity.oxygenationData.saturationAvgPercentage,
      saturationGranularDataPercentage: activity.oxygenationData.saturationGranularDataPercentage
          ?.map((element) => element.toItem())
          .toList(),
      vo2MaxMlPerMinPerKg: activity.oxygenationData.vo2MaxMlPerMinPerKg,
      vo2GranularDataMlPerMin: activity.oxygenationData.vo2GranularDataMlPerMin
          ?.map((element) => element.toItem())
          .toList(),
      stressAtRestDurationSeconds: activity.stressData.stressAtRestDurationSeconds,
      stressDurationSeconds: activity.stressData.stressDurationSeconds,
      lowStressDurationSeconds: activity.stressData.lowStressDurationSeconds,
      mediumStressDurationSeconds: activity.stressData.mediumStressDurationSeconds,
      highStressDurationSeconds: activity.stressData.highStressDurationSeconds,
      tssGranularData1To500ScoreNumber: activity.stressData.tssGranularData1To500ScoreNumber
          ?.map((element) => element.toItem())
          .toList(),
      stressAvgLevelNumber: activity.stressData.stressAvgLevelNumber,
      stressMaxLevelNumber: activity.stressData.stressMaxLevelNumber,
    );
  }
}

extension AHExtensions4 on AHBodySummary {
  BodySummaryItem toItem() {
    return BodySummaryItem(
      dateTime: bodyData.metadata.dateTime,
      sourceOfData: bodyData.metadata.sourceOfData,
      waistCircumferenceCmNumber: bodyData.bodyMetrics.waistCircumferenceCmNumber,
      hipCircumferenceCmNumber: bodyData.bodyMetrics.hipCircumferenceCmNumber,
      chestCircumferenceCmNumber: bodyData.bodyMetrics.chestCircumferenceCmNumber,
      boneCompositionPercentageNumber: bodyData.bodyMetrics.boneCompositionPercentageNumber,
      muscleCompositionPercentageNumber: bodyData.bodyMetrics.muscleCompositionPercentageNumber,
      waterCompositionPercentageNumber: bodyData.bodyMetrics.waterCompositionPercentageNumber,
      weightKgNumber: bodyData.bodyMetrics.weightKgNumber,
      heightCmNumber: bodyData.bodyMetrics.heightCmNumber,
      bmiNumber: bodyData.bodyMetrics.bmiNumber,
      bloodGlucoseDayAvgMgPerDlNumber: bodyData.bloodGlucose.bloodGlucoseDayAvgMgPerDlNumber,
      bloodGlucoseGranularDataMgPerDlNumber: bodyData
          .bloodGlucose.bloodGlucoseGranularDataMgPerDlNumber
          ?.map((element) => element.toItem())
          .toList(),
      bloodPressureDayAvgSystolicDiastolicBpNumber:
          bodyData.bloodPressure.bloodPressureDayAvgSystolicDiastolicBpNumber?.toItem(),
      bloodPressureGranularDataSystolicDiastolicBpNumber: bodyData
          .bloodPressure.bloodPressureGranularDataSystolicDiastolicBpNumber
          ?.map((element) => element.toItem())
          .toList(),
      waterTotalConsumptionMlNumber: bodyData.hydration.waterTotalConsumptionMlNumber,
      hydrationAmountGranularDataMlNumber: bodyData.hydration.hydrationAmountGranularDataMlNumber
          ?.map((element) => element.toItem())
          .toList(),
      hydrationLevelGranularDataPercentageNumber: bodyData
          .hydration.hydrationLevelGranularDataPercentageNumber
          ?.map((element) => element.toItem())
          .toList(),
      hrMaxBpm: bodyData.heartRateData.hrMaxBpm,
      hrMinimumBpm: bodyData.heartRateData.hrMinimumBpm,
      hrAvgBpm: bodyData.heartRateData.hrAvgBpm,
      hrRestingBpm: bodyData.heartRateData.hrRestingBpm,
      hrGranularDataBpm:
          bodyData.heartRateData.hrGranularDataBpm?.map((element) => element.toItem()).toList(),
      hrvAvgRmssdNumber: bodyData.heartRateData.hrvAvgRmssdNumber,
      hrvAvgSdnnNumber: bodyData.heartRateData.hrvAvgSdnnNumber,
      hrvSdnnGranularDataNumber: bodyData.heartRateData.hrvSdnnGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
      hrvRmssdGranularDataNumber: bodyData.heartRateData.hrvRmssdGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
      moodMinimumScale: bodyData.mood.moodMinimumScale,
      moodAvgScale: bodyData.mood.moodAvgScale,
      moodMaxScale: bodyData.mood.moodMaxScale,
      moodGranularDataScale:
          bodyData.mood.moodGranularDataScale?.map((element) => element.toItem()).toList(),
      moodDeltaScale: bodyData.mood.moodDeltaScale,
      foodIntakeNumber: bodyData.nutrition.foodIntakeNumber,
      caloriesIntakeNumber: bodyData.nutrition.caloriesIntakeNumber,
      proteinIntakeGNumber: bodyData.nutrition.proteinIntakeGNumber,
      sugarIntakeGNumber: bodyData.nutrition.sugarIntakeGNumber,
      fatIntakeGNumber: bodyData.nutrition.fatIntakeGNumber,
      transFatIntakeGNumber: bodyData.nutrition.transFatIntakeGNumber,
      carbohydratesIntakeGNumber: bodyData.nutrition.carbohydratesIntakeGNumber,
      fiberIntakeGNumber: bodyData.nutrition.fiberIntakeGNumber,
      alcoholIntakeGNumber: bodyData.nutrition.alcoholIntakeGNumber,
      sodiumIntakeMgNumber: bodyData.nutrition.sodiumIntakeMgNumber,
      cholesterolIntakeMgNumber: bodyData.nutrition.cholesterolIntakeMgNumber,
      saturationAvgPercentage: bodyData.oxygenationData.saturationAvgPercentage,
      saturationGranularDataPercentage: bodyData.oxygenationData.saturationGranularDataPercentage
          ?.map((element) => element.toItem())
          .toList(),
      vo2MaxMlPerMinPerKg: bodyData.oxygenationData.vo2MaxMlPerMinPerKg,
      vo2GranularDataMlPerMin: bodyData.oxygenationData.vo2GranularDataMlPerMin
          ?.map((element) => element.toItem())
          .toList(),
      temperatureMinimumCelsius: bodyData.temperatureData.temperatureMinimumCelsius?.toItem(),
      temperatureAvgCelsius: bodyData.temperatureData.temperatureAvgCelsius?.toItem(),
      temperatureMaxCelsius: bodyData.temperatureData.temperatureMaxCelsius?.toItem(),
      temperatureGranularDataCelsius: bodyData.temperatureData.temperatureGranularDataCelsius
          ?.map((element) => element.toItem())
          .toList(),
      temperatureDeltaCelsius: bodyData.temperatureData.temperatureDeltaCelsius?.toItem(),
      lastUpdatedDatetime: bodyData.menstruationData.lastUpdatedDatetime,
      periodStartDate: bodyData.menstruationData.periodStartDate,
      cycleDay: bodyData.menstruationData.cycleDay,
      cycleLengthDays: bodyData.menstruationData.cycleLengthDays,
      predictedCycleLengthDays: bodyData.menstruationData.predictedCycleLengthDays,
      currentPhase: bodyData.menstruationData.currentPhase,
      lengthOfCurrentPhaseDays: bodyData.menstruationData.lengthOfCurrentPhaseDays,
      daysUntilNextPhase: bodyData.menstruationData.daysUntilNextPhase,
      isAPredictedCycle: bodyData.menstruationData.isAPredictedCycle,
      menstruationFlowMlGranularDataNumber: bodyData
          .menstruationData.menstruationFlowMlGranularDataNumber
          ?.map((element) => element.toItem())
          .toList(),
    );
  }
}

extension AHExtensions5 on AHBloodGlucoseEvent {
  BloodGlucoseEventItem toItem() {
    return BloodGlucoseEventItem(
      dateTime: metadata.dateTime,
      sourceOfData: metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: metadata.wasTheUserUnderPhysicalActivity,
      bloodGlucoseDayAvgMgPerDlNumber: bloodGlucose.bloodGlucoseDayAvgMgPerDlNumber,
      bloodGlucoseGranularDataMgPerDlNumber: bloodGlucose.bloodGlucoseGranularDataMgPerDlNumber
          ?.map((element) => element.toItem())
          .toList(),
    );
  }
}

extension AHExtensions6 on AHBloodPressureEvent {
  BloodPressureEventItem toItem() {
    return BloodPressureEventItem(
      dateTime: metadata.dateTime,
      sourceOfData: metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: metadata.wasTheUserUnderPhysicalActivity,
      bloodPressureDayAvgSystolicDiastolicBpNumber:
          bloodPressure.bloodPressureDayAvgSystolicDiastolicBpNumber?.toItem(),
      bloodPressureGranularDataSystolicDiastolicBpNumber: bloodPressure
          .bloodPressureGranularDataSystolicDiastolicBpNumber
          ?.map((element) => element.toItem())
          .toList(),
    );
  }
}

extension AHExtensions7 on AHBodyMetricsEvent {
  BodyMetricsEventItem toItem() {
    return BodyMetricsEventItem(
      dateTime: metadata.dateTime,
      sourceOfData: metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: metadata.wasTheUserUnderPhysicalActivity,
      waistCircumferenceCmNumber: bodyMetrics.waistCircumferenceCmNumber,
      hipCircumferenceCmNumber: bodyMetrics.hipCircumferenceCmNumber,
      chestCircumferenceCmNumber: bodyMetrics.chestCircumferenceCmNumber,
      boneCompositionPercentageNumber: bodyMetrics.boneCompositionPercentageNumber,
      muscleCompositionPercentageNumber: bodyMetrics.muscleCompositionPercentageNumber,
      waterCompositionPercentageNumber: bodyMetrics.waterCompositionPercentageNumber,
      weightKgNumber: bodyMetrics.weightKgNumber,
      heightCmNumber: bodyMetrics.heightCmNumber,
      bmiNumber: bodyMetrics.bmiNumber,
    );
  }
}

extension AHExtensions8 on AHHeartRateEvent {
  HeartRateEventItem toItem() {
    return HeartRateEventItem(
      dateTime: metadata.dateTime,
      sourceOfData: metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: metadata.wasTheUserUnderPhysicalActivity,
      hrMaxBpm: heartRateData.hrMaxBpm,
      hrMinimumBpm: heartRateData.hrMinimumBpm,
      hrAvgBpm: heartRateData.hrAvgBpm,
      hrRestingBpm: heartRateData.hrRestingBpm,
      hrGranularDataBpm:
          heartRateData.hrGranularDataBpm?.map((element) => element.toItem()).toList(),
      hrvAvgRmssdNumber: heartRateData.hrvAvgRmssdNumber,
      hrvAvgSdnnNumber: heartRateData.hrvAvgSdnnNumber,
      hrvSdnnGranularDataNumber:
          heartRateData.hrvSdnnGranularDataNumber?.map((element) => element.toItem()).toList(),
      hrvRmssdGranularDataNumber:
          heartRateData.hrvRmssdGranularDataNumber?.map((element) => element.toItem()).toList(),
    );
  }
}

extension AHExtensions9 on AHHydrationEvent {
  HydrationEventItem toItem() {
    return HydrationEventItem(
      dateTime: metadata.dateTime,
      sourceOfData: metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: metadata.wasTheUserUnderPhysicalActivity,
      waterTotalConsumptionMlNumber: hydration.waterTotalConsumptionMlNumber,
      hydrationAmountGranularDataMlNumber: hydration.hydrationAmountGranularDataMlNumber
          ?.map((element) => element.toItem())
          .toList(),
      hydrationLevelGranularDataPercentageNumber: hydration
          .hydrationLevelGranularDataPercentageNumber
          ?.map((element) => element.toItem())
          .toList(),
    );
  }
}

extension AHExtensions10 on AHMoodEvent {
  MoodEventItem toItem() {
    return MoodEventItem(
      dateTime: metadata.dateTime,
      sourceOfData: metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: metadata.wasTheUserUnderPhysicalActivity,
      moodMinimumScale: mood.moodMinimumScale,
      moodAvgScale: mood.moodAvgScale,
      moodMaxScale: mood.moodMaxScale,
      moodGranularDataScale:
          mood.moodGranularDataScale?.map((element) => element.toItem()).toList(),
      moodDeltaScale: mood.moodDeltaScale,
    );
  }
}

extension AHExtensions11 on AHNutritionEvent {
  NutritionEventItem toItem() {
    return NutritionEventItem(
      dateTime: metadata.dateTime,
      sourceOfData: metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: metadata.wasTheUserUnderPhysicalActivity,
      foodIntakeNumber: nutrition.foodIntakeNumber,
      caloriesIntakeNumber: nutrition.caloriesIntakeNumber,
      proteinIntakeGNumber: nutrition.proteinIntakeGNumber,
      sugarIntakeGNumber: nutrition.sugarIntakeGNumber,
      fatIntakeGNumber: nutrition.fatIntakeGNumber,
      transFatIntakeGNumber: nutrition.transFatIntakeGNumber,
      carbohydratesIntakeGNumber: nutrition.carbohydratesIntakeGNumber,
      fiberIntakeGNumber: nutrition.fiberIntakeGNumber,
      alcoholIntakeGNumber: nutrition.alcoholIntakeGNumber,
      sodiumIntakeMgNumber: nutrition.sodiumIntakeMgNumber,
      cholesterolIntakeMgNumber: nutrition.cholesterolIntakeMgNumber,
    );
  }
}

extension AHExtensions12 on AHOxygenationEvent {
  OxygenationEventItem toItem() {
    return OxygenationEventItem(
      dateTime: metadata.dateTime,
      sourceOfData: metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: metadata.wasTheUserUnderPhysicalActivity,
      saturationAvgPercentage: oxygenationData.saturationAvgPercentage,
      saturationGranularDataPercentage: oxygenationData.saturationGranularDataPercentage
          ?.map((element) => element.toItem())
          .toList(),
      vo2MaxMlPerMinPerKg: oxygenationData.vo2MaxMlPerMinPerKg,
      vo2GranularDataMlPerMin:
          oxygenationData.vo2GranularDataMlPerMin?.map((element) => element.toItem()).toList(),
    );
  }
}

extension AHExtensions13 on AHStressEvent {
  StressEventItem toItem() {
    return StressEventItem(
      dateTime: metadata.dateTime,
      sourceOfData: metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: metadata.wasTheUserUnderPhysicalActivity,
      stressAtRestDurationSeconds: stressData.stressAtRestDurationSeconds,
      stressDurationSeconds: stressData.stressDurationSeconds,
      lowStressDurationSeconds: stressData.lowStressDurationSeconds,
      mediumStressDurationSeconds: stressData.mediumStressDurationSeconds,
      highStressDurationSeconds: stressData.highStressDurationSeconds,
      tssGranularData1To500ScoreNumber:
          stressData.tssGranularData1To500ScoreNumber?.map((element) => element.toItem()).toList(),
      stressAvgLevelNumber: stressData.stressAvgLevelNumber,
      stressMaxLevelNumber: stressData.stressMaxLevelNumber,
    );
  }
}

extension AHExtensions14 on AHTemperatureEvent {
  TemperatureEventItem toItem() {
    return TemperatureEventItem(
      dateTime: metadata.dateTime,
      sourceOfData: metadata.sourceOfData,
      wasTheUserUnderPhysicalActivity: metadata.wasTheUserUnderPhysicalActivity,
      temperatureMinimumCelsius: temperatureData.temperatureMinimumCelsius?.toItem(),
      temperatureAvgCelsius: temperatureData.temperatureAvgCelsius?.toItem(),
      temperatureMaxCelsius: temperatureData.temperatureMaxCelsius?.toItem(),
      temperatureGranularDataCelsius: temperatureData.temperatureGranularDataCelsius
          ?.map((element) => element.toItem())
          .toList(),
      temperatureDeltaCelsius: temperatureData.temperatureDeltaCelsius?.toItem(),
    );
  }
}

extension AHExtensions15 on AHActiveStepsGranularDataStepsPerHr {
  ActiveStepsGranularDataStepsPerHrItem toItem() {
    return ActiveStepsGranularDataStepsPerHrItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      steps: steps,
    );
  }
}

extension AHExtensions16 on AHActivityLevelGranularDataNumber {
  ActivityLevelGranularDataNumberItem toItem() {
    return ActivityLevelGranularDataNumberItem(
      dateTime: dateTime,
      activityLevel: activityLevel,
    );
  }
}

extension AHExtensions17 on AHBloodGlucoseGranularDataMgPerDlNumber {
  BloodGlucoseGranularDataMgPerDlNumberItem toItem() {
    return BloodGlucoseGranularDataMgPerDlNumberItem(
      dateTime: dateTime,
      bloodGlucoseMgPerDlNumber: bloodGlucoseMgPerDlNumber,
    );
  }
}

extension AHExtensions18 on AHBloodPressureGranularDataSystolicDiastolicBpNumber {
  BloodPressureGranularDataSystolicDiastolicBpNumberItem toItem() {
    return BloodPressureGranularDataSystolicDiastolicBpNumberItem(
      dateTime: dateTime,
      systolicBp: systolicBp,
      diastolicBp: diastolicBp,
    );
  }
}

extension AHExtensions19 on AHBreathingGranularDataBreathsPerMin {
  BreathingGranularDataBreathsPerMinItem toItem() {
    return BreathingGranularDataBreathsPerMinItem(
      dateTime: dateTime,
      breathsPerMin: breathsPerMin,
    );
  }
}

extension AHExtensions20 on AHCadenceGranularDataRpm {
  CadenceGranularDataRpmItem toItem() {
    return CadenceGranularDataRpmItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      cadenceRpm: cadenceRpm,
    );
  }
}

extension AHExtensions21 on AHElevationGranularDataMeters {
  ElevationGranularDataMetersItem toItem() {
    return ElevationGranularDataMetersItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      elevationChange: elevationChange,
    );
  }
}

extension AHExtensions22 on AHFloorsClimbedGranularDataFloors {
  FloorsClimbedGranularDataFloorsItem toItem() {
    return FloorsClimbedGranularDataFloorsItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      floorsClimbed: floorsClimbed,
    );
  }
}

extension AHExtensions23 on AHHrGranularDataBpm {
  HrGranularDataBpmItem toItem() {
    return HrGranularDataBpmItem(
      dateTime: dateTime,
      hrBpm: hrBpm,
    );
  }
}

extension AHExtensions24 on AHHrvRmssdGranularDataNumber {
  HrvRmssdGranularDataNumberItem toItem() {
    return HrvRmssdGranularDataNumberItem(
      dateTime: dateTime,
      hrvRmssd: hrvRmssdNumber,
    );
  }
}

extension AHExtensions25 on AHHrvSdnnGranularDataNumber {
  HrvSdnnGranularDataNumberItem toItem() {
    return HrvSdnnGranularDataNumberItem(
      dateTime: dateTime,
      hrvSdnn: hrvSdnnNumber,
    );
  }
}

extension AHExtensions26 on AHHydrationAmountGranularDataMlNumber {
  HydrationAmountGranularDataMlNumberItem toItem() {
    return HydrationAmountGranularDataMlNumberItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      hydrationAmountMl: hydrationAmountMl,
    );
  }
}

extension AHExtensions27 on AHHydrationLevelGranularDataPercentageNumber {
  HydrationLevelGranularDataPercentageNumberItem toItem() {
    return HydrationLevelGranularDataPercentageNumberItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      hydrationLevelPercentage: hydrationLevelPercentage,
    );
  }
}

extension AHExtensions28 on AHLapGranularDataLapsNumber {
  LapGranularDataLapsNumberItem toItem() {
    return LapGranularDataLapsNumberItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      laps: laps,
    );
  }
}

extension AHExtensions29 on AHMenstruationFlowMlGranularDataNumber {
  MenstruationFlowMlGranularDataNumberItem toItem() {
    return MenstruationFlowMlGranularDataNumberItem(
      dateTime: dateTime,
      flowMl: flowMl,
    );
  }
}

extension AHExtensions30 on AHMoodGranularDataScale {
  MoodGranularDataScaleItem toItem() {
    return MoodGranularDataScaleItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      moodScale: moodScale,
    );
  }
}

extension AHExtensions31 on AHPositionGranularDataLatLngDeg {
  PositionGranularDataLatLngDegItem toItem() {
    return PositionGranularDataLatLngDegItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      lat: lat,
      lng: lng,
    );
  }
}

extension AHExtensions32 on AHPowerGranularDataWattsNumber {
  PowerGranularDataWattsNumberItem toItem() {
    return PowerGranularDataWattsNumberItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      powerWatts: powerWatts,
    );
  }
}

extension AHExtensions33 on AHSaturationGranularDataPercentage {
  SaturationGranularDataPercentageItem toItem() {
    return SaturationGranularDataPercentageItem(
      dateTime: dateTime,
      saturationPercentage: saturationPercentage,
    );
  }
}

extension AHExtensions34 on AHSnoringGranularDataSnores {
  SnoringGranularDataSnoresItem toItem() {
    return SnoringGranularDataSnoresItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      snoringEventsCountNumber: snoringEventsCountNumber,
    );
  }
}

extension AHExtensions35 on AHSpeedGranularDataMetersPerSecond {
  SpeedGranularDataMetersPerSecondItem toItem() {
    return SpeedGranularDataMetersPerSecondItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      speedMetersPerSecond: speedMetersPerSecond,
    );
  }
}

extension AHExtensions36 on AHStepsGranularDataStepsPerHr {
  StepsGranularDataStepsPerHrItem toItem() {
    return StepsGranularDataStepsPerHrItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      steps: steps,
    );
  }
}

extension AHExtensions37 on AHStepsGranularDataStepsPerMin {
  StepsGranularDataStepsPerMinItem toItem() {
    return StepsGranularDataStepsPerMinItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      steps: steps,
    );
  }
}

extension AHExtensions38 on AHStressGranularDataScoreNumber {
  StressGranularDataScoreNumberItem toItem() {
    return StressGranularDataScoreNumberItem(
      dateTime: dateTime,
      stressScore: stressScore,
    );
  }
}

extension AHExtensions39 on AHSwimmingDistanceGranularDataMeters {
  SwimmingDistanceGranularDataMetersItem toItem() {
    return SwimmingDistanceGranularDataMetersItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      swimmingDistanceMeters: swimmingDistanceMeters,
    );
  }
}

extension AHExtensions40 on AHTemperatureGranularDataCelsius {
  TemperatureGranularDataCelsiusItem toItem() {
    return TemperatureGranularDataCelsiusItem(
      dateTime: dateTime,
      temperatureCelsius: temperatureCelsius,
      measurementType: measurementType,
    );
  }
}

extension AHExtensions41 on AHTorqueGranularDataNewtonMeters {
  TorqueGranularDataNewtonMetersItem toItem() {
    return TorqueGranularDataNewtonMetersItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      torqueNewtonMeters: torqueNewtonMeters,
    );
  }
}

extension AHExtensions42 on AHTraveledDistanceGranularDataMeters {
  TraveledDistanceGranularDataMetersItem toItem() {
    return TraveledDistanceGranularDataMetersItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      traveledDistanceMeters: traveledDistanceMeters,
    );
  }
}

extension AHExtensions43 on AHTssGranularData1To500ScoreNumber {
  TssGranularData1To500ScoreNumberItem toItem() {
    return TssGranularData1To500ScoreNumberItem(
      dateTime: dateTime,
      intervalDurationSeconds: intervalDurationSeconds,
      tss1To500Score: tss1To500Score,
    );
  }
}

extension AHExtensions44 on AHVo2GranularDataMlPerMin {
  Vo2GranularDataMlPerMinItem toItem() {
    return Vo2GranularDataMlPerMinItem(
      dateTime: dateTime,
      vo2MlPerMin: vo2MlPerMin,
    );
  }
}

extension DomainExtensions45 on AHTemperature {
  TemperatureItem toItem() {
    return TemperatureItem(
      temperatureCelsius: temperatureCelsius,
      measurementType: measurementType,
    );
  }
}

extension DomainExtensions46 on AHPositionLatLngDeg {
  PositionLatLngDegItem toItem() {
    return PositionLatLngDegItem(
      lat: lat,
      lng: lng,
    );
  }
}

extension DomainExtensions47 on AHVelocityVectorSpeedAndDirection {
  VelocityVectorSpeedAndDirectionItem toItem() {
    return VelocityVectorSpeedAndDirectionItem(
      speedMetersPerSecond: speedMetersPerSecond,
      direction: direction,
    );
  }
}

extension DomainExtensions48 on AHBloodPressureDaySystolicDiastolicBpNumber {
  BloodPressureDaySystolicDiastolicBpNumberItem toItem() {
    return BloodPressureDaySystolicDiastolicBpNumberItem(
      systolicBp: systolicBp,
      diastolicBp: diastolicBp,
    );
  }
}
