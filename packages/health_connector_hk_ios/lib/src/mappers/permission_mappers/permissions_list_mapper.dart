import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/permission_mappers/permission_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        HealthDataPermissionRequestDto,
        PermissionRequestDto,
        PermissionsRequestDto;
import 'package:meta/meta.dart' show internal;

/// All individual data types that make up a NutritionRecord.
///
/// When requesting permission for [NutritionDataType], we need to
/// also request permission for all individual nutrient types since HealthKit
/// stores nutrition as an HKCorrelation containing individual
/// HKQuantitySamples.
const _allNutrientDataTypes = [
  HealthDataType.dietaryEnergyConsumed,
  HealthDataType.dietaryCaffeine,
  HealthDataType.dietaryProtein,
  HealthDataType.dietaryTotalCarbohydrate,
  HealthDataType.dietaryTotalFat,
  HealthDataType.dietarySaturatedFat,
  HealthDataType.dietaryMonounsaturatedFat,
  HealthDataType.dietaryPolyunsaturatedFat,
  HealthDataType.dietaryCholesterol,
  HealthDataType.dietaryFiber,
  HealthDataType.dietarySugar,
  HealthDataType.dietaryVitaminA,
  HealthDataType.dietaryVitaminB6,
  HealthDataType.dietaryVitaminB12,
  HealthDataType.dietaryVitaminC,
  HealthDataType.dietaryVitaminD,
  HealthDataType.dietaryVitaminE,
  HealthDataType.dietaryVitaminK,
  HealthDataType.dietaryThiamin,
  HealthDataType.dietaryRiboflavin,
  HealthDataType.dietaryNiacin,
  HealthDataType.dietaryFolate,
  HealthDataType.dietaryBiotin,
  HealthDataType.dietaryPantothenicAcid,
  HealthDataType.dietaryCalcium,
  HealthDataType.dietaryIron,
  HealthDataType.dietaryMagnesium,
  HealthDataType.dietaryManganese,
  HealthDataType.dietaryPhosphorus,
  HealthDataType.dietaryPotassium,
  HealthDataType.dietarySelenium,
  HealthDataType.dietarySodium,
  HealthDataType.dietaryZinc,
];

/// Expands a single permission into one or more DTOs.
///
/// For [NutritionDataType], expands to all individual nutrient types.
/// For other types, returns a single DTO.
Iterable<PermissionRequestDto> _expandHealthDataPermission(
  HealthDataPermission permission,
) {
  if (permission.dataType is NutritionDataType) {
    return _allNutrientDataTypes
        .cast<HealthDataType<HealthRecord, MeasurementUnit>>()
        .map(
          (nutrientType) => HealthDataPermissionRequestDto(
            healthDataType: nutrientType.toDto(),
            accessType: permission.accessType.toDto(),
          ),
        );
  }

  return [permission.toDto()];
}

/// Converts [List<HealthDataPermission>] to [PermissionsRequestDto].
@internal
extension PermissionsListToDto on List<HealthDataPermission> {
  /// Converts a list of [HealthDataPermission] objects to a
  /// [PermissionsRequestDto].
  ///
  /// If a permission for [NutritionDataType] is found, this method will
  /// also add permissions for all individual data types with the same
  /// access type (read/write). This is required because HealthKit stores
  /// nutrition as an HKCorrelation containing individual HKQuantitySamples.
  PermissionsRequestDto toDto() {
    final permissionRequests = expand<PermissionRequestDto>(
      _expandHealthDataPermission,
    ).toList();

    return PermissionsRequestDto(permissionRequests: permissionRequests);
  }
}

/// Converts health data permissions and exercise route permissions to a
/// [PermissionsRequestDto].
@internal
PermissionsRequestDto createPermissionsRequestDto({
  required List<HealthDataPermission> healthDataPermissions,
  required List<ExerciseRoutePermission> exerciseRoutePermissions,
}) {
  final healthDataDtos = healthDataPermissions
      .expand<PermissionRequestDto>(_expandHealthDataPermission)
      .toList();
  final exerciseRouteDtos = exerciseRoutePermissions
      .map((p) => p.toDto())
      .toList();

  return PermissionsRequestDto(
    permissionRequests: [...healthDataDtos, ...exerciseRouteDtos],
  );
}
