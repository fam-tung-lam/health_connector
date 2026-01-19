import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/ovulation_test_result/ovulation_test_result_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [OvulationTestRecord] to [OvulationTestRecordDto].
@internal
extension OvulationTestRecordToDto on OvulationTestRecord {
  /// Converts [OvulationTestRecord] to [OvulationTestRecordDto].
  OvulationTestRecordDto toDto() {
    return OvulationTestRecordDto(
      id: id.value,
      metadata: metadata.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      result: result.toDto(),
    );
  }
}

/// Extension to convert [OvulationTestRecordDto] to [OvulationTestRecord].
@internal
extension OvulationTestRecordDtoToDomain on OvulationTestRecordDto {
  /// Converts [OvulationTestRecordDto] to [OvulationTestRecord].
  OvulationTestRecord toDomain() {
    return OvulationTestRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      result: result.toDomain(),
    );
  }
}
