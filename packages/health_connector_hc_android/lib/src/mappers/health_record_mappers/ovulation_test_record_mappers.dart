import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/ovulation_test_result_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [OvulationTestRecord] to [OvulationTestRecordDto].
@sinceV2_2_0
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
@sinceV2_2_0
@internal
extension OvulationTestRecordDtoToDomain on OvulationTestRecordDto {
  /// Converts [OvulationTestRecordDto] to [OvulationTestRecord].
  OvulationTestRecord toDomain() {
    return OvulationTestRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true).toLocal(),
      zoneOffsetSeconds: zoneOffsetSeconds,
      result: result.toDomain(),
    );
  }
}
