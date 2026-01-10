part of '../health_data_type.dart';

///
/// {@category Health Data Types}
@sinceV1_0_0
@supportedOnAppleHealth
@internal
@immutable
sealed class NutrientDataType<R extends HealthRecord, U extends MeasurementUnit>
    extends HealthDataType<R, U> {
  const NutrientDataType();

  @override
  String get id => 'nutrient';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];
}
