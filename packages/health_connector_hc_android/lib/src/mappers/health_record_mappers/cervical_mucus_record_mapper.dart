import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/cervical_mucus_appearance_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/cervical_mucus_sensation_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [CervicalMucusRecord] to [CervicalMucusRecordDto].
@sinceV2_1_0
@internal
extension CervicalMucusRecordToDto on CervicalMucusRecord {
  /// Converts this [CervicalMucusRecord] to [CervicalMucusRecordDto].
  CervicalMucusRecordDto toDto() {
    return CervicalMucusRecordDto(
      id: id.value,
      metadata: metadata.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      appearance: appearance.toDto(),
      sensation: sensation.toDto(),
    );
  }
}

/// Extension to convert [CervicalMucusRecordDto] to [CervicalMucusRecord].
@sinceV2_1_0
@internal
extension CervicalMucusRecordDtoToDomain on CervicalMucusRecordDto {
  /// Converts this [CervicalMucusRecordDto] to [CervicalMucusRecord].
  CervicalMucusRecord toDomain() {
    return CervicalMucusRecord(
      id: id != null ? HealthRecordId(id!) : HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true).toLocal(),
      zoneOffsetSeconds: zoneOffsetSeconds,
      appearance: appearance.toDomain(),
      sensation: sensation.toDomain(),
    );
  }
}
