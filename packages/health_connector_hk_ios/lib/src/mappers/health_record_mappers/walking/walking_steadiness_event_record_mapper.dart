import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart';

/// Converts [WalkingSteadinessEventRecordDto] to
/// [WalkingSteadinessEventRecord].
@internal
extension WalkingSteadinessEventRecordDtoMapper
    on WalkingSteadinessEventRecordDto {
  WalkingSteadinessEventRecord toDomain() {
    return WalkingSteadinessEventRecord.internal(
      id: HealthRecordId(id!),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      metadata: metadata.toDomain(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      type: type.toDomain(),
    );
  }
}

/// Converts [WalkingSteadinessTypeDto] to
/// [WalkingSteadinessType].
@internal
extension WalkingSteadinessTypeDtoMapper on WalkingSteadinessTypeDto {
  WalkingSteadinessType toDomain() {
    switch (this) {
      case WalkingSteadinessTypeDto.initialLow:
        return WalkingSteadinessType.initialLow;
      case WalkingSteadinessTypeDto.initialVeryLow:
        return WalkingSteadinessType.initialVeryLow;
      case WalkingSteadinessTypeDto.repeatLow:
        return WalkingSteadinessType.repeatLow;
      case WalkingSteadinessTypeDto.repeatVeryLow:
        return WalkingSteadinessType.repeatVeryLow;
    }
  }
}
