import 'package:flutter/foundation.dart' show immutable, mapEquals;
import 'package:health_connector/health_connector_internal.dart'
    show HealthConnectorLog, HealthConnectorLogLevel, HealthConnectorNativeLog;
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';

/// The Dart isolate that captured a console log entry.
///
/// The toolbox runs SDK code in the main UI isolate and in the background
/// isolate started by the platform scheduler. Each isolate keeps its own
/// persisted log list so that concurrent writes never overwrite each other.
enum ConsoleLogIsolate {
  /// The main UI isolate.
  main('main'),

  /// The headless background task isolate.
  background('background')
  ;

  const ConsoleLogIsolate(this.id);

  /// Stable identifier used in storage keys and JSON.
  final String id;

  /// Returns the isolate matching [id], defaulting to [main].
  static ConsoleLogIsolate fromId(String? id) {
    return values.firstWhere(
      (isolate) => isolate.id == id,
      orElse: () => ConsoleLogIsolate.main,
    );
  }
}

/// One immutable, JSON-serializable log event captured from the SDK logger.
///
/// The entry flattens a [HealthConnectorLog] into plain values so it can be
/// persisted, transferred between isolates, and rendered in the console.
@immutable
final class ConsoleLogEntry {
  const ConsoleLogEntry({
    required this.id,
    required this.timestamp,
    required this.level,
    required this.tag,
    required this.message,
    required this.origin,
    required this.isolate,
    this.operation,
    this.exception,
    this.context,
  });

  /// Creates an entry from an SDK [log] captured in [isolate].
  factory ConsoleLogEntry.fromHealthConnectorLog(
    HealthConnectorLog log, {
    required ConsoleLogIsolate isolate,
  }) {
    final origin = switch (log) {
      HealthConnectorNativeLog(:final platform) => platform,
      _ => dartOrigin,
    };
    final context = log.context?.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    final exception = log.exception?.toString();
    // The per-isolate sequence keeps two identical logs captured in the same
    // microsecond apart; the isolate id keeps sequences of different isolates
    // apart.
    final id =
        '${log.dateTime.microsecondsSinceEpoch}:${isolate.id}:${_sequence++}';

    return ConsoleLogEntry(
      id: id,
      timestamp: log.dateTime,
      level: log.level,
      tag: log.tag,
      message: log.message,
      origin: origin,
      isolate: isolate,
      operation: log.operation,
      exception: exception,
      context: context,
    );
  }

  /// Restores an entry written by [toJson].
  factory ConsoleLogEntry.fromJson(Map<String, dynamic> json) {
    return ConsoleLogEntry(
      id: json[_idKey] as String,
      timestamp: DateTime.fromMicrosecondsSinceEpoch(
        json[_timestampKey] as int,
      ),
      level: _levelFromName(json[_levelKey] as String?),
      tag: json[_tagKey] as String,
      message: json[_messageKey] as String,
      origin: json[_originKey] as String,
      isolate: ConsoleLogIsolate.fromId(json[_isolateKey] as String?),
      operation: json[_operationKey] as String?,
      exception: json[_exceptionKey] as String?,
      context: (json[_contextKey] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
  }

  /// Origin value used for logs emitted by Dart code.
  static const String dartOrigin = 'dart';

  static int _sequence = 0;

  /// Unique identifier used to de-duplicate entries across reloads.
  final String id;

  /// When the SDK produced the log.
  final DateTime timestamp;

  /// Severity of the log.
  final HealthConnectorLogLevel level;

  /// SDK component that produced the log.
  final String tag;

  /// Human-readable log message.
  final String message;

  /// Where the log came from: [dartOrigin] or the native platform name.
  final String origin;

  /// Isolate that captured the log.
  final ConsoleLogIsolate isolate;

  /// SDK operation in progress, when known.
  final String? operation;

  /// Stringified exception attached to the log, when any.
  final String? exception;

  /// Stringified structured context attached to the log, when any.
  final Map<String, String>? context;

  /// Whether the log was emitted by native platform code.
  bool get isNative => origin != dartOrigin;

  /// Single-line representation used in the console list and clipboard.
  String get formattedLine {
    final time = DateFormatter.formatTimeWithMilliseconds(timestamp);
    final operationPart = operation == null ? '' : ' $operation:';
    return '[$time] [${level.name}] [$tag]$operationPart $message';
  }

  /// Serializes the entry for persistence.
  Map<String, dynamic> toJson() => {
    _idKey: id,
    _timestampKey: timestamp.microsecondsSinceEpoch,
    _levelKey: level.name,
    _tagKey: tag,
    _messageKey: message,
    _originKey: origin,
    _isolateKey: isolate.id,
    if (operation != null) _operationKey: operation,
    if (exception != null) _exceptionKey: exception,
    if (context != null) _contextKey: context,
  };

  static HealthConnectorLogLevel _levelFromName(String? name) {
    return HealthConnectorLogLevel.values.firstWhere(
      (level) => level.name == name,
      orElse: () => HealthConnectorLogLevel.info,
    );
  }

  static const _idKey = 'id';
  static const _timestampKey = 'timestamp';
  static const _levelKey = 'level';
  static const _tagKey = 'tag';
  static const _messageKey = 'message';
  static const _originKey = 'origin';
  static const _isolateKey = 'isolate';
  static const _operationKey = 'operation';
  static const _exceptionKey = 'exception';
  static const _contextKey = 'context';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsoleLogEntry &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          timestamp == other.timestamp &&
          level == other.level &&
          tag == other.tag &&
          message == other.message &&
          origin == other.origin &&
          isolate == other.isolate &&
          operation == other.operation &&
          exception == other.exception &&
          mapEquals(context, other.context);

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    level,
    tag,
    message,
    origin,
    isolate,
    operation,
    exception,
    context == null
        ? null
        : Object.hashAllUnordered(
            context!.entries.map(
              (entry) => Object.hash(entry.key, entry.value),
            ),
          ),
  );

  @override
  String toString() => formattedLine;
}
