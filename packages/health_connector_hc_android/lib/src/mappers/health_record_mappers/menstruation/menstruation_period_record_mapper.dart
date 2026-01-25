import 'package:health_connector_core/health_connector_core_internal.dart'
    show MenstruationPeriodRecord, HealthRecordId;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show MenstruationPeriodRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [MenstruationPeriodRecord] to [MenstruationPeriodRecordDto].
@internal
extension MenstruationPeriodRecordToDto on MenstruationPeriodRecord {
  MenstruationPeriodRecordDto toDto() {
    return MenstruationPeriodRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
    );
  }
}

/// Converts [MenstruationPeriodRecordDto] to [MenstruationPeriodRecord].
@internal
extension MenstruationPeriodRecordDtoToDomain on MenstruationPeriodRecordDto {
  MenstruationPeriodRecord toDomain() {
    return MenstruationPeriodRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
    );
  }
}
