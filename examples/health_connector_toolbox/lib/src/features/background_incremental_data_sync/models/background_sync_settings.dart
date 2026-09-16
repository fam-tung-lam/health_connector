import 'package:flutter/foundation.dart' show immutable, listEquals;
import 'package:health_connector/health_connector.dart' show HealthDataType;

/// User-editable configuration of the background incremental data sync.
///
/// The settings are persisted so the headless background isolate can read the
/// same selection the UI shows.
@immutable
final class BackgroundSyncSettings {
  const BackgroundSyncSettings({
    this.dataTypes = const [],
    this.isEnabled = false,
  });

  /// Restores settings written by [toJson].
  ///
  /// Unknown data type identifiers are skipped so an older selection never
  /// blocks the feature after an SDK upgrade.
  factory BackgroundSyncSettings.fromJson(Map<String, dynamic> json) {
    final ids = (json[_dataTypesKey] as List<dynamic>? ?? const [])
        .cast<String>();
    return BackgroundSyncSettings(
      dataTypes: resolveDataTypes(ids),
      isEnabled: json[_isEnabledKey] as bool? ?? false,
    );
  }

  /// Interval between background runs.
  ///
  /// Android WorkManager enforces a 15 minute minimum for periodic work. Both
  /// platforms treat the value as a hint; iOS in particular runs app refresh
  /// tasks whenever it decides based on usage patterns.
  static const Duration frequency = Duration(minutes: 15);

  /// Health data types included in every background sync.
  final List<HealthDataType> dataTypes;

  /// Whether the periodic background task is registered.
  final bool isEnabled;

  /// Identifiers of [dataTypes], in selection order.
  List<String> get dataTypeIds => dataTypes.map((type) => type.id).toList();

  /// Maps [ids] back to [HealthDataType] values, skipping unknown ids.
  static List<HealthDataType> resolveDataTypes(Iterable<String> ids) {
    final byId = {for (final type in HealthDataType.values) type.id: type};
    return [
      for (final id in ids)
        if (byId[id] case final type?) type,
    ];
  }

  BackgroundSyncSettings copyWith({
    List<HealthDataType>? dataTypes,
    bool? isEnabled,
  }) {
    return BackgroundSyncSettings(
      dataTypes: dataTypes ?? this.dataTypes,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
    _dataTypesKey: dataTypeIds,
    _isEnabledKey: isEnabled,
  };

  static const _dataTypesKey = 'dataTypes';
  static const _isEnabledKey = 'isEnabled';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackgroundSyncSettings &&
          runtimeType == other.runtimeType &&
          listEquals(dataTypes, other.dataTypes) &&
          isEnabled == other.isEnabled;

  @override
  int get hashCode => Object.hash(Object.hashAll(dataTypes), isEnabled);

  @override
  String toString() =>
      'BackgroundSyncSettings(dataTypes: $dataTypeIds, isEnabled: $isEnabled)';
}
