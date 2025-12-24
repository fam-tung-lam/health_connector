import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, sinceV1_0_0;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthRecordId] to [String] for DTO transfer.
@sinceV1_0_0
@internal
extension HealthRecordIdFromDomainToDto on HealthRecordId {
  String toDto() => value;
}

/// Converts [String] to [HealthRecordId].
@sinceV1_0_0
@internal
extension HealthRecordIdFromDtoToDomain on String {
  HealthRecordId toDomain() {
    if (this == HealthRecordId.none.value) {
      return HealthRecordId.none;
    }
    return HealthRecordId(this);
  }
}
