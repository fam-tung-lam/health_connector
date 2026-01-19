import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [WalkingSteadinessRecord] to
/// [WalkingSteadinessRecordDto] and vice versa.
@sinceV1_0_0
@internal
extension WalkingSteadinessRecordToDto on WalkingSteadinessRecord {
  WalkingSteadinessRecordDto toDto() {
    return WalkingSteadinessRecordDto(
      id: id.value,
      percentage: percentage.asDecimal,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
    );
  }
}

@sinceV1_0_0
@internal
extension WalkingSteadinessRecordDtoToDomain on WalkingSteadinessRecordDto {
  WalkingSteadinessRecord toDomain() {
    return WalkingSteadinessRecord.internal(
      id: HealthRecordId(id!),
      percentage: Percentage.fromDecimal(percentage),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      metadata: metadata.toDomain(),
    );
  }
}
