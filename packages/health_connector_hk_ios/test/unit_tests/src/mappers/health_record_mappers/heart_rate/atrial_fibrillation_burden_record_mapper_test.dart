import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/atrial_fibrillation_burden_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group(
    'AtrialFibrillationBurdenRecordMapper',
    () {
      group(
        'AtrialFibrillationBurdenRecordDtoToDomain',
        () {
          test(
            'converts AtrialFibrillationBurdenRecordDto to '
            'AtrialFibrillationBurdenRecord',
            () {
              final startTime = FakeData.fakeTime;
              final endTime = FakeData.fakeTime.add(const Duration(minutes: 5));

              final dto = AtrialFibrillationBurdenRecordDto(
                id: FakeData.fakeId,
                startTime: startTime.millisecondsSinceEpoch,
                endTime: endTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: startTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds: endTime.timeZoneOffset.inSeconds,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                percentage: 0.202,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, startTime);
              expect(record.endTime, endTime);
              expect(record.percentage.asDecimal, closeTo(0.202, 0.0001));
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );
        },
      );
    },
  );
}
