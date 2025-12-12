import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart';

/// Mapper extensions for [RespiratoryRateRecord].
extension RespiratoryRateRecordMapper on RespiratoryRateRecord {
  /// Converts [RespiratoryRateRecord] to its [RespiratoryRateRecordDto].
  RespiratoryRateRecordDto toDto() {
    return RespiratoryRateRecordDto(
      id: id.toDto(),
      time: time.toUtc().millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      rate: rate.toDto() as NumericDto,
    );
  }
}

/// Mapper extensions for [RespiratoryRateRecordDto].
extension RespiratoryRateRecordDtoMapper on RespiratoryRateRecordDto {
  /// Converts [RespiratoryRateRecordDto] to its domain representation.
  RespiratoryRateRecord toDomain() {
    return RespiratoryRateRecord(
      id: HealthRecordId(id ?? HealthRecordId.none.value),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true).toLocal(),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      rate: RespiratoryRate(breathsPerMinute: rate.value),
    );
  }
}
