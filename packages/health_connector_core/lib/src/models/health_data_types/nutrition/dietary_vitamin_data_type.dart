part of '../health_data_type.dart';

///
/// ## See also
///
/// - [DietaryVitaminRecord]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class DietaryVitaminDataType<R extends HealthRecord>
    extends NutrientDataType<R, Mass> {
  const DietaryVitaminDataType();

  @override
  String get id => 'dietary_vitamin';
}
