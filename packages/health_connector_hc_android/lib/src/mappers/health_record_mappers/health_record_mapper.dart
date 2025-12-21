import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedRecord,
        BloodPressureRecord,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        DiastolicBloodPressureRecord,
        DistanceRecord,
        FloorsClimbedRecord,
        HealthRecord,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        LeanBodyMassRecord,
        NutritionRecord,
        SleepSessionRecord,
        SleepStageRecord,
        StepsRecord,
        SystolicBloodPressureRecord,
        WeightRecord,
        WheelchairPushesRecord,
        PhosphorusNutrientRecord,
        OxygenSaturationRecord,
        EnergyNutrientRecord,
        CaffeineNutrientRecord,
        ProteinNutrientRecord,
        TotalCarbohydrateNutrientRecord,
        TotalFatNutrientRecord,
        SaturatedFatNutrientRecord,
        MonounsaturatedFatNutrientRecord,
        PolyunsaturatedFatNutrientRecord,
        CholesterolNutrientRecord,
        DietaryFiberNutrientRecord,
        SugarNutrientRecord,
        VitaminANutrientRecord,
        VitaminB6NutrientRecord,
        VitaminB12NutrientRecord,
        VitaminCNutrientRecord,
        VitaminDNutrientRecord,
        VitaminENutrientRecord,
        VitaminKNutrientRecord,
        ThiaminNutrientRecord,
        RiboflavinNutrientRecord,
        NiacinNutrientRecord,
        FolateNutrientRecord,
        BiotinNutrientRecord,
        PantothenicAcidNutrientRecord,
        CalciumNutrientRecord,
        IronNutrientRecord,
        MagnesiumNutrientRecord,
        ManganeseNutrientRecord,
        PotassiumNutrientRecord,
        RestingHeartRateRecord,
        SeleniumNutrientRecord,
        SodiumNutrientRecord,
        ZincNutrientRecord,
        Vo2MaxRecord,
        BloodGlucoseRecord,
        RespiratoryRateRecord,
        sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/active_calories_burned_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_glucose_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_pressure_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/body_fat_percentage_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/body_temperature_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/distance_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/floors_climbed_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/heart_rate_series_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/height_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/hydration_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/lean_body_mass_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/nutrition_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/oxygen_saturation_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/respiratory_rate_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/resting_heart_rate_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/sleep_session_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/steps_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/vo2_max_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/weight_record_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/wheelchair_pushes_record_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        ActiveCaloriesBurnedRecordDto,
        BloodPressureRecordDto,
        BodyFatPercentageRecordDto,
        BodyTemperatureRecordDto,
        DistanceRecordDto,
        FloorsClimbedRecordDto,
        HealthRecordDto,
        HeartRateSeriesRecordDto,
        HeightRecordDto,
        HydrationRecordDto,
        LeanBodyMassRecordDto,
        NutritionRecordDto,
        OxygenSaturationRecordDto,
        RestingHeartRateRecordDto,
        SleepSessionRecordDto,
        StepsRecordDto,
        WeightRecordDto,
        WheelchairPushesRecordDto,
        Vo2MaxRecordDto,
        BloodGlucoseRecordDto,
        RespiratoryRateRecordDto;
import 'package:meta/meta.dart' show internal;

/// ## ⚠️ CRITICAL: Infinite Recursion Prevention
///
/// This extension uses **explicit extension invocation** to prevent infinite
/// recursion bugs caused by missing extension imports.
///
/// ### The Problem
///
/// Each [HealthRecord] subclass has its own `toDto()` extension method defined
/// in a separate file (e.g., `BodyTemperatureRecordToDto` in
/// `body_temperature_record_mappers.dart`). If you forget to import one of
/// these files, Dart's extension resolution will fall back to this base
/// extension, causing infinite recursion:
///
/// ```dart
/// // ❌ DANGEROUS: Implicit extension invocation
/// case final BodyTemperatureRecord record:
///   return record.toDto();  // If import missing, calls THIS method again!
/// ```
///
/// ### The Solution
///
/// We use explicit extension invocation to force compile-time errors when
/// imports are missing:
///
/// ```dart
/// // ✅ SAFE: Explicit extension invocation
/// case final BodyTemperatureRecord record:
///   return BodyTemperatureRecordToDto(record).toDto();  // Compile error if import missing
/// ```
///
/// ### For Developers
///
/// When adding a new [HealthRecord] subclass:
///
/// 1. Create a new mapper file with the extension (e.g., `FooRecordToDto`)
/// 2. Import the mapper file at the top of this file
/// 3. Add a case using **explicit extension invocation**:
///    ```dart
///    case final FooRecord record:
///      return FooRecordToDto(record).toDto();
///    ```
/// 4. **Never** use implicit invocation (`record.toDto()`) - it will compile
///    but cause infinite recursion if the import is missing
///
/// The same approach must be applied to [HealthRecordDtoToDomain].

/// Converts [HealthRecord] to [HealthRecordDto].
@sinceV1_0_0
@internal
extension HealthRecordToDto on HealthRecord {
  HealthRecordDto toDto() {
    switch (this) {
      case final ActiveCaloriesBurnedRecord record:
        return ActiveCaloriesBurnedRecordToDto(record).toDto();
      case final DistanceRecord record:
        return DistanceRecordToDto(record).toDto();
      case final FloorsClimbedRecord record:
        return FloorsClimbedRecordToDto(record).toDto();
      case final HeightRecord record:
        return HeightRecordToDto(record).toDto();
      case final HydrationRecord record:
        return HydrationRecordToDto(record).toDto();
      case final LeanBodyMassRecord record:
        return LeanBodyMassRecordToDto(record).toDto();
      case final BodyFatPercentageRecord record:
        return BodyFatPercentageRecordToDto(record).toDto();
      case final BodyTemperatureRecord record:
        return BodyTemperatureRecordToDto(record).toDto();
      case final StepsRecord record:
        return StepsRecordToDto(record).toDto();
      case final WeightRecord record:
        return WeightRecordToDto(record).toDto();
      case final WheelchairPushesRecord record:
        return WheelchairPushesRecordToDto(record).toDto();
      case final HeartRateSeriesRecord record:
        return HeartRateSeriesRecordToDto(record).toDto();
      case final SleepSessionRecord record:
        return SleepSessionRecordToDto(record).toDto();
      case final NutritionRecord record:
        return NutritionRecordToDto(record).toDto();
      case final RestingHeartRateRecord record:
        return RestingHeartRateRecordToDto(record).toDto();
      case final OxygenSaturationRecord record:
        return OxygenSaturationRecordToDto(record).toDto();
      case final BloodPressureRecord record:
        return BloodPressureRecordToDto(record).toDto();
      case final RespiratoryRateRecord record:
        return RespiratoryRateRecordToDto(record).toDto();
      case final Vo2MaxRecord record:
        return Vo2MaxRecordToDto(record).toDto();
      case final BloodGlucoseRecord record:
        return BloodGlucoseRecordToDto(record).toDto();
      case final EnergyNutrientRecord _:
        throw UnsupportedError(
          '$EnergyNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final CaffeineNutrientRecord _:
        throw UnsupportedError(
          '$CaffeineNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final ProteinNutrientRecord _:
        throw UnsupportedError(
          '$ProteinNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final TotalCarbohydrateNutrientRecord _:
        throw UnsupportedError(
          '$TotalCarbohydrateNutrientRecord is not supported on '
          'Health Connect. Use $NutritionRecord instead.',
        );
      case final TotalFatNutrientRecord _:
        throw UnsupportedError(
          '$TotalFatNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final SaturatedFatNutrientRecord _:
        throw UnsupportedError(
          '$SaturatedFatNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final MonounsaturatedFatNutrientRecord _:
        throw UnsupportedError(
          '$MonounsaturatedFatNutrientRecord is not supported on '
          'Health Connect. Use $NutritionRecord instead.',
        );
      case final PolyunsaturatedFatNutrientRecord _:
        throw UnsupportedError(
          '$PolyunsaturatedFatNutrientRecord is not supported on '
          'Health Connect. Use $NutritionRecord instead.',
        );
      case final CholesterolNutrientRecord _:
        throw UnsupportedError(
          '$CholesterolNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryFiberNutrientRecord _:
        throw UnsupportedError(
          '$DietaryFiberNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final SugarNutrientRecord _:
        throw UnsupportedError(
          '$SugarNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final VitaminANutrientRecord _:
        throw UnsupportedError(
          '$VitaminANutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final VitaminB6NutrientRecord _:
        throw UnsupportedError(
          '$VitaminB6NutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final VitaminB12NutrientRecord _:
        throw UnsupportedError(
          '$VitaminB12NutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final VitaminCNutrientRecord _:
        throw UnsupportedError(
          '$VitaminCNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final VitaminDNutrientRecord _:
        throw UnsupportedError(
          '$VitaminDNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final VitaminENutrientRecord _:
        throw UnsupportedError(
          '$VitaminENutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final VitaminKNutrientRecord _:
        throw UnsupportedError(
          '$VitaminKNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final ThiaminNutrientRecord _:
        throw UnsupportedError(
          '$ThiaminNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final RiboflavinNutrientRecord _:
        throw UnsupportedError(
          '$RiboflavinNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final NiacinNutrientRecord _:
        throw UnsupportedError(
          '$NiacinNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final FolateNutrientRecord _:
        throw UnsupportedError(
          '$FolateNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final BiotinNutrientRecord _:
        throw UnsupportedError(
          '$BiotinNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final PantothenicAcidNutrientRecord _:
        throw UnsupportedError(
          '$PantothenicAcidNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final CalciumNutrientRecord _:
        throw UnsupportedError(
          '$CalciumNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final IronNutrientRecord _:
        throw UnsupportedError(
          '$IronNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final MagnesiumNutrientRecord _:
        throw UnsupportedError(
          '$MagnesiumNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final ManganeseNutrientRecord _:
        throw UnsupportedError(
          '$ManganeseNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final PhosphorusNutrientRecord _:
        throw UnsupportedError(
          '$PhosphorusNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final PotassiumNutrientRecord _:
        throw UnsupportedError(
          '$PotassiumNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final SeleniumNutrientRecord _:
        throw UnsupportedError(
          '$SeleniumNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final SodiumNutrientRecord _:
        throw UnsupportedError(
          '$SodiumNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final ZincNutrientRecord _:
        throw UnsupportedError(
          '$ZincNutrientRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final SleepStageRecord _:
        throw UnsupportedError(
          '$SleepStageRecord is not supported on Android. '
          'Use $SleepSessionRecord instead.',
        );
      case final HeartRateMeasurementRecord _:
        throw UnsupportedError(
          '$HeartRateMeasurementRecord is not supported on Android. '
          'Use $HeartRateSeriesRecord instead.',
        );
      case final SystolicBloodPressureRecord _:
        throw UnsupportedError(
          '$SystolicBloodPressureRecord is not supported on '
          'Health Connect. Use $BloodPressureRecord instead.',
        );
      case final DiastolicBloodPressureRecord _:
        throw UnsupportedError(
          '$DiastolicBloodPressureRecord is not supported on '
          'Health Connect. Use $BloodPressureRecord instead.',
        );
    }
  }
}

/// Converts [HealthRecordDto] to [HealthRecord].
@sinceV1_0_0
@internal
extension HealthRecordDtoToDomain on HealthRecordDto {
  HealthRecord toDomain() {
    switch (this) {
      case final ActiveCaloriesBurnedRecordDto dto:
        return ActiveCaloriesBurnedRecordDtoToDomain(dto).toDomain();
      case final DistanceRecordDto dto:
        return DistanceRecordDtoToDomain(dto).toDomain();
      case final FloorsClimbedRecordDto dto:
        return FloorsClimbedRecordDtoToDomain(dto).toDomain();
      case final HeightRecordDto dto:
        return HeightRecordDtoToDomain(dto).toDomain();
      case final HydrationRecordDto dto:
        return HydrationRecordDtoToDomain(dto).toDomain();
      case final LeanBodyMassRecordDto dto:
        return LeanBodyMassRecordDtoToDomain(dto).toDomain();
      case final BodyFatPercentageRecordDto dto:
        return BodyFatPercentageRecordDtoToDomain(dto).toDomain();
      case final BodyTemperatureRecordDto dto:
        return BodyTemperatureRecordDtoToDomain(dto).toDomain();
      case final StepsRecordDto dto:
        return StepsRecordDtoToDomain(dto).toDomain();
      case final WeightRecordDto dto:
        return WeightRecordDtoToDomain(dto).toDomain();
      case final WheelchairPushesRecordDto dto:
        return WheelchairPushesRecordDtoToDomain(dto).toDomain();
      case final HeartRateSeriesRecordDto dto:
        return HeartRateSeriesRecordDtoToDomain(dto).toDomain();
      case final SleepSessionRecordDto dto:
        return SleepSessionRecordDtoToDomain(dto).toDomain();
      case final NutritionRecordDto dto:
        return NutritionRecordDtoToDomain(dto).toDomain();
      case final RestingHeartRateRecordDto dto:
        return RestingHeartRateRecordDtoToDomain(dto).toDomain();
      case final OxygenSaturationRecordDto dto:
        return OxygenSaturationRecordDtoToDomain(dto).toDomain();
      case final BloodPressureRecordDto dto:
        return BloodPressureRecordDtoToDomain(dto).toDomain();
      case final RespiratoryRateRecordDto dto:
        return RespiratoryRateRecordDtoToDomain(dto).toDomain();
      case final Vo2MaxRecordDto dto:
        return Vo2MaxRecordDtoToDomain(dto).toDomain();
      case final BloodGlucoseRecordDto dto:
        return BloodGlucoseRecordDtoToDomain(dto).toDomain();
    }
  }
}
