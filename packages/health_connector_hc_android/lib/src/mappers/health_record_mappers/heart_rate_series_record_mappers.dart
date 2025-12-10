import 'package:health_connector_core/health_connector_core.dart'
    show HeartRateSeriesRecord, HealthRecordId;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/heart_rate_measurement_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
    show HeartRateSeriesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateSeriesRecord] to [HeartRateSeriesRecordDto].
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
@internal
extension HeartRateSeriesRecordDtoToDomain on HeartRateSeriesRecordDto {
  HeartRateSeriesRecord toDomain() {
    return HeartRateSeriesRecord(
      id: id?.toHealthRecordId() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      samples: samples.map((s) => s.toDomain()).toList(),
    );
  }
}
