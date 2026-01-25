part of '../health_record.dart';

/// Represents a series of skin temperature delta measurements over a
/// time interval.
///
/// This record captures the skin temperature of a user. Each record can
/// represent a series of measurements of temperature differences.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`SkinTemperatureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/SkinTemperatureRecord)
/// - **iOS HealthKit**: Not supported
///
/// ## Example
///
/// ```dart
/// final record = SkinTemperatureDeltaSeriesRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime.now().subtract(Duration(minutes: 10)),
///   endTime: DateTime.now(),
///   baseline: Temperature.celsius(36.5),
///   samples: [
///     SkinTemperatureDelta(
///       time: DateTime.now().subtract(Duration(minutes: 10)),
///       temperatureDelta: Temperature.celsius(0.2),
///     ),
///     SkinTemperatureDelta(
///       time: DateTime.now().subtract(Duration(minutes: 5)),
///       temperatureDelta: Temperature.celsius(-0.1),
///     ),
///     SkinTemperatureDelta(
///       time: DateTime.now(),
///       temperatureDelta: Temperature.celsius(0.3),
///     ),
///   ],
///   measurementLocation: SkinTemperatureMeasurementLocation.wrist,
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [SkinTemperatureDataType]
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnHealthConnect
@immutable
final class SkinTemperatureDeltaSeriesRecord
    extends SeriesHealthRecord<SkinTemperatureDeltaSample> {
  /// Minimum valid baseline temperature (0.0°C).
  static const Temperature minBaseline = Temperature.zero;

  /// Maximum valid baseline temperature (100.0°C).
  static const Temperature maxBaseline = Temperature.celsius(100.0);

  /// Creates a skin temperature delta series record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: Start time of the record.
  /// - [endTime]: End time of the record.
  /// - [samples]: A list of skin temperature samples. If [baseline] is set,
  ///   these values are expected to be relative to it. Otherwise, they are
  ///   samples against an unspecified starting baseline.
  /// - [baseline]: Optional baseline temperature in Celsius. Valid range:
  ///   0-100 Celsius degrees.
  /// - [measurementLocation]: Indicates the location on the body from which the
  ///   temperature reading was taken.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for the start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for the end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [baseline] is outside the valid range of
  ///   [minBaseline]-[maxBaseline] Celsius.
  /// - [ArgumentError] if any delta's time is outside the record time range.
  SkinTemperatureDeltaSeriesRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    this.baseline,
    this.measurementLocation = SkinTemperatureMeasurementLocation.unknown,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);

    if (baseline != null) {
      require(
        condition: baseline! >= minBaseline && baseline! <= maxBaseline,
        value: baseline,
        name: 'baseline',
        message:
            'Baseline temperature must be between '
            '${minBaseline.inCelsius.toStringAsFixed(0)}-'
            '${maxBaseline.inCelsius.toStringAsFixed(0)} °C. '
            'Got ${baseline!.inCelsius.toStringAsFixed(2)} °C.',
      );
    }

    if (samples.isNotEmpty) {
      // Check all samples are within parent record duration
      final minDeltaTime = samples
          .map((delta) => delta.time)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      final maxDeltaTime = samples
          .map((delta) => delta.time)
          .reduce((a, b) => a.isAfter(b) ? a : b);

      require(
        condition: !minDeltaTime.isBefore(startTime),
        value: minDeltaTime,
        name: 'samples',
        message: 'Deltas cannot be out of parent time range.',
      );

      require(
        condition: maxDeltaTime.isBefore(endTime),
        value: maxDeltaTime,
        name: 'samples',
        message: 'Deltas cannot be out of parent time range.',
      );
    }
  }

  /// Internal factory for creating [SkinTemperatureDeltaSeriesRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory SkinTemperatureDeltaSeriesRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required List<SkinTemperatureDeltaSample> samples,
    Temperature? baseline,
    SkinTemperatureMeasurementLocation measurementLocation =
        SkinTemperatureMeasurementLocation.unknown,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return SkinTemperatureDeltaSeriesRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      samples: samples,
      baseline: baseline,
      measurementLocation: measurementLocation,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  SkinTemperatureDeltaSeriesRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required super.samples,
    this.baseline,
    this.measurementLocation = SkinTemperatureMeasurementLocation.unknown,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Optional baseline temperature in Celsius.
  ///
  /// Valid range: 0-100 Celsius degrees. If set, [samples] are relative to
  /// this baseline.
  final Temperature? baseline;

  /// Indicates the location on the body from which the temperature reading
  /// was taken.
  final SkinTemperatureMeasurementLocation measurementLocation;

  /// Creates a copy with the given fields replaced with the new values.
  SkinTemperatureDeltaSeriesRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    List<SkinTemperatureDeltaSample>? samples,
    Temperature? baseline,
    SkinTemperatureMeasurementLocation? measurementLocation,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return SkinTemperatureDeltaSeriesRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      samples: samples ?? this.samples,
      baseline: baseline ?? this.baseline,
      measurementLocation: measurementLocation ?? this.measurementLocation,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkinTemperatureDeltaSeriesRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          baseline == other.baseline &&
          measurementLocation == other.measurementLocation &&
          const ListEquality<SkinTemperatureDeltaSample>().equals(
            samples,
            other.samples,
          );

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      (baseline?.hashCode ?? 0) ^
      measurementLocation.hashCode ^
      const ListEquality<SkinTemperatureDeltaSample>().hash(samples);
}

/// Represents a single skin temperature delta measurement at a specific point
/// in time.
///
/// This class is used exclusively as a sample type within
/// [SkinTemperatureDeltaSeriesRecord] to represent individual temperature delta
/// measurements in a time series.
///
/// **Note**: This class does not have an ID or metadata. Those are
/// properties of the record that contains the measurement.
///
/// {@category Health Records}
@immutable
final class SkinTemperatureDeltaSample {
  /// Minimum valid temperature delta (-30.0°C).
  static const Temperature minDelta = Temperature.celsius(-30.0);

  /// Maximum valid temperature delta (30.0°C).
  static const Temperature maxDelta = Temperature.celsius(30.0);

  /// Creates a skin temperature delta measurement.
  ///
  /// ## Parameters
  ///
  /// - [time]: The point in time when the measurement was taken.
  /// - [temperatureDelta]: The temperature delta value in Celsius. Valid range:
  ///   -30 to 30 Celsius degrees.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [temperatureDelta] is outside the valid range of
  ///   [minDelta]-[maxDelta].
  SkinTemperatureDeltaSample({
    required this.time,
    required this.temperatureDelta,
  }) {
    require(
      condition: temperatureDelta >= minDelta && temperatureDelta <= maxDelta,
      value: temperatureDelta,
      name: 'temperatureDelta',
      message:
          'Temperature delta must be between '
          '${minDelta.inCelsius.toStringAsFixed(0)}-'
          '${maxDelta.inCelsius.toStringAsFixed(0)} °C. '
          'Got ${temperatureDelta.inCelsius.toStringAsFixed(2)} °C.',
    );
  }

  /// The timestamp when this temperature delta measurement was taken, stored as
  /// a UTC instant.
  ///
  /// Timezone offset information is provided by the parent record.
  final DateTime time;

  /// The temperature delta value in Celsius.
  ///
  /// Valid range: -30 to 30 Celsius degrees.
  final Temperature temperatureDelta;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkinTemperatureDeltaSample &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          temperatureDelta == other.temperatureDelta;

  @override
  int get hashCode => time.hashCode ^ temperatureDelta.hashCode;
}
