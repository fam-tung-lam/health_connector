import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        ActiveCaloriesBurnedRecord,
        BiotinNutrientRecord,
        BloodPressureRecord,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        CaffeineNutrientRecord,
        CalciumNutrientRecord,
        CholesterolNutrientRecord,
        CyclingPowerRecord,
        DietaryFiberNutrientRecord,
        DiastolicBloodPressureRecord,
        DistanceActivityRecord,
        DistanceRecord,
        EnergyNutrientRecord,
        FloorsClimbedRecord,
        FolateNutrientRecord,
        HealthRecord,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        IronNutrientRecord,
        LeanBodyMassRecord,
        MagnesiumNutrientRecord,
        ManganeseNutrientRecord,
        MonounsaturatedFatNutrientRecord,
        NiacinNutrientRecord,
        NutritionRecord,
        PantothenicAcidNutrientRecord,
        PhosphorusNutrientRecord,
        PolyunsaturatedFatNutrientRecord,
        PotassiumNutrientRecord,
        PowerSeriesRecord,
        ProteinNutrientRecord,
        RestingHeartRateRecord,
        RiboflavinNutrientRecord,
        SaturatedFatNutrientRecord,
        SeleniumNutrientRecord,
        SleepSessionRecord,
        SleepStageRecord,
        SodiumNutrientRecord,
        StepsRecord,
        SugarNutrientRecord,
        SystolicBloodPressureRecord,
        ThiaminNutrientRecord,
        TotalCarbohydrateNutrientRecord,
        TotalFatNutrientRecord,
        VitaminANutrientRecord,
        VitaminB12NutrientRecord,
        VitaminB6NutrientRecord,
        VitaminCNutrientRecord,
        VitaminDNutrientRecord,
        VitaminENutrientRecord,
        VitaminKNutrientRecord,
        WeightRecord,
        WheelchairPushesRecord,
        ZincNutrientRecord,
        OxygenSaturationRecord,
        RespiratoryRateRecord,
        BloodGlucoseRecord,
        Vo2MaxRecord,
        SpeedActivityRecord,
        SpeedSeriesRecord,
        ExerciseSessionRecord,
        sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/active_calories_burned_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_glucose_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/body_fat_percentage_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/body_temperature_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/cycling_power_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/diastolic_blood_pressure_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance_activity_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/exercise_session_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/floors_climbed_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate_measurement_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/height_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/hydration_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/lean_body_mass_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/oxygen_saturation_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/respiratory_rate_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/resting_heart_rate_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/sleep_stage_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/speed_activity_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/steps_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/systolic_blood_pressure_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/vo2_max_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/weight_record_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/wheelchair_pushes_record_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        ActiveCaloriesBurnedRecordDto,
        BiotinNutrientRecordDto,
        BloodPressureRecordDto,
        BodyFatPercentageRecordDto,
        BodyTemperatureRecordDto,
        CaffeineNutrientRecordDto,
        CalciumNutrientRecordDto,
        CholesterolNutrientRecordDto,
        CyclingPowerRecordDto,
        DiastolicBloodPressureRecordDto,
        DietaryFiberNutrientRecordDto,
        DistanceActivityRecordDto,
        EnergyNutrientRecordDto,
        FloorsClimbedRecordDto,
        FolateNutrientRecordDto,
        HealthRecordDto,
        HeartRateMeasurementRecordDto,
        HeightRecordDto,
        HydrationRecordDto,
        IronNutrientRecordDto,
        LeanBodyMassRecordDto,
        MagnesiumNutrientRecordDto,
        ManganeseNutrientRecordDto,
        MonounsaturatedFatNutrientRecordDto,
        NiacinNutrientRecordDto,
        NutritionRecordDto,
        PantothenicAcidNutrientRecordDto,
        PhosphorusNutrientRecordDto,
        PolyunsaturatedFatNutrientRecordDto,
        PotassiumNutrientRecordDto,
        ProteinNutrientRecordDto,
        RestingHeartRateRecordDto,
        RiboflavinNutrientRecordDto,
        SaturatedFatNutrientRecordDto,
        SeleniumNutrientRecordDto,
        SleepStageRecordDto,
        SodiumNutrientRecordDto,
        StepsRecordDto,
        SugarNutrientRecordDto,
        SystolicBloodPressureRecordDto,
        ThiaminNutrientRecordDto,
        TotalCarbohydrateNutrientRecordDto,
        TotalFatNutrientRecordDto,
        VitaminANutrientRecordDto,
        VitaminB12NutrientRecordDto,
        VitaminB6NutrientRecordDto,
        VitaminCNutrientRecordDto,
        VitaminDNutrientRecordDto,
        VitaminENutrientRecordDto,
        VitaminKNutrientRecordDto,
        WeightRecordDto,
        WheelchairPushesRecordDto,
        ZincNutrientRecordDto,
        OxygenSaturationRecordDto,
        RespiratoryRateRecordDto,
        BloodGlucoseRecordDto,
        Vo2MaxRecordDto,
        SpeedActivityRecordDto,
        ExerciseSessionRecordDto;
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
/// // SAFE: Explicit extension invocation
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
/// 3. Add a case using **explicit extension invocation**:  ```dart
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
      case final FloorsClimbedRecord record:
        return FloorsClimbedRecordToDto(record).toDto();
      case final StepsRecord record:
        return StepsRecordToDto(record).toDto();
      case final WeightRecord record:
        return WeightRecordToDto(record).toDto();
      case final LeanBodyMassRecord record:
        return LeanBodyMassRecordToDto(record).toDto();
      case final HeightRecord record:
        return HeightRecordToDto(record).toDto();
      case final BodyFatPercentageRecord record:
        return BodyFatPercentageRecordToDto(record).toDto();
      case final BodyTemperatureRecord record:
        return BodyTemperatureRecordToDto(record).toDto();
      case final HydrationRecord record:
        return HydrationRecordToDto(record).toDto();
      case final WheelchairPushesRecord record:
        return WheelchairPushesRecordToDto(record).toDto();
      case final HeartRateMeasurementRecord record:
        return HeartRateMeasurementRecordToDto(record).toDto();
      case final SleepStageRecord record:
        return SleepStageRecordToDto(record).toDto();
      case final NutritionRecord record:
        return NutritionRecordToDto(record).toDto();
      case final EnergyNutrientRecord record:
        return EnergyNutrientRecordToDto(record).toDto();
      case final CaffeineNutrientRecord record:
        return CaffeineNutrientRecordToDto(record).toDto();
      case final ProteinNutrientRecord record:
        return ProteinNutrientRecordToDto(record).toDto();
      case final TotalCarbohydrateNutrientRecord record:
        return TotalCarbohydrateNutrientRecordToDto(record).toDto();
      case final TotalFatNutrientRecord record:
        return TotalFatNutrientRecordToDto(record).toDto();
      case final SaturatedFatNutrientRecord record:
        return SaturatedFatNutrientRecordToDto(record).toDto();
      case final MonounsaturatedFatNutrientRecord record:
        return MonounsaturatedFatNutrientRecordToDto(record).toDto();
      case final PolyunsaturatedFatNutrientRecord record:
        return PolyunsaturatedFatNutrientRecordToDto(record).toDto();
      case final CholesterolNutrientRecord record:
        return CholesterolNutrientRecordToDto(record).toDto();
      case final DietaryFiberNutrientRecord record:
        return DietaryFiberNutrientRecordToDto(record).toDto();
      case final SugarNutrientRecord record:
        return SugarNutrientRecordToDto(record).toDto();
      case final VitaminANutrientRecord record:
        return VitaminANutrientRecordToDto(record).toDto();
      case final VitaminB6NutrientRecord record:
        return VitaminB6NutrientRecordToDto(record).toDto();
      case final VitaminB12NutrientRecord record:
        return VitaminB12NutrientRecordToDto(record).toDto();
      case final VitaminCNutrientRecord record:
        return VitaminCNutrientRecordToDto(record).toDto();
      case final VitaminDNutrientRecord record:
        return VitaminDNutrientRecordToDto(record).toDto();
      case final VitaminENutrientRecord record:
        return VitaminENutrientRecordToDto(record).toDto();
      case final VitaminKNutrientRecord record:
        return VitaminKNutrientRecordToDto(record).toDto();
      case final ThiaminNutrientRecord record:
        return ThiaminNutrientRecordToDto(record).toDto();
      case final RiboflavinNutrientRecord record:
        return RiboflavinNutrientRecordToDto(record).toDto();
      case final NiacinNutrientRecord record:
        return NiacinNutrientRecordToDto(record).toDto();
      case final FolateNutrientRecord record:
        return FolateNutrientRecordToDto(record).toDto();
      case final BiotinNutrientRecord record:
        return BiotinNutrientRecordToDto(record).toDto();
      case final PantothenicAcidNutrientRecord record:
        return PantothenicAcidNutrientRecordToDto(record).toDto();
      case final CalciumNutrientRecord record:
        return CalciumNutrientRecordToDto(record).toDto();
      case final IronNutrientRecord record:
        return IronNutrientRecordToDto(record).toDto();
      case final MagnesiumNutrientRecord record:
        return MagnesiumNutrientRecordToDto(record).toDto();
      case final ManganeseNutrientRecord record:
        return ManganeseNutrientRecordToDto(record).toDto();
      case final PhosphorusNutrientRecord record:
        return PhosphorusNutrientRecordToDto(record).toDto();
      case final PotassiumNutrientRecord record:
        return PotassiumNutrientRecordToDto(record).toDto();
      case final SeleniumNutrientRecord record:
        return SeleniumNutrientRecordToDto(record).toDto();
      case final SodiumNutrientRecord record:
        return SodiumNutrientRecordToDto(record).toDto();
      case final ZincNutrientRecord record:
        return ZincNutrientRecordToDto(record).toDto();
      case final OxygenSaturationRecord record:
        return OxygenSaturationRecordToDto(record).toDto();
      case final RespiratoryRateRecord record:
        return RespiratoryRateRecordToDto(record).toDto();
      case final BloodPressureRecord record:
        return BloodPressureRecordToDto(record).toDto();
      case final SystolicBloodPressureRecord record:
        return SystolicBloodPressureRecordToDto(record).toDto();
      case final DiastolicBloodPressureRecord record:
        return DiastolicBloodPressureRecordToDto(record).toDto();
      case final RestingHeartRateRecord record:
        return RestingHeartRateRecordToDto(record).toDto();
      case final Vo2MaxRecord record:
        return Vo2MaxRecordToDto(record).toDto();
      case final BloodGlucoseRecord record:
        return BloodGlucoseRecordToDto(record).toDto();
      case final CyclingPowerRecord record:
        return CyclingPowerRecordToDto(record).toDto();
      case final DistanceActivityRecord record:
        return DistanceActivityRecordToDto(record).toDto();
      case final HeartRateSeriesRecord _:
        throw UnsupportedError(
          '$HeartRateSeriesRecord is not supported on iOS HealthKit. '
          'Use $HeartRateMeasurementRecord instead.',
        );
      case final SleepSessionRecord _:
        throw UnsupportedError(
          '$SleepSessionRecord is not supported on iOS HealthKit. '
          'Use $SleepStageRecord instead.',
        );
      case DistanceRecord():
        throw UnsupportedError(
          '$DistanceRecord is not supported on iOS HealthKit. '
          'Use $DistanceActivityRecord instead.',
        );
      case final SpeedActivityRecord record:
        return SpeedActivityRecordToDto(record).toDto();
      case SpeedSeriesRecord():
        throw UnsupportedError(
          '$SpeedSeriesRecord is not supported on iOS HealthKit. '
          'Use $SpeedActivityRecord instead.',
        );
      case PowerSeriesRecord():
        throw UnsupportedError(
          '$PowerSeriesRecord is not supported on iOS HealthKit. '
          'Use $CyclingPowerRecord instead.',
        );
      case ExerciseSessionRecord():
        return ExerciseSessionRecordToDto(
          this as ExerciseSessionRecord,
        ).toDto();
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
      case final FloorsClimbedRecordDto dto:
        return FloorsClimbedRecordDtoToDomain(dto).toDomain();
      case final StepsRecordDto dto:
        return StepsRecordDtoToDomain(dto).toDomain();
      case final WeightRecordDto dto:
        return WeightRecordDtoToDomain(dto).toDomain();
      case final LeanBodyMassRecordDto dto:
        return LeanBodyMassRecordDtoToDomain(dto).toDomain();
      case final HeightRecordDto dto:
        return HeightRecordDtoToDomain(dto).toDomain();
      case final BodyFatPercentageRecordDto dto:
        return BodyFatPercentageRecordDtoToDomain(dto).toDomain();
      case final BodyTemperatureRecordDto dto:
        return BodyTemperatureRecordDtoToDomain(dto).toDomain();
      case final HydrationRecordDto dto:
        return HydrationRecordDtoToDomain(dto).toDomain();
      case final WheelchairPushesRecordDto dto:
        return WheelchairPushesRecordDtoToDomain(dto).toDomain();
      case final HeartRateMeasurementRecordDto dto:
        return HeartRateMeasurementRecordDtoToDomain(dto).toDomain();
      case final SleepStageRecordDto dto:
        return SleepStageRecordDtoToDomain(dto).toDomain();
      case final OxygenSaturationRecordDto dto:
        return OxygenSaturationRecordDtoToDomain(dto).toDomain();
      case final RespiratoryRateRecordDto dto:
        return RespiratoryRateRecordDtoToDomain(dto).toDomain();
      case final BloodPressureRecordDto dto:
        return BloodPressureRecordDtoToDomain(dto).toDomain();
      case final SystolicBloodPressureRecordDto dto:
        return SystolicBloodPressureRecordDtoToDomain(dto).toDomain();
      case final DiastolicBloodPressureRecordDto dto:
        return DiastolicBloodPressureRecordDtoToDomain(dto).toDomain();
      case final RestingHeartRateRecordDto dto:
        return RestingHeartRateRecordDtoToDomain(dto).toDomain();
      case final EnergyNutrientRecordDto dto:
        return EnergyNutrientRecordDtoToDomain(dto).toDomain();
      case final CaffeineNutrientRecordDto dto:
        return CaffeineNutrientRecordDtoToDomain(dto).toDomain();
      case final ProteinNutrientRecordDto dto:
        return ProteinNutrientRecordDtoToDomain(dto).toDomain();
      case final TotalCarbohydrateNutrientRecordDto dto:
        return TotalCarbohydrateNutrientRecordDtoToDomain(dto).toDomain();
      case final TotalFatNutrientRecordDto dto:
        return TotalFatNutrientRecordDtoToDomain(dto).toDomain();
      case final SaturatedFatNutrientRecordDto dto:
        return SaturatedFatNutrientRecordDtoToDomain(dto).toDomain();
      case final MonounsaturatedFatNutrientRecordDto dto:
        return MonounsaturatedFatNutrientRecordDtoToDomain(dto).toDomain();
      case final PolyunsaturatedFatNutrientRecordDto dto:
        return PolyunsaturatedFatNutrientRecordDtoToDomain(dto).toDomain();
      case final CholesterolNutrientRecordDto dto:
        return CholesterolNutrientRecordDtoToDomain(dto).toDomain();
      case final DietaryFiberNutrientRecordDto dto:
        return DietaryFiberNutrientRecordDtoToDomain(dto).toDomain();
      case final SugarNutrientRecordDto dto:
        return SugarNutrientRecordDtoToDomain(dto).toDomain();
      case final VitaminANutrientRecordDto dto:
        return VitaminANutrientRecordDtoToDomain(dto).toDomain();
      case final VitaminB6NutrientRecordDto dto:
        return VitaminB6NutrientRecordDtoToDomain(dto).toDomain();
      case final VitaminB12NutrientRecordDto dto:
        return VitaminB12NutrientRecordDtoToDomain(dto).toDomain();
      case final VitaminCNutrientRecordDto dto:
        return VitaminCNutrientRecordDtoToDomain(dto).toDomain();
      case final VitaminDNutrientRecordDto dto:
        return VitaminDNutrientRecordDtoToDomain(dto).toDomain();
      case final VitaminENutrientRecordDto dto:
        return VitaminENutrientRecordDtoToDomain(dto).toDomain();
      case final VitaminKNutrientRecordDto dto:
        return VitaminKNutrientRecordDtoToDomain(dto).toDomain();
      case final ThiaminNutrientRecordDto dto:
        return ThiaminNutrientRecordDtoToDomain(dto).toDomain();
      case final RiboflavinNutrientRecordDto dto:
        return RiboflavinNutrientRecordDtoToDomain(dto).toDomain();
      case final NiacinNutrientRecordDto dto:
        return NiacinNutrientRecordDtoToDomain(dto).toDomain();
      case final FolateNutrientRecordDto dto:
        return FolateNutrientRecordDtoToDomain(dto).toDomain();
      case final BiotinNutrientRecordDto dto:
        return BiotinNutrientRecordDtoToDomain(dto).toDomain();
      case final PantothenicAcidNutrientRecordDto dto:
        return PantothenicAcidNutrientRecordDtoToDomain(dto).toDomain();
      case final CalciumNutrientRecordDto dto:
        return CalciumNutrientRecordDtoToDomain(dto).toDomain();
      case final IronNutrientRecordDto dto:
        return IronNutrientRecordDtoToDomain(dto).toDomain();
      case final MagnesiumNutrientRecordDto dto:
        return MagnesiumNutrientRecordDtoToDomain(dto).toDomain();
      case final ManganeseNutrientRecordDto dto:
        return ManganeseNutrientRecordDtoToDomain(dto).toDomain();
      case final PhosphorusNutrientRecordDto dto:
        return PhosphorusNutrientRecordDtoToDomain(dto).toDomain();
      case final PotassiumNutrientRecordDto dto:
        return PotassiumNutrientRecordDtoToDomain(dto).toDomain();
      case final SeleniumNutrientRecordDto dto:
        return SeleniumNutrientRecordDtoToDomain(dto).toDomain();
      case final SodiumNutrientRecordDto dto:
        return SodiumNutrientRecordDtoToDomain(dto).toDomain();
      case final ZincNutrientRecordDto dto:
        return ZincNutrientRecordDtoToDomain(dto).toDomain();
      case final NutritionRecordDto dto:
        return NutritionRecordDtoToDomain(dto).toDomain();
      case final Vo2MaxRecordDto dto:
        return Vo2MaxRecordDtoToDomain(dto).toDomain();
      case final BloodGlucoseRecordDto dto:
        return BloodGlucoseRecordDtoToDomain(dto).toDomain();
      case final CyclingPowerRecordDto dto:
        return CyclingPowerRecordDtoToDomain(dto).toDomain();
      case final DistanceActivityRecordDto dto:
        return DistanceActivityRecordDtoToDomain(dto).toDomain();
      case final SpeedActivityRecordDto dto:
        return SpeedActivityRecordDtoToDomain(dto).toDomain();
      case final ExerciseSessionRecordDto dto:
        return ExerciseSessionRecordDtoToDomain(dto).toDomain();
    }
  }
}
