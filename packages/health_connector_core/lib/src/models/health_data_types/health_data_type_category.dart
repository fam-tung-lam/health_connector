part of 'health_data_type.dart';

/// Categories for organizing health data types.
///
/// Health data types are organized into categories based on their primary
/// physiological domain and clinical utility.
///
/// {@category Health Data Types}
@sinceV1_0_0
enum HealthDataTypeCategory {
  /// Physical activity and kinetic output data.
  ///
  /// Represents the "quantity" of movement.
  activity,

  /// Body measurements and anthropometric data.
  bodyMeasurement,

  /// Clinical records and history.
  ///
  /// Includes data typically generated in a clinical setting or
  /// part of the electronic health record (EHR).
  clinical,

  /// Mental, cognitive, and behavioral health data.
  mentalHealth,

  /// Mobility and functional status data.
  ///
  /// Represents the "quality" of movement and neurological integrity.
  mobility,

  /// Nutritional intake and hydration data.
  nutrition,

  /// Reproductive and sexual health data.
  reproductiveHealth,

  /// Sleep architecture and restorative health.
  sleep,

  /// Vital signs and physiological indicators.
  ///
  /// Represents the mechanical and biochemical function of organ systems.
  vitals,
}
