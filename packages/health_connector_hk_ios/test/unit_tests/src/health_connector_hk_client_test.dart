import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/health_connector_hk_client.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parameterized_test/parameterized_test.dart';

import '../utils/fake_data.dart';

class MockHealthConnectorHKIOSApi extends Mock
    implements HealthConnectorHKIOSApi {}

void main() {
  late MockHealthConnectorHKIOSApi mockApi;

  setUpAll(
    () {
      // Initialize Flutter binding for EventChannel support
      TestWidgetsFlutterBinding.ensureInitialized();

      // Register fallback values for complex types
      registerFallbackValue(
        HealthConnectorConfigDto(isLoggerEnabled: false),
      );
      registerFallbackValue(
        HealthDataPermissionRequestDto(
          healthDataType: HealthDataTypeDto.steps,
          accessType: PermissionAccessTypeDto.read,
        ),
      );
      registerFallbackValue(
        PermissionsRequestDto(
          permissionRequests: [],
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
          count: 100,
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
    },
  );

  setUp(
    () {
      mockApi = MockHealthConnectorHKIOSApi();
      HealthConnectorHKClient.platformClient = mockApi;
    },
  );

  group(
    'HealthConnectorHKClient',
    () {
      group(
        'getHealthPlatformStatus',
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
                  await HealthConnectorHKClient.getHealthPlatformStatus();

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
                HealthConnectorHKClient.getHealthPlatformStatus,
                throwsA(isA<HealthConnectorException>()),
              );
            },
          );
        },
      );

      group(
        'create',
        () {
          test(
            'initializes and returns client instance',
            () async {
              when(() => mockApi.initialize(any())).thenAnswer(
                (_) async => OperatingSystemInfoDto(
                  majorVersion: 18,
                  minorVersion: 2,
                  patchVersion: 1,
                ),
              );

              final client = await HealthConnectorHKClient.create();

              expect(client, isA<HealthConnectorHKClient>());
              expect(
                client.operatingSystemInfo.version,
                const IOSVersion(18, 2, 1),
              );
              verify(() => mockApi.initialize(any())).called(1);
            },
          );
        },
      );

      group(
        'instance methods',
        () {
          late HealthConnectorHKClient client;

          setUp(
            () async {
              when(() => mockApi.initialize(any())).thenAnswer(
                (_) async => OperatingSystemInfoDto(
                  majorVersion: 18,
                  minorVersion: 0,
                  patchVersion: 0,
                ),
              );
              client = await HealthConnectorHKClient.create();
            },
          );

          group(
            'requestPermissions',
            () {
              test('requests characteristic-only native permissions', () async {
                // Given unknown native results for both characteristics.
                when(() => mockApi.requestPermissions(any())).thenAnswer(
                  (_) async => [
                    UserCharacteristicPermissionRequestResultDto(
                      permission: UserCharacteristicPermissionRequestDto(
                        characteristicType: UserCharacteristicTypeDto.birthDate,
                      ),
                      status: PermissionStatusDto.unknown,
                    ),
                    UserCharacteristicPermissionRequestResultDto(
                      permission: UserCharacteristicPermissionRequestDto(
                        characteristicType:
                            UserCharacteristicTypeDto.biologicalSex,
                      ),
                      status: PermissionStatusDto.unknown,
                    ),
                  ],
                );
                final permissions = [
                  UserCharacteristicType.birthDate.readPermission,
                  UserCharacteristicType.biologicalSex.readPermission,
                ];
                // When requesting characteristic-only access.
                final results = await client.requestPermissions(permissions);
                // Then authorization reaches native and does not imply a grant.
                expect(results.map((result) => result.permission), permissions);
                expect(
                  results.map((result) => result.status),
                  everyElement(PermissionStatus.unknown),
                );
                final request =
                    verify(
                          () => mockApi.requestPermissions(captureAny()),
                        ).captured.single
                        as PermissionsRequestDto;
                expect(
                  request.permissionRequests
                      .cast<UserCharacteristicPermissionRequestDto>()
                      .map((permission) => permission.characteristicType),
                  [
                    UserCharacteristicTypeDto.birthDate,
                    UserCharacteristicTypeDto.biologicalSex,
                  ],
                );
              });

              test('maps characteristic permission request failures', () async {
                // Given native authorization cannot complete.
                when(() => mockApi.requestPermissions(any())).thenThrow(
                  PlatformException(code: 'PERMISSION_NOT_GRANTED'),
                );
                // When requesting a characteristic, then failure is preserved.
                await expectLater(
                  client.requestPermissions([
                    UserCharacteristicType.birthDate.readPermission,
                  ]),
                  throwsA(isA<AuthorizationException>()),
                );
              });

              test(
                'returns empty list when empty permissions provided',
                () async {
                  final result = await client.requestPermissions([]);

                  expect(result, isEmpty);
                  verifyNever(() => mockApi.requestPermissions(any()));
                },
              );

              test(
                'returns permission results for health data permissions',
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
                'auto-grants feature permissions on iOS',
                () async {
                  final result = await client.requestPermissions([
                    const HealthPlatformFeaturePermission(
                      HealthPlatformFeature.readHealthDataHistory,
                    ),
                  ]);

                  expect(result, hasLength(1));
                  expect(result.first.status, equals(PermissionStatus.granted));
                  verifyNever(() => mockApi.requestPermissions(any()));
                },
              );

              test(
                'handles mixed permissions (health data + feature)',
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
                    const HealthPlatformFeaturePermission(
                      HealthPlatformFeature.readHealthDataHistory,
                    ),
                  ]);

                  expect(result, hasLength(2));
                  expect(
                    result
                        .where((r) => r.status == PermissionStatus.granted)
                        .length,
                    equals(2),
                  );
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
            'getPermissionStatus',
            () {
              parameterizedTest(
                'returns unknown read authorization for characteristics',
                [
                  [
                    UserCharacteristicType.birthDate,
                    UserCharacteristicTypeDto.birthDate,
                  ],
                  [
                    UserCharacteristicType.biologicalSex,
                    UserCharacteristicTypeDto.biologicalSex,
                  ],
                ],
                (
                  UserCharacteristicType<Object> type,
                  UserCharacteristicTypeDto expected,
                ) async {
                  // Given HealthKit hides characteristic read authorization.
                  when(() => mockApi.getPermissionStatus(any())).thenAnswer(
                    (_) async => PermissionStatusDto.unknown,
                  );
                  // When querying characteristic read permission.
                  final status = await client.getPermissionStatus(
                    type.readPermission,
                  );
                  // Then unknown is preserved for the correct native type.
                  expect(status, PermissionStatus.unknown);
                  final request =
                      verify(
                            () => mockApi.getPermissionStatus(captureAny()),
                          ).captured.single
                          as UserCharacteristicPermissionRequestDto;
                  expect(request.characteristicType, expected);
                },
              );

              test(
                'returns granted status for health data permission',
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
                'returns denied status for health data permission',
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
                'auto-grants feature permissions without API call',
                () async {
                  final result = await client.getPermissionStatus(
                    const HealthPlatformFeaturePermission(
                      HealthPlatformFeature.readHealthDataHistory,
                    ),
                  );

                  expect(result, equals(PermissionStatus.granted));
                  verifyNever(() => mockApi.getPermissionStatus(any()));
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

          group('readUserCharacteristic', () {
            test(
              'reads a birth date through the native birth-date API',
              () async {
                // Given a readable native date.
                when(() => mockApi.readBirthDate()).thenAnswer(
                  (_) async => BirtDateDto(year: 1968, month: 2, day: 29),
                );
                // When reading the birth-date characteristic.
                final value = await client.readUserCharacteristic(
                  UserCharacteristicType.birthDate,
                );
                // Then the birth-date API supplies the result.
                expect(value, BirtDate(year: 1968, month: 2, day: 29));
                verify(() => mockApi.readBirthDate()).called(1);
                verifyNever(() => mockApi.readBiologicalSex());
              },
            );

            test('reads biological sex through the native sex API', () async {
              // Given a readable native biological-sex value.
              when(() => mockApi.readBiologicalSex()).thenAnswer(
                (_) async => BiologicalSexDto.other,
              );
              // When reading the biological-sex characteristic.
              final value = await client.readUserCharacteristic(
                UserCharacteristicType.biologicalSex,
              );
              // Then the biological-sex API supplies the result.
              expect(value, BiologicalSex.other);
              verify(() => mockApi.readBiologicalSex()).called(1);
              verifyNever(() => mockApi.readBirthDate());
            });

            parameterizedTest(
              'returns null when the native characteristic is unavailable',
              [
                [UserCharacteristicType.birthDate],
                [UserCharacteristicType.biologicalSex],
              ],
              (UserCharacteristicType<Object> type) async {
                // Given no readable value from either native API.
                when(
                  () => mockApi.readBirthDate(),
                ).thenAnswer((_) async => null);
                when(() => mockApi.readBiologicalSex()).thenAnswer(
                  (_) async => null,
                );
                // When reading a characteristic.
                final value = await client.readUserCharacteristic(type);
                // Then native absence remains null.
                expect(value, isNull);
              },
            );

            parameterizedTest(
              'preserves explicit native authorization failures',
              [
                [UserCharacteristicType.birthDate],
                [UserCharacteristicType.biologicalSex],
              ],
              (UserCharacteristicType<Object> type) async {
                // Given an explicit native authorization failure.
                final error = PlatformException(code: 'PERMISSION_NOT_GRANTED');
                when(() => mockApi.readBirthDate()).thenThrow(error);
                when(() => mockApi.readBiologicalSex()).thenThrow(error);
                // When reading, then the failure must not become null.
                await expectLater(
                  client.readUserCharacteristic(type),
                  throwsA(
                    isA<AuthorizationException>().having(
                      (error) => error.code,
                      'code',
                      HealthConnectorErrorCode.permissionNotGranted,
                    ),
                  ),
                );
              },
            );
          });

          group(
            'readRecord',
            () {
              test(
                'returns record when found',
                () async {
                  when(() => mockApi.readRecord(any())).thenAnswer(
                    (_) async => StepsRecordDto(
                      count: 100,
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
                          count: 100,
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
                'throws UnsupportedOperationException (iOS does not support)',
                () async {
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
                    throwsA(isA<UnsupportedOperationException>()),
                  );
                },
              );
            },
          );

          group(
            'updateRecords',
            () {
              test(
                'throws UnsupportedOperationException (iOS does not support)',
                () async {
                  final now = DateTime.now();
                  expect(
                    () => client.updateRecords([
                      StepsRecord(
                        count: const Number(150),
                        startTime: now.subtract(const Duration(hours: 1)),
                        endTime: now,
                        id: HealthRecordId('existing-id'),
                        metadata: Metadata.manualEntry(),
                      ),
                    ]),
                    throwsA(isA<UnsupportedOperationException>()),
                  );
                },
              );
            },
          );

          group(
            'aggregate',
            () {
              test(
                'saved exercise session active energy returns kilocalories',
                () async {
                  // Given
                  final request = HealthDataType.exerciseSession
                      .aggregateActiveEnergyBurnedFor(
                        exerciseSession: ExerciseSessionRecord(
                          id: HealthRecordId(FakeData.fakeId),
                          startTime: FakeData.fakeStartTime,
                          endTime: FakeData.fakeEndTime,
                          exerciseType: ExerciseType.running,
                          metadata: Metadata.manualEntry(),
                        ),
                      );
                  when(() => mockApi.aggregate(any())).thenAnswer(
                    (_) async => 279.0,
                  );

                  // When
                  final result = await client.aggregate(request);

                  // Then
                  expect(result, const Energy.kilocalories(279));
                  final dto =
                      verify(
                            () => mockApi.aggregate(captureAny()),
                          ).captured.single
                          as ExerciseSessionActiveEnergyAggregateRequestDto;
                  expect(dto.exerciseSessionId, FakeData.fakeId);
                },
              );

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
