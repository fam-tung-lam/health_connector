import 'package:health_connector_core/health_connector_core_internal.dart'
    show BodyFatPercentageRecord, HealthRecordId, Percentage, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BodyFatPercentageRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BodyFatPercentageRecord] to [BodyFatPercentageRecordDto].
@sinceV1_0_0
@internal
extension BodyFatPercentageRecordToDto on BodyFatPercentageRecord {
  BodyFatPercentageRecordDto toDto() {
    return BodyFatPercentageRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      percentage: percentage.asDecimal,
    );
  }
}

/// Converts [BodyFatPercentageRecordDto] to [BodyFatPercentageRecord].
@sinceV1_0_0
@internal
extension BodyFatPercentageRecordDtoToDomain on BodyFatPercentageRecordDto {
  BodyFatPercentageRecord toDomain() {
    return BodyFatPercentageRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      percentage: Percentage.fromDecimal(percentage),
    );
  }
}
