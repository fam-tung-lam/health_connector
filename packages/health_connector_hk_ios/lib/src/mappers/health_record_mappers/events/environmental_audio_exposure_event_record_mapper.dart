import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to map [EnvironmentalAudioExposureEventRecordDto] to
/// [EnvironmentalAudioExposureEventRecord].
@internal
extension EnvironmentalAudioExposureEventRecordDtoToDomain
    on EnvironmentalAudioExposureEventRecordDto {
  EnvironmentalAudioExposureEventRecord toDomain() {
    return EnvironmentalAudioExposureEventRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      aWeightedDecibel: aWeightedDecibel == null
          ? null
          : Number(aWeightedDecibel!),
      metadata: metadata.toDomain(),
    );
  }
}
