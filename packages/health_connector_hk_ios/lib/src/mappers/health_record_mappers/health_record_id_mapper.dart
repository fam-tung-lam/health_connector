import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthRecordId] to nullable [String] for DTO transfer.
@internal
extension HealthRecordIdFromDomainToDto on HealthRecordId {
  String toDto() => value;
}

/// Converts [String] to [HealthRecordId].
@internal
extension HealthRecordIdFromDtoToDomain on String {
  HealthRecordId toDomain() {
    if (this == HealthRecordId.none.value) {
      return HealthRecordId.none;
    }
    return HealthRecordId(this);
  }
}
