part of '../health_data_type.dart';

///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class VitaminNutrientDataType<R extends HealthRecord>
    extends NutrientHealthDataType<R, Mass> {
  const VitaminNutrientDataType();
}
