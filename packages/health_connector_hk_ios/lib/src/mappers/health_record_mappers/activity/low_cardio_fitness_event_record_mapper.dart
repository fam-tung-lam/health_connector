import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to map [LowCardioFitnessEventRecordDto] to
/// [LowCardioFitnessEventRecord].
@internal
extension LowCardioFitnessEventRecordDtoToDomain
    on LowCardioFitnessEventRecordDto {
  LowCardioFitnessEventRecord toDomain() {
    return LowCardioFitnessEventRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      vo2MlPerMinPerKg: vo2MlPerMinPerKg == null
          ? null
          : Number(vo2MlPerMinPerKg!),
      vo2MlPerMinPerKgThreshold: vo2MlPerMinPerKgThreshold == null
          ? null
          : Number(vo2MlPerMinPerKgThreshold!),
      metadata: metadata.toDomain(),
    );
  }
}
