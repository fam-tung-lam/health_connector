import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthDataSyncToken;
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthDataSyncTokenDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthDataSyncToken] to [HealthDataSyncTokenDto] for DTO transfer.
@internal
extension HealthDataSyncTokenFromDomainToDto on HealthDataSyncToken {
  HealthDataSyncTokenDto toDto() {
    return HealthDataSyncTokenDto(
      token: token,
      dataTypes: dataTypes.map((e) => e.toDto()).toList(),
      createdAtMillis: createdAt.millisecondsSinceEpoch,
    );
  }
}

/// Converts [HealthDataSyncTokenDto] to [HealthDataSyncToken].
@internal
extension HealthDataSyncTokenFromDtoToDomain on HealthDataSyncTokenDto {
  HealthDataSyncToken toDomain() {
    return HealthDataSyncToken.internal(
      token: token,
      dataTypes: dataTypes.map((e) => e.toDomain()).toList(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        createdAtMillis,
        isUtc: true,
      ),
    );
  }
}
