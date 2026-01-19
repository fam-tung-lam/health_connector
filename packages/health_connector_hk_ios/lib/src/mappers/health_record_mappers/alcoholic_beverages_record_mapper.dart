import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        Number,
        AlcoholicBeveragesRecord,
        HealthRecordId,
        DateTimeToDto;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show AlcoholicBeveragesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [AlcoholicBeveragesRecord] to [AlcoholicBeveragesRecordDto].
@internal
extension AlcoholicBeveragesRecordToDto on AlcoholicBeveragesRecord {
  AlcoholicBeveragesRecordDto toDto() {
    return AlcoholicBeveragesRecordDto(
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
      count: count.value.toDouble(),
    );
  }
}

/// Converts [AlcoholicBeveragesRecordDto] to [AlcoholicBeveragesRecord].
@internal
extension AlcoholicBeveragesRecordDtoToDomain on AlcoholicBeveragesRecordDto {
  AlcoholicBeveragesRecord toDomain() {
    return AlcoholicBeveragesRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      count: Number(count),
    );
  }
}
