import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/health_connector_hk_client.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:mocktail/mocktail.dart';

class MockApi extends Mock implements HealthConnectorHKIOSApi {}

void main() {
  late MockApi api;
  late HealthConnectorHKClient client;
  final start = DateTime(2026, 3, 28);
  final middle = DateTime(2026, 3, 29);
  final end = DateTime(2026, 3, 30);

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(HealthConnectorConfigDto(isLoggerEnabled: false));
    registerFallbackValue(
      StandardAggregateRequestDto(
        dataType: HealthDataTypeDto.hydration,
        aggregationMetric: AggregationMetricDto.sum,
        startTime: 0,
        endTime: 1,
      ),
    );
  });

  setUp(() async {
    api = MockApi();
    HealthConnectorHKClient.platformClient = api;
    when(() => api.initialize(any())).thenAnswer(
      (_) async => OperatingSystemInfoDto(
        majorVersion: 18,
        minorVersion: 0,
        patchVersion: 0,
      ),
    );
    client = await HealthConnectorHKClient.create();
  });

  test(
    'GIVEN empty and measured-zero days WHEN queried THEN preserves both',
    () async {
      // Given
      when(() => api.aggregateByDay(any())).thenAnswer(
        (_) async => [
          DailyAggregateResultDto(
            startTime: start.millisecondsSinceEpoch,
            endTime: middle.millisecondsSinceEpoch,
          ),
          DailyAggregateResultDto(
            startTime: middle.millisecondsSinceEpoch,
            endTime: end.millisecondsSinceEpoch,
            value: 0,
          ),
        ],
      );
      // When
      final days = await client.aggregateByDay(
        HealthDataType.hydration.aggregateSum(startTime: start, endTime: end),
      );
      // Then
      expect(days.map((day) => day.value), [null, Volume.zero]);
      expect(days.first.startTime, start);
      expect(days.last.endTime, end);
      expect(days.clear, throwsUnsupportedError);
      final dto =
          verify(() => api.aggregateByDay(captureAny())).captured.single
              as StandardAggregateRequestDto;
      expect(dto.dataType, HealthDataTypeDto.hydration);
      expect(dto.startTime, start.millisecondsSinceEpoch);
      expect(dto.endTime, end.millisecondsSinceEpoch);
    },
  );

  test(
    'GIVEN energy in native units WHEN queried THEN returns kilocalories',
    () async {
      // Given
      when(() => api.aggregateByDay(any())).thenAnswer(
        (_) async => [
          DailyAggregateResultDto(
            startTime: start.millisecondsSinceEpoch,
            endTime: middle.millisecondsSinceEpoch,
            value: 123.5,
          ),
        ],
      );
      // When
      final days = await client.aggregateByDay(
        HealthDataType.activeEnergyBurned.aggregateSum(
          startTime: start,
          endTime: middle,
        ),
      );
      // Then
      expect(days.single.value, const Energy.kilocalories(123.5));
    },
  );

  test(
    'GIVEN native query failure WHEN queried THEN propagates a connector error',
    () async {
      // Given
      when(
        () => api.aggregateByDay(any()),
      ).thenThrow(PlatformException(code: 'HEALTH_SERVICE_UNAVAILABLE'));
      // When / Then
      await expectLater(
        client.aggregateByDay(
          HealthDataType.hydration.aggregateSum(startTime: start, endTime: end),
        ),
        throwsA(isA<HealthServiceUnavailableException>()),
      );
    },
  );

  test(
    'GIVEN partial day WHEN queried THEN rejects before native access',
    () async {
      // Given
      final request = HealthDataType.hydration.aggregateSum(
        startTime: start.add(const Duration(hours: 1)),
        endTime: end,
      );
      // When / Then
      await expectLater(client.aggregateByDay(request), throwsArgumentError);
      verifyNever(() => api.aggregateByDay(any()));
    },
  );

  test('GIVEN steps WHEN queried THEN returns daily counts', () async {
    // Given
    when(() => api.aggregateByDay(any())).thenAnswer(
      (_) async => [
        DailyAggregateResultDto(
          startTime: start.millisecondsSinceEpoch,
          endTime: middle.millisecondsSinceEpoch,
          value: 1234,
        ),
      ],
    );
    // When
    final days = await client.aggregateByDay(
      HealthDataType.steps.aggregateSum(startTime: start, endTime: middle),
    );
    // Then
    expect(days.single.value, const Number(1234));
    final dto =
        verify(() => api.aggregateByDay(captureAny())).captured.single
            as StandardAggregateRequestDto;
    expect(dto.dataType, HealthDataTypeDto.steps);
  });

  for (final metric in [
    AggregationMetric.min,
    AggregationMetric.avg,
    AggregationMetric.max,
  ]) {
    test(
      'GIVEN weight $metric WHEN queried THEN preserves metric and unit',
      () async {
        // Given
        when(() => api.aggregateByDay(any())).thenAnswer(
          (_) async => [
            DailyAggregateResultDto(
              startTime: start.millisecondsSinceEpoch,
              endTime: middle.millisecondsSinceEpoch,
              value: 72.5,
            ),
          ],
        );
        final request = StandardAggregateRequest<Mass>(
          dataType: HealthDataType.weight,
          aggregationMetric: metric,
          startTime: start,
          endTime: middle,
        );
        // When
        final days = await client.aggregateByDay(request);
        // Then
        expect(days.single.value, const Mass.kilograms(72.5));
        final dto =
            verify(() => api.aggregateByDay(captureAny())).captured.single
                as StandardAggregateRequestDto;
        expect(dto.aggregationMetric.name, metric.name);
      },
    );
  }

  test(
    'GIVEN unsupported native capability WHEN queried THEN preserves error',
    () async {
      // Given
      when(
        () => api.aggregateByDay(any()),
      ).thenThrow(PlatformException(code: 'UNSUPPORTED_OPERATION'));
      // When / Then
      await expectLater(
        client.aggregateByDay(
          HealthDataType.hydration.aggregateSum(startTime: start, endTime: end),
        ),
        throwsA(isA<UnsupportedOperationException>()),
      );
    },
  );
  test(
    'GIVEN blood pressure WHEN grouped THEN preserves pressure units',
    () async {
      // Given
      when(() => api.aggregateByDay(any())).thenAnswer(
        (_) async => [
          DailyAggregateResultDto(
            startTime: start.millisecondsSinceEpoch,
            endTime: middle.millisecondsSinceEpoch,
            value: 120,
          ),
        ],
      );
      // When
      final days = await client.aggregateByDay(
        HealthDataType.bloodPressure.aggregateAverage(
          bloodPressureType: HealthDataType.systolicBloodPressure,
          startTime: start,
          endTime: middle,
        ),
      );
      // Then
      expect(days.single.value, const Pressure.millimetersOfMercury(120));
      expect(
        verify(() => api.aggregateByDay(captureAny())).captured.single,
        isA<StandardAggregateRequestDto>(),
      );
    },
  );
}
