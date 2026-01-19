import 'package:health_connector_core/health_connector_core_internal.dart'
    show WeightRecord, HealthRecordId, Mass;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show WeightRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [WeightRecord] to [WeightRecordDto].
@internal
extension WeightRecordToDto on WeightRecord {
  WeightRecordDto toDto() {
    return WeightRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      kilograms: weight.inKilograms,
    );
  }
}

/// Converts [WeightRecordDto] to [WeightRecord].
@internal
extension WeightRecordDtoToDomain on WeightRecordDto {
  WeightRecord toDomain() {
    return WeightRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      weight: Mass.kilograms(kilograms),
    );
  }
}
