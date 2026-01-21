import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart';

/// Extension to map Pigeon [AtrialFibrillationBurdenRecordDto] to
/// [AtrialFibrillationBurdenRecord].
@internal
extension AtrialFibrillationBurdenRecordDtoToDomain
    on AtrialFibrillationBurdenRecordDto {
  AtrialFibrillationBurdenRecord toDomain() {
    return AtrialFibrillationBurdenRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      metadata: metadata.toDomain(),
      percentage: Percentage.fromDecimal(percentage),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
