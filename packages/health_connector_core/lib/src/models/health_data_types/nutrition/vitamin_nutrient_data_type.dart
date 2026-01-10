part of '../health_data_type.dart';

///
/// ## See also
///
/// - [VitaminNutrientRecord]
///
/// {@category Health Data Types}
@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class VitaminNutrientDataType<R extends HealthRecord>
    extends NutrientDataType<R, Mass> {
  const VitaminNutrientDataType();

  @override
  String get id => 'vitamin_nutrient';
}
