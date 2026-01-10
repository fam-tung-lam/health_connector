/// @docImport 'src/annotations/annotations.dart';
///
/// Internal APIs for health_connector core library.
///
/// This library exposes internal APIs marked with the [internalUse] annotation
/// that are NOT part of the public API contract.
///
/// **⚠️ WARNING**: The internal APIs in this library are subject to breaking
/// changes without notice. Do NOT use these in production applications.
///
/// ## Public API
///
/// For the stable public API, import `health_connector_core.dart` instead:
///
/// ```dart
/// import 'package:health_connector_core/health_connector_core.dart';
/// ```
library;

export 'src/annotations/annotations.dart';
export 'src/config/health_connector_config.dart';
export 'src/health_connector_health_platform_client.dart';
export 'src/models/exceptions/health_connector_error_code.dart';
export 'src/models/exceptions/health_connector_exception.dart';
export 'src/models/health_data_sync/health_data_sync_result.dart';
export 'src/models/health_data_sync/health_data_sync_token.dart';
export 'src/models/health_data_types/health_data_type.dart'
    hide
        MineralNutrientDataType,
        NutrientHealthDataType,
        VitaminNutrientDataType,
        MacronutrientDataType;
export 'src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
export 'src/models/health_platform.dart';
export 'src/models/health_platform_features/health_platform_feature.dart';
export 'src/models/health_records/blood_pressure/blood_pressure_body_position.dart';
export 'src/models/health_records/blood_pressure/blood_pressure_measurement_location.dart';
export 'src/models/health_records/cycling_pedaling_cadence/cycling_pedaling_cadence_measurement.dart';
export 'src/models/health_records/health_record.dart'
    hide MacronutrientRecord, MineralNutrientRecord, VitaminNutrientRecord;
export 'src/models/health_records/sleep/sleep_stage.dart';
export 'src/models/measurement_units/measurement_unit.dart';
export 'src/models/metadata/metadata.dart';
export 'src/models/permissions/permission.dart';
export 'src/models/requests/aggregate_request.dart';
export 'src/models/requests/aggregation_metric.dart';
export 'src/models/requests/delete_records_request.dart';
export 'src/models/requests/read_records_request.dart' hide ReadRecordsRequest;
export 'src/models/requests/sort_descriptor.dart';
export 'src/models/responses/permission_request_result.dart';
export 'src/models/responses/read_records_response.dart'
    hide ReadRecordsResponse;
export 'src/utils/date_time_utils.dart';
export 'src/utils/permission_extension.dart';
export 'src/utils/validation_utils.dart';
