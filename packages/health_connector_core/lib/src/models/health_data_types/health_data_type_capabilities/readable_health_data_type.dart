import 'package:health_connector_core/src/annotations/internal_use.dart';
import 'package:health_connector_core/src/annotations/since.dart';
import 'package:health_connector_core/src/config/health_connector_config_constants.dart'
    show HealthConnectorConfigConstants;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord, HealthRecordId;
import 'package:health_connector_core/src/models/metadata/metadata.dart'
    show DataOrigin;
import 'package:health_connector_core/src/models/permissions/permission.dart'
    show HealthDataPermission;
import 'package:health_connector_core/src/models/requests/read_requests/read_records_request.dart'
    show ReadRecordsInTimeRangeRequest, ReadRecordByIdRequest;

/// Interface that adds read capability to a health data type.
@sinceV1_0_0
@internalUse
abstract interface class ReadableHealthDataType<R extends HealthRecord> {
  /// The read permission for this health data type.
  HealthDataPermission get readPermission;
}

/// Interface that adds capability to read a health record by ID.
@sinceV3_2_0
@internalUse
abstract interface class ReadableByIdHealthDataType<R extends HealthRecord>
    implements ReadableHealthDataType<R> {
  /// Creates a request to read a single health record by ID.
  ReadRecordByIdRequest<R> readById(HealthRecordId id);
}

/// Interface that adds capability to read health records within a time range.
@sinceV3_2_0
@internalUse
abstract interface class ReadableInTimeRangeHealthDataType<
  R extends HealthRecord
>
    implements ReadableHealthDataType<R> {
  /// Creates a request to read multiple health records within a time range.
  ReadRecordsInTimeRangeRequest<R> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
    String? pageToken,
    List<DataOrigin> dataOrigins = const [],
  });
}
