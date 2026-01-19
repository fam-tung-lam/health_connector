import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthDataSyncResult;
import 'package:health_connector_hk_ios/src/mappers/health_data_sync/health_data_sync_token_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthDataSyncResultDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthDataSyncResult] to [HealthDataSyncResultDto] for
/// DTO transfer.;
extension HealthDataSyncResultFromDomainToDto on HealthDataSyncResult {
  HealthDataSyncResultDto toDto() {
    return HealthDataSyncResultDto(
      upsertedRecords: upsertedRecords.map((e) => e.toDto()).toList(),
      deletedRecordIds: deletedRecordIds.map((e) => e.toDto()).toList(),
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
