import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [AppleWalkingSteadinessRecord] to
/// [AppleWalkingSteadinessRecordDto] and vice versa.
@sinceV1_0_0
@internal
extension AppleWalkingSteadinessRecordToDto on AppleWalkingSteadinessRecord {
  AppleWalkingSteadinessRecordDto toDto() {
    return AppleWalkingSteadinessRecordDto(
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
extension AppleWalkingSteadinessRecordDtoToDomain
    on AppleWalkingSteadinessRecordDto {
  AppleWalkingSteadinessRecord toDomain() {
    return AppleWalkingSteadinessRecord.internal(
      id: HealthRecordId(id!),
      percentage: Percentage.fromDecimal(percentage),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      metadata: metadata.toDomain(),
    );
  }
}
