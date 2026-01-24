import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [HeadphoneAudioExposureRecord] to
/// [HeadphoneAudioExposureRecordDto].
@sinceV3_6_0
@internal
extension HeadphoneAudioExposureRecordToDto on HeadphoneAudioExposureRecord {
  HeadphoneAudioExposureRecordDto toDto() {
    return HeadphoneAudioExposureRecordDto(
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

/// Converts [HeadphoneAudioExposureRecordDto] to
/// [HeadphoneAudioExposureRecord].
@sinceV3_6_0
@internal
extension HeadphoneAudioExposureRecordDtoToDomain
    on HeadphoneAudioExposureRecordDto {
  HeadphoneAudioExposureRecord toDomain() {
    return HeadphoneAudioExposureRecord.internal(
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
