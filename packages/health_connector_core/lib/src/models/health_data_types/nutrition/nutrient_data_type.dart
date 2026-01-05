part of '../health_data_type.dart';

///
/// {@category Health Data Types}
@sinceV1_0_0
@supportedOnAppleHealth
@internal
@immutable
sealed class NutrientHealthDataType<
  R extends HealthRecord,
  U extends MeasurementUnit
>
    extends HealthDataType<R, U> {
  const NutrientHealthDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
    HealthPlatform.healthConnect,
  ];
}
