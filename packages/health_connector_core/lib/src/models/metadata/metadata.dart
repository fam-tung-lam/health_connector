import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0;
import 'package:meta/meta.dart' show immutable;

part 'data_origin.dart';
part 'device.dart';
part 'recording_method.dart';

/// Metadata associated with a health record.
///
/// All health records contain metadata that provides context about how, when,
/// and by what the data was recorded.
@sinceV1_0_0
@immutable
final class Metadata {
  /// Internal factory constructor to create metadata with all fields.
  ///
  /// **Not for public use.** Use the semantic factory methods instead.
  const Metadata({
    required this.dataOrigin,
    required this.recordingMethod,
    this.lastModifiedTime,
    this.clientRecordId,
    this.clientRecordVersion,
    this.device,
  });

  /// Creates metadata for manually entered data.
  ///
  /// Use this when a user types or inputs health data through your
  /// application's UI. Manual entry does not require a device.
  factory Metadata.manualEntry({
    required DataOrigin dataOrigin,
    String? clientRecordId,
    int? clientRecordVersion,
  }) {
    return Metadata(
      dataOrigin: dataOrigin,
      recordingMethod: RecordingMethod.manualEntry,
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
    );
  }

  /// Creates metadata for automatically recorded data.
  ///
  /// Use this when a device passively captures data in the background without
  /// explicit user action for each measurement. A device must be specified.
  factory Metadata.automaticallyRecorded({
    required DataOrigin dataOrigin,
    required Device device,
    String? clientRecordId,
    int? clientRecordVersion,
  }) {
    return Metadata(
      dataOrigin: dataOrigin,
      recordingMethod: RecordingMethod.automaticallyRecorded,
      device: device,
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
    );
  }

  /// Creates metadata for actively recorded data.
  ///
  /// Use this when a user explicitly initiates a recording session on a device.
  /// This indicates intentional, focused data capture
  /// A device must be specified.
  factory Metadata.activelyRecorded({
    required DataOrigin dataOrigin,
    required Device device,
    String? clientRecordId,
    int? clientRecordVersion,
  }) {
    return Metadata(
      dataOrigin: dataOrigin,
      recordingMethod: RecordingMethod.activelyRecorded,
      device: device,
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
    );
  }

  /// Creates metadata when the recording method is unknown.
  ///
  /// Use this when you cannot determine or verify how the data was captured.
  /// This should be used sparingly, typically only for legacy data migration.
  factory Metadata.unknownRecordingMethod({
    required DataOrigin dataOrigin,
    Device? device,
    String? clientRecordId,
    int? clientRecordVersion,
  }) {
    return Metadata(
      dataOrigin: dataOrigin,
      recordingMethod: RecordingMethod.unknown,
      device: device,
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
    );
  }

  /// The application that wrote this health record.
  ///
  /// Identifies the source application using its package name (Android) or
  /// bundle identifier (iOS).
  final DataOrigin dataOrigin;

  /// The timestamp when this record was last modified on the platform.
  ///
  /// This field is managed by the platform and is automatically updated when
  /// a record is modified. When writing new records, this should be `null` -
  /// the platform will set it.
  final DateTime? lastModifiedTime;

  /// A custom identifier assigned by your application.
  ///
  /// Use this for client-side record tracking, deduplication, or correlation
  /// with your application's data model. This is particularly useful for:
  /// - Preventing duplicate writes
  /// - Mapping platform records to your database
  /// - Implementing versioning logic
  ///
  /// The format and content are entirely up to your application.
  /// Common patterns:
  /// - UUIDs: `'550e8400-e29b-41d4-a716-446655440000'`
  /// - Composite keys: `'weight-user123-1705334400000'`
  /// - Sequential IDs: `'record-00042'`
  final String? clientRecordId;

  /// A version number assigned by your application.
  ///
  /// Use this to implement your own versioning or tracking logic. This could
  /// represent:
  /// - The number of times a record has been updated
  /// - A schema version for your data
  /// - A sync version for conflict resolution
  final int? clientRecordVersion;

  /// The device that recorded the data.
  ///
  /// Contains information about the hardware that captured the measurement,
  /// including device type, manufacturer, model, and hardware version.
  final Device? device;

  /// The method used to record this data.
  ///
  /// Describes how the data was captured: manual entry, automatically by a
  /// device, actively initiated by user, or unknown.
  final RecordingMethod recordingMethod;

  /// Creates a copy of this metadata with the specified fields replaced.
  ///
  /// This is useful for creating variations of metadata or updating specific
  /// fields while preserving others.
  Metadata copyWith({
    DataOrigin? dataOrigin,
    DateTime? lastModifiedTime,
    String? clientRecordId,
    int? clientRecordVersion,
    Device? device,
    RecordingMethod? recordingMethod,
  }) {
    return Metadata(
      dataOrigin: dataOrigin ?? this.dataOrigin,
      lastModifiedTime: lastModifiedTime ?? this.lastModifiedTime,
      clientRecordId: clientRecordId ?? this.clientRecordId,
      clientRecordVersion: clientRecordVersion ?? this.clientRecordVersion,
      device: device ?? this.device,
      recordingMethod: recordingMethod ?? this.recordingMethod,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Metadata &&
          runtimeType == other.runtimeType &&
          dataOrigin == other.dataOrigin &&
          lastModifiedTime == other.lastModifiedTime &&
          clientRecordId == other.clientRecordId &&
          clientRecordVersion == other.clientRecordVersion &&
          device == other.device &&
          recordingMethod == other.recordingMethod;

  @override
  int get hashCode =>
      dataOrigin.hashCode ^
      lastModifiedTime.hashCode ^
      clientRecordId.hashCode ^
      clientRecordVersion.hashCode ^
      device.hashCode ^
      recordingMethod.hashCode;

  @override
  String toString() {
    final buffer = StringBuffer('Metadata(')
      ..write('dataOrigin: $dataOrigin, ')
      ..write('recordingMethod: ${recordingMethod.name}');

    if (lastModifiedTime != null) {
      buffer.write(', lastModifiedTime: $lastModifiedTime');
    }

    if (clientRecordId != null) {
      buffer.write(', clientRecordId: $clientRecordId');
    }

    if (clientRecordVersion != null) {
      buffer.write(', clientRecordVersion: $clientRecordVersion');
    }

    if (device != null) {
      buffer.write(', device: $device');
    }

    buffer.write(')');
    return buffer.toString();
  }
}
