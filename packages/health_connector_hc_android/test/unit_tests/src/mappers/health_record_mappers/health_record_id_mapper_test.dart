import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:test/test.dart';

import '../../../utils/fake_data.dart';

void main() {
  const fakeId = 'test-id-123';

  group(
    'HealthRecordIdMapper',
    () {
      group(
        'HealthRecordIdToDto',
        () {
          test(
            'converts HealthRecordId to String',
            () {
              final id = HealthRecordId(FakeData.fakeId);
              final dto = id.toDto();

              expect(dto, FakeData.fakeId);
            },
          );

          test(
            'converts HealthRecordId.none to null',
            () {
              final dto = HealthRecordId.none.toDto();

              expect(dto, isNull);
            },
          );
        },
      );

      group(
        'StringToDomain',
        () {
          test(
            'converts non-null String to HealthRecordId',
            () {
              const dto = fakeId;
              final id = dto.toDomain();

              expect(id.value, FakeData.fakeId);
              expect(id, isNot(HealthRecordId.none));
            },
          );
        },
      );
    },
  );
}
