part of '../health_data_type.dart';

@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class MineralNutrientDataType<R extends HealthRecord>
    extends NutrientHealthDataType<R, Mass> {
  const MineralNutrientDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalciumNutrientDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;
}
