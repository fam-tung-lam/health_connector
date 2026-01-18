import 'package:collection/collection.dart' show ListEquality;
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/deletable_health_data_type.dart';
import 'package:health_connector_core/src/models/requests/request.dart';
import 'package:health_connector_core/src/utils/validation_utils.dart';
import 'package:meta/meta.dart';

part 'delete_records_by_ids_request.dart';
part 'delete_records_in_time_range_request.dart';

/// Base sealed class for all delete records requests.
///
/// ## Data Ownership Restriction
///
/// Apps can only delete health records that they created.
/// Attempting to delete records created by other apps, manually entered by
/// users, or system-generated will fail with [AuthorizationException].
///
/// {@category Core API}
@sinceV2_0_0
@internalUse
@immutable
sealed class DeleteRecordsRequest extends Request {
  /// Creates a base delete records request.
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The type of health data to delete.
  DeleteRecordsRequest({required this.dataType}) {
    require(
      condition: dataType is DeletableHealthDataType,
      value: dataType,
      name: 'dataType',
      message: '$dataType is not deletable.',
    );
  }

  /// The type of health data to delete.
  final HealthDataType dataType;
}
