import 'package:health_connector_core/health_connector_core_internal.dart'
    show HeartbeatSample, HeartbeatSeriesRecord, HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HeartbeatSampleDto, HeartbeatSeriesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartbeatSeriesRecord] to [HeartbeatSeriesRecordDto].
@internal
extension HeartbeatSeriesRecordToDto on HeartbeatSeriesRecord {
  HeartbeatSeriesRecordDto toDto() {
    return HeartbeatSeriesRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      samples: samples.map((sample) => sample.toDto()).toList(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [HeartbeatSeriesRecordDto] to [HeartbeatSeriesRecord].
@internal
extension HeartbeatSeriesRecordDtoToDomain on HeartbeatSeriesRecordDto {
  HeartbeatSeriesRecord toDomain() {
    return HeartbeatSeriesRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(
        startTime,
        isUtc: true,
      ),
      endTime: DateTime.fromMillisecondsSinceEpoch(
        endTime,
        isUtc: true,
      ),
      metadata: metadata.toDomain(),
      samples: samples.map((sample) => sample.toDomain()).toList(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [HeartbeatSample] to [HeartbeatSampleDto].
@internal
extension HeartbeatSampleToDto on HeartbeatSample {
  HeartbeatSampleDto toDto() {
    return HeartbeatSampleDto(
      offsetMilliseconds: timeSinceSeriesStart.inMilliseconds,
      precededByGap: precededByGap,
    );
  }
}

/// Converts [HeartbeatSampleDto] to [HeartbeatSample].
@internal
extension HeartbeatSampleDtoToDomain on HeartbeatSampleDto {
  HeartbeatSample toDomain() {
    return HeartbeatSample(
      timeSinceSeriesStart: Duration(milliseconds: offsetMilliseconds),
      precededByGap: precededByGap,
    );
  }
}
