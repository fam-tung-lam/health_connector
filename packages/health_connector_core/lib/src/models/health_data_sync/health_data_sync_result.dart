import 'package:collection/collection.dart' show ListEquality;
import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_data_sync/health_data_sync_token.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart';
import 'package:health_connector_core/src/models/responses/response.dart';
import 'package:meta/meta.dart' show immutable;

/// Result of a synchronization operation containing changes since the last
/// sync.
///
/// {@category Core API}
@sinceV3_0_0
@immutable
final class HealthDataSyncResult extends Response {
  /// Create a [HealthDataSyncResult] instance.
  const HealthDataSyncResult._({
    required this.upsertedRecords,
    required this.deletedRecordIds,
    required this.hasMore,
    required this.nextSyncToken,
  });

  /// Creates a [HealthDataSyncResult] instance.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory HealthDataSyncResult.internal({
    required List<HealthRecord> upsertedRecords,
    required List<HealthRecordId> deletedRecordIds,
    required bool hasMore,
    required HealthDataSyncToken? nextSyncToken,
  }) {
    return HealthDataSyncResult._(
      upsertedRecords: upsertedRecords,
      deletedRecordIds: deletedRecordIds,
      hasMore: hasMore,
      nextSyncToken: nextSyncToken,
    );
  }

  /// Records added or updated since the last sync.
  final List<HealthRecord> upsertedRecords;

  /// IDs of records deleted since the last sync.
  final List<HealthRecordId> deletedRecordIds;

  /// Whether more changes are available in the current sync snapshot.
  ///
  /// - `true`: Call synchronize() again with [nextSyncToken]
  /// - `false`: All changes up to current moment have been fetched
  final bool hasMore;

  /// Sync token for the next synchronization request.
  final HealthDataSyncToken? nextSyncToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthDataSyncResult &&
          runtimeType == other.runtimeType &&
          const ListEquality<HealthRecord>().equals(
            upsertedRecords,
            other.upsertedRecords,
          ) &&
          const ListEquality<HealthRecordId>().equals(
            deletedRecordIds,
            other.deletedRecordIds,
          ) &&
          hasMore == other.hasMore &&
          nextSyncToken == other.nextSyncToken;

  @override
  int get hashCode =>
      const ListEquality<HealthRecord>().hash(upsertedRecords) ^
      const ListEquality<HealthRecordId>().hash(deletedRecordIds) ^
      hasMore.hashCode ^
      nextSyncToken.hashCode;

  @override
  String toString() {
    return 'HealthDataSyncResult('
        'upsertedRecordsCount=${upsertedRecords.length}, '
        'deletedRecordIdsCount=${deletedRecordIds.length}, '
        'hasMore=$hasMore, '
        'nextSyncToken=$nextSyncToken'
        ')';
  }
}
