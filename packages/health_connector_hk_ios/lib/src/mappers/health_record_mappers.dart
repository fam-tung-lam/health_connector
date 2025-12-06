import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedRecord,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        DistanceRecord,
        Energy,
        FloorsClimbedRecord,
        HealthRecord,
        HealthRecordId,
        HeartRateMeasurement,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        LeanBodyMassRecord,
        Length,
        Mass,
        Numeric,
        Percentage,
        SleepSessionRecord,
        SleepStageRecord,
        StepRecord,
        Temperature,
        Volume,
        WeightRecord,
        WheelchairPushesRecord,
        SleepStageType,
        CaffeineNutrientRecord,
        NutritionRecord,
        EnergyNutrientRecord,
        ProteinNutrientRecord,
        TotalCarbohydrateNutrientRecord,
        TotalFatNutrientRecord,
        SaturatedFatNutrientRecord,
        MonounsaturatedFatNutrientRecord,
        PolyunsaturatedFatNutrientRecord,
        CholesterolNutrientRecord,
        DietaryFiberNutrientRecord,
        SugarNutrientRecord,
        CalciumNutrientRecord,
        IronNutrientRecord,
        MagnesiumNutrientRecord,
        ManganeseNutrientRecord,
        PhosphorusNutrientRecord,
        PotassiumNutrientRecord,
        SeleniumNutrientRecord,
        SodiumNutrientRecord,
        ZincNutrientRecord,
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
        PantothenicAcidNutrientRecord;
import 'package:health_connector_hk_ios/src/mappers/'
    'measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show
        ActiveCaloriesBurnedRecordDto,
        BodyFatPercentageRecordDto,
        BodyTemperatureRecordDto,
        DistanceRecordDto,
        EnergyDto,
        FloorsClimbedRecordDto,
        HealthRecordDto,
        HeartRateMeasurementDto,
        HeartRateMeasurementRecordDto,
        HeightRecordDto,
        HydrationRecordDto,
        LeanBodyMassRecordDto,
        LengthDto,
        MassDto,
        NumericDto,
        PercentageDto,
        SleepStageRecordDto,
        StepRecordDto,
        TemperatureDto,
        VolumeDto,
        WeightRecordDto,
        WheelchairPushesRecordDto,
        SleepStageTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthRecordId] to [String] for DTO transfer.
@internal
extension HealthRecordIdFromDomainToDto on HealthRecordId {
  String toDto() => value;
}

/// Converts [String] to [HealthRecordId].
@internal
extension HealthRecordIdFromDtoToDomain on String {
  HealthRecordId toDomain() {
    if (this == HealthRecordId.none.value) {
      return HealthRecordId.none;
    }
    return HealthRecordId(this);
  }
}

/// Converts [HeartRateMeasurement] to [HeartRateMeasurementDto].
@internal
extension HeartRateMeasurementDomainToDto on HeartRateMeasurement {
  HeartRateMeasurementDto toDto() {
    return HeartRateMeasurementDto(
      time: time.millisecondsSinceEpoch,
      beatsPerMinute: beatsPerMinute.toDto() as NumericDto,
    );
  }
}

/// Converts [HeartRateMeasurementDto] to [HeartRateMeasurement].
@internal
extension HeartRateMeasurementDtoToDomain on HeartRateMeasurementDto {
  HeartRateMeasurement toDomain() {
    return HeartRateMeasurement(
      time: DateTime.fromMillisecondsSinceEpoch(time),
      beatsPerMinute: beatsPerMinute.toDomain() as Numeric,
    );
  }
}

/// Converts [HealthRecord] to [HealthRecordDto].
@internal
extension HealthRecordToDto on HealthRecord {
  HealthRecordDto toDto() {
    switch (this) {
      case final ActiveCaloriesBurnedRecord record:
        return ActiveCaloriesBurnedRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds:
              record.startZoneOffsetSeconds ?? record.endZoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          energy: record.energy.toDto() as EnergyDto,
        );
      case final DistanceRecord record:
        return DistanceRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.startZoneOffsetSeconds,

          metadata: record.metadata.toDto(),
          distance: record.distance.toDto() as LengthDto,
        );
      case final FloorsClimbedRecord record:
        return FloorsClimbedRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.startZoneOffsetSeconds,

          metadata: record.metadata.toDto(),
          floors: record.floors.toDto() as NumericDto,
        );
      case final StepRecord record:
        return StepRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.startZoneOffsetSeconds,

          metadata: record.metadata.toDto(),
          count: record.count.toDto() as NumericDto,
        );
      case final WeightRecord record:
        return WeightRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          weight: record.weight.toDto() as MassDto,
        );
      case final LeanBodyMassRecord record:
        return LeanBodyMassRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          mass: record.mass.toDto() as MassDto,
        );
      case final HeightRecord record:
        return HeightRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          height: record.height.toDto() as LengthDto,
        );
      case final BodyFatPercentageRecord record:
        return BodyFatPercentageRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          percentage: record.percentage.toDto() as PercentageDto,
        );
      case final BodyTemperatureRecord record:
        return BodyTemperatureRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          temperature: record.temperature.toDto() as TemperatureDto,
        );
      case final HydrationRecord record:
        return HydrationRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.startZoneOffsetSeconds,

          metadata: record.metadata.toDto(),
          volume: record.volume.toDto() as VolumeDto,
        );
      case final WheelchairPushesRecord record:
        return WheelchairPushesRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.startZoneOffsetSeconds,

          metadata: record.metadata.toDto(),
          pushes: record.pushes.toDto() as NumericDto,
        );
      case final HeartRateMeasurementRecord record:
        return HeartRateMeasurementRecordDto(
          id: record.id.toDto(),
          time: record.measurement.time.millisecondsSinceEpoch,
          metadata: record.metadata.toDto(),
          measurement: record.measurement.toDto(),
        );
      case final SleepStageRecord record:
        return SleepStageRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          metadata: metadata.toDto(),
          stageType: record.stageType.toDto(),
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
        );
      case NutritionRecord _:
        throw UnimplementedError();
      case EnergyNutrientRecord _:
        throw UnimplementedError();
      case CaffeineNutrientRecord _:
        throw UnimplementedError();
      case ProteinNutrientRecord _:
        throw UnimplementedError();
      case TotalCarbohydrateNutrientRecord _:
        throw UnimplementedError();
      case TotalFatNutrientRecord _:
        throw UnimplementedError();
      case SaturatedFatNutrientRecord _:
        throw UnimplementedError();
      case MonounsaturatedFatNutrientRecord _:
        throw UnimplementedError();
      case PolyunsaturatedFatNutrientRecord _:
        throw UnimplementedError();
      case CholesterolNutrientRecord _:
        throw UnimplementedError();
      case DietaryFiberNutrientRecord _:
        throw UnimplementedError();
      case SugarNutrientRecord _:
        throw UnimplementedError();
      case CalciumNutrientRecord _:
        throw UnimplementedError();
      case IronNutrientRecord _:
        throw UnimplementedError();
      case MagnesiumNutrientRecord _:
        throw UnimplementedError();
      case ManganeseNutrientRecord _:
        throw UnimplementedError();
      case PhosphorusNutrientRecord _:
        throw UnimplementedError();
      case PotassiumNutrientRecord _:
        throw UnimplementedError();
      case SeleniumNutrientRecord _:
        throw UnimplementedError();
      case SodiumNutrientRecord _:
        throw UnimplementedError();
      case ZincNutrientRecord _:
        throw UnimplementedError();
      case VitaminANutrientRecord _:
        throw UnimplementedError();
      case VitaminB6NutrientRecord _:
        throw UnimplementedError();
      case VitaminB12NutrientRecord _:
        throw UnimplementedError();
      case VitaminCNutrientRecord _:
        throw UnimplementedError();
      case VitaminDNutrientRecord _:
        throw UnimplementedError();
      case VitaminENutrientRecord _:
        throw UnimplementedError();
      case VitaminKNutrientRecord _:
        throw UnimplementedError();
      case ThiaminNutrientRecord _:
        throw UnimplementedError();
      case RiboflavinNutrientRecord _:
        throw UnimplementedError();
      case NiacinNutrientRecord _:
        throw UnimplementedError();
      case FolateNutrientRecord _:
        throw UnimplementedError();
      case BiotinNutrientRecord _:
        throw UnimplementedError();
      case PantothenicAcidNutrientRecord _:
        throw UnimplementedError();
      case final SleepSessionRecord _:
        throw UnsupportedError(
          'SleepSessionRecord is not supported on iOS. '
          'Use SleepStageRecord instead.',
        );
      case final HeartRateSeriesRecord _:
        throw UnsupportedError(
          'HeartRateSeriesRecord is not supported on iOS. '
          'Use HeartRateMeasurementRecord instead.',
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
        return ActiveCaloriesBurnedRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          energy: dto.energy.toDomain() as Energy,
        );
      case final DistanceRecordDto dto:
        return DistanceRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          distance: dto.distance.toDomain() as Length,
        );
      case final FloorsClimbedRecordDto dto:
        return FloorsClimbedRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          floors: dto.floors.toDomain() as Numeric,
        );
      case final StepRecordDto dto:
        return StepRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          count: dto.count.toDomain() as Numeric,
        );
      case final WeightRecordDto dto:
        return WeightRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          weight: dto.weight.toDomain() as Mass,
        );
      case final LeanBodyMassRecordDto dto:
        return LeanBodyMassRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          mass: dto.mass.toDomain() as Mass,
        );
      case final HeightRecordDto dto:
        return HeightRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          height: dto.height.toDomain() as Length,
        );
      case final BodyFatPercentageRecordDto dto:
        return BodyFatPercentageRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          percentage: dto.percentage.toDomain() as Percentage,
        );
      case final BodyTemperatureRecordDto dto:
        return BodyTemperatureRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          temperature: dto.temperature.toDomain() as Temperature,
        );
      case final HydrationRecordDto dto:
        return HydrationRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          volume: dto.volume.toDomain() as Volume,
        );
      case final WheelchairPushesRecordDto dto:
        return WheelchairPushesRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          pushes: dto.pushes.toDomain() as Numeric,
        );
      case final HeartRateMeasurementRecordDto dto:
        return HeartRateMeasurementRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          metadata: dto.metadata.toDomain(),
          measurement: dto.measurement.toDomain(),
        );
      case final SleepStageRecordDto dto:
        return SleepStageRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          metadata: dto.metadata.toDomain(),
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          stageType: dto.stageType.toDomain(),
        );
    }
  }
}

extension SleepStageTypeDomainToDto on SleepStageType {
  SleepStageTypeDto toDto() {
    return switch (this) {
      SleepStageType.unknown => SleepStageTypeDto.unknown,
      SleepStageType.awake => SleepStageTypeDto.awake,
      SleepStageType.sleeping => SleepStageTypeDto.sleeping,
      SleepStageType.outOfBed => SleepStageTypeDto.outOfBed,
      SleepStageType.light => SleepStageTypeDto.light,
      SleepStageType.deep => SleepStageTypeDto.deep,
      SleepStageType.rem => SleepStageTypeDto.rem,
      SleepStageType.inBed => SleepStageTypeDto.inBed,
    };
  }
}

extension SleepStageTypeDtoToDomain on SleepStageTypeDto {
  SleepStageType toDomain() {
    return switch (this) {
      SleepStageTypeDto.unknown => SleepStageType.unknown,
      SleepStageTypeDto.awake => SleepStageType.awake,
      SleepStageTypeDto.sleeping => SleepStageType.sleeping,
      SleepStageTypeDto.outOfBed => SleepStageType.outOfBed,
      SleepStageTypeDto.light => SleepStageType.light,
      SleepStageTypeDto.deep => SleepStageType.deep,
      SleepStageTypeDto.rem => SleepStageType.rem,
      SleepStageTypeDto.inBed => SleepStageType.inBed,
    };
  }
}
