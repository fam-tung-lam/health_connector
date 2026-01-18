import 'package:collection/collection.dart' show ListEquality;
import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0, sinceV2_0_0, internalUse, sinceV3_0_0;
import 'package:health_connector_core/src/config/health_connector_config_constants.dart'
    show HealthConnectorConfigConstants;
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart'
    show HealthDataType;
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart'
    show ReadableHealthDataType;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord, HealthRecordId;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show MeasurementUnit;
import 'package:health_connector_core/src/models/metadata/metadata.dart'
    show DataOrigin;
import 'package:health_connector_core/src/models/requests/read_requests/sort_descriptor.dart'
    show SortDescriptor;
import 'package:health_connector_core/src/models/requests/request.dart'
    show Request;
import 'package:health_connector_core/src/models/responses/read_records_response.dart'
    show ReadRecordsInTimeRangeResponse;
import 'package:health_connector_core/src/utils/validation_utils.dart'
    show requireEndTimeAfterStartTime, require;
import 'package:meta/meta.dart';

part 'read_record_by_id_request.dart';
part 'read_records_in_time_range_request.dart';

/// Base sealed class for all health records read requests.
///
/// @nodoc
@sinceV2_0_0
@internalUse
@immutable
sealed class ReadRecordsRequest<R extends HealthRecord> extends Request {
  /// Creates a base read records request.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to read.
  ReadRecordsRequest({required this.dataType}) {
    require(
      condition: dataType is ReadableHealthDataType,
      value: dataType,
      name: 'dataType',
      message: '$dataType is not readable.',
    );
  }

  /// The type of health data to read.
  final HealthDataType<R, MeasurementUnit> dataType;
}
