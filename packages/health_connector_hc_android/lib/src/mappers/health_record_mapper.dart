// General extensions for dispatching to specific record type mappers
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
        StepRecord,
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
        ZincNutrientRecord;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
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
        StepRecordDto,
        WeightRecordDto,
        WheelchairPushesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthRecord] to [HealthRecordDto].
@internal
extension HealthRecordToDto on HealthRecord {
  HealthRecordDto toDto() {
    switch (this) {
      case final ActiveCaloriesBurnedRecord record:
        return record.toDto();
      case final DistanceRecord record:
        return record.toDto();
      case final FloorsClimbedRecord record:
        return record.toDto();
      case final HeightRecord record:
        return record.toDto();
      case final HydrationRecord record:
        return record.toDto();
      case final LeanBodyMassRecord record:
        return record.toDto();
      case final BodyFatPercentageRecord record:
        return record.toDto();
      case final BodyTemperatureRecord record:
        return record.toDto();
      case final StepRecord record:
        return record.toDto();
      case final WeightRecord record:
        return record.toDto();
      case final WheelchairPushesRecord record:
        return record.toDto();
      case final HeartRateSeriesRecord record:
        return record.toDto();
      case final SleepSessionRecord record:
        return record.toDto();
      case final EnergyNutrientRecord record:
        return record.toDto();
      case final CaffeineNutrientRecord record:
        return record.toDto();
      case final ProteinNutrientRecord record:
        return record.toDto();
      case final TotalCarbohydrateNutrientRecord record:
        return record.toDto();
      case final TotalFatNutrientRecord record:
        return record.toDto();
      case final SaturatedFatNutrientRecord record:
        return record.toDto();
      case final MonounsaturatedFatNutrientRecord record:
        return record.toDto();
      case final PolyunsaturatedFatNutrientRecord record:
        return record.toDto();
      case final CholesterolNutrientRecord record:
        return record.toDto();
      case final DietaryFiberNutrientRecord record:
        return record.toDto();
      case final SugarNutrientRecord record:
        return record.toDto();
      case final VitaminANutrientRecord record:
        return record.toDto();
      case final VitaminB6NutrientRecord record:
        return record.toDto();
      case final VitaminB12NutrientRecord record:
        return record.toDto();
      case final VitaminCNutrientRecord record:
        return record.toDto();
      case final VitaminDNutrientRecord record:
        return record.toDto();
      case final VitaminENutrientRecord record:
        return record.toDto();
      case final VitaminKNutrientRecord record:
        return record.toDto();
      case final ThiaminNutrientRecord record:
        return record.toDto();
      case final RiboflavinNutrientRecord record:
        return record.toDto();
      case final NiacinNutrientRecord record:
        return record.toDto();
      case final FolateNutrientRecord record:
        return record.toDto();
      case final BiotinNutrientRecord record:
        return record.toDto();
      case final PantothenicAcidNutrientRecord record:
        return record.toDto();
      case final CalciumNutrientRecord record:
        return record.toDto();
      case final IronNutrientRecord record:
        return record.toDto();
      case final MagnesiumNutrientRecord record:
        return record.toDto();
      case final ManganeseNutrientRecord record:
        return record.toDto();
      case final PhosphorusNutrientRecord record:
        return record.toDto();
      case final PotassiumNutrientRecord record:
        return record.toDto();
      case final SeleniumNutrientRecord record:
        return record.toDto();
      case final SodiumNutrientRecord record:
        return record.toDto();
      case final ZincNutrientRecord record:
        return record.toDto();
      case final NutritionRecord record:
        return record.toDto();
      case final RestingHeartRateRecord record:
        return record.toDto();
      case final OxygenSaturationRecord record:
        return record.toDto();
      case final BloodPressureRecord record:
        return record.toDto();
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
          'Android Health Connect. Use $BloodPressureRecord instead.',
        );
      case final DiastolicBloodPressureRecord _:
        throw UnsupportedError(
          '$DiastolicBloodPressureRecord is not supported on '
          'Android Health Connect. Use $BloodPressureRecord instead.',
        );
    }
  }
}

/// Converts [HealthRecordDto] to [HealthRecord].
@internal
extension HealthRecordDtoToDomain on HealthRecordDto {
  HealthRecord toDomain() {
    switch (this) {
      case final ActiveCaloriesBurnedRecordDto dto:
        return dto.toDomain();
      case final DistanceRecordDto dto:
        return dto.toDomain();
      case final FloorsClimbedRecordDto dto:
        return dto.toDomain();
      case final HeightRecordDto dto:
        return dto.toDomain();
      case final HydrationRecordDto dto:
        return dto.toDomain();
      case final LeanBodyMassRecordDto dto:
        return dto.toDomain();
      case final BodyFatPercentageRecordDto dto:
        return dto.toDomain();
      case final BodyTemperatureRecordDto dto:
        return dto.toDomain();
      case final StepRecordDto dto:
        return dto.toDomain();
      case final WeightRecordDto dto:
        return dto.toDomain();
      case final WheelchairPushesRecordDto dto:
        return dto.toDomain();
      case final HeartRateSeriesRecordDto dto:
        return dto.toDomain();
      case final SleepSessionRecordDto dto:
        return dto.toDomain();
      case final NutritionRecordDto dto:
        return dto.toDomain();
      case final RestingHeartRateRecordDto dto:
        return dto.toDomain();
      case final OxygenSaturationRecordDto dto:
        return dto.toDomain();
      case final BloodPressureRecordDto dto:
        return dto.toDomain();
    }
  }
}
