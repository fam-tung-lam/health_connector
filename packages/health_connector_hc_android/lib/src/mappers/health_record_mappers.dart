import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedRecord,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        DistanceRecord,
        FloorsClimbedRecord,
        HealthRecordId,
        HeartRateMeasurement,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        LeanBodyMassRecord,
        StepRecord,
        WeightRecord,
        WheelchairPushesRecord;
import 'package:health_connector_hc_android/src/mappers/'
    'measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
    show
        ActiveCaloriesBurnedRecordDto,
        BodyFatPercentageRecordDto,
        BodyTemperatureRecordDto,
        DistanceRecordDto,
        FloorsClimbedRecordDto,
        HeartRateMeasurementDto,
        HeartRateSeriesRecordDto,
        HeightRecordDto,
        HydrationRecordDto,
        LeanBodyMassRecordDto,
        StepRecordDto,
        WeightRecordDto,
        WheelchairPushesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthRecordId] to [String] for DTO transfer.
@internal
extension HealthRecordIdToString on HealthRecordId {
  String toDto() => value;
}

/// Converts [String] to [HealthRecordId].
@internal
extension StringToHealthRecordId on String {
  HealthRecordId toHealthRecordId() {
    if (this == HealthRecordId.none.value) {
      return HealthRecordId.none;
    }
    return HealthRecordId(this);
  }
}

/// Converts [ActiveCaloriesBurnedRecord] to [ActiveCaloriesBurnedRecordDto].
@internal
extension ActiveCaloriesBurnedRecordDtoMapper on ActiveCaloriesBurnedRecord {
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
      id: id.toHealthRecordId(),
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
extension DistanceRecordDtoMapper on DistanceRecord {
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
      id: id.toHealthRecordId(),
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
extension FloorsClimbedRecordDtoMapper on FloorsClimbedRecord {
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
      id: id.toHealthRecordId(),
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
extension StepRecordDtoMapper on StepRecord {
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
      id: id.toHealthRecordId(),
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
extension WeightRecordDtoMapper on WeightRecord {
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
      id: id.toHealthRecordId(),
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      weight: weight.toDomain(),
    );
  }
}

/// Converts [LeanBodyMassRecord] to [LeanBodyMassRecordDto].
@internal
extension LeanBodyMassRecordDtoMapper on LeanBodyMassRecord {
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
      id: id.toHealthRecordId(),
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      mass: mass.toDomain(),
    );
  }
}

/// Converts [HeightRecord] to [HeightRecordDto].
@internal
extension HeightRecordDtoMapper on HeightRecord {
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
      id: id.toHealthRecordId(),
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      height: height.toDomain(),
    );
  }
}

/// Converts [BodyFatPercentageRecord] to [BodyFatPercentageRecordDto].
@internal
extension BodyFatPercentageRecordDtoMapper on BodyFatPercentageRecord {
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
      id: id.toHealthRecordId(),
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      percentage: percentage.toDomain(),
    );
  }
}

/// Converts [BodyTemperatureRecord] to [BodyTemperatureRecordDto].
@internal
extension BodyTemperatureRecordDtoMapper on BodyTemperatureRecord {
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
      id: id.toHealthRecordId(),
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      temperature: temperature.toDomain(),
    );
  }
}

/// Converts [WheelchairPushesRecord] to [WheelchairPushesRecordDto].
@internal
extension WheelchairPushesRecordDtoMapper on WheelchairPushesRecord {
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
      id: id.toHealthRecordId(),
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
extension HydrationRecordDtoMapper on HydrationRecord {
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
      id: id.toHealthRecordId(),
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
extension HeartRateMeasurementDtoMapper on HeartRateMeasurement {
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

/// Converts [HeartRateSeriesRecord] to [HeartRateSeriesRecordDto].
@internal
extension HeartRateSeriesRecordDtoMapper on HeartRateSeriesRecord {
  HeartRateSeriesRecordDto toDto() {
    return HeartRateSeriesRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      samples: samples.map((s) => s.toDto()).toList(),
    );
  }
}

/// Converts [HeartRateSeriesRecordDto] to [HeartRateSeriesRecord].
@internal
extension HeartRateSeriesRecordDtoToDomain on HeartRateSeriesRecordDto {
  HeartRateSeriesRecord toDomain() {
    return HeartRateSeriesRecord(
      id: id.toHealthRecordId(),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      samples: samples.map((s) => s.toDomain()).toList(),
    );
  }
}
