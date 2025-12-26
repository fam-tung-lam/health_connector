part of 'metadata.dart';

/// The method used to record health data.
///
/// Recording method describes how the health data was captured, which helps
/// assess data quality, reliability, and user intent. Different recording
/// methods have different characteristics and use cases.
@sinceV1_0_0
enum RecordingMethod {
  /// Recording method is unknown or cannot be determined.
  ///
  /// Use this when:
  /// - The recording method information is unavailable
  /// - You cannot verify how the data was captured
  /// - Migrating legacy data without method information
  unknown,

  /// Data was manually entered by the user.
  ///
  /// The user typed or input the data themselves, typically through a form
  /// or input field in an application. No device measurement was involved.
  ///
  /// **Common use cases:**
  /// - User logs their weight in an app
  /// - User enters food/meal information
  /// - User records medications taken
  manualEntry,

  /// Data was automatically recorded by a device in the background.
  ///
  /// The device captured data passively without explicit user action. This
  /// typically involves continuous or periodic monitoring throughout the day.
  ///
  /// **Common use cases:**
  /// - Smartwatch counting steps throughout the day
  /// - Continuous heart rate monitoring
  /// - Automatic sleep stage detection
  automaticallyRecorded,

  /// Data was recorded by a device with active user initiation.
  ///
  /// The user explicitly started a recording session or measurement.
  /// This indicates intentional data capture for a specific purpose.
  ///
  /// **Common use cases:**
  /// - User starts a exercise session on their watch
  /// - User begins tracking a specific exercise session
  /// - User starts a meditation or breathing session
  activelyRecorded,
}
