import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [EnvironmentalAudioExposureRecord] to
/// [EnvironmentalAudioExposureRecordDto].
@sinceV3_6_0
@internal
extension EnvironmentalAudioExposureRecordToDto
    on EnvironmentalAudioExposureRecord {
  EnvironmentalAudioExposureRecordDto toDto() {
    return EnvironmentalAudioExposureRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      aWeightedDecibel: aWeightedDecibel.value.toDouble(),
    );
  }
}

/// Converts [EnvironmentalAudioExposureRecordDto] to
/// [EnvironmentalAudioExposureRecord].
@sinceV3_6_0
@internal
extension EnvironmentalAudioExposureRecordDtoToDomain
    on EnvironmentalAudioExposureRecordDto {
  EnvironmentalAudioExposureRecord toDomain() {
    return EnvironmentalAudioExposureRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      aWeightedDecibel: Number(aWeightedDecibel),
    );
  }
}
