import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector_internal.dart'
    show
        AggregateRequest,
        AggregationMetric,
        HealthDataType,
        HealthRecord,
        MeasurementUnit,
        HealthConnector,
        Pressure,
        PantothenicAcidNutrientDataType,
        StepsHealthDataType,
        FloorsClimbedHealthDataType,
        WheelchairPushesHealthDataType,
        WeightHealthDataType,
        HeightHealthDataType,
        BloodPressureHealthDataType,
        SystolicBloodPressureHealthDataType,
        DiastolicBloodPressureHealthDataType,
        DistanceHealthDataType,
        CrossCountrySkiingDistanceDataType,
        CyclingDistanceDataType,
        DownhillSnowSportsDistanceDataType,
        PaddleSportsDistanceDataType,
        RowingDistanceDataType,
        SixMinuteWalkTestDistanceDataType,
        SkatingSportsDistanceDataType,
        SwimmingDistanceDataType,
        WheelchairDistanceDataType,
        WalkingRunningDistanceDataType,
        Length,
        ActiveCaloriesBurnedHealthDataType,
        HydrationHealthDataType,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        RestingHeartRateHealthDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        ExerciseSessionHealthDataType,
        MindfulnessSessionDataType,
        OxygenSaturationHealthDataType,
        RespiratoryRateHealthDataType,
        Vo2MaxHealthDataType,
        BloodGlucoseHealthDataType,
        EnergyNutrientDataType,
        CaffeineNutrientDataType,
        ProteinNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        SaturatedFatNutrientDataType,
        MonounsaturatedFatNutrientDataType,
        PolyunsaturatedFatNutrientDataType,
        CholesterolNutrientDataType,
        DietaryFiberNutrientDataType,
        SugarNutrientDataType,
        CalciumNutrientDataType,
        IronNutrientDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        PhosphorusNutrientDataType,
        PotassiumNutrientDataType,
        SeleniumNutrientDataType,
        SodiumNutrientDataType,
        ZincNutrientDataType,
        VitaminANutrientDataType,
        VitaminB6NutrientDataType,
        VitaminB12NutrientDataType,
        VitaminCNutrientDataType,
        VitaminDNutrientDataType,
        VitaminENutrientDataType,
        VitaminKNutrientDataType,
        ThiaminNutrientDataType,
        RiboflavinNutrientDataType,
        NiacinNutrientDataType,
        FolateNutrientDataType,
        BiotinNutrientDataType,
        Mass,
        WalkingSpeedDataType,
        RunningSpeedDataType,
        StairAscentSpeedDataType,
        StairDescentSpeedDataType,
        PowerSeriesDataType,
        CyclingPowerDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        LeanBodyMassHealthDataType,
        NutritionHealthDataType,
        SpeedSeriesDataType;

/// Manages state and operations for aggregating health data.
///
/// Handles aggregating health records (sum, average, min, max, count) over
/// a time range, tracking loading state and the aggregation result.
final class AggregateHealthDataChangeNotifier extends ChangeNotifier {
  final HealthConnector _healthConnector;

  AggregateHealthDataChangeNotifier(this._healthConnector);

  bool _isLoading = false;
  MeasurementUnit? _aggregationResult;

  MeasurementUnit? get aggregationResult => _aggregationResult;

  bool get isLoading => _isLoading;

  /// Aggregates health data based on the provided parameters.
  ///
  /// Updates [aggregationResult] with the aggregation result on success.
  /// Exceptions are propagated to the caller for handling.
  Future<void> aggregateHealthData({
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
      StepsHealthDataType() => _buildSum(
        () => HealthDataType.steps.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      FloorsClimbedHealthDataType() => _buildSum(
        () => HealthDataType.floorsClimbed.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      WheelchairPushesHealthDataType() => _buildSum(
        () => HealthDataType.wheelchairPushes.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Mass/Length types - avg/min/max
      WeightHealthDataType() => _buildAvgMinMax(
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
      HeightHealthDataType() => _buildAvgMinMax(
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

      // Blood pressure types
      BloodPressureHealthDataType() => _buildAvgMinMax(
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
      SystolicBloodPressureHealthDataType() => _buildAvgMinMax(
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
      DiastolicBloodPressureHealthDataType() => _buildAvgMinMax(
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
      DistanceHealthDataType() ||
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
      ActiveCaloriesBurnedHealthDataType() => _buildSum(
        () => HealthDataType.activeCaloriesBurned.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      HydrationHealthDataType() => _buildSum(
        () => HealthDataType.hydration.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Heart rate types - avg/min/max
      HeartRateMeasurementRecordHealthDataType() => _buildAvgMinMax(
        () => HealthDataType.heartRateMeasurementRecord.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.heartRateMeasurementRecord.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.heartRateMeasurementRecord.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      HeartRateSeriesRecordHealthDataType() => _buildAvgMinMax(
        () => HealthDataType.heartRateSeriesRecord.aggregateAvg(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.heartRateSeriesRecord.aggregateMin(
          startTime: startTime,
          endTime: endTime,
        ),
        () => HealthDataType.heartRateSeriesRecord.aggregateMax(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      RestingHeartRateHealthDataType() => _buildAvgMinMax(
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
      SleepSessionHealthDataType() => _buildSum(
        () => HealthDataType.sleepSession.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),
      SleepStageHealthDataType() => _buildSum(
        () => HealthDataType.sleepStageRecord.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
        metric,
      ),

      // Vital signs - avg/min/max
      OxygenSaturationHealthDataType() => _buildAvgMinMax(
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
      RespiratoryRateHealthDataType() => _buildAvgMinMax(
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
      Vo2MaxHealthDataType() => _buildAvgMinMax(
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
      BloodGlucoseHealthDataType() => _buildAvgMinMax(
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

      // Nutrient types - sum only (all nutrients)
      EnergyNutrientDataType() ||
      CaffeineNutrientDataType() ||
      ProteinNutrientDataType() ||
      TotalCarbohydrateNutrientDataType() ||
      TotalFatNutrientDataType() ||
      SaturatedFatNutrientDataType() ||
      MonounsaturatedFatNutrientDataType() ||
      PolyunsaturatedFatNutrientDataType() ||
      CholesterolNutrientDataType() ||
      DietaryFiberNutrientDataType() ||
      SugarNutrientDataType() ||
      CalciumNutrientDataType() ||
      IronNutrientDataType() ||
      MagnesiumNutrientDataType() ||
      ManganeseNutrientDataType() ||
      PhosphorusNutrientDataType() ||
      PotassiumNutrientDataType() ||
      SeleniumNutrientDataType() ||
      SodiumNutrientDataType() ||
      ZincNutrientDataType() ||
      VitaminANutrientDataType() ||
      VitaminB6NutrientDataType() ||
      VitaminB12NutrientDataType() ||
      VitaminCNutrientDataType() ||
      VitaminDNutrientDataType() ||
      VitaminENutrientDataType() ||
      VitaminKNutrientDataType() ||
      ThiaminNutrientDataType() ||
      RiboflavinNutrientDataType() ||
      NiacinNutrientDataType() ||
      FolateNutrientDataType() ||
      BiotinNutrientDataType() ||
      PantothenicAcidNutrientDataType() => _buildNutrientSum(
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

      ExerciseSessionHealthDataType() => _buildSum(
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
      BodyFatPercentageHealthDataType() => throw UnsupportedError(
        'Body fat percentage does not support aggregation',
      ),
      BodyTemperatureHealthDataType() => throw UnsupportedError(
        'Body temperature does not support aggregation',
      ),
      LeanBodyMassHealthDataType() => throw UnsupportedError(
        'Lean body mass does not support aggregation',
      ),
      NutritionHealthDataType() => throw UnsupportedError(
        'Nutrition does not support aggregation',
      ),
      SpeedSeriesDataType() => throw UnsupportedError(
        'Speed series data type does not support aggregation',
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
      DistanceHealthDataType() => HealthDataType.distance.aggregateSum(
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
      EnergyNutrientDataType() => HealthDataType.energyNutrient.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      CaffeineNutrientDataType() => HealthDataType.caffeine.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      ProteinNutrientDataType() => HealthDataType.protein.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      TotalCarbohydrateNutrientDataType() =>
        HealthDataType.totalCarbohydrate.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      TotalFatNutrientDataType() => HealthDataType.totalFat.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      SaturatedFatNutrientDataType() =>
        HealthDataType.saturatedFat.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      MonounsaturatedFatNutrientDataType() =>
        HealthDataType.monounsaturatedFat.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      PolyunsaturatedFatNutrientDataType() =>
        HealthDataType.polyunsaturatedFat.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      CholesterolNutrientDataType() => HealthDataType.cholesterol.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryFiberNutrientDataType() =>
        HealthDataType.dietaryFiber.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      SugarNutrientDataType() => HealthDataType.sugar.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      CalciumNutrientDataType() => HealthDataType.calcium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      IronNutrientDataType() => HealthDataType.iron.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      MagnesiumNutrientDataType() => HealthDataType.magnesium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      ManganeseNutrientDataType() => HealthDataType.manganese.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      PhosphorusNutrientDataType() => HealthDataType.phosphorus.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      PotassiumNutrientDataType() => HealthDataType.potassium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      SeleniumNutrientDataType() => HealthDataType.selenium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      SodiumNutrientDataType() => HealthDataType.sodium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      ZincNutrientDataType() => HealthDataType.zinc.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminANutrientDataType() => HealthDataType.vitaminA.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminB6NutrientDataType() => HealthDataType.vitaminB6.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminB12NutrientDataType() => HealthDataType.vitaminB12.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminCNutrientDataType() => HealthDataType.vitaminC.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminDNutrientDataType() => HealthDataType.vitaminD.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminENutrientDataType() => HealthDataType.vitaminE.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminKNutrientDataType() => HealthDataType.vitaminK.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      ThiaminNutrientDataType() => HealthDataType.thiamin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      RiboflavinNutrientDataType() => HealthDataType.riboflavin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      NiacinNutrientDataType() => HealthDataType.niacin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      FolateNutrientDataType() => HealthDataType.folate.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      BiotinNutrientDataType() => HealthDataType.biotin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      PantothenicAcidNutrientDataType() =>
        HealthDataType.pantothenicAcid.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      _ => throw ArgumentError('Unsupported nutrient type'),
    };
  }
}
