import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, SpeedSeriesRecord, SpeedMeasurement, sinceV2_0_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SpeedSeriesRecordDto, SpeedMeasurementDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SpeedSeriesRecord] to [SpeedSeriesRecordDto].
@sinceV2_0_0
@internal
extension SpeedSeriesRecordToDto on SpeedSeriesRecord {
  /// Converts this speed record to a DTO for platform transfer.
  SpeedSeriesRecordDto toDto() {
    return SpeedSeriesRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      samples: samples.map((sample) => sample._toDto()).toList(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [SpeedMeasurement] to [SpeedMeasurementDto].
extension _SpeedSampleToDto on SpeedMeasurement {
  SpeedMeasurementDto _toDto() {
    return SpeedMeasurementDto(
      time: time.millisecondsSinceEpoch,
      speed: speed.toDto(),
    );
  }
}

/// Converts [SpeedSeriesRecordDto] to [SpeedSeriesRecord].
@sinceV2_0_0
@internal
extension SpeedSeriesRecordDtoToDomain on SpeedSeriesRecordDto {
  /// Converts this DTO to a speed record.
  SpeedSeriesRecord toDomain() {
    return SpeedSeriesRecord(
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
      samples: samples.map((dto) => dto._toDomain()).toList(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [SpeedMeasurementDto] to [SpeedMeasurement].
extension _SpeedSampleDtoToDomain on SpeedMeasurementDto {
  SpeedMeasurement _toDomain() {
    return SpeedMeasurement(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      speed: speed.toDomain(),
    );
  }
}
