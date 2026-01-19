import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to map Pigeon [WalkingSteadinessRecordDto] to
/// [WalkingSteadinessRecord].
@internal
extension WalkingSteadinessRecordDtoToDomain on WalkingSteadinessRecordDto {
  WalkingSteadinessRecord toDomain() {
    return WalkingSteadinessRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      percentage: Percentage.fromDecimal(percentage),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      metadata: metadata.toDomain(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
