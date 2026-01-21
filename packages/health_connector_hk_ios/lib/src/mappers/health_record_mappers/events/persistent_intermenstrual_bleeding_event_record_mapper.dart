import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to map [PersistentIntermenstrualBleedingEventRecordDto] to
/// [PersistentIntermenstrualBleedingEventRecord].
@internal
extension PersistentIntermenstrualBleedingEventRecordDtoToDomain
    on PersistentIntermenstrualBleedingEventRecordDto {
  PersistentIntermenstrualBleedingEventRecord toDomain() {
    return PersistentIntermenstrualBleedingEventRecord.internal(
      id: id.toDomain(),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
    );
  }
}
