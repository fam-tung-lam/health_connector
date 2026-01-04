import 'package:health_connector_core/health_connector_core_internal.dart'
    show HeartRateVariabilitySDNNRecord, HealthRecordId, Number, sinceV2_2_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HeartRateVariabilitySDNNRecordDto, NumberDto;
import 'package:meta/meta.dart' show internal;

@sinceV2_2_0
@internal
extension HeartRateVariabilitySDNNRecordToDto
    on HeartRateVariabilitySDNNRecord {
  HeartRateVariabilitySDNNRecordDto toDto() {
    return HeartRateVariabilitySDNNRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      heartRateVariabilitySDNN: NumberDto(
        value: heartRateVariabilitySDNN.value.toDouble(),
      ),
    );
  }
}

@sinceV2_2_0
@internal
extension HeartRateVariabilitySDNNRecordDtoToDomain
    on HeartRateVariabilitySDNNRecordDto {
  HeartRateVariabilitySDNNRecord toDomain() {
    return HeartRateVariabilitySDNNRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      heartRateVariabilitySDNN: Number(heartRateVariabilitySDNN.value),
    );
  }
}
