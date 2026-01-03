part of '../health_data_type.dart';

///
/// {@category Health Data Types}
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
      other is MineralNutrientDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
