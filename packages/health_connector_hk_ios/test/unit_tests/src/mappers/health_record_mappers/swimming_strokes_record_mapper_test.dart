import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/swimming_strokes_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group('SwimmingStrokesRecordMapper', () {
    final now = DateTime(2023, 10, 26, 8, 30).toUtc();
    final startTime = now;
    final endTime = now.add(const Duration(minutes: 30));
    const count = Number(500);
    final metadata = Metadata.manualEntry();

    final record = SwimmingStrokesRecord.internal(
      id: HealthRecordId('test-uuid'),
      startTime: startTime,
      endTime: endTime,
      count: count,
      metadata: metadata,
      startZoneOffsetSeconds: 3600,
      endZoneOffsetSeconds: 3600,
    );

    test('toDto maps correctly', () {
      final dto = record.toDto();

      expect(dto.id, 'test-uuid');
      expect(dto.count, 500.0);
      expect(dto.startTime, startTime.millisecondsSinceEpoch);
      expect(dto.endTime, endTime.millisecondsSinceEpoch);
      expect(dto.startZoneOffsetSeconds, 3600);
      expect(dto.endZoneOffsetSeconds, 3600);
      expect(dto.metadata, isA<MetadataDto>());
    });

    test('toDomain maps correctly', () {
      final dto = SwimmingStrokesRecordDto(
        id: 'test-uuid',
        startTime: startTime.millisecondsSinceEpoch,
        endTime: endTime.millisecondsSinceEpoch,
        count: 500.0,
        metadata: MetadataDto(
          dataOrigin: 'com.example.app',
          recordingMethod: RecordingMethodDto.manualEntry,
          deviceType: DeviceTypeDto.unknown,
        ),
        startZoneOffsetSeconds: 3600,
        endZoneOffsetSeconds: 3600,
      );

      final mappedRecord = dto.toDomain();

      expect(mappedRecord.id.value, 'test-uuid');
      // Time is converted to local in toDomain, so compare instants
      expect(
        mappedRecord.startTime.toUtc().millisecondsSinceEpoch,
        startTime.millisecondsSinceEpoch,
      );
      expect(
        mappedRecord.endTime.toUtc().millisecondsSinceEpoch,
        endTime.millisecondsSinceEpoch,
      );
      expect(mappedRecord.count, count);
      expect(mappedRecord.startZoneOffsetSeconds, 3600);
      expect(mappedRecord.endZoneOffsetSeconds, 3600);
    });

    test(
      'converts SwimmingStrokesRecordDto with null id to domain with none id',
      () {
        final dto = SwimmingStrokesRecordDto(
          startTime: startTime.millisecondsSinceEpoch,
          endTime: endTime.millisecondsSinceEpoch,
          count: 500.0,
          metadata: MetadataDto(
            dataOrigin: 'com.example.app',
            recordingMethod: RecordingMethodDto.manualEntry,
            deviceType: DeviceTypeDto.unknown,
          ),
          startZoneOffsetSeconds: 3600,
          endZoneOffsetSeconds: 3600,
        );

        final mappedRecord = dto.toDomain();

        expect(mappedRecord.id, HealthRecordId.none);
      },
    );
  });
}
