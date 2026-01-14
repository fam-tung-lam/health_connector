import 'package:collection/collection.dart' show ListEquality;
import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart';
import 'package:meta/meta.dart' show immutable;

/// A synchronization token representing a position in the health data stream.
///
/// Treat this object as opaque. Persist it to resume sync from this point.
///
/// {@category Core API}
@sinceV3_0_0
@immutable
final class HealthDataSyncToken {
  /// Creates a [HealthDataSyncToken] instance.
  const HealthDataSyncToken._({
    required this.token,
    required this.dataTypes,
    required this.createdAt,
  });

  /// Platform-specific opaque token string.
  final String token;

  /// Health data types included in this sync token's scope.
  final List<HealthDataType<HealthRecord, MeasurementUnit>> dataTypes;

  /// When this sync token was originally created (UTC).
  final DateTime createdAt;

  /// Creates a [HealthDataSyncToken] instance.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory HealthDataSyncToken.internal({
    required String token,
    required List<HealthDataType> dataTypes,
    required DateTime createdAt,
  }) {
    return HealthDataSyncToken._(
      token: token,
      dataTypes: dataTypes,
      createdAt: createdAt,
    );
  }

  /// Creates a [HealthDataSyncToken] from a JSON map.
  ///
  /// The [json] map must contain the following keys:
  /// - `token`: The platform-specific opaque token string.
  /// - `dataTypes`: A list of [HealthDataType] IDs.
  /// - `createdAt`: The ISO 8601 timestamp when the token was created.
  factory HealthDataSyncToken.fromJson(Map<String, dynamic> json) {
    return HealthDataSyncToken._(
      token: json[_tokenKey] as String,
      dataTypes: (json[_dataTypesKey] as List<dynamic>).map((id) {
        final dataType = HealthDataType.dataTypeMap[id];
        if (dataType == null) {
          throw ArgumentError(
            'Unknown HealthDataType id: $id. '
            'This may indicate a version mismatch or unsupported data type.',
          );
        }

        return dataType;
      }).toList(),
      createdAt: DateTime.parse(json[_createdAtKey] as String).toUtc(),
    );
  }

  /// Converts this [HealthDataSyncToken] to a JSON-compatible map.
  ///
  /// The resulting map contains:
  /// - `token`: The [token] string.
  /// - `dataTypes`: A list of IDs for the [dataTypes].
  /// - `createdAt`: The [createdAt] timestamp in ISO 8601 format.
  Map<String, dynamic> toJson() => {
    _tokenKey: token,
    _dataTypesKey: dataTypes.map((e) => e.id).toList(),
    _createdAtKey: createdAt.toIso8601String(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthDataSyncToken &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          const ListEquality<HealthDataType>().equals(
            dataTypes,
            other.dataTypes,
          ) &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(token, Object.hashAll(dataTypes), createdAt);

  /// The JSON key for the [token] field.
  static const _tokenKey = 'token';

  /// The JSON key for the [dataTypes] field.
  static const _dataTypesKey = 'dataTypes';

  /// The JSON key for the [createdAt] field.
  static const _createdAtKey = 'createdAt';
}
