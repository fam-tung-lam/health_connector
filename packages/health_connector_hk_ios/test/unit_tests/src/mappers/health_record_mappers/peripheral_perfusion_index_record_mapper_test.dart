import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/peripheral_perfusion_index_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group('PeripheralPerfusionIndexRecordMapper', () {
    group('toDto', () {
      test(
        'converts PeripheralPerfusionIndexRecord to '
        'PeripheralPerfusionIndexRecordDto',
        () {
          final record = PeripheralPerfusionIndexRecord(
            id: HealthRecordId(FakeData.fakeId),
            time: FakeData.fakeStartTime,
            zoneOffsetSeconds: FakeData.fakeStartTime.timeZoneOffset.inSeconds,
            metadata: Metadata.internal(
              dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
              recordingMethod: RecordingMethod.activelyRecorded,
              clientRecordVersion: 1,
              device: const Device(type: DeviceType.phone),
            ),
            percentage: const Percentage.fromDecimal(0.85),
          );

          final dto = record.toDto();

          expect(dto.id, FakeData.fakeId);
          expect(
            dto.time,
            FakeData.fakeStartTime.millisecondsSinceEpoch,
          );
          expect(
            dto.zoneOffsetSeconds,
            FakeData.fakeStartTime.timeZoneOffset.inSeconds,
          );
          expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
          expect(dto.percentage, 0.85);
        },
      );
    });

    group('toDomain', () {
      test(
        'converts PeripheralPerfusionIndexRecordDto to '
        'PeripheralPerfusionIndexRecord',
        () {
          final dto = PeripheralPerfusionIndexRecordDto(
            id: FakeData.fakeId,
            time: FakeData.fakeStartTime.millisecondsSinceEpoch,
            zoneOffsetSeconds: 0,
            metadata: MetadataDto(
              dataOrigin: FakeData.fakeDataOrigin,
              recordingMethod: RecordingMethodDto.manualEntry,
              clientRecordVersion: 1,
              deviceType: DeviceTypeDto.phone,
            ),
            percentage: 0.90,
          );

          final record = dto.toDomain();

          expect(record.id.value, FakeData.fakeId);
          expect(record.time, FakeData.fakeStartTime);
          expect(
            record.metadata.dataOrigin?.packageName,
            FakeData.fakeDataOrigin,
          );
          expect(record.percentage.asDecimal, 0.90);
        },
      );

      test(
        'converts PeripheralPerfusionIndexRecordDto with null id to '
        'domain with none id',
        () {
          final dto = PeripheralPerfusionIndexRecordDto(
            time: FakeData.fakeStartTime.millisecondsSinceEpoch,
            zoneOffsetSeconds: 0,
            metadata: MetadataDto(
              dataOrigin: FakeData.fakeDataOrigin,
              recordingMethod: RecordingMethodDto.activelyRecorded,
              clientRecordVersion: 1,
              deviceType: DeviceTypeDto.watch,
            ),
            percentage: 0.95,
          );

          final record = dto.toDomain();

          expect(record.id, HealthRecordId.none);
        },
      );
    });
  });
}
