import 'package:health_connector_core/health_connector_core_internal.dart';

/// Validates the supported request and complete local-day boundaries.
@internalUse
void validateDailyAggregateRequest(AggregateRequest<MeasurementUnit> request) {
  if (request is ExerciseSessionActiveEnergyAggregateRequest) {
    throw const UnsupportedOperationException(
      'A saved workout cannot be aggregated into calendar days.',
    );
  }
  for (final time in [request.startTime, request.endTime]) {
    final local = time.toLocal();
    if (!local.isAtSameMomentAs(DateTime(local.year, local.month, local.day))) {
      throw ArgumentError('Daily aggregation requires local day boundaries.');
    }
  }
}
