import 'package:health_connector_core/health_connector_core_internal.dart'
    show WeightRecord, HealthRecordId, sinceV1_0_0, Mass;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show WeightRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [WeightRecord] to [WeightRecordDto].
@sinceV1_0_0
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
@sinceV1_0_0
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
