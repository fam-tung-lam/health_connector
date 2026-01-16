import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthRecordId,
        Percentage,
        PeripheralPerfusionIndexRecord,
        sinceV3_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PeripheralPerfusionIndexRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PeripheralPerfusionIndexRecord] to
/// [PeripheralPerfusionIndexRecordDto].
@sinceV3_1_0
@internal
extension PeripheralPerfusionIndexRecordToDto
    on PeripheralPerfusionIndexRecord {
  PeripheralPerfusionIndexRecordDto toDto() {
    return PeripheralPerfusionIndexRecordDto(
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      percentage: percentage.asDecimal,
      metadata: metadata.toDto(),
      id: id.toDto(),
    );
  }
}

/// Converts [PeripheralPerfusionIndexRecordDto] to
/// [PeripheralPerfusionIndexRecord].
@sinceV3_1_0
@internal
extension PeripheralPerfusionIndexRecordDtoToDomain
    on PeripheralPerfusionIndexRecordDto {
  PeripheralPerfusionIndexRecord toDomain() {
    return PeripheralPerfusionIndexRecord(
      time: DateTime.fromMillisecondsSinceEpoch(time),
      percentage: Percentage.fromDecimal(percentage),
      metadata: metadata.toDomain(),
      id: id?.toDomain() ?? HealthRecordId.none,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}
