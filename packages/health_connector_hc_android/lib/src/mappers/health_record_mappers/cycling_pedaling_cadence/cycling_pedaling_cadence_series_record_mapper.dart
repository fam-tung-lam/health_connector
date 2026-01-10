import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        CyclingPedalingCadenceSeriesRecord,
        HealthRecordId,
        sinceV2_2_0,
        DateTimeToDto;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/cycling_pedaling_cadence/cycling_pedaling_cadence_sample_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show CyclingPedalingCadenceSeriesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [CyclingPedalingCadenceSeriesRecord] to
/// [CyclingPedalingCadenceSeriesRecordDto].
@sinceV2_2_0
@internal
extension CyclingPedalingCadenceSeriesRecordToDto
    on CyclingPedalingCadenceSeriesRecord {
  CyclingPedalingCadenceSeriesRecordDto toDto() {
    return CyclingPedalingCadenceSeriesRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.resolveZoneOffsetSeconds(
        startZoneOffsetSeconds,
      ),
      endZoneOffsetSeconds: endTime.resolveZoneOffsetSeconds(
        endZoneOffsetSeconds,
      ),
      metadata: metadata.toDto(),
      samples: samples.map((s) => s.toDto()).toList(),
    );
  }
}

/// Converts [CyclingPedalingCadenceSeriesRecordDto] to
/// [CyclingPedalingCadenceSeriesRecord].
@sinceV2_2_0
@internal
extension CyclingPedalingCadenceSeriesRecordDtoToDomain
    on CyclingPedalingCadenceSeriesRecordDto {
  CyclingPedalingCadenceSeriesRecord toDomain() {
    return CyclingPedalingCadenceSeriesRecord.internal(
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
