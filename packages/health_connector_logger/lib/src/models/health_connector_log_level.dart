/// Enum representing the different log levels.
///
/// Each level has a [name] field that contains the string representation
/// of the log level and a [value] field that contains the integer value
/// for `dart:developer.log`.
enum HealthConnectorLogLevel {
  /// Debug level for detailed diagnostic information.
  debug('DEBUG', 500),

  /// Info level for general informational messages.
  info('INFO', 800),

  /// Warning level for potential problems or unexpected behavior.
  warning('WARNING', 900),

  /// Error level for serious problems.
  error('ERROR', 1000);

  /// The string name of the log level.
  final String name;

  /// The integer value for `dart:developer.log`.
  final int value;

  /// Creates a [HealthConnectorLogLevel] with the given [name] and [value].
  const HealthConnectorLogLevel(this.name, this.value);
}
