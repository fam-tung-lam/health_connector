import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector.dart'
    show AggregateRequest, AggregateResponse, MeasurementUnit, HealthConnector;

/// Manages state and operations for aggregating health data.
///
/// Handles aggregating health records (sum, average, min, max, count) over
/// a time range, tracking loading state and the aggregation result.
final class AggregateHealthDataChangeNotifier extends ChangeNotifier {
  final HealthConnector _healthConnector;

  AggregateHealthDataChangeNotifier(this._healthConnector);

  bool _isLoading = false;
  AggregateResponse? _aggregateResponse;

  AggregateResponse? get aggregateResponse => _aggregateResponse;

  MeasurementUnit? get aggregationResult => _aggregateResponse?.value;

  bool get isLoading => _isLoading;

  /// Aggregates health data based on the provided request.
  ///
  /// Updates [aggregateResponse] with the aggregation result on success.
  /// Exceptions are propagated to the caller for handling.
  Future<void> aggregateHealthData(AggregateRequest request) async {
    notify(() {
      _isLoading = true;
      _aggregateResponse = null;
    });

    try {
      final response = await _healthConnector.aggregate(request);
      notify(() {
        _aggregateResponse = response;
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
      _aggregateResponse = null;
    });
  }

  void notify(void Function() fn) {
    fn();
    notifyListeners();
  }
}
