import 'dart:collection';

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector_internal.dart'
    show
        DataOrigin,
        DeleteRecordsRequest,
        HealthDataType,
        HealthRecord,
        MeasurementUnit,
        ReadRecordsInTimeRangeRequest,
        HealthConnector;

/// Manages state and operations for reading health records.
///
/// Handles reading health records with pagination support, loading additional
/// pages, and deleting individual records. Tracks loading state and
/// the current list of records.
final class ReadHealthRecordsChangeNotifier extends ChangeNotifier {
  final HealthConnector _healthConnector;

  ReadHealthRecordsChangeNotifier(this._healthConnector);

  bool _isLoading = false;
  ReadRecordsInTimeRangeRequest? _nextPageRequest;
  UnmodifiableListView<HealthRecord> _healthRecords = UnmodifiableListView([]);
  bool _hasQueriedRecords = false;

  UnmodifiableListView<HealthRecord> get healthRecords => _healthRecords;

  bool get isLoading => _isLoading;

  ReadRecordsInTimeRangeRequest? get nextPageRequest => _nextPageRequest;

  bool get hasQueriedRecords => _hasQueriedRecords;

  /// Reads health records based on the provided parameters.
  ///
  /// Resets the current records list and loads the first page of results.
  /// Updates [healthRecords], [nextPageRequest], and [hasQueriedRecords].
  /// Exceptions are propagated to the caller for handling.
  Future<void> readHealthRecords<R extends HealthRecord>({
    required HealthDataType<R, MeasurementUnit> dataType,
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = 100,
    String? pageToken,
    List<DataOrigin> dataOrigins = const [],
  }) async {
    notify(() {
      _isLoading = true;
      _healthRecords = UnmodifiableListView([]);
      _nextPageRequest = null;
      _hasQueriedRecords = false;
    });

    try {
      // ## Why `dynamic` is used here
      //
      // The base `HealthDataType` does not define a `readInTimeRange` method
      // to ensure type safety, as not all data types are readable.
      //
      // However, all 100+ *readable* health data types consistently implement
      // this method. This internal dynamic call allows the toolbox app to
      // generically handle any readable type without creating a lot of
      // repetitive code for each one.
      //
      // ## For Production Apps, use a type-safe approach
      //
      // Instead of `(dataType as dynamic)`, you should call the method on the
      // concrete type to leverage compile-time safety.
      //
      // ### Example
      // ```dart
      // final request = Steps.readInTimeRange(...);
      // final request = HeartRate.readInTimeRange(...);
      // ```
      final request =
          (dataType as dynamic).readInTimeRange(
                startTime: startTime,
                endTime: endTime,
                pageSize: pageSize,
                pageToken: pageToken,
                dataOrigins: dataOrigins,
              )
              as ReadRecordsInTimeRangeRequest;

      final response = await _healthConnector.readRecords(request);

      notify(() {
        _healthRecords = UnmodifiableListView(response.records);
        _nextPageRequest = response.nextPageRequest;
        _hasQueriedRecords = true;
      });
    } finally {
      notify(() {
        _isLoading = false;
      });
    }
  }

  /// Loads the next page of health records if available.
  ///
  /// Appends the new records to the existing [healthRecords] list.
  /// Does nothing if [nextPageRequest] is null.
  /// Exceptions are propagated to the caller for handling.
  Future<void> loadNextPage() async {
    final nextPageRequest = _nextPageRequest;
    if (nextPageRequest == null) {
      return;
    }

    notify(() {
      _isLoading = true;
    });

    try {
      final nextResponse = await _healthConnector.readRecords(nextPageRequest);

      notify(() {
        final updatedHealthRecords = [
          ..._healthRecords,
          ...nextResponse.records,
        ];
        _healthRecords = UnmodifiableListView(updatedHealthRecords);
        _nextPageRequest = nextResponse.nextPageRequest;
      });
    } finally {
      notify(() {
        _isLoading = false;
      });
    }
  }

  /// Deletes a health record by its ID.
  ///
  /// Removes the record from [healthRecords] on success.
  /// Exceptions are propagated to the caller for handling.
  Future<void> deleteRecord(
    HealthRecord record,
    HealthDataType<HealthRecord, MeasurementUnit> dataType,
  ) async {
    notify(() {
      _isLoading = true;
    });

    try {
      // Note: Using dynamic cast because not all HealthDataTypes implement
      // DeletableHealthDataType. The caller is responsible for ensuring the
      // dataType passed supports deletion.
      final request =
          (dataType as dynamic).deleteByIds([record.id])
              as DeleteRecordsRequest<HealthRecord>;

      await _healthConnector.deleteRecords(request);

      notify(() {
        final updatedHealthRecords = _healthRecords
            .where((r) => r.id != record.id)
            .toList();
        _healthRecords = UnmodifiableListView(updatedHealthRecords);
      });
    } finally {
      notify(() {
        _isLoading = false;
      });
    }
  }

  /// Resets the state by clearing all records and pagination information.
  void reset() {
    notify(() {
      _healthRecords = UnmodifiableListView([]);
      _nextPageRequest = null;
      _hasQueriedRecords = false;
    });
  }

  void notify(void Function() fn) {
    fn();
    notifyListeners();
  }
}
