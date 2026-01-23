import 'package:health_connector_core/health_connector_core_internal.dart'
    show Number, InsulinDeliveryRecord, InsulinDeliveryReason, HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show InsulinDeliveryRecordDto, InsulinDeliveryReasonDto;
import 'package:meta/meta.dart' show internal;

/// Converts [InsulinDeliveryRecord] to [InsulinDeliveryRecordDto].
@internal
extension InsulinDeliveryRecordToDto on InsulinDeliveryRecord {
  InsulinDeliveryRecordDto toDto() {
    return InsulinDeliveryRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      units: units.value.toDouble(),
      reason: InsulinDeliveryReasonDto.values.byName(reason.name),
    );
  }
}

/// Converts [InsulinDeliveryRecordDto] to [InsulinDeliveryRecord].
@internal
extension InsulinDeliveryRecordDtoToDomain on InsulinDeliveryRecordDto {
  InsulinDeliveryRecord toDomain() {
    return InsulinDeliveryRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      units: Number(units),
      reason: InsulinDeliveryReason.values.byName(reason.name),
    );
  }
}
