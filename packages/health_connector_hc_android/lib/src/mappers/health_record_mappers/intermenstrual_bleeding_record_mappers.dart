import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [IntermenstrualBleedingRecord] to
/// [IntermenstrualBleedingRecordDto].
@sinceV2_2_0
@internal
extension IntermenstrualBleedingRecordToDto on IntermenstrualBleedingRecord {
  /// Converts [IntermenstrualBleedingRecord] to
  /// [IntermenstrualBleedingRecordDto].
  IntermenstrualBleedingRecordDto toDto() {
    return IntermenstrualBleedingRecordDto(
      id: id.value,
      metadata: metadata.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}

/// Extension to convert [IntermenstrualBleedingRecordDto] to
/// [IntermenstrualBleedingRecord].
@sinceV2_2_0
@internal
extension IntermenstrualBleedingRecordDtoToDomain
    on IntermenstrualBleedingRecordDto {
  /// Converts [IntermenstrualBleedingRecordDto] to
  /// [IntermenstrualBleedingRecord].
  IntermenstrualBleedingRecord toDomain() {
    return IntermenstrualBleedingRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true).toLocal(),
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}
