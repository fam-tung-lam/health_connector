import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/health_connector_hc_client.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parameterized_test/parameterized_test.dart';

import '../utils/fake_data.dart';

class MockHealthConnectorHCAndroidApi extends Mock
    implements HealthConnectorHCAndroidApi {}

void main() {
  late MockHealthConnectorHCAndroidApi mockApi;

  setUpAll(
    () {
      // Initialize Flutter binding for EventChannel support
      TestWidgetsFlutterBinding.ensureInitialized();

      // Register fallback values for complex types
      registerFallbackValue(
        HealthConnectorConfigDto(isLoggerEnabled: false),
      );
      // Use a simpler fallback for initialization if needed
      registerFallbackValue(HealthPlatformFeatureDto.readHealthDataHistory);
      registerFallbackValue(
        PermissionRequestsDto(
          permissionRequests: [],
        ),
      );
      registerFallbackValue(
        HealthDataPermissionRequestDto(
          healthDataType: HealthDataTypeDto.steps,
          accessType: PermissionAccessTypeDto.read,
        ),
      );
      registerFallbackValue(
        ReadRecordRequestDto(
          dataType: HealthDataTypeDto.steps,
          recordId: 'test-id',
        ),
      );
      registerFallbackValue(
        ReadRecordsRequestDto(
          dataType: HealthDataTypeDto.steps,
          startTime: 0,
          endTime: 1000,
          pageSize: 100,
          dataOriginPackageNames: [],
        ),
      );
      registerFallbackValue(
        StandardAggregateRequestDto(
          dataType: HealthDataTypeDto.steps,
          startTime: 0,
          endTime: 1000,
          aggregationMetric: AggregationMetricDto.sum,
        ),
      );
      registerFallbackValue(
        DeleteRecordsByTimeRangeRequestDto(
          dataType: HealthDataTypeDto.steps,
          startTime: 0,
          endTime: 1000,
        ),
      );
      registerFallbackValue(
        StepsRecordDto(
          count: 100.0,
          startTime: 0,
          endTime: 1000,
          startZoneOffsetSeconds: 0,
          endZoneOffsetSeconds: 0,
          metadata: MetadataDto(
            dataOrigin: FakeData.fakeDataOrigin,
            recordingMethod: RecordingMethodDto.manualEntry,
            deviceType: DeviceTypeDto.unknown,
          ),
        ),
      );
      registerFallbackValue(<StepsRecordDto>[]);
    },
  );

  setUp(
    () {
      mockApi = MockHealthConnectorHCAndroidApi();
      HealthConnectorHCClient.platformClient = mockApi;
    },
  );

  group(
    HealthConnectorHCClient,
    () {
      group(
        HealthConnectorHCClient.getHealthPlatformStatus,
        () {
          parameterizedTest(
            'GIVEN any platform status → '
            'WHEN getHealthPlatformStatus is called → '
            'THEN returns expected status',
            [
              [
                HealthPlatformStatusDto.available,
                HealthPlatformStatus.available,
              ],
              [
                HealthPlatformStatusDto.notAvailable,
                HealthPlatformStatus.unavailable,
              ],
              [
                HealthPlatformStatusDto.installationOrUpdateRequired,
                HealthPlatformStatus.installationOrUpdateRequired,
              ],
            ],
            (
              HealthPlatformStatusDto status,
              HealthPlatformStatus expectedStatus,
            ) async {
              // GIVEN
              when(
                () => mockApi.getHealthPlatformStatus(),
              ).thenAnswer((_) async => status);

              // WHEN
              final result =
                  await HealthConnectorHCClient.getHealthPlatformStatus();

              // THEN
              expect(result, equals(expectedStatus));
              verify(() => mockApi.getHealthPlatformStatus()).called(1);
            },
          );

          test(
            'GIVEN PlatformException is thrown → '
            'WHEN getHealthPlatformStatus is called → '
            'THEN throws HealthConnectorException',
            () async {
              // GIVEN
              when(() => mockApi.getHealthPlatformStatus()).thenThrow(
                PlatformException(code: 'unknown', message: 'Test error'),
              );

              // WHEN & THEN
              expect(
                HealthConnectorHCClient.getHealthPlatformStatus,
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );
        },
      );

      group(
        HealthConnectorHCClient.launchHealthConnectPageInGooglePlay,
        () {
          test(
            'completes successfully when API succeeds',
            () async {
              when(
                () => mockApi.launchHealthConnectPageInGooglePlay(),
              ).thenAnswer(
                (_) async {},
              );

              await expectLater(
                HealthConnectorHCClient.launchHealthConnectPageInGooglePlay(),
                completes,
              );
              verify(
                () => mockApi.launchHealthConnectPageInGooglePlay(),
              ).called(1);
            },
          );

          test(
            'throws HealthConnectorException on PlatformException',
            () async {
              when(
                () => mockApi.launchHealthConnectPageInGooglePlay(),
              ).thenThrow(
                PlatformException(code: 'unknown', message: 'Test error'),
              );

              expect(
                HealthConnectorHCClient.launchHealthConnectPageInGooglePlay,
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );
        },
      );

      group(
        HealthConnectorHCClient.create,
        () {
          test(
            'initializes and returns client instance',
            () async {
              when(() => mockApi.initialize(any())).thenAnswer(
                (_) async {},
              );

              final client = await HealthConnectorHCClient.create();

              expect(client, isA<HealthConnectorHCClient>());
              verify(() => mockApi.initialize(any())).called(1);
            },
          );
        },
      );

      group(
        'instance methods',
        () {
          late HealthConnectorHCClient client;

          setUp(
            () async {
              when(() => mockApi.initialize(any())).thenAnswer(
                (_) async {},
              );
              client = await HealthConnectorHCClient.create();
            },
          );

          group(
            'requestPermissions',
            () {
              test(
                'returns empty list when empty permissions provided',
                () async {
                  final result = await client.requestPermissions([]);

                  expect(result, isEmpty);
                  verifyNever(() => mockApi.requestPermissions(any()));
                },
              );

              test(
                'returns permission results on success',
                () async {
                  when(() => mockApi.requestPermissions(any())).thenAnswer(
                    (_) async => [
                      HealthDataPermissionRequestResultDto(
                        permission: HealthDataPermissionRequestDto(
                          healthDataType: HealthDataTypeDto.steps,
                          accessType: PermissionAccessTypeDto.read,
                        ),
                        status: PermissionStatusDto.granted,
                      ),
                    ],
                  );

                  final result = await client.requestPermissions([
                    const HealthDataPermission(
                      dataType: HealthDataType.steps,
                      accessType: HealthDataPermissionAccessType.read,
                    ),
                  ]);

                  expect(result, hasLength(1));
                  expect(result.first.status, equals(PermissionStatus.granted));
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.requestPermissions(any())).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  expect(
                    () => client.requestPermissions([
                      const HealthDataPermission(
                        dataType: HealthDataType.steps,
                        accessType: HealthDataPermissionAccessType.read,
                      ),
                    ]),
                    throwsA(isA<HealthConnectorException>()),
                  );
                },
              );
            },
          );

          group(
            'getGrantedPermissions',
            () {
              test(
                'returns granted permissions',
                () async {
                  when(() => mockApi.getGrantedPermissions()).thenAnswer(
                    (_) async => [
                      HealthDataPermissionRequestResultDto(
                        permission: HealthDataPermissionRequestDto(
                          healthDataType: HealthDataTypeDto.steps,
                          accessType: PermissionAccessTypeDto.read,
                        ),
                        status: PermissionStatusDto.granted,
                      ),
                    ],
                  );

                  final result = await client.getGrantedPermissions();

                  expect(result, hasLength(1));
                  verify(() => mockApi.getGrantedPermissions()).called(1);
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.getGrantedPermissions()).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  expect(
                    () => client.getGrantedPermissions(),
                    throwsA(isA<HealthConnectorException>()),
                  );
                },
              );
            },
          );

          group(
            'getPermissionStatus',
            () {
              test(
                'returns granted status',
                () async {
                  when(
                    () => mockApi.getPermissionStatus(any()),
                  ).thenAnswer((_) async => PermissionStatusDto.granted);

                  final result = await client.getPermissionStatus(
                    const HealthDataPermission(
                      dataType: HealthDataType.steps,
                      accessType: HealthDataPermissionAccessType.read,
                    ),
                  );

                  expect(result, equals(PermissionStatus.granted));
                },
              );

              test(
                'returns denied status',
                () async {
                  when(
                    () => mockApi.getPermissionStatus(any()),
                  ).thenAnswer((_) async => PermissionStatusDto.denied);

                  final result = await client.getPermissionStatus(
                    const HealthDataPermission(
                      dataType: HealthDataType.steps,
                      accessType: HealthDataPermissionAccessType.read,
                    ),
                  );

                  expect(result, equals(PermissionStatus.denied));
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.getPermissionStatus(any())).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  expect(
                    () => client.getPermissionStatus(
                      const HealthDataPermission(
                        dataType: HealthDataType.steps,
                        accessType: HealthDataPermissionAccessType.read,
                      ),
                    ),
                    throwsA(isA<HealthConnectorException>()),
                  );
                },
              );
            },
          );

          group(
            'revokeAllPermissions',
            () {
              test(
                'completes successfully',
                () async {
                  when(() => mockApi.revokeAllPermissions()).thenAnswer(
                    (_) async {},
                  );

                  await expectLater(client.revokeAllPermissions(), completes);
                  verify(() => mockApi.revokeAllPermissions()).called(1);
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.revokeAllPermissions()).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  expect(
                    () => client.revokeAllPermissions(),
                    throwsA(isA<HealthConnectorException>()),
                  );
                },
              );
            },
          );

          group(
            'getFeatureStatus',
            () {
              test(
                'returns available status',
                () async {
                  when(() => mockApi.getFeatureStatus(any())).thenAnswer(
                    (_) async => HealthPlatformFeatureStatusDto.available,
                  );

                  final result = await client.getFeatureStatus(
                    HealthPlatformFeature.readHealthDataHistory,
                  );

                  expect(result, equals(HealthPlatformFeatureStatus.available));
                },
              );

              test(
                'returns unavailable status',
                () async {
                  when(() => mockApi.getFeatureStatus(any())).thenAnswer(
                    (_) async => HealthPlatformFeatureStatusDto.unavailable,
                  );

                  final result = await client.getFeatureStatus(
                    HealthPlatformFeature.readHealthDataHistory,
                  );

                  expect(
                    result,
                    equals(HealthPlatformFeatureStatus.unavailable),
                  );
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.getFeatureStatus(any())).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  expect(
                    () => client.getFeatureStatus(
                      HealthPlatformFeature.readHealthDataHistory,
                    ),
                    throwsA(isA<HealthConnectorException>()),
                  );
                },
              );
            },
          );

          group(
            'readRecord',
            () {
              test(
                'returns record when found',
                () async {
                  when(() => mockApi.readRecord(any())).thenAnswer(
                    (_) async => StepsRecordDto(
                      count: 100.0,
                      startTime: 0,
                      endTime: 1000,
                      startZoneOffsetSeconds: 0,
                      endZoneOffsetSeconds: 0,
                      metadata: MetadataDto(
                        clientRecordId: 'test-id',
                        dataOrigin: FakeData.fakeDataOrigin,
                        recordingMethod: RecordingMethodDto.manualEntry,
                        deviceType: DeviceTypeDto.unknown,
                      ),
                    ),
                  );

                  final result = await client.readRecord(
                    ReadRecordByIdRequest<StepsRecord>(
                      dataType: HealthDataType.steps,
                      id: HealthRecordId('test-id'),
                    ),
                  );

                  expect(result, isA<StepsRecord>());
                  expect(result?.count, equals(const Number(100)));
                },
              );

              test(
                'returns null when record not found',
                () async {
                  when(
                    () => mockApi.readRecord(any()),
                  ).thenAnswer((_) async => null);

                  final result = await client.readRecord(
                    ReadRecordByIdRequest<StepsRecord>(
                      dataType: HealthDataType.steps,
                      id: HealthRecordId('non-existent-id'),
                    ),
                  );

                  expect(result, isNull);
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.readRecord(any())).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  expect(
                    () => client.readRecord(
                      ReadRecordByIdRequest<StepsRecord>(
                        dataType: HealthDataType.steps,
                        id: HealthRecordId('test-id'),
                      ),
                    ),
                    throwsA(isA<HealthConnectorException>()),
                  );
                },
              );
            },
          );

          group(
            'readRecords',
            () {
              test(
                'returns records on success',
                () async {
                  when(() => mockApi.readRecords(any())).thenAnswer(
                    (_) async => ReadRecordsResponseDto(
                      records: [
                        StepsRecordDto(
                          count: 100.0,
                          startTime: 0,
                          endTime: 1000,
                          startZoneOffsetSeconds: 0,
                          endZoneOffsetSeconds: 0,
                          metadata: MetadataDto(
                            clientRecordId: 'test-id',
                            dataOrigin: FakeData.fakeDataOrigin,
                            recordingMethod: RecordingMethodDto.manualEntry,
                            deviceType: DeviceTypeDto.unknown,
                          ),
                        ),
                      ],
                    ),
                  );

                  final now = DateTime.now();
                  final result = await client.readRecords(
                    ReadRecordsInTimeRangeRequest<StepsRecord>(
                      dataType: HealthDataType.steps,
                      startTime: now.subtract(const Duration(days: 1)),
                      endTime: now,
                    ),
                  );

                  expect(result.records, hasLength(1));
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.readRecords(any())).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  final now = DateTime.now();
                  expect(
                    () => client.readRecords(
                      ReadRecordsInTimeRangeRequest<StepsRecord>(
                        dataType: HealthDataType.steps,
                        startTime: now.subtract(const Duration(days: 1)),
                        endTime: now,
                      ),
                    ),
                    throwsA(isA<HealthConnectorException>()),
                  );
                },
              );
            },
          );

          group(
            'writeRecord',
            () {
              test(
                'returns record ID on success',
                () async {
                  when(
                    () => mockApi.writeRecord(any()),
                  ).thenAnswer((_) async => 'new-record-id');

                  final now = DateTime.now();
                  final result = await client.writeRecord(
                    StepsRecord(
                      count: const Number(100),
                      startTime: now.subtract(const Duration(hours: 1)),
                      endTime: now,
                      metadata: Metadata.manualEntry(),
                    ),
                  );

                  expect(result.value, equals('new-record-id'));
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.writeRecord(any())).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  final now = DateTime.now();
                  expect(
                    () => client.writeRecord(
                      StepsRecord(
                        count: const Number(100),
                        startTime: now.subtract(const Duration(hours: 1)),
                        endTime: now,
                        metadata: Metadata.manualEntry(),
                      ),
                    ),
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
                'returns empty list when empty records provided',
                () async {
                  final result = await client.writeRecords(<StepsRecord>[]);

                  expect(result, isEmpty);
                  verifyNever(() => mockApi.writeRecords(any()));
                },
              );

              test(
                'returns record IDs on success',
                () async {
                  when(
                    () => mockApi.writeRecords(any()),
                  ).thenAnswer((_) async => ['id-1', 'id-2']);

                  final now = DateTime.now();
                  final result = await client.writeRecords([
                    StepsRecord(
                      count: const Number(100),
                      startTime: now.subtract(const Duration(hours: 2)),
                      endTime: now.subtract(const Duration(hours: 1)),
                      metadata: Metadata.manualEntry(),
                    ),
                    StepsRecord(
                      count: const Number(200),
                      startTime: now.subtract(const Duration(hours: 1)),
                      endTime: now,
                      metadata: Metadata.manualEntry(),
                    ),
                  ]);

                  expect(result, hasLength(2));
                  expect(result[0].value, equals('id-1'));
                  expect(result[1].value, equals('id-2'));
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.writeRecords(any())).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  final now = DateTime.now();
                  expect(
                    () => client.writeRecords([
                      StepsRecord(
                        count: const Number(100),
                        startTime: now.subtract(const Duration(hours: 1)),
                        endTime: now,
                        metadata: Metadata.manualEntry(),
                      ),
                    ]),
                    throwsA(isA<HealthConnectorException>()),
                  );
                },
              );
            },
          );

          group(
            'updateRecord',
            () {
              test(
                'completes successfully',
                () async {
                  when(() => mockApi.updateRecord(any())).thenAnswer(
                    (_) async {},
                  );

                  final now = DateTime.now();
                  await expectLater(
                    client.updateRecord(
                      StepsRecord(
                        count: const Number(150),
                        startTime: now.subtract(const Duration(hours: 1)),
                        endTime: now,
                        id: HealthRecordId('existing-id'),
                        metadata: Metadata.manualEntry(),
                      ),
                    ),
                    completes,
                  );
                  verify(() => mockApi.updateRecord(any())).called(1);
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.updateRecord(any())).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  final now = DateTime.now();
                  expect(
                    () => client.updateRecord(
                      StepsRecord(
                        count: const Number(150),
                        startTime: now.subtract(const Duration(hours: 1)),
                        endTime: now,
                        id: HealthRecordId('existing-id'),
                        metadata: Metadata.manualEntry(),
                      ),
                    ),
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
                'returns aggregated value on success',
                () async {
                  when(() => mockApi.aggregate(any())).thenAnswer(
                    (_) async => 5000.0,
                  );

                  final now = DateTime.now();
                  final result = await client.aggregate(
                    StandardAggregateRequest<Number>(
                      dataType: HealthDataType.steps,
                      startTime: now.subtract(const Duration(days: 1)),
                      endTime: now,
                      aggregationMetric: AggregationMetric.sum,
                    ),
                  );

                  expect(result, isA<Number>());
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.aggregate(any())).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  final now = DateTime.now();
                  expect(
                    () => client.aggregate(
                      StandardAggregateRequest<Number>(
                        dataType: HealthDataType.steps,
                        startTime: now.subtract(const Duration(days: 1)),
                        endTime: now,
                        aggregationMetric: AggregationMetric.sum,
                      ),
                    ),
                    throwsA(isA<HealthConnectorException>()),
                  );
                },
              );
            },
          );

          group(
            'deleteRecords',
            () {
              test(
                'completes successfully',
                () async {
                  when(() => mockApi.deleteRecords(any())).thenAnswer(
                    (_) async {},
                  );

                  final now = DateTime.now();
                  await expectLater(
                    client.deleteRecords(
                      DeleteRecordsInTimeRangeRequest(
                        dataType: HealthDataType.steps,
                        startTime: now.subtract(const Duration(days: 1)),
                        endTime: now,
                      ),
                    ),
                    completes,
                  );
                  verify(() => mockApi.deleteRecords(any())).called(1);
                },
              );

              test(
                'throws HealthConnectorException on PlatformException',
                () async {
                  when(() => mockApi.deleteRecords(any())).thenThrow(
                    PlatformException(code: 'unknown', message: 'Test error'),
                  );

                  final now = DateTime.now();
                  expect(
                    () => client.deleteRecords(
                      DeleteRecordsInTimeRangeRequest(
                        dataType: HealthDataType.steps,
                        startTime: now.subtract(const Duration(days: 1)),
                        endTime: now,
                      ),
                    ),
                    throwsA(isA<HealthConnectorException>()),
                  );
                },
              );
            },
          );
        },
      );
    },
  );
}
