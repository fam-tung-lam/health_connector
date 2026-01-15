import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/reproductive_health/contraceptive_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [ContraceptiveRecord] to [ContraceptiveRecordDto].
@sinceV3_1_0
@internal
extension ContraceptiveRecordToDto on ContraceptiveRecord {
  /// Converts [ContraceptiveRecord] to [ContraceptiveRecordDto].
  ContraceptiveRecordDto toDto() {
    return ContraceptiveRecordDto(
      id: id.value,
      metadata: metadata.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      contraceptiveType: contraceptiveType.toDto(),
      startZoneOffsetSeconds: startTime.resolveZoneOffsetSeconds(
        startZoneOffsetSeconds,
      ),
      endZoneOffsetSeconds: endTime.resolveZoneOffsetSeconds(
        endZoneOffsetSeconds,
      ),
    );
  }
}

/// Extension to convert [ContraceptiveRecordDto] to [ContraceptiveRecord].
@sinceV3_1_0
@internal
extension ContraceptiveRecordDtoToDomain on ContraceptiveRecordDto {
  /// Converts [ContraceptiveRecordDto] to [ContraceptiveRecord].
  ContraceptiveRecord toDomain() {
    return ContraceptiveRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      contraceptiveType: contraceptiveType.toDomain(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
