import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:test/test.dart';

void main() {
  group(
    'HealthRecordIdMapper',
    () {
      group(
        'HealthRecordIdFromDomainToDto',
        () {
          test(
            'converts HealthRecordId to String',
            () {
              final id = HealthRecordId('test-id-123');
              final dto = id.toDto();

              expect(dto, 'test-id-123');
            },
          );

          test(
            'converts HealthRecordId.none to empty string',
            () {
              final dto = HealthRecordId.none.toDto();

              expect(dto, '');
            },
          );
        },
      );

      group(
        'HealthRecordIdFromDtoToDomain',
        () {
          test(
            'converts String to HealthRecordId',
            () {
              const dto = 'test-id-456';
              final id = dto.toDomain();

              expect(id.value, 'test-id-456');
            },
          );

          test(
            'converts empty string to HealthRecordId.none',
            () {
              const dto = '';
              final id = dto.toDomain();

              expect(id, HealthRecordId.none);
            },
          );
        },
      );
    },
  );
}
