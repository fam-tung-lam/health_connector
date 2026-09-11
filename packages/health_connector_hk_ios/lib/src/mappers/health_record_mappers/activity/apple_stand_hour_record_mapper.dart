import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [AppleStandHourRecordDto] to [AppleStandHourRecord].
@internal
extension AppleStandHourRecordDtoToDomain on AppleStandHourRecordDto {
  AppleStandHourRecord toDomain() {
    return AppleStandHourRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      metadata: metadata.toDomain(),
      status: status.toDomain(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [AppleStandHourStatusDto] to [AppleStandHourStatus].
@internal
extension AppleStandHourStatusDtoToDomain on AppleStandHourStatusDto {
  AppleStandHourStatus toDomain() {
    return switch (this) {
      AppleStandHourStatusDto.stood => AppleStandHourStatus.stood,
      AppleStandHourStatusDto.idle => AppleStandHourStatus.idle,
    };
  }
}
