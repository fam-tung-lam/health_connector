import 'package:health_connector_core/health_connector_core_internal.dart'
    show BasalMetabolicRateRecord, HealthRecordId, sinceV3_6_0, Power;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show BasalMetabolicRateRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BasalMetabolicRateRecord] to [BasalMetabolicRateRecordDto].
@sinceV3_6_0
@internal
extension BasalMetabolicRateRecordToDto on BasalMetabolicRateRecord {
  BasalMetabolicRateRecordDto toDto() {
    return BasalMetabolicRateRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      kilocaloriesPerDay: rate.inKilocaloriesPerDay,
    );
  }
}

/// Converts [BasalMetabolicRateRecordDto] to [BasalMetabolicRateRecord].
@sinceV3_6_0
@internal
extension BasalMetabolicRateRecordDtoToDomain on BasalMetabolicRateRecordDto {
  BasalMetabolicRateRecord toDomain() {
    return BasalMetabolicRateRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      rate: Power.kilocaloriesPerDay(kilocaloriesPerDay),
    );
  }
}
