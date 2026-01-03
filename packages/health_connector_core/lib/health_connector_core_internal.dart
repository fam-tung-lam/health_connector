/// @docImport 'package:health_connector_core/health_connector_core.dart';
/// @docImport 'package:health_connector_core/health_connector_core_internal.dart';
///
/// Internal APIs for health_connector core library.
///
/// This library exposes internal APIs marked with the [internalUse] annotation
/// that are NOT part of the public API contract. These APIs are intended for:
/// - Platform-specific implementations (HealthKit iOS, Health Connect Android)
/// - Internal SDK utilities and helpers
/// - Testing and development tools
///
/// **WARNING**: APIs in this library are subject to breaking changes without
/// notice. Do NOT use these in production applications unless you understand
/// the risks and are willing to handle breaking changes.
///
/// ## Internal APIs Exposed
///
/// ### Platform Client Interface
/// - [HealthConnectorPlatformClient] - Interface for platform implementations
///
/// ### Health Data Type Capabilities
/// Mixins that define which operations a health data type supports:
/// - [ReadableHealthDataType] - Data type can be read
/// - [WriteableHealthDataType] - Data type can be written
/// - [DeletableHealthDataType] - Data type can be deleted
/// - [SumAggregatableHealthDataType] - Supports sum aggregation
/// - [AvgAggregatableHealthDataType] - Supports average aggregation
/// - [MinAggregatableHealthDataType] - Supports min aggregation
/// - [MaxAggregatableHealthDataType] - Supports max aggregation
///
/// ### Utility Functions
/// - [formatTimeRange] - Format time ranges for display
/// - [require] - Assertion utility for argument validation
/// - [requireEndTimeAfterStartTime] - Validate time range ordering
///
/// ## Who Should Use This
///
/// - Platform implementation developers (e.g., adding a new platform)
/// - SDK contributors and maintainers
/// - Advanced users building custom health data integrations
///
/// ## Public API
///
/// For the stable public API, import `health_connector_core.dart` instead:
///
/// ```dart
/// import 'package:health_connector_core/health_connector_core.dart';
/// ```
library;

// Annotations
export 'src/annotations/annotations.dart';
// Config
export 'src/config/health_connector_config.dart';
// Internal: Platform client interface
export 'src/health_connector_health_platform_client.dart';
// Models - Exceptions
export 'src/models/exceptions/health_connector_error_code.dart';
export 'src/models/exceptions/health_connector_exception.dart';
// Models - Health Data Types
export 'src/models/health_data_types/health_data_type.dart'
    hide
        MineralNutrientDataType,
        NutrientHealthDataType,
        VitaminNutrientDataType,
        MacronutrientDataType;
// Internal: Health data type capabilities
export 'src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
// Models - Health Platform
export 'src/models/health_platform.dart';
// Models - Health Platform Features
export 'src/models/health_platform_features/health_platform_feature.dart';
export 'src/models/health_records/blood_pressure_records/blood_pressure_body_position.dart';
export 'src/models/health_records/blood_pressure_records/blood_pressure_measurement_location.dart';
export 'src/models/health_records/cycling_pedaling_cadence_measurement.dart';
// Models - Health Records
export 'src/models/health_records/health_record.dart'
    hide MacronutrientRecord, MineralNutrientRecord, VitaminNutrientRecord;
export 'src/models/health_records/heart_rate_measurement.dart';
export 'src/models/health_records/sleep_records/sleep_stage_type.dart';
// Models - Measurement Units
export 'src/models/measurement_units/measurement_unit.dart';
// Models - Metadata
export 'src/models/metadata/metadata.dart';
// Models - Permissions
export 'src/models/permissions/permission.dart';
// Models - Requests
export 'src/models/requests/aggregate_request.dart';
export 'src/models/requests/aggregation_metric.dart';
export 'src/models/requests/delete_records_request.dart';
export 'src/models/requests/read_records_request.dart';
// Models - Responses
export 'src/models/responses/permission_request_result.dart';
export 'src/models/responses/read_records_response.dart'
    hide ReadRecordsResponse;
// Internal: Utility functions
export 'src/utils/datetime_utils.dart';
export 'src/utils/validation_utils.dart';
