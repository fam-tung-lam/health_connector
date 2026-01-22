import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthRecordId] to nullable [String] for DTO transfer.
@internal
extension HealthRecordIdFromDomainToDto on HealthRecordId {
  String? toDto() => this == HealthRecordId.none ? null : value;
}

/// Converts [String] to [HealthRecordId].
@internal
extension HealthRecordIdFromDtoToDomain on String? {
  HealthRecordId toDomain() {
    final value = this;
    if (value == null) {
      return HealthRecordId.none;
    }

    if (value.isEmpty) {
      return HealthRecordId.none;
    }

    return HealthRecordId(value);
  }
}
