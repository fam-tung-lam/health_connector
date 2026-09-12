import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/activity/apple_stand_hour_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('AppleStandHourRecordDtoToDomain', () {
    parameterizedTest(
      'maps every stand-hour status',
      [
        [AppleStandHourStatusDto.stood, AppleStandHourStatus.stood],
        [AppleStandHourStatusDto.idle, AppleStandHourStatus.idle],
      ],
      (AppleStandHourStatusDto dtoStatus, AppleStandHourStatus domainStatus) {
        // Given
        final dto = AppleStandHourRecordDto(
          id: FakeData.fakeId,
          startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
          endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
          metadata: MetadataDto(
            dataOrigin: FakeData.fakeDataOrigin,
            recordingMethod: RecordingMethodDto.automaticallyRecorded,
            deviceType: DeviceTypeDto.watch,
          ),
          status: dtoStatus,
          startZoneOffsetSeconds: 7200,
          endZoneOffsetSeconds: 7200,
        );

        // When
        final record = dto.toDomain();

        // Then
        expect(record.id.value, FakeData.fakeId);
        expect(record.startTime, FakeData.fakeStartTime);
        expect(record.endTime, FakeData.fakeEndTime);
        expect(record.status, domainStatus);
        expect(record.startZoneOffsetSeconds, 7200);
        expect(record.endZoneOffsetSeconds, 7200);
        expect(
          record.metadata.dataOrigin?.packageName,
          FakeData.fakeDataOrigin,
        );
      },
    );
  });
}
