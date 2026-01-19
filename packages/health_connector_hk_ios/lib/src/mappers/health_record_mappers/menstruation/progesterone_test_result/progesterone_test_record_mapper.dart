import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/progesterone_test_result/progesterone_test_result_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [ProgesteroneTestRecord] to
/// [ProgesteroneTestRecordDto].
@internal
extension ProgesteroneTestRecordToDto on ProgesteroneTestRecord {
  /// Converts [ProgesteroneTestRecord] to [ProgesteroneTestRecordDto].
  ProgesteroneTestRecordDto toDto() {
    return ProgesteroneTestRecordDto(
      id: id.value,
      metadata: metadata.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      result: result.toDto(),
    );
  }
}

/// Extension to convert [ProgesteroneTestRecordDto] to
/// [ProgesteroneTestRecord].
@internal
extension ProgesteroneTestRecordDtoToDomain on ProgesteroneTestRecordDto {
  /// Converts [ProgesteroneTestRecordDto] to [ProgesteroneTestRecord].
  ProgesteroneTestRecord toDomain() {
    return ProgesteroneTestRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      result: result.toDomain(),
    );
  }
}
