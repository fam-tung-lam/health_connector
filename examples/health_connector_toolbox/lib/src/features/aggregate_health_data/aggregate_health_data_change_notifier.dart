import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector_internal.dart';

/// Manages state and operations for aggregating health data.
///
/// Handles aggregating health records (sum, average, min, max, count) over
/// a time range, tracking loading state and the aggregation result.
final class AggregateDataChangeNotifier extends ChangeNotifier {
  final HealthConnector _healthConnector;

  AggregateDataChangeNotifier(this._healthConnector);

  bool _isLoading = false;
  MeasurementUnit? _aggregationResult;

  MeasurementUnit? get aggregationResult => _aggregationResult;

  bool get isLoading => _isLoading;

  /// Aggregates health data based on the provided parameters.
  ///
  /// Updates [aggregationResult] with the aggregation result on success.
  /// Exceptions are propagated to the caller for handling.
  Future<void> aggregateData({
    required HealthDataType dataType,
    required AggregationMetric aggregationMetric,
    required DateTime startTime,
    required DateTime endTime,
    HealthDataType<HealthRecord, Pressure>? bloodPressureSubtype,
  }) async {
    notify(() {
      _isLoading = true;
      _aggregationResult = null;
    });

    try {
      final request = _buildRequest(
        dataType: dataType,
        metric: aggregationMetric,
        startTime: startTime,
        endTime: endTime,
        bloodPressureSubtype: bloodPressureSubtype,
      );
      final response = await _healthConnector.aggregate(request);
      notify(() {
        _aggregationResult = response;
      });
    } finally {
      notify(() {
        _isLoading = false;
      });
    }
  }

  /// Clears the aggregation results.
  void clearResults() {
    notify(() {
      _aggregationResult = null;
    });
  }

  void notify(void Function() fn) {
    fn();
    notifyListeners();
  }

  /// Builds an aggregation request for the specified parameters.
  ///
  /// Throws [UnsupportedError] if the metric is not supported for the type.
  static AggregateRequest _buildRequest({
    required HealthDataType dataType,
    required AggregationMetric metric,
    required DateTime startTime,
    required DateTime endTime,
    HealthDataType<HealthRecord, Pressure>? bloodPressureSubtype,
  }) {
    return switch (dataType) {
      // Count types - sum only
      StepsDataType() => _buildSum(
        () => HealthDataType.steps.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      FloorsClimbedDataType() => _buildSum(
        () => HealthDataType.floorsClimbed.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      WheelchairPushesDataType() => _buildSum(
        () => HealthDataType.wheelchairPushes.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      AlcoholicBeveragesDataType() => _buildSum(
        () => HealthDataType.alcoholicBeverages.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      ElevationGainedDataType() => _buildSum(
        () => HealthDataType.elevationGained.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      SwimmingStrokesDataType() => _buildSum(
        () => HealthDataType.swimmingStrokes.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Mass/Length types - avg/min/max
      WeightDataType() => _buildAvgMinMax(
        () => HealthDataType.weight.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.weight.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.weight.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      ForcedVitalCapacityDataType() => _buildAvgMinMax(
        () => HealthDataType.forcedVitalCapacity.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.forcedVitalCapacity.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.forcedVitalCapacity.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      HeightDataType() => _buildAvgMinMax(
        () => HealthDataType.height.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.height.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.height.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      BodyMassIndexDataType() => _buildAvgMinMax(
        () => HealthDataType.bodyMassIndex.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.bodyMassIndex.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.bodyMassIndex.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      WaistCircumferenceDataType() => _buildAvgMinMax(
        () => HealthDataType.waistCircumference.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.waistCircumference.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.waistCircumference.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      HeartRateVariabilitySDNNDataType() => _buildAvgMinMax(
        () => HealthDataType.heartRateVariabilitySDNN.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.heartRateVariabilitySDNN.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.heartRateVariabilitySDNN.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Blood pressure types
      BloodPressureDataType() => _buildAvgMinMax(
        () => HealthDataType.bloodPressure.aggregateAverage(
          bloodPressureType: bloodPressureSubtype!,
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.bloodPressure.aggregateMin(
          bloodPressureType: bloodPressureSubtype!,
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.bloodPressure.aggregateMax(
          bloodPressureType: bloodPressureSubtype!,
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      SystolicBloodPressureDataType() => _buildAvgMinMax(
        () => HealthDataType.systolicBloodPressure.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.systolicBloodPressure.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.systolicBloodPressure.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      DiastolicBloodPressureDataType() => _buildAvgMinMax(
        () => HealthDataType.diastolicBloodPressure.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.diastolicBloodPressure.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.diastolicBloodPressure.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Distance types - sum only
      DistanceDataType() ||
      CrossCountrySkiingDistanceDataType() ||
      CyclingDistanceDataType() ||
      DownhillSnowSportsDistanceDataType() ||
      PaddleSportsDistanceDataType() ||
      RowingDistanceDataType() ||
      SixMinuteWalkTestDistanceDataType() ||
      SkatingSportsDistanceDataType() ||
      SwimmingDistanceDataType() ||
      WheelchairDistanceDataType() ||
      WalkingRunningDistanceDataType() => _buildDistanceSum(
        dataType as HealthDataType<HealthRecord, Length>,
        metric,
        startTime,
        endTime,
      ),

      // Energy/hydration types - sum only
      ActiveEnergyBurnedDataType() => _buildSum(
        () => HealthDataType.activeEnergyBurned.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      BasalEnergyBurnedDataType() => _buildSum(
        () => HealthDataType.basalEnergyBurned.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      TotalEnergyBurnedDataType() => _buildSum(
        () => HealthDataType.totalEnergyBurned.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      HydrationDataType() => _buildSum(
        () => HealthDataType.hydration.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Heart rate types - avg/min/max
      HeartRateDataType() => _buildAvgMinMax(
        () => HealthDataType.heartRate.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.heartRate.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.heartRate.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      HeartRateSeriesDataType() => _buildAvgMinMax(
        () => HealthDataType.heartRateSeries.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.heartRateSeries.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.heartRateSeries.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      CyclingPedalingCadenceDataType() => _buildAvgMinMax(
        () => HealthDataType.cyclingPedalingCadence.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.cyclingPedalingCadence.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.cyclingPedalingCadence.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      CyclingPedalingCadenceSeriesDataType() => _buildAvgMinMax(
        () => HealthDataType.cyclingPedalingCadenceSeries.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.cyclingPedalingCadenceSeries.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.cyclingPedalingCadenceSeries.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      StepsCadenceSeriesDataType() => _buildAvgMinMax(
        () => HealthDataType.stepsCadenceSeries.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.stepsCadenceSeries.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.stepsCadenceSeries.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      RestingHeartRateDataType() => _buildAvgMinMax(
        () => HealthDataType.restingHeartRate.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.restingHeartRate.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.restingHeartRate.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Sleep types - sum only
      SleepSessionDataType() => _buildSum(
        () => HealthDataType.sleepSession.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      SleepStageDataType() => _buildSum(
        () => HealthDataType.sleepStageRecord.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Vital signs - avg/min/max
      BloodAlcoholContentDataType() => _buildAvgMinMax(
        () => HealthDataType.bloodAlcoholContent.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.bloodAlcoholContent.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.bloodAlcoholContent.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      OxygenSaturationDataType() => _buildAvgMinMax(
        () => HealthDataType.oxygenSaturation.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.oxygenSaturation.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.oxygenSaturation.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      RespiratoryRateDataType() => _buildAvgMinMax(
        () => HealthDataType.respiratoryRate.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.respiratoryRate.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.respiratoryRate.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      Vo2MaxDataType() => _buildAvgMinMax(
        () => HealthDataType.vo2Max.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.vo2Max.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.vo2Max.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      BloodGlucoseDataType() => _buildAvgMinMax(
        () => HealthDataType.bloodGlucose.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.bloodGlucose.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.bloodGlucose.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Energy - sum only
      DietaryEnergyConsumedDataType() => _buildSum(
        () => HealthDataType.dietaryEnergyConsumed.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Nutrient types - sum only (all nutrients)
      DietaryCaffeineDataType() ||
      DietaryProteinDataType() ||
      DietaryTotalCarbohydrateDataType() ||
      DietaryTotalFatDataType() ||
      DietarySaturatedFatDataType() ||
      DietaryMonounsaturatedFatDataType() ||
      DietaryPolyunsaturatedFatDataType() ||
      DietaryCholesterolDataType() ||
      DietaryFiberNutrientDataType() ||
      DietarySugarDataType() ||
      DietaryCalciumDataType() ||
      DietaryIronDataType() ||
      DietaryMagnesiumDataType() ||
      DietaryManganeseDataType() ||
      DietaryPhosphorusDataType() ||
      DietaryPotassiumDataType() ||
      DietarySeleniumDataType() ||
      DietarySodiumDataType() ||
      DietaryZincDataType() ||
      DietaryVitaminADataType() ||
      DietaryVitaminB6DataType() ||
      DietaryVitaminB12DataType() ||
      DietaryVitaminCDataType() ||
      DietaryVitaminDDataType() ||
      DietaryVitaminEDataType() ||
      DietaryVitaminKDataType() ||
      DietaryThiaminDataType() ||
      DietaryRiboflavinDataType() ||
      DietaryNiacinDataType() ||
      DietaryFolateDataType() ||
      DietaryBiotinDataType() ||
      DietaryPantothenicAcidDataType() => _buildNutrientSum(
        dataType as HealthDataType<HealthRecord, Mass>,
        metric,
        startTime,
        endTime,
      ),

      // Speed types - avg only
      WalkingSpeedDataType() => _buildAvg(
        () => HealthDataType.walkingSpeed.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      RunningSpeedDataType() => _buildAvg(
        () => HealthDataType.runningSpeed.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      StairAscentSpeedDataType() => _buildAvg(
        () => HealthDataType.stairAscentSpeed.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      StairDescentSpeedDataType() => _buildAvg(
        () => HealthDataType.stairDescentSpeed.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Power types - avg/min/max
      PowerSeriesDataType() => _buildAvgMinMax(
        () => HealthDataType.powerSeries.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.powerSeries.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.powerSeries.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      CyclingPowerDataType() => _buildAvgMinMax(
        () => HealthDataType.cyclingPower.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.cyclingPower.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.cyclingPower.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      RunningPowerDataType() => _buildAvgMinMax(
        () => HealthDataType.runningPower.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.runningPower.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.runningPower.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      ExerciseSessionDataType() => _buildSum(
        () => HealthDataType.exerciseSession.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      MindfulnessSessionDataType() => _buildSum(
        () => HealthDataType.mindfulnessSession.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Unsupported types
      BodyFatPercentageDataType() => throw UnsupportedError(
        'Body fat percentage does not support aggregation',
      ),
      BasalBodyTemperatureDataType() => throw UnsupportedError(
        'Basal body temperature does not support aggregation',
      ),
      BodyTemperatureDataType() => throw UnsupportedError(
        'Body temperature does not support aggregation',
      ),
      LeanBodyMassDataType() => throw UnsupportedError(
        'Lean body mass does not support aggregation',
      ),
      NutritionDataType() => throw UnsupportedError(
        'Nutrition does not support aggregation',
      ),
      SexualActivityDataType() => throw UnsupportedError(
        'Sexual activity does not support aggregation',
      ),
      SpeedSeriesDataType() => throw UnsupportedError(
        'Speed series data type does not support aggregation',
      ),
      CervicalMucusDataType() => throw UnsupportedError(
        'Cervical mucus does not support aggregation',
      ),
      IntermenstrualBleedingDataType() => throw UnsupportedError(
        'Intermenstrual bleeding does not support aggregation',
      ),
      OvulationTestDataType() => throw UnsupportedError(
        'Ovulation test does not support aggregation',
      ),
      PregnancyTestDataType() => throw UnsupportedError(
        'Pregnancy test does not support aggregation',
      ),
      ProgesteroneTestDataType() => throw UnsupportedError(
        'Progesterone test does not support aggregation',
      ),
      BoneMassDataType() => throw UnsupportedError(
        'Bone mass does not support aggregation',
      ),
      BodyWaterMassDataType() => throw UnsupportedError(
        'Body water mass does not support aggregation',
      ),
      HeartRateVariabilityRMSSDDataType() => throw UnsupportedError(
        'Heart rate variability (RMSSD) does not support aggregation',
      ),
      MenstrualFlowDataType() => throw UnsupportedError(
        'Menstrual flow does not support aggregation',
      ),
      MenstrualFlowInstantDataType() => throw UnsupportedError(
        'Menstrual flow does not support aggregation',
      ),
      LactationDataType() => throw UnsupportedError(
        'Lactation does not support aggregation',
      ),
      PregnancyDataType() => throw UnsupportedError(
        'Pregnancy does not support aggregation',
      ),
      PeripheralPerfusionIndexDataType() => throw UnsupportedError(
        'Peripheral perfusion index does not support aggregation',
      ),
      ContraceptiveDataType() => throw UnsupportedError(
        'Contraceptive does not support aggregation',
      ),
    };
  }

  // Helper methods using callbacks to avoid generic type issues

  static AggregateRequest _buildSum(
    AggregateRequest Function() sumFn,
    AggregationMetric metric,
  ) {
    if (metric != AggregationMetric.sum) {
      throw UnsupportedError('Only SUM metric is supported');
    }
    return sumFn();
  }

  static AggregateRequest _buildAvg(
    AggregateRequest Function() avgFn,
    AggregationMetric metric,
  ) {
    if (metric != AggregationMetric.avg) {
      throw UnsupportedError('Only AVG metric is supported');
    }
    return avgFn();
  }

  static AggregateRequest _buildAvgMinMax(
    AggregateRequest Function() avgFn,
    AggregateRequest Function() minFn,
    AggregateRequest Function() maxFn,
    AggregationMetric metric,
  ) {
    return switch (metric) {
      AggregationMetric.avg => avgFn(),
      AggregationMetric.min => minFn(),
      AggregationMetric.max => maxFn(),
      AggregationMetric.sum => throw UnsupportedError(
        'SUM is not supported for this data type',
      ),
    };
  }

  static AggregateRequest _buildDistanceSum(
    HealthDataType<HealthRecord, Length> dataType,
    AggregationMetric metric,
    DateTime startTime,
    DateTime endTime,
  ) {
    if (metric != AggregationMetric.sum) {
      throw UnsupportedError('Only SUM metric is supported');
    }

    // Delegate to specific data type instances
    return switch (dataType) {
      DistanceDataType() => HealthDataType.distance.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      CrossCountrySkiingDistanceDataType() =>
        HealthDataType.crossCountrySkiingDistance.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      CyclingDistanceDataType() => HealthDataType.cyclingDistance.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DownhillSnowSportsDistanceDataType() =>
        HealthDataType.downhillSnowSportsDistance.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      PaddleSportsDistanceDataType() =>
        HealthDataType.paddleSportsDistance.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      RowingDistanceDataType() => HealthDataType.rowingDistance.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      SixMinuteWalkTestDistanceDataType() =>
        HealthDataType.sixMinuteWalkTestDistance.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      SkatingSportsDistanceDataType() =>
        HealthDataType.skatingSportsDistance.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      SwimmingDistanceDataType() =>
        HealthDataType.swimmingDistance.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      WheelchairDistanceDataType() =>
        HealthDataType.wheelchairDistance.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      WalkingRunningDistanceDataType() =>
        HealthDataType.walkingRunningDistance.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      _ => throw ArgumentError('Unsupported distance type'),
    };
  }

  static AggregateRequest _buildNutrientSum(
    HealthDataType<HealthRecord, Mass> dataType,
    AggregationMetric metric,
    DateTime startTime,
    DateTime endTime,
  ) {
    if (metric != AggregationMetric.sum) {
      throw UnsupportedError('Only SUM metric is supported for nutrients');
    }

    // Delegate to specific data type instances
    return switch (dataType) {
      DietaryCaffeineDataType() => HealthDataType.dietaryCaffeine.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryProteinDataType() => HealthDataType.dietaryProtein.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryTotalCarbohydrateDataType() =>
        HealthDataType.dietaryTotalCarbohydrate.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryTotalFatDataType() => HealthDataType.dietaryTotalFat.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietarySaturatedFatDataType() =>
        HealthDataType.dietarySaturatedFat.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryMonounsaturatedFatDataType() =>
        HealthDataType.dietaryMonounsaturatedFat.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryPolyunsaturatedFatDataType() =>
        HealthDataType.dietaryPolyunsaturatedFat.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryCholesterolDataType() =>
        HealthDataType.dietaryCholesterol.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryFiberNutrientDataType() =>
        HealthDataType.dietaryFiber.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietarySugarDataType() => HealthDataType.dietarySugar.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryCalciumDataType() => HealthDataType.dietaryCalcium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryIronDataType() => HealthDataType.dietaryIron.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryMagnesiumDataType() =>
        HealthDataType.dietaryMagnesium.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryManganeseDataType() =>
        HealthDataType.dietaryManganese.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryPhosphorusDataType() =>
        HealthDataType.dietaryPhosphorus.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryPotassiumDataType() =>
        HealthDataType.dietaryPotassium.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietarySeleniumDataType() => HealthDataType.dietarySelenium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietarySodiumDataType() => HealthDataType.dietarySodium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryZincDataType() => HealthDataType.dietaryZinc.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryVitaminADataType() => HealthDataType.dietaryVitaminA.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryVitaminB6DataType() =>
        HealthDataType.dietaryVitaminB6.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryVitaminB12DataType() =>
        HealthDataType.dietaryVitaminB12.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryVitaminCDataType() => HealthDataType.dietaryVitaminC.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryVitaminDDataType() => HealthDataType.dietaryVitaminD.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryVitaminEDataType() => HealthDataType.dietaryVitaminE.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryVitaminKDataType() => HealthDataType.dietaryVitaminK.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryThiaminDataType() => HealthDataType.dietaryThiamin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryRiboflavinDataType() =>
        HealthDataType.dietaryRiboflavin.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      DietaryNiacinDataType() => HealthDataType.dietaryNiacin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryFolateDataType() => HealthDataType.dietaryFolate.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryBiotinDataType() => HealthDataType.dietaryBiotin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryPantothenicAcidDataType() =>
        HealthDataType.dietaryPantothenicAcid.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      _ => throw ArgumentError('Unsupported nutrient type'),
    };
  }
}
