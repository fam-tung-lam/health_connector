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
    this.frequency = defaultFrequency,
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
      frequency: Duration(
        minutes:
            json[_frequencyMinutesKey] as int? ?? defaultFrequency.inMinutes,
      ),
    );
  }

  /// Android WorkManager enforces a 15 minute minimum for periodic work.
  static const Duration defaultFrequency = Duration(minutes: 15);

  /// Health data types included in every background sync.
  final List<HealthDataType> dataTypes;

  /// Whether the periodic background task is registered.
  final bool isEnabled;

  /// Requested interval between background runs.
  ///
  /// Both platforms treat this as a hint; iOS in particular runs app refresh
  /// tasks whenever it decides based on usage patterns.
  final Duration frequency;

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
    Duration? frequency,
  }) {
    return BackgroundSyncSettings(
      dataTypes: dataTypes ?? this.dataTypes,
      isEnabled: isEnabled ?? this.isEnabled,
      frequency: frequency ?? this.frequency,
    );
  }

  Map<String, dynamic> toJson() => {
    _dataTypesKey: dataTypeIds,
    _isEnabledKey: isEnabled,
    _frequencyMinutesKey: frequency.inMinutes,
  };

  static const _dataTypesKey = 'dataTypes';
  static const _isEnabledKey = 'isEnabled';
  static const _frequencyMinutesKey = 'frequencyMinutes';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackgroundSyncSettings &&
          runtimeType == other.runtimeType &&
          listEquals(dataTypes, other.dataTypes) &&
          isEnabled == other.isEnabled &&
          frequency == other.frequency;

  @override
  int get hashCode =>
      Object.hash(Object.hashAll(dataTypes), isEnabled, frequency);

  @override
  String toString() =>
      'BackgroundSyncSettings(dataTypes: $dataTypeIds, '
      'isEnabled: $isEnabled, frequency: $frequency)';
}
