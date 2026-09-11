part of '../health_data_type.dart';

///
@sinceV1_0_0
@internal
@immutable
sealed class NutrientDataType<R extends HealthRecord, U extends MeasurementUnit>
    extends HealthDataType<R, U> {
  const NutrientDataType();

  @override
  String get id => 'dietary_nutrient';

  @override
  List<HealthPlatformRequirement> get healthPlatformRequirements => const [
    AppleHealthRequirement.allVersions,
  ];
}
