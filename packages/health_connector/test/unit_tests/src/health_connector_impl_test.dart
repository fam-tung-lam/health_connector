import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector/src/health_connector_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../utils/fake_data.dart';

class MockHealthConnectorClient extends Mock
    implements HealthConnectorPlatformClient {}

void main() {
  late MockHealthConnectorClient mockClient;

  setUpAll(
    () {
      // Register fallback values for complex types
      registerFallbackValue(
        const HealthDataPermission(
          dataType: HealthDataType.steps,
          accessType: HealthDataPermissionAccessType.read,
        ),
      );
      registerFallbackValue(HealthPlatformFeature.readHealthDataHistory);
      registerFallbackValue(
        ReadRecordByIdRequest<StepsRecord>(
          dataType: HealthDataType.steps,
          id: HealthRecordId(FakeData.fakeId),
        ),
      );
      registerFallbackValue(
        ReadRecordsInTimeRangeRequest<StepsRecord>(
          dataType: HealthDataType.steps,
          startTime: FakeData.fakeStartTime,
          endTime: FakeData.fakeEndTime,
        ),
      );
      registerFallbackValue(
        StandardAggregateRequest<Number>(
          dataType: HealthDataType.steps,
          startTime: FakeData.fakeStartTime,
          endTime: FakeData.fakeEndTime,
          aggregationMetric: AggregationMetric.sum,
        ),
      );
      registerFallbackValue(
        DeleteRecordsInTimeRangeRequest(
          dataType: HealthDataType.steps,
          startTime: FakeData.fakeStartTime,
          endTime: FakeData.fakeEndTime,
        ),
      );
      registerFallbackValue(
        DeleteRecordsByIdsRequest(
          dataType: HealthDataType.steps,
          recordIds: [HealthRecordId(FakeData.fakeId)],
        ),
      );
      registerFallbackValue(
        StepsRecord(
          count: const Number(100),
          startTime: FakeData.fakeStartTime,
          endTime: FakeData.fakeEndTime,
          metadata: Metadata.manualEntry(),
        ),
      );
      registerFallbackValue(const <StepsRecord>[]);
      registerFallbackValue(
        ReadRecordByIdRequest<BoneMassRecord>(
          dataType: HealthDataType.boneMass,
          id: HealthRecordId(FakeData.fakeId),
        ),
      );
      registerFallbackValue(
        ReadRecordsInTimeRangeRequest<BoneMassRecord>(
          dataType: HealthDataType.boneMass,
          startTime: FakeData.fakeStartTime,
          endTime: FakeData.fakeEndTime,
        ),
      );
      registerFallbackValue(
        DeleteRecordsInTimeRangeRequest(
          dataType: HealthDataType.boneMass,
          startTime: FakeData.fakeStartTime,
          endTime: FakeData.fakeEndTime,
        ),
      );
      registerFallbackValue(
        StandardAggregateRequest<Energy>(
          dataType: HealthDataType.totalEnergyBurned,
          startTime: FakeData.fakeStartTime,
          endTime: FakeData.fakeEndTime,
          aggregationMetric: AggregationMetric.sum,
        ),
      );
    },
  );

  setUp(
    () {
      mockClient = MockHealthConnectorClient();
    },
  );

  group(
    'HealthConnectorImpl',
    () {
      group(
        'requestPermissions',
        () {
          test(
            'GIVEN granted permissions → '
            'WHEN requestPermissions is called → '
            'THEN returns permission results',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              const permissions = [
                HealthDataPermission(
                  dataType: HealthDataType.steps,
                  accessType: HealthDataPermissionAccessType.read,
                ),
              ];
              final expectedResults = [
                const PermissionRequestResult(
                  permission: HealthDataPermission(
                    dataType: HealthDataType.steps,
                    accessType: HealthDataPermissionAccessType.read,
                  ),
                  status: PermissionStatus.granted,
                ),
              ];

              when(
                () => mockClient.requestPermissions(any()),
              ).thenAnswer((_) async => expectedResults);

              // WHEN
              final result = await connector.requestPermissions(permissions);

              // THEN
              expect(result, equals(expectedResults));
              verify(
                () => mockClient.requestPermissions(permissions),
              ).called(1);
            },
          );

          test(
            'GIVEN empty permissions list → '
            'WHEN requestPermissions is called → '
            'THEN returns empty list without API call',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );

              // WHEN
              final result = await connector.requestPermissions([]);

              // THEN
              expect(result, isEmpty);
              verifyNever(() => mockClient.requestPermissions(any()));
            },
          );

          test(
            'GIVEN exception from platform client → '
            'WHEN requestPermissions is called → '
            'THEN rethrows HealthConnectorException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              const permissions = [
                HealthDataPermission(
                  dataType: HealthDataType.steps,
                  accessType: HealthDataPermissionAccessType.read,
                ),
              ];

              when(() => mockClient.requestPermissions(any())).thenThrow(
                const UnknownException('Fake exception'),
              );

              // WHEN & THEN
              expect(
                () => connector.requestPermissions(permissions),
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );

          test(
            'GIVEN unsupported permission on platform → '
            'WHEN requestPermissions is called → '
            'THEN throws UnsupportedOperationException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.appleHealth,
                healthPlatformClient: mockClient,
              );
              const permissions = [
                HealthDataPermission(
                  dataType: HealthDataType.boneMass,
                  accessType: HealthDataPermissionAccessType.read,
                ),
              ];

              // WHEN & THEN
              await expectLater(
                connector.requestPermissions(permissions),
                throwsA(
                  isA<UnsupportedOperationException>().having(
                    (e) => e.message,
                    'message',
                    contains('not supported on HealthPlatform.appleHealth'),
                  ),
                ),
              );
              verifyNever(() => mockClient.requestPermissions(any()));
            },
          );
        },
      );

      group(
        'getPermissionStatus',
        () {
          test(
            'GIVEN permission → '
            'WHEN getPermissionStatus is called → '
            'THEN returns status from client',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              const permission = HealthDataPermission(
                dataType: HealthDataType.steps,
                accessType: HealthDataPermissionAccessType.read,
              );

              when(
                () => mockClient.getPermissionStatus(any()),
              ).thenAnswer((_) async => PermissionStatus.granted);

              // WHEN
              final result = await connector.getPermissionStatus(permission);

              // THEN
              expect(result, equals(PermissionStatus.granted));
              verify(
                () => mockClient.getPermissionStatus(permission),
              ).called(1);
            },
          );

          test(
            'GIVEN exception from client → '
            'WHEN getPermissionStatus is called → '
            'THEN rethrows exception',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              const permission = HealthDataPermission(
                dataType: HealthDataType.steps,
                accessType: HealthDataPermissionAccessType.read,
              );

              when(
                () => mockClient.getPermissionStatus(any()),
              ).thenThrow(
                const UnknownException('Fake exception'),
              );

              // WHEN & THEN
              expect(
                () => connector.getPermissionStatus(permission),
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );

          test(
            'GIVEN unsupported permission on platform → '
            'WHEN getPermissionStatus is called → '
            'THEN throws UnsupportedOperationException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.appleHealth,
                healthPlatformClient: mockClient,
              );
              const permission = HealthDataPermission(
                dataType: HealthDataType.boneMass,
                accessType: HealthDataPermissionAccessType.read,
              );

              // WHEN & THEN
              await expectLater(
                connector.getPermissionStatus(permission),
                throwsA(
                  isA<UnsupportedOperationException>().having(
                    (e) => e.message,
                    'message',
                    contains('not supported on HealthPlatform.appleHealth'),
                  ),
                ),
              );
              verifyNever(() => mockClient.getPermissionStatus(any()));
            },
          );
        },
      );

      group(
        'readRecord',
        () {
          test(
            'GIVEN record exists → '
            'WHEN readRecord is called → '
            'THEN returns record from client',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = ReadRecordByIdRequest<StepsRecord>(
                dataType: HealthDataType.steps,
                id: HealthRecordId(FakeData.fakeId),
              );
              final expectedRecord = StepsRecord(
                count: const Number(100),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                id: HealthRecordId(FakeData.fakeId),
                metadata: Metadata.manualEntry(),
              );

              when(
                () => mockClient.readRecord(
                  any<ReadRecordByIdRequest<StepsRecord>>(),
                ),
              ).thenAnswer((_) async => expectedRecord);

              // WHEN
              final result = await connector.readRecord(request);

              // THEN
              expect(result, equals(expectedRecord));
              verify(() => mockClient.readRecord(request)).called(1);
            },
          );

          test(
            'GIVEN record does not exist → '
            'WHEN readRecord is called → '
            'THEN returns null',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = ReadRecordByIdRequest<StepsRecord>(
                dataType: HealthDataType.steps,
                id: HealthRecordId(FakeData.fakeId),
              );

              when(
                () => mockClient.readRecord(
                  any<ReadRecordByIdRequest<StepsRecord>>(),
                ),
              ).thenAnswer((_) async => null);

              // WHEN
              final result = await connector.readRecord(request);

              // THEN
              expect(result, isNull);
              verify(() => mockClient.readRecord(request)).called(1);
            },
          );

          test(
            'GIVEN exception from client → '
            'WHEN readRecord is called → '
            'THEN rethrows exception',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = ReadRecordByIdRequest<StepsRecord>(
                dataType: HealthDataType.steps,
                id: HealthRecordId(FakeData.fakeId),
              );

              when(
                () => mockClient.readRecord(
                  any<ReadRecordByIdRequest<StepsRecord>>(),
                ),
              ).thenThrow(
                const UnknownException('Fake exception'),
              );

              // WHEN & THEN
              expect(
                () => connector.readRecord(request),
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );

          test(
            'GIVEN unsupported data type on platform → '
            'WHEN readRecord is called → '
            'THEN throws UnsupportedOperationException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.appleHealth,
                healthPlatformClient: mockClient,
              );
              final request = ReadRecordByIdRequest<BoneMassRecord>(
                dataType: HealthDataType.boneMass,
                id: HealthRecordId(FakeData.fakeId),
              );

              // WHEN & THEN
              await expectLater(
                connector.readRecord(request),
                throwsA(
                  isA<UnsupportedOperationException>().having(
                    (e) => e.message,
                    'message',
                    contains('not supported on HealthPlatform.appleHealth'),
                  ),
                ),
              );
              verifyNever(
                () => mockClient.readRecord(
                  any<ReadRecordByIdRequest<BoneMassRecord>>(),
                ),
              );
            },
          );
        },
      );

      group(
        'readRecords',
        () {
          test(
            'GIVEN time range request → '
            'WHEN readRecords is called → '
            'THEN returns records from client',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = ReadRecordsInTimeRangeRequest<StepsRecord>(
                dataType: HealthDataType.steps,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );
              final expectedResponse = ReadRecordsInTimeRangeResponse(
                records: [
                  StepsRecord(
                    count: const Number(100),
                    startTime: FakeData.fakeStartTime,
                    endTime: FakeData.fakeEndTime,
                    metadata: Metadata.manualEntry(),
                  ),
                ],
              );

              when(
                () => mockClient.readRecords(
                  any<ReadRecordsInTimeRangeRequest<StepsRecord>>(),
                ),
              ).thenAnswer((_) async => expectedResponse);

              // WHEN
              final result = await connector.readRecords(request);

              // THEN
              expect(result, equals(expectedResponse));
              verify(() => mockClient.readRecords(request)).called(1);
            },
          );

          test(
            'GIVEN exception from client → '
            'WHEN readRecords is called → '
            'THEN rethrows exception',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = ReadRecordsInTimeRangeRequest<StepsRecord>(
                dataType: HealthDataType.steps,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              when(
                () => mockClient.readRecords(
                  any<ReadRecordsInTimeRangeRequest<StepsRecord>>(),
                ),
              ).thenThrow(
                const UnknownException('Fake exception'),
              );

              // WHEN & THEN
              expect(
                () => connector.readRecords(request),
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );

          test(
            'GIVEN unsupported data type on platform → '
            'WHEN readRecords is called → '
            'THEN throws UnsupportedOperationException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.appleHealth,
                healthPlatformClient: mockClient,
              );
              final request = ReadRecordsInTimeRangeRequest<BoneMassRecord>(
                dataType: HealthDataType.boneMass,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              // WHEN & THEN
              await expectLater(
                connector.readRecords(request),
                throwsA(
                  isA<UnsupportedOperationException>().having(
                    (e) => e.message,
                    'message',
                    contains('not supported on HealthPlatform.appleHealth'),
                  ),
                ),
              );
              verifyNever(
                () => mockClient.readRecords(
                  any<ReadRecordsInTimeRangeRequest<BoneMassRecord>>(),
                ),
              );
            },
          );
        },
      );

      group(
        'writeRecord',
        () {
          test(
            'GIVEN valid record with HealthRecordId.none → '
            'WHEN writeRecord is called → '
            'THEN returns record ID from client',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final record = StepsRecord(
                count: const Number(100),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                metadata: Metadata.manualEntry(),
              );
              final expectedId = HealthRecordId('new-id');

              when(
                () => mockClient.writeRecord(
                  any<StepsRecord>(),
                ),
              ).thenAnswer((_) async => expectedId);

              // WHEN
              final result = await connector.writeRecord(record);

              // THEN
              expect(result, equals(expectedId));
              verify(() => mockClient.writeRecord(record)).called(1);
            },
          );

          test(
            'GIVEN record with existing ID → '
            'WHEN writeRecord is called → '
            'THEN throws InvalidArgumentException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final record = StepsRecord(
                count: const Number(100),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                id: HealthRecordId('existing-id'),
                metadata: Metadata.manualEntry(),
              );

              // WHEN & THEN
              expect(
                () => connector.writeRecord(record),
                throwsA(isA<InvalidArgumentException>()),
              );
              verifyNever(
                () => mockClient.writeRecord(
                  any<StepsRecord>(),
                ),
              );
            },
          );

          test(
            'GIVEN exception from client → '
            'WHEN writeRecord is called → '
            'THEN rethrows exception',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final record = StepsRecord(
                count: const Number(100),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                metadata: Metadata.manualEntry(),
              );

              when(
                () => mockClient.writeRecord(
                  any<StepsRecord>(),
                ),
              ).thenThrow(
                const UnknownException('Fake exception'),
              );

              // WHEN & THEN
              expect(
                () => connector.writeRecord(record),
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );
        },
      );

      group(
        'writeRecords',
        () {
          test(
            'GIVEN empty list → '
            'WHEN writeRecords is called → '
            'THEN returns empty list without API call',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );

              // WHEN
              final result = await connector.writeRecords(<StepsRecord>[]);

              // THEN
              expect(result, isEmpty);
              verifyNever(
                () => mockClient.writeRecords(
                  any<List<StepsRecord>>(),
                ),
              );
            },
          );

          test(
            'GIVEN valid records with HealthRecordId.none → '
            'WHEN writeRecords is called → '
            'THEN returns record IDs from client',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final records = [
                StepsRecord(
                  count: const Number(100),
                  startTime: FakeData.fakeStartTime,
                  endTime: FakeData.fakeEndTime,
                  metadata: Metadata.manualEntry(),
                ),
                StepsRecord(
                  count: const Number(200),
                  startTime: FakeData.fakeStartTime,
                  endTime: FakeData.fakeEndTime,
                  metadata: Metadata.manualEntry(),
                ),
              ];
              final expectedIds = [
                HealthRecordId('id-1'),
                HealthRecordId('id-2'),
              ];

              when(
                () => mockClient.writeRecords(
                  any<List<StepsRecord>>(),
                ),
              ).thenAnswer((_) async => expectedIds);

              // WHEN
              final result = await connector.writeRecords(records);

              // THEN
              expect(result, equals(expectedIds));
              verify(() => mockClient.writeRecords(records)).called(1);
            },
          );

          test(
            'GIVEN records with existing IDs → '
            'WHEN writeRecords is called → '
            'THEN throws InvalidArgumentException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final records = [
                StepsRecord(
                  count: const Number(100),
                  startTime: FakeData.fakeStartTime,
                  endTime: FakeData.fakeEndTime,
                  id: HealthRecordId('existing-id'),
                  metadata: Metadata.manualEntry(),
                ),
              ];

              // WHEN & THEN
              expect(
                () => connector.writeRecords(records),
                throwsA(isA<InvalidArgumentException>()),
              );
              verifyNever(
                () => mockClient.writeRecords(
                  any<List<StepsRecord>>(),
                ),
              );
            },
          );

          test(
            'GIVEN exception from client → '
            'WHEN writeRecords is called → '
            'THEN rethrows exception',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final records = [
                StepsRecord(
                  count: const Number(100),
                  startTime: FakeData.fakeStartTime,
                  endTime: FakeData.fakeEndTime,
                  metadata: Metadata.manualEntry(),
                ),
              ];

              when(
                () => mockClient.writeRecords(any<List<StepsRecord>>()),
              ).thenThrow(
                const UnknownException('Fake exception'),
              );

              // WHEN & THEN
              expect(
                () => connector.writeRecords(records),
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );
        },
      );

      group(
        'aggregate',
        () {
          test(
            'GIVEN aggregate request → '
            'WHEN aggregate is called → '
            'THEN returns aggregated value from client',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = StandardAggregateRequest<Number>(
                dataType: HealthDataType.steps,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                aggregationMetric: AggregationMetric.sum,
              );
              const expectedValue = Number(5000);

              when(
                () => mockClient.aggregate(
                  any<StandardAggregateRequest<Number>>(),
                ),
              ).thenAnswer((_) async => expectedValue);

              // WHEN
              final result = await connector.aggregate(request);

              // THEN
              expect(result, equals(expectedValue));
              verify(() => mockClient.aggregate(request)).called(1);
            },
          );

          test(
            'GIVEN exception from client → '
            'WHEN aggregate is called → '
            'THEN rethrows exception',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = StandardAggregateRequest<Number>(
                dataType: HealthDataType.steps,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                aggregationMetric: AggregationMetric.sum,
              );

              when(
                () => mockClient.aggregate(
                  any<StandardAggregateRequest<Number>>(),
                ),
              ).thenThrow(
                const UnknownException('Fake exception'),
              );

              // WHEN & THEN
              expect(
                () => connector.aggregate(request),
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );

          test(
            'GIVEN unsupported data type on platform → '
            'WHEN aggregate is called → '
            'THEN throws UnsupportedOperationException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.appleHealth,
                healthPlatformClient: mockClient,
              );
              // TotalEnergyBurnedDataType is HC-only and supports aggregation
              final request = StandardAggregateRequest<Energy>(
                dataType: HealthDataType.totalEnergyBurned,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                aggregationMetric: AggregationMetric.sum,
              );

              // WHEN & THEN
              await expectLater(
                connector.aggregate(request),
                throwsA(
                  isA<UnsupportedOperationException>().having(
                    (e) => e.message,
                    'message',
                    contains('not supported on HealthPlatform.appleHealth'),
                  ),
                ),
              );
              verifyNever(
                () => mockClient.aggregate(
                  any<StandardAggregateRequest<Energy>>(),
                ),
              );
            },
          );
        },
      );

      group(
        'deleteRecords',
        () {
          test(
            'GIVEN time range request → '
            'WHEN deleteRecords is called → '
            'THEN completes successfully',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = DeleteRecordsInTimeRangeRequest(
                dataType: HealthDataType.steps,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              when(
                () => mockClient.deleteRecords(
                  any<DeleteRecordsInTimeRangeRequest>(),
                ),
              ).thenAnswer((_) async {});

              // WHEN
              await connector.deleteRecords(request);

              // THEN
              verify(() => mockClient.deleteRecords(request)).called(1);
            },
          );

          test(
            'GIVEN by IDs request with empty list → '
            'WHEN deleteRecords is called → '
            'THEN returns early without API call',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = DeleteRecordsByIdsRequest(
                dataType: HealthDataType.steps,
                recordIds: const [],
              );

              // WHEN
              await connector.deleteRecords(request);

              // THEN
              verifyNever(
                () => mockClient.deleteRecords(
                  any<DeleteRecordsByIdsRequest>(),
                ),
              );
            },
          );

          test(
            'GIVEN by IDs request with record IDs → '
            'WHEN deleteRecords is called → '
            'THEN completes successfully',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = DeleteRecordsByIdsRequest(
                dataType: HealthDataType.steps,
                recordIds: [
                  HealthRecordId('id-1'),
                  HealthRecordId('id-2'),
                ],
              );

              when(
                () => mockClient.deleteRecords(
                  any<DeleteRecordsByIdsRequest>(),
                ),
              ).thenAnswer((_) async {});

              // WHEN
              await connector.deleteRecords(request);

              // THEN
              verify(() => mockClient.deleteRecords(request)).called(1);
            },
          );

          test(
            'GIVEN exception from client → '
            'WHEN deleteRecords is called → '
            'THEN rethrows exception',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final request = DeleteRecordsInTimeRangeRequest(
                dataType: HealthDataType.steps,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              when(
                () => mockClient.deleteRecords(
                  any<DeleteRecordsInTimeRangeRequest>(),
                ),
              ).thenThrow(
                const UnknownException('Fake exception'),
              );

              // WHEN & THEN
              expect(
                () => connector.deleteRecords(request),
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );

          test(
            'GIVEN unsupported data type on platform → '
            'WHEN deleteRecords is called → '
            'THEN throws UnsupportedOperationException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.appleHealth,
                healthPlatformClient: mockClient,
              );
              final request = DeleteRecordsInTimeRangeRequest(
                dataType: HealthDataType.boneMass,
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
              );

              // WHEN & THEN
              await expectLater(
                connector.deleteRecords(request),
                throwsA(
                  isA<UnsupportedOperationException>().having(
                    (e) => e.message,
                    'message',
                    contains('not supported on HealthPlatform.appleHealth'),
                  ),
                ),
              );
              verifyNever(
                () => mockClient.deleteRecords(
                  any<DeleteRecordsInTimeRangeRequest>(),
                ),
              );
            },
          );
        },
      );

      group(
        'updateRecord',
        () {
          test(
            'GIVEN Apple Health platform → '
            'WHEN updateRecord is called → '
            'THEN throws UnsupportedOperationException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.appleHealth,
                healthPlatformClient: mockClient,
              );
              final record = StepsRecord(
                count: const Number(100),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                id: HealthRecordId('existing-id'),
                metadata: Metadata.manualEntry(),
              );

              // WHEN & THEN
              expect(
                () => connector.updateRecord(record),
                throwsA(isA<UnsupportedOperationException>()),
              );
              verifyNever(
                () => mockClient.updateRecord(any<StepsRecord>()),
              );
            },
          );

          test(
            'GIVEN HealthConnect platform with valid record → '
            'WHEN updateRecord is called → '
            'THEN completes successfully',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final record = StepsRecord(
                count: const Number(100),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                id: HealthRecordId('existing-id'),
                metadata: Metadata.manualEntry(),
              );

              when(
                () => mockClient.updateRecord(
                  any<StepsRecord>(),
                ),
              ).thenAnswer((_) async {});

              // WHEN
              await connector.updateRecord(record);

              // THEN
              verify(() => mockClient.updateRecord(record)).called(1);
            },
          );

          test(
            'GIVEN record with HealthRecordId.none → '
            'WHEN updateRecord is called → '
            'THEN throws InvalidArgumentException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final record = StepsRecord(
                count: const Number(100),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                metadata: Metadata.manualEntry(),
              );

              // WHEN & THEN
              expect(
                () => connector.updateRecord(record),
                throwsA(isA<InvalidArgumentException>()),
              );
              verifyNever(
                () => mockClient.updateRecord(
                  any<StepsRecord>(),
                ),
              );
            },
          );

          test(
            'GIVEN exception from client → '
            'WHEN updateRecord is called → '
            'THEN rethrows exception',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final record = StepsRecord(
                count: const Number(100),
                startTime: FakeData.fakeStartTime,
                endTime: FakeData.fakeEndTime,
                id: HealthRecordId('existing-id'),
                metadata: Metadata.manualEntry(),
              );

              when(
                () => mockClient.updateRecord(any<StepsRecord>()),
              ).thenThrow(
                const UnknownException('Fake exception'),
              );

              // WHEN & THEN
              expect(
                () => connector.updateRecord(record),
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );
        },
      );

      group(
        'synchronize',
        () {
          test(
            'GIVEN unsupported data type on platform → '
            'WHEN synchronize is called → '
            'THEN throws UnsupportedOperationException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.appleHealth,
                healthPlatformClient: mockClient,
              );
              const dataTypes = [HealthDataType.boneMass];

              // WHEN & THEN
              await expectLater(
                connector.synchronize(
                  dataTypes: dataTypes,
                  syncToken: null,
                ),
                throwsA(
                  isA<UnsupportedOperationException>().having(
                    (e) => e.message,
                    'message',
                    contains('not supported on HealthPlatform.appleHealth'),
                  ),
                ),
              );
              verifyNever(
                () => mockClient.synchronize(
                  dataTypes: any(named: 'dataTypes'),
                  syncToken: any(named: 'syncToken'),
                ),
              );
            },
          );
        },
      );

      group(
        'updateRecords',
        () {
          test(
            'GIVEN Apple Health platform → '
            'WHEN updateRecords is called → '
            'THEN throws UnsupportedOperationException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.appleHealth,
                healthPlatformClient: mockClient,
              );
              final records = [
                StepsRecord(
                  count: const Number(100),
                  startTime: FakeData.fakeStartTime,
                  endTime: FakeData.fakeEndTime,
                  id: HealthRecordId('existing-id'),
                  metadata: Metadata.manualEntry(),
                ),
              ];

              // WHEN & THEN
              expect(
                () => connector.updateRecords(records),
                throwsA(isA<UnsupportedOperationException>()),
              );
              verifyNever(
                () => mockClient.updateRecords(
                  any<List<StepsRecord>>(),
                ),
              );
            },
          );

          test(
            'GIVEN HealthConnect platform with valid records → '
            'WHEN updateRecords is called → '
            'THEN completes successfully',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final records = [
                StepsRecord(
                  count: const Number(100),
                  startTime: FakeData.fakeStartTime,
                  endTime: FakeData.fakeEndTime,
                  id: HealthRecordId('id-1'),
                  metadata: Metadata.manualEntry(),
                ),
                StepsRecord(
                  count: const Number(200),
                  startTime: FakeData.fakeStartTime,
                  endTime: FakeData.fakeEndTime,
                  id: HealthRecordId('id-2'),
                  metadata: Metadata.manualEntry(),
                ),
              ];

              when(
                () => mockClient.updateRecords(
                  any<List<StepsRecord>>(),
                ),
              ).thenAnswer((_) async {});

              // WHEN
              await connector.updateRecords(records);

              // THEN
              verify(() => mockClient.updateRecords(records)).called(1);
            },
          );

          test(
            'GIVEN records with HealthRecordId.none → '
            'WHEN updateRecords is called → '
            'THEN throws InvalidArgumentException',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final records = [
                StepsRecord(
                  count: const Number(100),
                  startTime: FakeData.fakeStartTime,
                  endTime: FakeData.fakeEndTime,
                  metadata: Metadata.manualEntry(),
                ),
              ];

              // WHEN & THEN
              expect(
                () => connector.updateRecords(records),
                throwsA(isA<InvalidArgumentException>()),
              );
              verifyNever(
                () => mockClient.updateRecords(
                  any<List<StepsRecord>>(),
                ),
              );
            },
          );

          test(
            'GIVEN exception from client → '
            'WHEN updateRecords is called → '
            'THEN rethrows exception',
            () async {
              // GIVEN
              final connector = HealthConnectorImpl(
                config: const HealthConnectorConfig(),
                healthPlatform: HealthPlatform.healthConnect,
                healthPlatformClient: mockClient,
              );
              final records = [
                StepsRecord(
                  count: const Number(100),
                  startTime: FakeData.fakeStartTime,
                  endTime: FakeData.fakeEndTime,
                  id: HealthRecordId('id-1'),
                  metadata: Metadata.manualEntry(),
                ),
              ];

              when(
                () => mockClient.updateRecords(any<List<StepsRecord>>()),
              ).thenThrow(
                const UnknownException('Fake exception'),
              );

              // WHEN & THEN
              expect(
                () => connector.updateRecords(records),
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );
        },
      );
    },
  );
}
