import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthDataPermission,
        HealthDataType,
        HealthRecord,
        MeasurementUnit,
        NutritionHealthDataType,
        sinceV1_0_0,
        Permission;
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/health_data_permission_access_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/health_data_permission_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PermissionsRequestDto, HealthDataPermissionDto;
import 'package:meta/meta.dart' show internal;

/// Converts [List<Permission>] to [PermissionsRequestDto].
@sinceV1_0_0
@internal
extension PermissionsListToDto on List<HealthDataPermission> {
  /// All individual nutrient data types that make up a NutritionRecord.
  ///
  /// When requesting permission for [NutritionHealthDataType], we need to
  /// also request permission for all individual nutrient types since HealthKit
  /// stores nutrition as an HKCorrelation containing individual
  /// HKQuantitySamples.
  static const _allNutrientDataTypes = [
    HealthDataType.energyNutrient,
    HealthDataType.caffeine,
    HealthDataType.protein,
    HealthDataType.totalCarbohydrate,
    HealthDataType.totalFat,
    HealthDataType.saturatedFat,
    HealthDataType.monounsaturatedFat,
    HealthDataType.polyunsaturatedFat,
    HealthDataType.cholesterol,
    HealthDataType.dietaryFiber,
    HealthDataType.sugar,
    HealthDataType.vitaminA,
    HealthDataType.vitaminB6,
    HealthDataType.vitaminB12,
    HealthDataType.vitaminC,
    HealthDataType.vitaminD,
    HealthDataType.vitaminE,
    HealthDataType.vitaminK,
    HealthDataType.thiamin,
    HealthDataType.riboflavin,
    HealthDataType.niacin,
    HealthDataType.folate,
    HealthDataType.biotin,
    HealthDataType.pantothenicAcid,
    HealthDataType.calcium,
    HealthDataType.iron,
    HealthDataType.magnesium,
    HealthDataType.manganese,
    HealthDataType.phosphorus,
    HealthDataType.potassium,
    HealthDataType.selenium,
    HealthDataType.sodium,
    HealthDataType.zinc,
  ];

  /// Converts a list of [Permission] objects to a [PermissionsRequestDto].
  ///
  /// If a permission for [NutritionHealthDataType] is found, this method will
  /// also add permissions for all individual nutrient data types with the same
  /// access type (read/write). This is required because HealthKit stores
  /// nutrition as an HKCorrelation containing individual HKQuantitySamples.
  PermissionsRequestDto toDto() {
    final healthDataPermissions = expand<HealthDataPermissionDto>(
      _expandPermission,
    ).toList();

    return PermissionsRequestDto(
      healthDataPermissions: healthDataPermissions,
    );
  }

  /// Expands a single permission into one or more DTOs.
  ///
  /// For [NutritionHealthDataType], expands to all individual nutrient types.
  /// For other types, returns a single DTO.
  Iterable<HealthDataPermissionDto> _expandPermission(
    HealthDataPermission permission,
  ) {
    if (permission.dataType is NutritionHealthDataType) {
      return _allNutrientDataTypes
          .cast<HealthDataType<HealthRecord, MeasurementUnit>>()
          .map(
            (nutrientType) => HealthDataPermissionDto(
              healthDataType: nutrientType.toDto(),
              accessType: permission.accessType.toDto(),
            ),
          );
    }

    return [permission.toDto()];
  }
}
