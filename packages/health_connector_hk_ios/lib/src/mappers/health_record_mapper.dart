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
        NutrientHealthRecord;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show
        ActiveCaloriesBurnedRecordDto,
        BiotinNutrientRecordDto,
        BloodPressureRecordDto,
        BodyFatPercentageRecordDto,
        BodyTemperatureRecordDto,
        CaffeineNutrientRecordDto,
        CalciumNutrientRecordDto,
        CholesterolNutrientRecordDto,
        DiastolicBloodPressureRecordDto,
        DietaryFiberNutrientRecordDto,
        DistanceRecordDto,
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
        RiboflavinNutrientRecordDto,
        SaturatedFatNutrientRecordDto,
        SeleniumNutrientRecordDto,
        SleepStageRecordDto,
        SodiumNutrientRecordDto,
        StepRecordDto,
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
        ZincNutrientRecordDto;
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
      case final StepRecord record:
        return record.toDto();
      case final WeightRecord record:
        return record.toDto();
      case final LeanBodyMassRecord record:
        return record.toDto();
      case final HeightRecord record:
        return record.toDto();
      case final BodyFatPercentageRecord record:
        return record.toDto();
      case final BodyTemperatureRecord record:
        return record.toDto();
      case final HydrationRecord record:
        return record.toDto();
      case final WheelchairPushesRecord record:
        return record.toDto();
      case final HeartRateMeasurementRecord record:
        return record.toDto();
      case final SleepStageRecord record:
        return record.toDto();
      case final NutritionRecord record:
        return record.toDto();
      case final NutrientHealthRecord record:
        return record.toDto();
      case final BloodPressureRecord record:
        return record.toDto();
      case final SystolicBloodPressureRecord record:
        return record.toDto();
      case final DiastolicBloodPressureRecord record:
        return record.toDto();
      case final SleepSessionRecord _:
        throw UnsupportedError(
          '$SleepSessionRecord is not supported on iOS HealthKit. '
          'Use $SleepStageRecord instead.',
        );
      case final HeartRateSeriesRecord _:
        throw UnsupportedError(
          '$HeartRateSeriesRecord is not supported on iOS HealthKit. '
          'Use $HeartRateMeasurementRecord instead.',
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
      case final StepRecordDto dto:
        return dto.toDomain();
      case final WeightRecordDto dto:
        return dto.toDomain();
      case final LeanBodyMassRecordDto dto:
        return dto.toDomain();
      case final HeightRecordDto dto:
        return dto.toDomain();
      case final BodyFatPercentageRecordDto dto:
        return dto.toDomain();
      case final BodyTemperatureRecordDto dto:
        return dto.toDomain();
      case final HydrationRecordDto dto:
        return dto.toDomain();
      case final WheelchairPushesRecordDto dto:
        return dto.toDomain();
      case final HeartRateMeasurementRecordDto dto:
        return dto.toDomain();
      case final SleepStageRecordDto dto:
        return dto.toDomain();
      case final NutritionRecordDto dto:
        return dto.toDomain();
      case final BloodPressureRecordDto dto:
        return dto.toDomain();
      case final SystolicBloodPressureRecordDto dto:
        return dto.toDomain();
      case final DiastolicBloodPressureRecordDto dto:
        return dto.toDomain();
      case final EnergyNutrientRecordDto dto:
        return dto.toDomain();
      case final CaffeineNutrientRecordDto dto:
        return dto.toDomain();
      case final ProteinNutrientRecordDto dto:
        return dto.toDomain();
      case final TotalCarbohydrateNutrientRecordDto dto:
        return dto.toDomain();
      case final TotalFatNutrientRecordDto dto:
        return dto.toDomain();
      case final SaturatedFatNutrientRecordDto dto:
        return dto.toDomain();
      case final MonounsaturatedFatNutrientRecordDto dto:
        return dto.toDomain();
      case final PolyunsaturatedFatNutrientRecordDto dto:
        return dto.toDomain();
      case final CholesterolNutrientRecordDto dto:
        return dto.toDomain();
      case final DietaryFiberNutrientRecordDto dto:
        return dto.toDomain();
      case final SugarNutrientRecordDto dto:
        return dto.toDomain();
      case final VitaminANutrientRecordDto dto:
        return dto.toDomain();
      case final VitaminB6NutrientRecordDto dto:
        return dto.toDomain();
      case final VitaminB12NutrientRecordDto dto:
        return dto.toDomain();
      case final VitaminCNutrientRecordDto dto:
        return dto.toDomain();
      case final VitaminDNutrientRecordDto dto:
        return dto.toDomain();
      case final VitaminENutrientRecordDto dto:
        return dto.toDomain();
      case final VitaminKNutrientRecordDto dto:
        return dto.toDomain();
      case final ThiaminNutrientRecordDto dto:
        return dto.toDomain();
      case final RiboflavinNutrientRecordDto dto:
        return dto.toDomain();
      case final NiacinNutrientRecordDto dto:
        return dto.toDomain();
      case final FolateNutrientRecordDto dto:
        return dto.toDomain();
      case final BiotinNutrientRecordDto dto:
        return dto.toDomain();
      case final PantothenicAcidNutrientRecordDto dto:
        return dto.toDomain();
      case final CalciumNutrientRecordDto dto:
        return dto.toDomain();
      case final IronNutrientRecordDto dto:
        return dto.toDomain();
      case final MagnesiumNutrientRecordDto dto:
        return dto.toDomain();
      case final ManganeseNutrientRecordDto dto:
        return dto.toDomain();
      case final PhosphorusNutrientRecordDto dto:
        return dto.toDomain();
      case final PotassiumNutrientRecordDto dto:
        return dto.toDomain();
      case final SeleniumNutrientRecordDto dto:
        return dto.toDomain();
      case final SodiumNutrientRecordDto dto:
        return dto.toDomain();
      case final ZincNutrientRecordDto dto:
        return dto.toDomain();
    }
  }
}
