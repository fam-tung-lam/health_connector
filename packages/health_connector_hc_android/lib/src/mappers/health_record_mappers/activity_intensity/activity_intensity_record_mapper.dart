import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/activity_intensity/activity_intensity_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart';

/// Extension to convert [ActivityIntensityRecord] to
/// [ActivityIntensityRecordDto].
@sinceV3_2_0
@internal
extension ActivityIntensityRecordToDto on ActivityIntensityRecord {
  ActivityIntensityRecordDto toDto() {
    return ActivityIntensityRecordDto(
      id: id.value,
      metadata: metadata.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.timeZoneOffset.inSeconds,
      endZoneOffsetSeconds: endTime.timeZoneOffset.inSeconds,
      activityIntensityType: activityIntensityType.toDto(),
      title: title,
      notes: notes,
    );
  }
}

/// Extension to convert [ActivityIntensityRecordDto] to
/// [ActivityIntensityRecord].
@sinceV3_2_0
@internal
extension ActivityIntensityRecordDtoToDomain on ActivityIntensityRecordDto {
  ActivityIntensityRecord toDomain() {
    return ActivityIntensityRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      startTime: DateTime.fromMillisecondsSinceEpoch(
        startTime,
        isUtc: true,
      ).toLocal(),
      endTime: DateTime.fromMillisecondsSinceEpoch(
        endTime,
        isUtc: true,
      ).toLocal(),
      activityIntensityType: activityIntensityType.toDomain(),
      title: title,
      notes: notes,
    );
  }
}
