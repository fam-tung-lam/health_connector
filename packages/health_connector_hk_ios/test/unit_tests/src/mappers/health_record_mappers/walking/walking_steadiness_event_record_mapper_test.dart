import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/walking/walking_steadiness_event_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('WalkingSteadinessEventRecordMapper', () {
    group('WalkingSteadinessEventRecordDtoToDomain', () {
      test(
        'converts WalkingSteadinessEventRecordDto to '
        'WalkingSteadinessEventRecord',
        () {
          final dto = WalkingSteadinessEventRecordDto(
            id: FakeData.fakeId,
            startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
            endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
            metadata: MetadataDto(
              dataOrigin: FakeData.fakeDataOrigin,
              recordingMethod: RecordingMethodDto.manualEntry,
              clientRecordVersion: 1,
              deviceType: DeviceTypeDto.phone,
            ),
            type: WalkingSteadinessTypeDto.initialLow,
          );

          final record = dto.toDomain();

          expect(record.id.value, FakeData.fakeId);
          expect(record.startTime, FakeData.fakeStartTime);
          expect(record.endTime, FakeData.fakeEndTime);
          expect(
            record.metadata.dataOrigin?.packageName,
            FakeData.fakeDataOrigin,
          );
          expect(record.type.name, 'initialLow');
        },
      );
    });
  });

  group('WalkingSteadinessTypeDtoMapper', () {
    test('maps initialLow correctly', () {
      expect(
        WalkingSteadinessTypeDto.initialLow.toDomain().name,
        'initialLow',
      );
    });

    test('maps repeatLow correctly', () {
      expect(
        WalkingSteadinessTypeDto.repeatLow.toDomain().name,
        'repeatLow',
      );
    });

    test('maps initialVeryLow correctly', () {
      expect(
        WalkingSteadinessTypeDto.initialVeryLow.toDomain().name,
        'initialVeryLow',
      );
    });

    test('maps repeatVeryLow correctly', () {
      expect(
        WalkingSteadinessTypeDto.repeatVeryLow.toDomain().name,
        'repeatVeryLow',
      );
    });
  });
}
