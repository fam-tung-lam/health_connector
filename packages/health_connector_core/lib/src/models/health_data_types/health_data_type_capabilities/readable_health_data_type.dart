import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/config/health_connector_config_constants.dart'
    show HealthConnectorConfigConstants;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord, HealthRecordId;
import 'package:health_connector_core/src/models/permissions/permission.dart'
    show HealthDataPermission;
import 'package:health_connector_core/src/models/requests/read_record_request.dart'
    show ReadRecordRequest;
import 'package:health_connector_core/src/models/requests/read_records_request.dart'
    show ReadRecordsRequest;
import 'package:meta/meta.dart' show internal;

/// Interface that adds read permission capability to a health data type.
@sinceV1_0_0
@internal
abstract interface class ReadableHealthDataType<R extends HealthRecord> {
  /// The read permission for this health data type.
  HealthDataPermission get readPermission;

  /// Creates a request to read a single health record by ID.
  ReadRecordRequest<R> readRecord(HealthRecordId id);

  /// Creates a request to read multiple health records within a time range.
  ReadRecordsRequest<R> readRecords({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  });
}
