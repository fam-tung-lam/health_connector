import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [PeakExpiratoryFlowRateRecordDto] to
/// [PeakExpiratoryFlowRateRecord].
@internal
extension PeakExpiratoryFlowRateRecordDtoToDomain
    on PeakExpiratoryFlowRateRecordDto {
  PeakExpiratoryFlowRateRecord toDomain() {
    return PeakExpiratoryFlowRateRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      volumePerSecond: Volume.liters(litersPerSecond),
    );
  }
}

/// Converts [PeakExpiratoryFlowRateRecord] to
/// [PeakExpiratoryFlowRateRecordDto].
@internal
extension PeakExpiratoryFlowRateRecordToDto on PeakExpiratoryFlowRateRecord {
  PeakExpiratoryFlowRateRecordDto toDto() {
    return PeakExpiratoryFlowRateRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      litersPerSecond: volumePerSecond.inLiters,
    );
  }
}
