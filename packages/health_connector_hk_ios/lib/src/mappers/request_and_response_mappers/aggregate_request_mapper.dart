import 'package:health_connector_core/health_connector_core.dart'
    show AggregateRequest, HealthRecord, MeasurementUnit, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/aggregation_metric_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show AggregateRequestDto;
import 'package:meta/meta.dart' show internal;

/// Converts [AggregateRequest] to [AggregateRequestDto].
@sinceV1_0_0
@internal
extension AggregateRequestDtoMapper<
  R extends HealthRecord,
  U extends MeasurementUnit
>
    on AggregateRequest<R, U> {
  AggregateRequestDto toDto() {
    return AggregateRequestDto(
      dataType: dataType.toDto(),
      aggregationMetric: aggregationMetric.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
    );
  }
}
