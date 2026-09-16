import 'package:flutter/foundation.dart' show immutable, listEquals;
import 'package:health_connector/health_connector.dart'
    show
        HealthConnectorErrorCode,
        HealthConnectorException,
        HealthDataSyncToken;

/// What started a background sync run.
enum BackgroundSyncTrigger {
  /// The platform scheduler ran the registered periodic task.
  scheduled('scheduled'),

  /// The developer tapped "Run now" in the toolbox UI.
  manual('manual')
  ;

  const BackgroundSyncTrigger(this.id);

  /// Stable identifier used in JSON.
  final String id;

  /// Returns the trigger matching [id], defaulting to [scheduled].
  static BackgroundSyncTrigger fromId(String? id) => values.firstWhere(
    (trigger) => trigger.id == id,
    orElse: () => BackgroundSyncTrigger.scheduled,
  );
}

/// How a background sync run ended.
enum BackgroundSyncOutcome {
  /// Every page was synchronized and the new token was stored.
  succeeded('succeeded'),

  /// The run stopped on an error; the stored token was left untouched.
  failed('failed'),

  /// Nothing was synchronized because no data types were selected.
  skipped('skipped')
  ;

  const BackgroundSyncOutcome(this.id);

  /// Stable identifier used in JSON.
  final String id;

  /// Returns the outcome matching [id], defaulting to [failed].
  static BackgroundSyncOutcome fromId(String? id) => values.firstWhere(
    (outcome) => outcome.id == id,
    orElse: () => BackgroundSyncOutcome.failed,
  );
}

/// Developer-facing snapshot of a [HealthDataSyncToken].
@immutable
final class SyncTokenSnapshot {
  const SyncTokenSnapshot({
    required this.token,
    required this.createdAt,
    required this.dataTypeIds,
  });

  factory SyncTokenSnapshot.fromToken(HealthDataSyncToken token) {
    return SyncTokenSnapshot(
      token: token.token,
      createdAt: token.createdAt,
      dataTypeIds: token.dataTypes.map((type) => type.id).toList(),
    );
  }

  factory SyncTokenSnapshot.fromJson(Map<String, dynamic> json) {
    return SyncTokenSnapshot(
      token: json['token'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      dataTypeIds: (json['dataTypeIds'] as List<dynamic>).cast<String>(),
    );
  }

  final String token;
  final DateTime createdAt;
  final List<String> dataTypeIds;

  Map<String, dynamic> toJson() => {
    'token': token,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'dataTypeIds': dataTypeIds,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncTokenSnapshot &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          createdAt == other.createdAt &&
          listEquals(dataTypeIds, other.dataTypeIds);

  @override
  int get hashCode =>
      Object.hash(token, createdAt, Object.hashAll(dataTypeIds));
}

/// Error that ended a background sync run.
@immutable
final class BackgroundSyncError {
  const BackgroundSyncError({
    required this.code,
    required this.message,
    required this.willRetry,
  });

  factory BackgroundSyncError.fromException(
    HealthConnectorException exception, {
    required bool willRetry,
  }) {
    return BackgroundSyncError(
      code: exception.code.name,
      message: exception.message,
      willRetry: willRetry,
    );
  }

  factory BackgroundSyncError.fromJson(Map<String, dynamic> json) {
    return BackgroundSyncError(
      code: json['code'] as String,
      message: json['message'] as String,
      willRetry: json['willRetry'] as bool? ?? false,
    );
  }

  /// [HealthConnectorErrorCode] name, or a Dart error type for other
  /// failures.
  final String code;
  final String message;

  /// Whether the task asked the scheduler to retry with backoff.
  final bool willRetry;

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'willRetry': willRetry,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackgroundSyncError &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          message == other.message &&
          willRetry == other.willRetry;

  @override
  int get hashCode => Object.hash(code, message, willRetry);
}

/// Everything a developer needs to know about the latest background sync run.
///
/// Only the most recent report is stored; each run replaces the previous one.
/// The report keeps record counts rather than the records themselves, so its
/// size does not depend on how much data a run returned. A fresh HealthKit
/// baseline can return years of samples, and the preferences store rejects
/// values above 4 MiB.
@immutable
final class BackgroundSyncReport {
  const BackgroundSyncReport({
    required this.trigger,
    required this.outcome,
    required this.startedAt,
    required this.finishedAt,
    required this.dataTypeIds,
    this.pageCount = 0,
    this.upsertedRecordCount = 0,
    this.deletedRecordCount = 0,
    this.tokenBefore,
    this.tokenAfter,
    this.tokenReset = false,
    this.error,
  });

  factory BackgroundSyncReport.fromJson(Map<String, dynamic> json) {
    final tokenBefore = json['tokenBefore'] as Map<String, dynamic>?;
    final tokenAfter = json['tokenAfter'] as Map<String, dynamic>?;
    final error = json['error'] as Map<String, dynamic>?;
    return BackgroundSyncReport(
      trigger: BackgroundSyncTrigger.fromId(json['trigger'] as String?),
      outcome: BackgroundSyncOutcome.fromId(json['outcome'] as String?),
      startedAt: DateTime.parse(json['startedAt'] as String),
      finishedAt: DateTime.parse(json['finishedAt'] as String),
      dataTypeIds: (json['dataTypeIds'] as List<dynamic>).cast<String>(),
      pageCount: json['pageCount'] as int? ?? 0,
      upsertedRecordCount: json['upsertedRecordCount'] as int? ?? 0,
      deletedRecordCount: json['deletedRecordCount'] as int? ?? 0,
      tokenBefore: tokenBefore == null
          ? null
          : SyncTokenSnapshot.fromJson(tokenBefore),
      tokenAfter: tokenAfter == null
          ? null
          : SyncTokenSnapshot.fromJson(tokenAfter),
      tokenReset: json['tokenReset'] as bool? ?? false,
      error: error == null ? null : BackgroundSyncError.fromJson(error),
    );
  }

  final BackgroundSyncTrigger trigger;
  final BackgroundSyncOutcome outcome;
  final DateTime startedAt;
  final DateTime finishedAt;

  /// Data types requested for the run, in selection order.
  final List<String> dataTypeIds;

  /// Number of `synchronize` calls the run needed, including pagination.
  final int pageCount;

  /// Total upserted records of the run across all pages.
  final int upsertedRecordCount;

  /// Total deleted records of the run across all pages.
  final int deletedRecordCount;

  /// Token loaded before the run, when one was stored.
  final SyncTokenSnapshot? tokenBefore;

  /// Token stored after the run, when the run succeeded.
  final SyncTokenSnapshot? tokenAfter;

  /// Whether the run had to discard the stored token and start from a new
  /// baseline, for example because it expired or the data types changed.
  final bool tokenReset;

  /// Error that ended the run, when [outcome] is
  /// [BackgroundSyncOutcome.failed].
  final BackgroundSyncError? error;

  Duration get duration => finishedAt.difference(startedAt);

  Map<String, dynamic> toJson() => {
    'trigger': trigger.id,
    'outcome': outcome.id,
    'startedAt': startedAt.toUtc().toIso8601String(),
    'finishedAt': finishedAt.toUtc().toIso8601String(),
    'dataTypeIds': dataTypeIds,
    'pageCount': pageCount,
    'upsertedRecordCount': upsertedRecordCount,
    'deletedRecordCount': deletedRecordCount,
    if (tokenBefore != null) 'tokenBefore': tokenBefore!.toJson(),
    if (tokenAfter != null) 'tokenAfter': tokenAfter!.toJson(),
    'tokenReset': tokenReset,
    if (error != null) 'error': error!.toJson(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackgroundSyncReport &&
          runtimeType == other.runtimeType &&
          trigger == other.trigger &&
          outcome == other.outcome &&
          startedAt == other.startedAt &&
          finishedAt == other.finishedAt &&
          listEquals(dataTypeIds, other.dataTypeIds) &&
          pageCount == other.pageCount &&
          upsertedRecordCount == other.upsertedRecordCount &&
          deletedRecordCount == other.deletedRecordCount &&
          tokenBefore == other.tokenBefore &&
          tokenAfter == other.tokenAfter &&
          tokenReset == other.tokenReset &&
          error == other.error;

  @override
  int get hashCode => Object.hash(
    trigger,
    outcome,
    startedAt,
    finishedAt,
    Object.hashAll(dataTypeIds),
    pageCount,
    upsertedRecordCount,
    deletedRecordCount,
    tokenBefore,
    tokenAfter,
    tokenReset,
    error,
  );

  @override
  String toString() =>
      'BackgroundSyncReport(trigger: ${trigger.id}, outcome: ${outcome.id}, '
      'pages: $pageCount, upserted: $upsertedRecordCount, '
      'deleted: $deletedRecordCount, tokenReset: $tokenReset, '
      'error: ${error?.code})';
}
