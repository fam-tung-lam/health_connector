import 'package:health_connector_core/src/annotations/internal_use.dart';
import 'package:health_connector_core/src/annotations/since.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show HealthRecord;
import 'package:health_connector_core/src/models/permissions/permission.dart'
    show HealthDataPermission;

/// Interface that adds write permission capability to a health data type.
@sinceV1_0_0
@internalUse
abstract interface class WriteableHealthDataType<R extends HealthRecord> {
  /// The write permission for this health data type.
  HealthDataPermission get writePermission;
}
