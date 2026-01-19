import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/pregnancy_test_result/pregnancy_test_result_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [PregnancyTestRecord] to [PregnancyTestRecordDto].
@internal
extension PregnancyTestRecordToDto on PregnancyTestRecord {
  /// Converts [PregnancyTestRecord] to [PregnancyTestRecordDto].
  PregnancyTestRecordDto toDto() {
    return PregnancyTestRecordDto(
      id: id.value,
      metadata: metadata.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      result: result.toDto(),
    );
  }
}

/// Extension to convert [PregnancyTestRecordDto] to [PregnancyTestRecord].
@internal
extension PregnancyTestRecordDtoToDomain on PregnancyTestRecordDto {
  /// Converts [PregnancyTestRecordDto] to [PregnancyTestRecord].
  PregnancyTestRecord toDomain() {
    return PregnancyTestRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      result: result.toDomain(),
    );
  }
}
