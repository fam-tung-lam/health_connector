import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        CrossCountrySkiingDistanceRecord,
        CyclingDistanceRecord,
        DistanceActivityRecord,
        DownhillSnowSportsDistanceRecord,
        HealthRecordId,
        PaddleSportsDistanceRecord,
        RowingDistanceRecord,
        SixMinuteWalkTestDistanceRecord,
        SkatingSportsDistanceRecord,
        SwimmingDistanceRecord,
        WheelchairDistanceRecord,
        sinceV2_0_0,
        WalkingRunningDistanceRecord;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DistanceActivityRecordDto, DistanceActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DistanceActivityRecord] subclasses to [DistanceActivityRecordDto].
@sinceV2_0_0
@internal
extension DistanceActivityRecordToDto on DistanceActivityRecord {
  DistanceActivityRecordDto toDto() {
    final record = this;
    return DistanceActivityRecordDto(
      id: record.id.toDto(),
      startTime: record.startTime.millisecondsSinceEpoch,
      endTime: record.endTime.millisecondsSinceEpoch,
      zoneOffsetSeconds: record.startZoneOffsetSeconds,
      metadata: record.metadata.toDto(),
      distance: record.distance.toDto(),
      activityType: switch (record) {
        CyclingDistanceRecord() => DistanceActivityTypeDto.cycling,
        SwimmingDistanceRecord() => DistanceActivityTypeDto.swimming,
        WheelchairDistanceRecord() => DistanceActivityTypeDto.wheelchair,
        DownhillSnowSportsDistanceRecord() =>
          DistanceActivityTypeDto.downhillSnowSports,
        RowingDistanceRecord() => DistanceActivityTypeDto.rowing,
        PaddleSportsDistanceRecord() => DistanceActivityTypeDto.paddleSports,
        CrossCountrySkiingDistanceRecord() =>
          DistanceActivityTypeDto.crossCountrySkiing,
        SkatingSportsDistanceRecord() => DistanceActivityTypeDto.skatingSports,
        SixMinuteWalkTestDistanceRecord() =>
          DistanceActivityTypeDto.sixMinuteWalkTest,
        WalkingRunningDistanceRecord() =>
          DistanceActivityTypeDto.walkingRunning,
      },
    );
  }
}

/// Converts [DistanceActivityRecordDto] to correct [DistanceActivityRecord].
@sinceV2_0_0
@internal
extension DistanceActivityRecordDtoToDomain on DistanceActivityRecordDto {
  DistanceActivityRecord toDomain() {
    final recordId = id?.toDomain() ?? HealthRecordId.none;
    final start = DateTime.fromMillisecondsSinceEpoch(startTime);
    final end = DateTime.fromMillisecondsSinceEpoch(endTime);
    final meta = metadata.toDomain();
    final dist = distance.toDomain();
    final zoneOffset = zoneOffsetSeconds;

    return switch (activityType) {
      DistanceActivityTypeDto.cycling => CyclingDistanceRecord(
        id: recordId,
        startTime: start,
        endTime: end,
        startZoneOffsetSeconds: zoneOffset,
        endZoneOffsetSeconds: zoneOffset,
        metadata: meta,
        distance: dist,
      ),
      DistanceActivityTypeDto.swimming => SwimmingDistanceRecord(
        id: recordId,
        startTime: start,
        endTime: end,
        startZoneOffsetSeconds: zoneOffset,
        endZoneOffsetSeconds: zoneOffset,
        metadata: meta,
        distance: dist,
      ),
      DistanceActivityTypeDto.wheelchair => WheelchairDistanceRecord(
        id: recordId,
        startTime: start,
        endTime: end,
        startZoneOffsetSeconds: zoneOffset,
        endZoneOffsetSeconds: zoneOffset,
        metadata: meta,
        distance: dist,
      ),
      DistanceActivityTypeDto.downhillSnowSports =>
        DownhillSnowSportsDistanceRecord(
          id: recordId,
          startTime: start,
          endTime: end,
          startZoneOffsetSeconds: zoneOffset,
          endZoneOffsetSeconds: zoneOffset,
          metadata: meta,
          distance: dist,
        ),
      DistanceActivityTypeDto.rowing => RowingDistanceRecord(
        id: recordId,
        startTime: start,
        endTime: end,
        startZoneOffsetSeconds: zoneOffset,
        endZoneOffsetSeconds: zoneOffset,
        metadata: meta,
        distance: dist,
      ),
      DistanceActivityTypeDto.paddleSports => PaddleSportsDistanceRecord(
        id: recordId,
        startTime: start,
        endTime: end,
        startZoneOffsetSeconds: zoneOffset,
        endZoneOffsetSeconds: zoneOffset,
        metadata: meta,
        distance: dist,
      ),
      DistanceActivityTypeDto.crossCountrySkiing =>
        CrossCountrySkiingDistanceRecord(
          id: recordId,
          startTime: start,
          endTime: end,
          startZoneOffsetSeconds: zoneOffset,
          endZoneOffsetSeconds: zoneOffset,
          metadata: meta,
          distance: dist,
        ),
      DistanceActivityTypeDto.skatingSports => SkatingSportsDistanceRecord(
        id: recordId,
        startTime: start,
        endTime: end,
        startZoneOffsetSeconds: zoneOffset,
        endZoneOffsetSeconds: zoneOffset,
        metadata: meta,
        distance: dist,
      ),
      DistanceActivityTypeDto.sixMinuteWalkTest =>
        SixMinuteWalkTestDistanceRecord(
          id: recordId,
          startTime: start,
          endTime: end,
          startZoneOffsetSeconds: zoneOffset,
          endZoneOffsetSeconds: zoneOffset,
          metadata: meta,
          distance: dist,
        ),
      DistanceActivityTypeDto.walkingRunning => WalkingRunningDistanceRecord(
        id: recordId,
        startTime: start,
        endTime: end,
        startZoneOffsetSeconds: zoneOffset,
        endZoneOffsetSeconds: zoneOffset,
        metadata: meta,
        distance: dist,
      ),
    };
  }
}
