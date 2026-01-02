import 'package:health_connector_core/health_connector_core_internal.dart'
    show HeartRateSeriesRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/heart_rate_measurement_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HeartRateSeriesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateSeriesRecord] to [HeartRateSeriesRecordDto].
@sinceV1_0_0
@internal
extension HeartRateSeriesRecordToDto on HeartRateSeriesRecord {
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
@sinceV1_0_0
@internal
extension HeartRateSeriesRecordDtoToDomain on HeartRateSeriesRecordDto {
  HeartRateSeriesRecord toDomain() {
    return HeartRateSeriesRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      samples: samples.map((s) => s.toDomain()).toList(),
    );
  }
}
