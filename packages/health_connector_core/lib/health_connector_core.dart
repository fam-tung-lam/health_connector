/// Core abstractions and models for cross-platform health data integration.
///
/// This library provides platform-agnostic interfaces and data types for
/// interacting with native health APIs across iOS and Android
/// health platforms.
library;

export 'src/config/health_connector_config.dart';
export 'src/models/exceptions/health_connector_error_code.dart';
export 'src/models/exceptions/health_connector_exception.dart';
export 'src/models/health_data_types/health_data_type.dart'
    hide
        MineralNutrientDataType,
        NutrientHealthDataType,
        VitaminNutrientDataType,
        MacronutrientDataType;
export 'src/models/health_platform.dart';
export 'src/models/health_platform_features/health_platform_feature.dart';
export 'src/models/health_records/blood_pressure/blood_pressure_body_position.dart';
export 'src/models/health_records/blood_pressure/blood_pressure_measurement_location.dart';
export 'src/models/health_records/health_record.dart'
    hide
        MacronutrientRecord,
        MineralNutrientRecord,
        VitaminNutrientRecord,
        SpeedActivityRecord,
        DistanceActivityRecord;
export 'src/models/health_records/heart_rate/heart_rate_measurement.dart';
export 'src/models/health_records/sleep/sleep_stage_type.dart';
export 'src/models/measurement_units/measurement_unit.dart'
    hide MeasurementUnit;
export 'src/models/metadata/metadata.dart';
export 'src/models/permissions/permission.dart';
export 'src/models/requests/aggregation_metric.dart' show AggregationMetric;
export 'src/models/responses/permission_request_result.dart'
    show PermissionRequestResult;
export 'src/models/responses/read_records_response.dart'
    show ReadRecordsInTimeRangeResponse;
