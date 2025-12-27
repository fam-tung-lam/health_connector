import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

abstract class MeasurementUnitValueValidator {
  /// Validates the parsed measurement unit value.
  ///
  /// Throws an [ArgumentError] if the value is invalid.
  static void validate({
    required HealthDataType forDataType,
    required MeasurementUnit value,
  }) {
    // Validate based on the parsed measurement unit type
    switch (value) {
      case Number():
        _validateNumber(value);
      case Percentage():
        _validatePercentage(value);
      case Mass():
        _validateMass(value);
      case Length():
        _validateLength(value);
      case Temperature():
        _validateTemperature(value);
      case BloodGlucose():
        _validateBloodGlucose(value);
      case Pressure():
        _validatePressure(value);
      case Energy():
        _validateEnergy(value);
      case Velocity():
        _validateVelocity(value);
      case Volume():
        _validateVolume(value);
      case Power():
        _validatePower(value);
      case TimeDuration():
        _validateTimeDuration(value);
    }
  }

  /// Validates a [Number] measurement unit.
  ///
  /// Ensures the value is non-negative.
  ///
  /// Throws an [ArgumentError] if the value is negative.
  static void _validateNumber(Number value) {
    if (value.value < 0) {
      throw ArgumentError(AppTexts.countMustBeNonNegative);
    }
  }

  /// Validates a [Percentage] measurement unit.
  ///
  /// Ensures the value is between 0 and 100 (inclusive).
  ///
  /// Throws an [ArgumentError] if the value is outside this range.
  static void _validatePercentage(Percentage value) {
    final wholeValue = value.asWhole;
    if (wholeValue < 0 || wholeValue > 100) {
      throw ArgumentError(AppTexts.bodyFatPercentageMustBeBetween0And100);
    }
  }

  /// Validates a [Mass] measurement unit.
  ///
  /// Ensures the value is positive (greater than 0).
  ///
  /// Throws an [ArgumentError] if the value is zero or negative.
  static void _validateMass(Mass value) {
    if (value.inKilograms <= 0) {
      throw ArgumentError(AppTexts.pleaseEnterValidNumber);
    }
  }

  /// Validates a [Length] measurement unit.
  ///
  /// Ensures the value is positive (greater than 0).
  ///
  /// Throws an [ArgumentError] if the value is zero or negative.
  static void _validateLength(Length value) {
    if (value.inMeters <= 0) {
      throw ArgumentError(AppTexts.pleaseEnterValidNumber);
    }
  }

  /// Validates a [Temperature] measurement unit.
  ///
  /// Currently has no specific validation constraints for temperature values.
  static void _validateTemperature(Temperature value) {
    // No validation constraints for temperature
  }

  /// Validates a [BloodGlucose] measurement unit.
  ///
  /// Ensures the value is positive (greater than 0).
  ///
  /// Throws an [ArgumentError] if the value is zero or negative.
  static void _validateBloodGlucose(BloodGlucose value) {
    if (value.inMilligramsPerDeciliter <= 0) {
      throw ArgumentError(AppTexts.pleaseEnterValidNumber);
    }
  }

  /// Validates a [Pressure] measurement unit.
  ///
  /// Ensures the value is positive (greater than 0).
  ///
  /// Throws an [ArgumentError] if the value is zero or negative.
  static void _validatePressure(Pressure value) {
    if (value.inMillimetersOfMercury <= 0) {
      throw ArgumentError(AppTexts.pleaseEnterValidNumber);
    }
  }

  /// Validates an [Energy] measurement unit.
  ///
  /// Ensures the value is positive (greater than 0).
  ///
  /// Throws an [ArgumentError] if the value is zero or negative.
  static void _validateEnergy(Energy value) {
    if (value.inKilocalories <= 0) {
      throw ArgumentError(AppTexts.pleaseEnterValidNumber);
    }
  }

  /// Validates a [Velocity] measurement unit.
  ///
  /// Ensures the value is positive (greater than 0).
  ///
  /// Throws an [ArgumentError] if the value is zero or negative.
  static void _validateVelocity(Velocity value) {
    if (value.inMetersPerSecond <= 0) {
      throw ArgumentError(AppTexts.pleaseEnterValidNumber);
    }
  }

  /// Validates a [Volume] measurement unit.
  ///
  /// Ensures the value is positive (greater than 0).
  ///
  /// Throws an [ArgumentError] if the value is zero or negative.
  static void _validateVolume(Volume value) {
    if (value.inLiters <= 0) {
      throw ArgumentError(AppTexts.pleaseEnterValidNumber);
    }
  }

  /// Validates a [Power] measurement unit.
  ///
  /// Ensures the value is positive (greater than 0).
  ///
  /// Throws an [ArgumentError] if the value is zero or negative.
  static void _validatePower(Power value) {
    if (value.inWatts <= 0) {
      throw ArgumentError(AppTexts.pleaseEnterValidNumber);
    }
  }

  /// Validates a [TimeDuration] measurement unit.
  ///
  /// Ensures the value is positive (greater than 0).
  ///
  /// Throws an [ArgumentError] if the value is zero or negative.
  static void _validateTimeDuration(TimeDuration value) {
    if (value.inSeconds <= 0) {
      throw ArgumentError(AppTexts.pleaseEnterValidNumber);
    }
  }
}
