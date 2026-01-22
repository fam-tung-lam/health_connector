import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:test/test.dart';

void main() {
  group(
    'HeartRateRecoveryOneMinuteDataType',
    () {
      const dataType = HealthDataType.heartRateRecoveryOneMinute;
      test(
        'has correct id',
        () {
          expect(dataType.id, equals('heart_rate_recovery_one_minute'));
        },
      );

      test(
        'type and capabilities are correctly defined',
        () {
          expect(dataType, isA<HeartRateRecoveryOneMinuteDataType>());
          expect(dataType, isA<ReadableHealthDataType>());
          expect(dataType, isA<ReadableByIdHealthDataType>());
          expect(dataType, isA<ReadableInTimeRangeHealthDataType>());
          expect(dataType, isA<AvgAggregatableHealthDataType>());
          expect(dataType, isA<MinAggregatableHealthDataType>());
          expect(dataType, isA<MaxAggregatableHealthDataType>());

          // Writeable support (iOS 16+)
          expect(dataType, isA<WriteableHealthDataType>());
          expect(dataType, isA<DeletableHealthDataType>());
        },
      );

      test(
        'supported platforms are correctly defined',
        () {
          expect(
            dataType.supportedHealthPlatforms,
            contains(HealthPlatform.appleHealth),
          );
          // Not supported on Health Connect (iOS only)
          expect(
            dataType.supportedHealthPlatforms,
            isNot(contains(HealthPlatform.healthConnect)),
          );
        },
      );

      test(
        'permissions are correctly defined',
        () {
          expect(dataType.permissions, hasLength(2));
          expect(
            dataType.permissions,
            contains(
              const HealthDataPermission(
                dataType: dataType,
                accessType: HealthDataPermissionAccessType.read,
              ),
            ),
          );
          expect(
            dataType.permissions,
            contains(
              const HealthDataPermission(
                dataType: dataType,
                accessType: HealthDataPermissionAccessType.write,
              ),
            ),
          );
        },
      );

      test(
        'aggregation metrics are correctly defined',
        () {
          expect(
            dataType.supportedAggregationMetrics,
            contains(AggregationMetric.avg),
          );
          expect(
            dataType.supportedAggregationMetrics,
            contains(AggregationMetric.min),
          );
          expect(
            dataType.supportedAggregationMetrics,
            contains(AggregationMetric.max),
          );
        },
      );

      test(
        'category is correctly defined',
        () {
          expect(
            dataType.category,
            equals(HealthDataTypeCategory.vitals),
          );
        },
      );
    },
  );
}
