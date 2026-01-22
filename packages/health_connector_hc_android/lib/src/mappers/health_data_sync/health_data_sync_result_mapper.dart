import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_data_sync/health_data_sync_token_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart';

/// Converts [HealthDataSyncResult] to [HealthDataSyncResultDto] for
/// DTO transfer.
@internal
extension HealthDataSyncResultFromDomainToDto on HealthDataSyncResult {
  HealthDataSyncResultDto toDto() {
    if (deletedRecordIds.any((id) => id == HealthRecordId.none)) {
      throw ArgumentError.value(
        deletedRecordIds,
        'deletedRecordIds',
        '`HealthDataSyncResult.deletedRecordIds` list cannot contain '
            '`HealthRecordId.none`.',
      );
    }

    return HealthDataSyncResultDto(
      upsertedRecords: upsertedRecords.map((e) => e.toDto()).toList(),
      deletedRecordIds: deletedRecordIds
          .map((e) => e.toDto())
          .cast<String>() // Safe cast because of the check above.
          .toList(),
      hasMore: hasMore,
      nextSyncToken: nextSyncToken?.toDto(),
    );
  }
}

/// Converts [HealthDataSyncResultDto] to [HealthDataSyncResult].
@internal
extension HealthDataSyncResultFromDtoToDomain on HealthDataSyncResultDto {
  HealthDataSyncResult toDomain() {
    return HealthDataSyncResult.internal(
      upsertedRecords: upsertedRecords.map((e) => e.toDomain()).toList(),
      deletedRecordIds: deletedRecordIds.map((e) => e.toDomain()).toList(),
      hasMore: hasMore,
      nextSyncToken: nextSyncToken?.toDomain(),
    );
  }
}
