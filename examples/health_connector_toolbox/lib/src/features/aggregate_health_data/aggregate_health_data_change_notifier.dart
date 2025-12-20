import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector.dart'
    show AggregateRequest, MeasurementUnit, HealthConnector;

/// Manages state and operations for aggregating health data.
///
/// Handles aggregating health records (sum, average, min, max, count) over
/// a time range, tracking loading state and the aggregation result.
final class AggregateHealthDataChangeNotifier extends ChangeNotifier {
  final HealthConnector _healthConnector;

  AggregateHealthDataChangeNotifier(this._healthConnector);

  bool _isLoading = false;
  MeasurementUnit? _aggregationResult;

  MeasurementUnit? get aggregationResult => _aggregationResult;

  bool get isLoading => _isLoading;

  /// Aggregates health data based on the provided request.
  ///
  /// Updates [aggregationResult] with the aggregation result on success.
  /// Exceptions are propagated to the caller for handling.
  Future<void> aggregateHealthData(AggregateRequest request) async {
    notify(() {
      _isLoading = true;
      _aggregationResult = null;
    });

    try {
      final response = await _healthConnector.aggregate(request);
      notify(() {
        _aggregationResult = response;
      });
    } finally {
      notify(() {
        _isLoading = false;
      });
    }
  }

  /// Clears the aggregation results.
  void clearResults() {
    notify(() {
      _aggregationResult = null;
    });
  }

  void notify(void Function() fn) {
    fn();
    notifyListeners();
  }
}
