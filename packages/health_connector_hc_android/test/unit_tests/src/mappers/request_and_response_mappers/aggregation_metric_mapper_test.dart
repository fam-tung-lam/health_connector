import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/aggregation_metric_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'AggregationMetricMapper',
    () {
      group(
        'AggregationMetricDtoMapper',
        () {
          parameterizedTest(
            'maps AggregationMetric to AggregationMetricDto',
            [
              [AggregationMetric.sum, AggregationMetricDto.sum],
              [AggregationMetric.avg, AggregationMetricDto.avg],
              [AggregationMetric.min, AggregationMetricDto.min],
              [AggregationMetric.max, AggregationMetricDto.max],
            ],
            (AggregationMetric domain, AggregationMetricDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'AggregationMetricDtoToDomain',
        () {
          parameterizedTest(
            'maps AggregationMetricDto to AggregationMetric',
            [
              [AggregationMetricDto.sum, AggregationMetric.sum],
              [AggregationMetricDto.avg, AggregationMetric.avg],
              [AggregationMetricDto.min, AggregationMetric.min],
              [AggregationMetricDto.max, AggregationMetric.max],
            ],
            (AggregationMetricDto dto, AggregationMetric domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
