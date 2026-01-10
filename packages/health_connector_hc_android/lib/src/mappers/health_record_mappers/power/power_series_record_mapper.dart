import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, PowerSeriesRecord, sinceV2_1_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/power/power_sample_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show PowerSeriesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PowerSeriesRecord] to [PowerSeriesRecordDto].
@sinceV2_1_0
@internal
extension PowerSeriesRecordToDto on PowerSeriesRecord {
  /// Converts this power record to a DTO for platform transfer.
  PowerSeriesRecordDto toDto() {
    return PowerSeriesRecordDto(
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

/// Converts [PowerSeriesRecordDto] to [PowerSeriesRecord].
@sinceV2_1_0
@internal
extension PowerSeriesRecordDtoToDomain on PowerSeriesRecordDto {
  /// Converts this DTO to a power record.
  PowerSeriesRecord toDomain() {
    return PowerSeriesRecord(
      id: id == null ? HealthRecordId.none : HealthRecordId(id!),
      startTime: DateTime.fromMillisecondsSinceEpoch(
        startTime,
        isUtc: true,
      ),
      endTime: DateTime.fromMillisecondsSinceEpoch(
        endTime,
        isUtc: true,
      ),
      metadata: metadata.toDomain(),
      samples: samples.map((dto) => dto.toDomain()).toList(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
