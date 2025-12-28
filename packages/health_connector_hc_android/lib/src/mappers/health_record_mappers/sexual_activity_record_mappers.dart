import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/sexual_activity_protection_used_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [SexualActivityRecord] to [SexualActivityRecordDto].
@sinceV2_1_0
@internal
extension SexualActivityRecordToDto on SexualActivityRecord {
  /// Converts [SexualActivityRecord] to [SexualActivityRecordDto].
  SexualActivityRecordDto toDto() {
    return SexualActivityRecordDto(
      id: id.value,
      metadata: metadata.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      protectionUsed: protectionUsed.toDto(),
    );
  }
}

/// Extension to convert [SexualActivityRecordDto] to [SexualActivityRecord].
@sinceV2_1_0
@internal
extension SexualActivityRecordDtoToDomain on SexualActivityRecordDto {
  /// Converts [SexualActivityRecordDto] to [SexualActivityRecord].
  SexualActivityRecord toDomain() {
    return SexualActivityRecord(
      id: id != null ? HealthRecordId(id!) : HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true).toLocal(),
      zoneOffsetSeconds: zoneOffsetSeconds,
      protectionUsed: protectionUsed.toDomain(),
    );
  }
}
