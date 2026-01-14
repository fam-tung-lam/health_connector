import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0, internalUse;
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
  ///
  /// ## Parameters
  ///
  /// - [dataOrigin]: The application that wrote this health record.
  /// - [recordingMethod]: The method used to record this data.
  /// - [lastModifiedTime]: The timestamp when this record was last modified.
  /// - [clientRecordId]: A custom identifier assigned by your application.
  /// - [clientRecordVersion]: A version number assigned by your application.
  /// - [device]: The device that recorded the data.
  const Metadata._({
    required this.recordingMethod,
    this.dataOrigin,
    this.lastModifiedTime,
    this.clientRecordId,
    this.clientRecordVersion,
    this.device,
  });

  /// Factory constructor for platform implementations.
  ///
  /// **⚠️ Internal Use Only**: This factory is intended for use by the SDK to
  /// construct metadata instances populated with values from the underlying
  /// native platform.
  ///
  /// ## Parameters
  ///
  /// - [dataOrigin]: The application that wrote this health record.
  /// - [recordingMethod]: The method used to record this data.
  /// - [lastModifiedTime]: The timestamp when this record was last modified.
  /// - [clientRecordId]: A custom identifier assigned by your application.
  /// - [clientRecordVersion]: A version number assigned by your application.
  /// - [device]: The device that recorded the data.
  @internalUse
  factory Metadata.internal({
    required RecordingMethod recordingMethod,
    DataOrigin? dataOrigin,
    DateTime? lastModifiedTime,
    String? clientRecordId,
    int? clientRecordVersion,
    Device? device,
  }) {
    return Metadata._(
      recordingMethod: recordingMethod,
      dataOrigin: dataOrigin,
      lastModifiedTime: lastModifiedTime,
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
      device: device,
    );
  }

  /// Creates metadata for manually entered data.
  ///
  /// Use this when a user types or inputs health data through your
  /// application's UI. Manual entry does not require a device.
  ///
  /// ## Parameters
  ///
  /// - [clientRecordId]: A custom identifier assigned by your application.
  /// - [clientRecordVersion]: A version number assigned by your application.
  factory Metadata.manualEntry({
    String? clientRecordId,
    int? clientRecordVersion,
    Device? device,
  }) {
    return Metadata._(
      recordingMethod: RecordingMethod.manualEntry,
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
      device: device,
    );
  }

  /// Creates metadata for automatically recorded data.
  ///
  /// Use this when a device passively captures data in the background without
  /// explicit user action for each measurement. A device must be specified.
  ///
  /// ## Parameters
  ///
  /// - [device]: The device that recorded the data.
  /// - [clientRecordId]: A custom identifier assigned by your application.
  /// - [clientRecordVersion]: A version number assigned by your application.
  factory Metadata.automaticallyRecorded({
    required Device device,
    String? clientRecordId,
    int? clientRecordVersion,
  }) {
    return Metadata._(
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
  ///
  /// ## Parameters
  ///
  /// - [device]: The device that recorded the data.
  /// - [clientRecordId]: A custom identifier assigned by your application.
  /// - [clientRecordVersion]: A version number assigned by your application.
  factory Metadata.activelyRecorded({
    required Device device,
    String? clientRecordId,
    int? clientRecordVersion,
  }) {
    return Metadata._(
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
  ///
  /// ## Parameters
  ///
  /// - [device]: The device that recorded the data.
  /// - [clientRecordId]: A custom identifier assigned by your application.
  /// - [clientRecordVersion]: A version number assigned by your application.
  factory Metadata.unknownRecordingMethod({
    Device? device,
    String? clientRecordId,
    int? clientRecordVersion,
  }) {
    return Metadata._(
      recordingMethod: RecordingMethod.unknown,
      device: device,
      clientRecordId: clientRecordId,
      clientRecordVersion: clientRecordVersion,
    );
  }

  /// The data origin (app package name) that wrote this record.
  ///
  /// This field is automatically populated by the platform when writing records
  /// and is only available on records retrieved via read operations.
  ///
  /// **Important**: You cannot specify the data origin when creating records.
  /// The platform automatically assigns your app's package name/bundle ID.
  final DataOrigin? dataOrigin;

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
    DateTime? lastModifiedTime,
    String? clientRecordId,
    int? clientRecordVersion,
    Device? device,
    RecordingMethod? recordingMethod,
  }) {
    return Metadata._(
      dataOrigin: dataOrigin,
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
