import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthRecordId,
        SkinTemperatureDeltaSeriesRecord,
        SkinTemperatureMeasurementLocation,
        Temperature;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/temperature/skin_temperature_delta_sample_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/temperature/skin_temperature_measurement_location_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SkinTemperatureDeltaSeriesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SkinTemperatureDeltaSeriesRecord] to
/// [SkinTemperatureDeltaSeriesRecordDto].
@internal
extension SkinTemperatureDeltaSeriesRecordToDto
    on SkinTemperatureDeltaSeriesRecord {
  SkinTemperatureDeltaSeriesRecordDto toDto() {
    return SkinTemperatureDeltaSeriesRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      samples: samples.map((sample) => sample.toDto()).toList(),
      baselineCelsius: baseline?.inCelsius,
      measurementLocation: measurementLocation.toDto(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [SkinTemperatureDeltaSeriesRecordDto] to
/// [SkinTemperatureDeltaSeriesRecord].
@internal
extension SkinTemperatureDeltaSeriesRecordDtoToDomain
    on SkinTemperatureDeltaSeriesRecordDto {
  SkinTemperatureDeltaSeriesRecord toDomain() {
    return SkinTemperatureDeltaSeriesRecord.internal(
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
      baseline: baselineCelsius != null
          ? Temperature.celsius(baselineCelsius!)
          : null,
      measurementLocation:
          measurementLocation?.toDomain() ??
          SkinTemperatureMeasurementLocation.unknown,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
