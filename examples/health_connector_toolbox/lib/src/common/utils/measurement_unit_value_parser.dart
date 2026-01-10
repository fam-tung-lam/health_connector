import 'package:health_connector/health_connector_internal.dart';

abstract class MeasurementUnitValueParser {
  /// Parse string input to MeasurementUnit based on the data type.
  ///
  /// Throws [ArgumentError] if the value is empty.
  /// Throws [FormatException] if the value cannot be parsed or is invalid.
  static MeasurementUnit parseValue({
    required String value,
    required HealthDataType forDataType,
  }) {
    if (value.isEmpty) {
      throw ArgumentError('Value cannot be empty.');
    }

    return switch (forDataType) {
      // Integer count types
      StepsDataType() ||
      FloorsClimbedDataType() ||
      WheelchairPushesDataType() => _parseIntegerCount(value),

      // Frequency types
      HeartRateDataType() ||
      CyclingPedalingCadenceDataType() ||
      CyclingPedalingCadenceSeriesDataType() ||
      RestingHeartRateDataType() => _parseFrequency(value),

      // Mass types (kilograms)
      WeightDataType() ||
      LeanBodyMassDataType() ||
      BoneMassDataType() ||
      BodyWaterMassDataType() => _parseMassKilograms(value),

      // Mass types (grams for nutrients)
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
      DietaryPantothenicAcidDataType() => _parseMassGrams(value),

      // Percentage types
      BodyFatPercentageDataType() ||
      OxygenSaturationDataType() => _parsePercentage(value),

      // Temperature
      BodyTemperatureDataType() ||
      BasalBodyTemperatureDataType() => _parseTemperature(value),

      // Distance/Length
      HeightDataType() ||
      WaistCircumferenceDataType() ||
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
      WalkingRunningDistanceDataType() => _parseLength(value),

      // Blood Glucose
      BloodGlucoseDataType() => _parseBloodGlucose(value),

      // Pressure
      SystolicBloodPressureDataType() ||
      DiastolicBloodPressureDataType() => _parsePressure(value),

      // Energy
      ActiveEnergyBurnedDataType() ||
      BasalEnergyBurnedDataType() ||
      TotalEnergyBurnedDataType() ||
      DietaryEnergyConsumedDataType() => _parseEnergy(value),

      // Velocity/Speed
      WalkingSpeedDataType() ||
      RunningSpeedDataType() ||
      StairAscentSpeedDataType() ||
      StairDescentSpeedDataType() => _parseVelocity(value),

      // Power
      CyclingPowerDataType() => _parsePower(value),

      // Respiratory Rate
      RespiratoryRateDataType() => _parseFrequency(value),

      // VO2 Max
      Vo2MaxDataType() => _parseVo2Max(value),

      // Double Number types
      BodyMassIndexDataType() => _parseDoubleNumber(value),

      // Time duration types (HRV)
      HeartRateVariabilityRMSSDDataType() ||
      HeartRateVariabilitySDNNDataType() => _parseTimeDuration(value),

      // Volume
      HydrationDataType() => _parseVolume(value),

      // Complex/composite types that cannot be parsed from a single string value
      BloodPressureDataType() => throw UnsupportedError(
        '$BloodPressureDataType requires systolic and diastolic values, '
        'cannot be parsed from a single string input.',
      ),
      HeartRateSeriesDataType() => throw UnsupportedError(
        '$HeartRateSeriesDataType is a time series data type, '
        'cannot be parsed from a single string input.',
      ),
      NutritionDataType() => throw UnsupportedError(
        '$NutritionDataType requires multiple nutrient values, '
        'cannot be parsed from a single string input.',
      ),
      SleepSessionDataType() => throw UnsupportedError(
        '$SleepSessionDataType is a complex type with stages and times, '
        'cannot be parsed from a single string input.',
      ),
      SleepStageDataType() => throw UnsupportedError(
        '$SleepStageDataType is part of SleepSession, '
        'cannot be parsed from a single string input.',
      ),
      SexualActivityDataType() => throw UnsupportedError(
        '$SexualActivityDataType is a complex type with time and optional '
        'protection info, cannot be parsed from a single string input.',
      ),
      SpeedSeriesDataType() => throw UnsupportedError(
        '$SpeedSeriesDataType is a time series data type, '
        'cannot be parsed from a single string input.',
      ),
      PowerSeriesDataType() => throw UnsupportedError(
        '$PowerSeriesDataType is a time series data type, '
        'cannot be parsed from a single string input.',
      ),
      ExerciseSessionDataType() => throw UnsupportedError(
        '$ExerciseSessionDataType is a complex type with exercise '
        'type and times, not a simple numeric value. Cannot parse.',
      ),
      MindfulnessSessionDataType() => throw UnsupportedError(
        '$MindfulnessSessionDataType is a complex type with session '
        'type and times, not a simple numeric value. Cannot parse.',
      ),
      CervicalMucusDataType() => throw UnsupportedError(
        '$CervicalMucusDataType is a complex type with appearance and '
        'sensation, cannot be parsed from a single string input.',
      ),
      IntermenstrualBleedingDataType() => throw UnsupportedError(
        '$IntermenstrualBleedingDataType is a record of bleeding occurrence, '
        'cannot be parsed from a single string input.',
      ),
      OvulationTestDataType() => throw UnsupportedError(
        '$OvulationTestDataType is a complex type with test result, '
        'cannot be parsed from a single string input.',
      ),
      MenstrualFlowDataType() => throw UnsupportedError(
        '$MenstrualFlowDataType is a complex type with flow intensity, '
        'cannot be parsed from a single string input.',
      ),
      MenstrualFlowInstantDataType() => throw UnsupportedError(
        '$MenstrualFlowInstantDataType is a complex type with flow intensity, '
        'cannot be parsed from a single string input.',
      ),
    };
  }

  /// Parse integer count value (steps, floors climbed, etc.).
  static Number _parseIntegerCount(String value) {
    final count = int.tryParse(value);
    if (count == null) {
      throw const FormatException('Invalid integer value');
    }
    if (count < 0) {
      throw const FormatException('Count must be non-negative');
    }
    return Number(count);
  }

  /// Parse mass value in kilograms (weight, lean body mass).
  static Mass _parseMassKilograms(String value) {
    final mass = double.tryParse(value);
    if (mass == null) {
      throw const FormatException('Invalid number value');
    }
    if (mass <= 0) {
      throw const FormatException('Mass must be positive');
    }
    return Mass.kilograms(mass);
  }

  /// Parse mass value in grams (nutrients).
  static Mass _parseMassGrams(String value) {
    final mass = double.tryParse(value);
    if (mass == null) {
      throw const FormatException('Invalid number value');
    }
    if (mass <= 0) {
      throw const FormatException('Mass must be positive');
    }
    return Mass.grams(mass);
  }

  /// Parse percentage value (body fat, oxygen saturation).
  static Percentage _parsePercentage(String value) {
    final pct = double.tryParse(value);
    if (pct == null) {
      throw const FormatException('Invalid number value');
    }
    if (pct < 0 || pct > 100) {
      throw const FormatException('Percentage must be between 0 and 100');
    }
    return Percentage.fromWhole(pct);
  }

  /// Parse temperature value in celsius.
  static Temperature _parseTemperature(String value) {
    final temp = double.tryParse(value);
    if (temp == null) {
      throw const FormatException('Invalid temperature value');
    }
    return Temperature.celsius(temp);
  }

  /// Parse length/distance value in meters.
  static Length _parseLength(String value) {
    final distance = double.tryParse(value);
    if (distance == null) {
      throw const FormatException('Invalid number value');
    }
    if (distance <= 0) {
      throw const FormatException('Distance must be positive');
    }
    return Length.meters(distance);
  }

  /// Parse blood glucose value in mg/dL.
  static BloodGlucose _parseBloodGlucose(String value) {
    final glucose = double.tryParse(value);
    if (glucose == null) {
      throw const FormatException('Invalid number value');
    }
    if (glucose <= 0) {
      throw const FormatException('Blood glucose must be positive');
    }
    return BloodGlucose.milligramsPerDeciliter(glucose);
  }

  /// Parse pressure value in mmHg.
  static Pressure _parsePressure(String value) {
    final pressure = double.tryParse(value);
    if (pressure == null) {
      throw const FormatException('Invalid number value');
    }
    if (pressure <= 0) {
      throw const FormatException('Pressure must be positive');
    }
    return Pressure.millimetersOfMercury(pressure);
  }

  /// Parse energy value in kilocalories.
  static Energy _parseEnergy(String value) {
    final energy = double.tryParse(value);
    if (energy == null) {
      throw const FormatException('Invalid number value');
    }
    if (energy <= 0) {
      throw const FormatException('Energy must be positive');
    }
    return Energy.kilocalories(energy);
  }

  /// Parse velocity/speed value in m/s.
  static Velocity _parseVelocity(String value) {
    final speed = double.tryParse(value);
    if (speed == null) {
      throw const FormatException('Invalid number value');
    }
    if (speed <= 0) {
      throw const FormatException('Speed must be positive');
    }
    return Velocity.metersPerSecond(speed);
  }

  /// Parse frequency value (heart rate, respiratory rate, cadence).
  static Frequency _parseFrequency(String value) {
    final rate = double.tryParse(value);
    if (rate == null) {
      throw const FormatException('Invalid number value');
    }
    if (rate <= 0) {
      throw const FormatException('Frequency must be positive');
    }
    return Frequency.perMinute(rate);
  }

  /// Parse VO2 max value.
  static Number _parseVo2Max(String value) {
    final vo2 = double.tryParse(value);
    if (vo2 == null) {
      throw const FormatException('Invalid number value');
    }
    if (vo2 <= 0) {
      throw const FormatException('VO2 max must be positive');
    }
    return Number(vo2.toInt());
  }

  /// Parse volume value in liters.
  static Volume _parseVolume(String value) {
    final volume = double.tryParse(value);
    if (volume == null) {
      throw const FormatException('Invalid number value');
    }
    if (volume <= 0) {
      throw const FormatException('Volume must be positive');
    }
    return Volume.liters(volume);
  }

  /// Parse power value in watts.
  static Power _parsePower(String value) {
    final watts = double.tryParse(value);
    if (watts == null) {
      throw const FormatException('Invalid number value');
    }
    if (watts <= 0) {
      throw const FormatException('Power must be positive');
    }
    return Power.watts(watts);
  }

  /// Parse double number value.
  static Number _parseDoubleNumber(String value) {
    final val = double.tryParse(value);
    if (val == null) {
      throw const FormatException('Invalid number value');
    }
    return Number(val);
  }

  /// Parse time duration value in milliseconds.
  static TimeDuration _parseTimeDuration(String value) {
    final millis = double.tryParse(value);
    if (millis == null) {
      throw const FormatException('Invalid number value');
    }
    if (millis <= 0) {
      throw const FormatException('Duration must be positive');
    }
    return TimeDuration.milliseconds(millis);
  }
}
