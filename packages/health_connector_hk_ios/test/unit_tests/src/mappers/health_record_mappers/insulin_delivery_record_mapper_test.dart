import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/insulin_delivery_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../utils/fake_data.dart';

void main() {
  group(
    'InsulinDeliveryRecordMapper',
    () {
      group(
        'InsulinDeliveryRecordToDto',
        () {
          test(
            'converts InsulinDeliveryRecord to InsulinDeliveryRecordDto',
            () {
              final record = InsulinDeliveryRecord(
                id: HealthRecordId(FakeData.fakeId),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                startZoneOffsetSeconds:
                    FakeData.fakeStartTime.timeZoneOffset.inSeconds,
                endZoneOffsetSeconds:
                    FakeData.fakeEndTime.timeZoneOffset.inSeconds,
                metadata: Metadata.internal(
                  dataOrigin: const DataOrigin(FakeData.fakeDataOrigin),
                  recordingMethod: RecordingMethod.manualEntry,
                  clientRecordVersion: 1,
                  device: const Device(type: DeviceType.phone),
                ),
                units: const Number(10.5),
                reason: InsulinDeliveryReason.basal,
              );

              final dto = record.toDto();

              expect(dto.id, FakeData.fakeId);
              expect(
                dto.startTime,
                FakeData.fakeStartTime.millisecondsSinceEpoch,
              );
              expect(dto.endTime, FakeData.fakeEndTime.millisecondsSinceEpoch);
              expect(
                dto.startZoneOffsetSeconds,
                FakeData.fakeStartTime.timeZoneOffset.inSeconds,
              );
              expect(
                dto.endZoneOffsetSeconds,
                FakeData.fakeEndTime.timeZoneOffset.inSeconds,
              );
              expect(dto.units, 10.5);
              expect(dto.reason, InsulinDeliveryReasonDto.basal);
              expect(dto.metadata.dataOrigin, FakeData.fakeDataOrigin);
            },
          );
        },
      );

      group(
        'InsulinDeliveryRecordDtoToDomain',
        () {
          test(
            'converts InsulinDeliveryRecordDto to InsulinDeliveryRecord',
            () {
              final dto = InsulinDeliveryRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                units: 15.0,
                reason: InsulinDeliveryReasonDto.bolus,
              );

              final record = dto.toDomain();

              expect(record.id.value, FakeData.fakeId);
              expect(record.startTime, FakeData.fakeStartTime);
              expect(record.endTime, FakeData.fakeEndTime);
              expect(record.units.value, 15.0);
              expect(record.reason, InsulinDeliveryReason.bolus);
              expect(
                record.metadata.dataOrigin?.packageName,
                FakeData.fakeDataOrigin,
              );
            },
          );

          test(
            'converts InsulinDeliveryRecordDto with null id to domain with '
            'none id',
            () {
              final dto = InsulinDeliveryRecordDto(
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.manualEntry,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                units: 20.0,
                reason: InsulinDeliveryReasonDto.basal,
              );

              final record = dto.toDomain();

              expect(record.id, HealthRecordId.none);
              expect(record.units.value, 20.0);
              expect(record.reason, InsulinDeliveryReason.basal);
            },
          );

          test(
            'converts InsulinDeliveryRecordDto with zero units',
            () {
              final dto = InsulinDeliveryRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                units: 0.0,
                reason: InsulinDeliveryReasonDto.basal,
              );

              final record = dto.toDomain();

              expect(record.units.value, 0.0);
              expect(record.reason, InsulinDeliveryReason.basal);
            },
          );

          test(
            'converts InsulinDeliveryRecordDto with maximum units',
            () {
              final dto = InsulinDeliveryRecordDto(
                id: FakeData.fakeId,
                startTime: FakeData.fakeStartTime.millisecondsSinceEpoch,
                endTime: FakeData.fakeEndTime.millisecondsSinceEpoch,
                startZoneOffsetSeconds: 0,
                endZoneOffsetSeconds: 0,
                metadata: MetadataDto(
                  dataOrigin: FakeData.fakeDataOrigin,
                  recordingMethod: RecordingMethodDto.activelyRecorded,
                  clientRecordVersion: 1,
                  deviceType: DeviceTypeDto.phone,
                ),
                units: 500.0,
                reason: InsulinDeliveryReasonDto.bolus,
              );

              final record = dto.toDomain();

              expect(record.units.value, 500.0);
              expect(record.reason, InsulinDeliveryReason.bolus);
            },
          );
        },
      );
    },
  );
}
