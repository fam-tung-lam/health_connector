part of '../health_data_type.dart';

///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class MacronutrientDataType<R extends HealthRecord>
    extends NutrientDataType<R, Mass> {
  const MacronutrientDataType();

  @override
  String get id => 'dietary_macronutrient';
}
