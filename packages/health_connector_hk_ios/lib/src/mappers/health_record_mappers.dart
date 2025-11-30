import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedRecord,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        DistanceRecord,
        FloorsClimbedRecord,
        HealthRecordId,
        HeartRateMeasurement,
        HeartRateMeasurementRecord,
        HeightRecord,
        HydrationRecord,
        LeanBodyMassRecord,
        StepRecord,
        WeightRecord,
        WheelchairPushesRecord;
import 'package:health_connector_hk_ios/src/mappers/'
    'measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show
        ActiveCaloriesBurnedRecordDto,
        BodyFatPercentageRecordDto,
        BodyTemperatureRecordDto,
        DistanceRecordDto,
        FloorsClimbedRecordDto,
        HeartRateMeasurementDto,
        HeartRateMeasurementRecordDto,
        HeightRecordDto,
        HydrationRecordDto,
        LeanBodyMassRecordDto,
        StepRecordDto,
        WeightRecordDto,
        WheelchairPushesRecordDto;
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

/// Converts [ActiveCaloriesBurnedRecord] to [ActiveCaloriesBurnedRecordDto].
@internal
extension ActiveCaloriesBurnedRecordDomainToDto on ActiveCaloriesBurnedRecord {
  ActiveCaloriesBurnedRecordDto toDto() {
    return ActiveCaloriesBurnedRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      energy: energy.toDto(),
    );
  }
}

/// Converts [ActiveCaloriesBurnedRecordDto] to [ActiveCaloriesBurnedRecord].
@internal
extension ActiveCaloriesBurnedRecordDtoToDomain
    on ActiveCaloriesBurnedRecordDto {
  ActiveCaloriesBurnedRecord toDomain() {
    return ActiveCaloriesBurnedRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      energy: energy.toDomain(),
    );
  }
}

/// Converts [DistanceRecord] to [DistanceRecordDto].
@internal
extension DistanceRecordDomainToDto on DistanceRecord {
  DistanceRecordDto toDto() {
    return DistanceRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      distance: distance.toDto(),
    );
  }
}

/// Converts [DistanceRecordDto] to [DistanceRecord].
@internal
extension DistanceRecordDtoToDomain on DistanceRecordDto {
  DistanceRecord toDomain() {
    return DistanceRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      distance: distance.toDomain(),
    );
  }
}

/// Converts [FloorsClimbedRecord] to [FloorsClimbedRecordDto].
@internal
extension FloorsClimbedRecordDomainToDto on FloorsClimbedRecord {
  FloorsClimbedRecordDto toDto() {
    return FloorsClimbedRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      floors: floors.toDto(),
    );
  }
}

/// Converts [FloorsClimbedRecordDto] to [FloorsClimbedRecord].
@internal
extension FloorsClimbedRecordDtoToDomain on FloorsClimbedRecordDto {
  FloorsClimbedRecord toDomain() {
    return FloorsClimbedRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      floors: floors.toDomain(),
    );
  }
}

/// Converts [StepRecord] to [StepRecordDto].
@internal
extension StepRecordDomainToDto on StepRecord {
  StepRecordDto toDto() {
    return StepRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      count: count.toDto(),
    );
  }
}

/// Converts [StepRecordDto] to [StepRecord].
@internal
extension StepRecordDtoToDomain on StepRecordDto {
  StepRecord toDomain() {
    return StepRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      count: count.toDomain(),
    );
  }
}

/// Converts [WeightRecord] to [WeightRecordDto].
@internal
extension WeightRecordDomainToDto on WeightRecord {
  WeightRecordDto toDto() {
    return WeightRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      weight: weight.toDto(),
    );
  }
}

/// Converts [WeightRecordDto] to [WeightRecord].
@internal
extension WeightRecordDtoToDomain on WeightRecordDto {
  WeightRecord toDomain() {
    return WeightRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      weight: weight.toDomain(),
    );
  }
}

/// Converts [LeanBodyMassRecord] to [LeanBodyMassRecordDto].
@internal
extension LeanBodyMassRecordDomainToDto on LeanBodyMassRecord {
  LeanBodyMassRecordDto toDto() {
    return LeanBodyMassRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      mass: mass.toDto(),
    );
  }
}

/// Converts [LeanBodyMassRecordDto] to [LeanBodyMassRecord].
@internal
extension LeanBodyMassRecordDtoToDomain on LeanBodyMassRecordDto {
  LeanBodyMassRecord toDomain() {
    return LeanBodyMassRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      mass: mass.toDomain(),
    );
  }
}

/// Converts [HeightRecord] to [HeightRecordDto].
@internal
extension HeightRecordDomainToDto on HeightRecord {
  HeightRecordDto toDto() {
    return HeightRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      height: height.toDto(),
    );
  }
}

/// Converts [HeightRecordDto] to [HeightRecord].
@internal
extension HeightRecordDtoToDomain on HeightRecordDto {
  HeightRecord toDomain() {
    return HeightRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      height: height.toDomain(),
    );
  }
}

/// Converts [BodyFatPercentageRecord] to [BodyFatPercentageRecordDto].
@internal
extension BodyFatPercentageRecordDomainToDto on BodyFatPercentageRecord {
  BodyFatPercentageRecordDto toDto() {
    return BodyFatPercentageRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      percentage: percentage.toDto(),
    );
  }
}

/// Converts [BodyFatPercentageRecordDto] to [BodyFatPercentageRecord].
@internal
extension BodyFatPercentageRecordDtoToDomain on BodyFatPercentageRecordDto {
  BodyFatPercentageRecord toDomain() {
    return BodyFatPercentageRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      percentage: percentage.toDomain(),
    );
  }
}

/// Converts [BodyTemperatureRecord] to [BodyTemperatureRecordDto].
@internal
extension BodyTemperatureRecordDomainToDto on BodyTemperatureRecord {
  BodyTemperatureRecordDto toDto() {
    return BodyTemperatureRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      temperature: temperature.toDto(),
    );
  }
}

/// Converts [BodyTemperatureRecordDto] to [BodyTemperatureRecord].
@internal
extension BodyTemperatureRecordDtoToDomain on BodyTemperatureRecordDto {
  BodyTemperatureRecord toDomain() {
    return BodyTemperatureRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      temperature: temperature.toDomain(),
    );
  }
}

/// Converts [WheelchairPushesRecord] to [WheelchairPushesRecordDto].
@internal
extension WheelchairPushesRecordDomainToDto on WheelchairPushesRecord {
  WheelchairPushesRecordDto toDto() {
    return WheelchairPushesRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      pushes: pushes.toDto(),
    );
  }
}

/// Converts [WheelchairPushesRecordDto] to [WheelchairPushesRecord].
@internal
extension WheelchairPushesRecordDtoToDomain on WheelchairPushesRecordDto {
  WheelchairPushesRecord toDomain() {
    return WheelchairPushesRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      pushes: pushes.toDomain(),
    );
  }
}

/// Converts [HydrationRecord] to [HydrationRecordDto].
@internal
extension HydrationRecordDomainToDto on HydrationRecord {
  HydrationRecordDto toDto() {
    return HydrationRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      volume: volume.toDto(),
    );
  }
}

/// Converts [HydrationRecordDto] to [HydrationRecord].
@internal
extension HydrationRecordDtoToDomain on HydrationRecordDto {
  HydrationRecord toDomain() {
    return HydrationRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      volume: volume.toDomain(),
    );
  }
}

/// Converts [HeartRateMeasurement] to [HeartRateMeasurementDto].
@internal
extension HeartRateMeasurementDomainToDto on HeartRateMeasurement {
  HeartRateMeasurementDto toDto() {
    return HeartRateMeasurementDto(
      time: time.millisecondsSinceEpoch,
      beatsPerMinute: beatsPerMinute.toDto(),
    );
  }
}

/// Converts [HeartRateMeasurementDto] to [HeartRateMeasurement].
@internal
extension HeartRateMeasurementDtoToDomain on HeartRateMeasurementDto {
  HeartRateMeasurement toDomain() {
    return HeartRateMeasurement(
      time: DateTime.fromMillisecondsSinceEpoch(time),
      beatsPerMinute: beatsPerMinute.toDomain(),
    );
  }
}

/// Converts [HeartRateMeasurementRecord] to [HeartRateMeasurementRecordDto].
@internal
extension HeartRateMeasurementRecordDomainToDto on HeartRateMeasurementRecord {
  HeartRateMeasurementRecordDto toDto() {
    return HeartRateMeasurementRecordDto(
      id: id.toDto(),
      time: measurement.time.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      measurement: measurement.toDto(),
    );
  }
}

/// Converts [HeartRateMeasurementRecordDto] to [HeartRateMeasurementRecord].
@internal
extension HeartRateMeasurementRecordDtoToDomain
    on HeartRateMeasurementRecordDto {
  HeartRateMeasurementRecord toDomain() {
    return HeartRateMeasurementRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      measurement: measurement.toDomain(),
    );
  }
}
