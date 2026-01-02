import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, PowerSeriesRecord, PowerMeasurement, sinceV2_1_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show PowerSeriesRecordDto, PowerMeasurementDto;
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
      samples: samples.map((sample) => sample._toDto()).toList(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [PowerMeasurement] to [PowerMeasurementDto].
extension _PowerSampleToDto on PowerMeasurement {
  PowerMeasurementDto _toDto() {
    return PowerMeasurementDto(
      time: time.millisecondsSinceEpoch,
      power: power.toDto(),
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
      samples: samples.map((dto) => dto._toDomain()).toList(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [PowerMeasurementDto] to [PowerMeasurement].
extension _PowerSampleDtoToDomain on PowerMeasurementDto {
  PowerMeasurement _toDomain() {
    return PowerMeasurement(
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      power: power.toDomain(),
    );
  }
}
