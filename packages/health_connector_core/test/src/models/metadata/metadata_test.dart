import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('Metadata', () {
    const testDataOrigin = DataOrigin('com.example.app');
    const testDevice = Device.fromType(DeviceType.phone);
    final testTime = DateTime(2026);
    const testClientId = 'client_123';
    const testClientVersion = 1;

    group('internal', () {
      test('creates metadata with all fields', () {
        final metadata = Metadata.internal(
          dataOrigin: testDataOrigin,
          recordingMethod: RecordingMethod.manualEntry,
          lastModifiedTime: testTime,
          clientRecordId: testClientId,
          clientRecordVersion: testClientVersion,
          device: testDevice,
        );

        expect(metadata.dataOrigin, equals(testDataOrigin));
        expect(metadata.recordingMethod, equals(RecordingMethod.manualEntry));
        expect(metadata.lastModifiedTime, equals(testTime));
        expect(metadata.clientRecordId, equals(testClientId));
        expect(metadata.clientRecordVersion, equals(testClientVersion));
        expect(metadata.device, equals(testDevice));
      });

      test('creates metadata with nullable fields as null', () {
        final metadata = Metadata.internal(
          recordingMethod: RecordingMethod.unknown,
        );

        expect(metadata.dataOrigin, isNull);
        expect(metadata.recordingMethod, equals(RecordingMethod.unknown));
        expect(metadata.lastModifiedTime, isNull);
        expect(metadata.clientRecordId, isNull);
        expect(metadata.clientRecordVersion, isNull);
        expect(metadata.device, isNull);
      });
    });

    group('manualEntry', () {
      test('creates metadata with correct recording method', () {
        final metadata = Metadata.manualEntry(
          clientRecordId: testClientId,
          clientRecordVersion: testClientVersion,
        );

        expect(metadata.recordingMethod, equals(RecordingMethod.manualEntry));
        expect(metadata.clientRecordId, equals(testClientId));
        expect(metadata.clientRecordVersion, equals(testClientVersion));
        expect(metadata.device, isNull);
        expect(metadata.dataOrigin, isNull);
      });
    });

    group('automaticallyRecorded', () {
      test('creates metadata with correct recording method', () {
        final metadata = Metadata.automaticallyRecorded(
          device: testDevice,
          clientRecordId: testClientId,
          clientRecordVersion: testClientVersion,
        );

        expect(
          metadata.recordingMethod,
          equals(RecordingMethod.automaticallyRecorded),
        );
        expect(metadata.device, equals(testDevice));
        expect(metadata.clientRecordId, equals(testClientId));
        expect(metadata.clientRecordVersion, equals(testClientVersion));
        expect(metadata.dataOrigin, isNull);
      });
    });

    group('activelyRecorded', () {
      test('creates metadata with correct recording method', () {
        final metadata = Metadata.activelyRecorded(
          device: testDevice,
          clientRecordId: testClientId,
          clientRecordVersion: testClientVersion,
        );

        expect(
          metadata.recordingMethod,
          equals(RecordingMethod.activelyRecorded),
        );
        expect(metadata.device, equals(testDevice));
        expect(metadata.clientRecordId, equals(testClientId));
        expect(metadata.clientRecordVersion, equals(testClientVersion));
        expect(metadata.dataOrigin, isNull);
      });
    });

    group('unknownRecordingMethod', () {
      test('creates metadata with correct recording method', () {
        final metadata = Metadata.unknownRecordingMethod(
          device: testDevice,
          clientRecordId: testClientId,
          clientRecordVersion: testClientVersion,
        );

        expect(metadata.recordingMethod, equals(RecordingMethod.unknown));
        expect(metadata.device, equals(testDevice));
        expect(metadata.clientRecordId, equals(testClientId));
        expect(metadata.clientRecordVersion, equals(testClientVersion));
        expect(metadata.dataOrigin, isNull);
      });
    });

    group('copyWith', () {
      final baseMetadata = Metadata.internal(
        dataOrigin: testDataOrigin,
        recordingMethod: RecordingMethod.manualEntry,
        lastModifiedTime: testTime,
        clientRecordId: testClientId,
        clientRecordVersion: testClientVersion,
        device: testDevice,
      );

      test('returns same object if no arguments provided', () {
        final copiedMetadata = baseMetadata.copyWith();
        expect(copiedMetadata, equals(baseMetadata));
      });

      test('updates provided fields', () {
        final newTime = DateTime(2023, 2, 2);
        const newDevice = Device.fromType(DeviceType.watch);
        const newClientId = 'new_client_id';
        const newVersion = 2;
        const newMethod = RecordingMethod.automaticallyRecorded;

        final copiedMetadata = baseMetadata.copyWith(
          lastModifiedTime: newTime,
          clientRecordId: newClientId,
          clientRecordVersion: newVersion,
          device: newDevice,
          recordingMethod: newMethod,
        );

        expect(
          copiedMetadata.dataOrigin,
          equals(testDataOrigin),
        ); // Should not change
        expect(copiedMetadata.lastModifiedTime, equals(newTime));
        expect(copiedMetadata.clientRecordId, equals(newClientId));
        expect(copiedMetadata.clientRecordVersion, equals(newVersion));
        expect(copiedMetadata.device, equals(newDevice));
        expect(copiedMetadata.recordingMethod, equals(newMethod));
      });
    });

    group('Equality and HashCode', () {
      test('identical instances are equal', () {
        final metadata = Metadata.manualEntry();
        expect(metadata, equals(metadata));
      });

      test('equal instances are equal', () {
        final metadataA = Metadata.manualEntry(clientRecordId: 'id');
        final metadataB = Metadata.manualEntry(clientRecordId: 'id');
        expect(metadataA, equals(metadataB));
        expect(metadataA.hashCode, equals(metadataB.hashCode));
      });

      test('different instances are not equal', () {
        final metadataA = Metadata.manualEntry(clientRecordId: 'id1');
        final metadataB = Metadata.manualEntry(clientRecordId: 'id2');
        expect(metadataA, isNot(equals(metadataB)));
      });
    });
  });
}
