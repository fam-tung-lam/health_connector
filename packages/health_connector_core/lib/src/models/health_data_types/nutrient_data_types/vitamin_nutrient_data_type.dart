part of '../health_data_type.dart';

@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class VitaminNutrientDataType<R extends HealthRecord>
    extends NutrientHealthDataType<R, Mass> {
  const VitaminNutrientDataType();
}
