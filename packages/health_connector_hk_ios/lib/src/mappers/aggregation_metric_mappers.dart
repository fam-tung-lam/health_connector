import 'package:health_connector_core/health_connector_core.dart'
    show AggregationMetric, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show AggregationMetricDto;
import 'package:meta/meta.dart' show internal;

/// Converts [AggregationMetric] to [AggregationMetricDto].
@sinceV1_0_0
@internal
extension AggregationMetricDtoMapper on AggregationMetric {
  AggregationMetricDto toDto() {
    switch (this) {
      case AggregationMetric.sum:
        return AggregationMetricDto.sum;
      case AggregationMetric.avg:
        return AggregationMetricDto.avg;
      case AggregationMetric.min:
        return AggregationMetricDto.min;
      case AggregationMetric.max:
        return AggregationMetricDto.max;
      case AggregationMetric.count:
        return AggregationMetricDto.count;
    }
  }
}

/// Converts [AggregationMetricDto] to [AggregationMetric].
@sinceV1_0_0
@internal
extension AggregationMetricDtoToDomain on AggregationMetricDto {
  AggregationMetric toDomain() {
    switch (this) {
      case AggregationMetricDto.sum:
        return AggregationMetric.sum;
      case AggregationMetricDto.avg:
        return AggregationMetric.avg;
      case AggregationMetricDto.min:
        return AggregationMetric.min;
      case AggregationMetricDto.max:
        return AggregationMetric.max;
      case AggregationMetricDto.count:
        return AggregationMetric.count;
    }
  }
}
