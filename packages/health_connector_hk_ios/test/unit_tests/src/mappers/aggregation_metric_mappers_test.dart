import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/aggregation_metric_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'AggregationMetricMappers',
    () {
      group(
        'AggregationMetricDtoMapper',
        () {
          parameterizedTest(
            'converts AggregationMetric to AggregationMetricDto',
            [
              [AggregationMetric.sum, AggregationMetricDto.sum],
              [AggregationMetric.avg, AggregationMetricDto.avg],
              [AggregationMetric.min, AggregationMetricDto.min],
              [AggregationMetric.max, AggregationMetricDto.max],
            ],
            (AggregationMetric metric, AggregationMetricDto expectedDto) {
              final dto = metric.toDto();
              expect(dto, expectedDto);
            },
          );
        },
      );

      group(
        'AggregationMetricDtoToDomain',
        () {
          parameterizedTest(
            'converts AggregationMetricDto to AggregationMetric',
            [
              [AggregationMetricDto.sum, AggregationMetric.sum],
              [AggregationMetricDto.avg, AggregationMetric.avg],
              [AggregationMetricDto.min, AggregationMetric.min],
              [AggregationMetricDto.max, AggregationMetric.max],
            ],
            (AggregationMetricDto dto, AggregationMetric expectedMetric) {
              final metric = dto.toDomain();
              expect(metric, expectedMetric);
            },
          );
        },
      );
    },
  );
}
