/// @docImport 'package:health_connector_core/health_connector_core.dart';
/// @docImport 'package:health_connector_core/health_connector_core_internal.dart';
///
/// Core abstractions and models for cross-platform health data integration.
///
/// This library provides platform-agnostic interfaces and data types for
/// interacting with native health APIs across iOS HealthKit and Android
/// (Android Health Connect). It defines the foundational contracts that
/// platform-specific implementations must fulfill.
///
/// ## Core Concepts
///
/// ### Health Data Types
///
/// [HealthDataType] represents different kinds of health and fitness data,
/// such as steps, heart rate, sleep, nutrition, and more. Each data type
/// is strongly typed and knows its supported platforms, permissions, and
/// capabilities.
///
/// ### Health Records
///
/// [HealthRecord] represents individual health data points or measurements.
/// Records can be interval-based (with start and end times) or instantaneous
/// (single timestamp). Examples include [StepsRecord], [WeightRecord], and
/// [SleepSessionRecord].
///
/// ### Measurement Units
///
/// [MeasurementUnit] provides type-safe unit conversion for health metrics.
/// Units include [Mass] (kg, lb), [Length] (m, ft), [Energy] (kcal, kJ),
/// and many others, with automatic conversion between unit systems.
///
/// ### Permissions
///
/// [Permission] represents access rights to health data. Apps must request
/// permissions before reading or writing health data. Permission models
/// handle read/write access and platform-specific permission flows.
///
/// ### Platform Client
///
/// [HealthConnectorPlatformClient] defines the interface that platform
/// implementations must implement to provide health data access.
///
/// ## Architecture
///
/// ```
/// ┌─────────────────────────────────────┐
/// │    health_connector (main SDK)      │
/// └─────────────────────────────────────┘
///              ↓ uses
/// ┌─────────────────────────────────────┐
/// │  health_connector_core (this lib)   │ ← Platform-agnostic models
/// └─────────────────────────────────────┘
///         ↑                  ↑
///    implements         implements
///         │                  │
/// ┌───────────────┐  ┌──────────────────┐
/// │ hk_ios plugin │  │ hc_android plugin│ ← Platform-specific
/// └───────────────┘  └──────────────────┘
/// ```
///
/// ## Usage Example
///
/// ```dart
/// import 'package:health_connector_core/health_connector_core.dart';
///
/// // Create a steps record
/// final stepsRecord = StepsRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   count: Number(1500),
///   metadata: Metadata.manual(),
/// );
///
/// // Work with measurement units
/// final weight = Mass.pounds(155.4);
/// print(weight.inKilograms); // 70.5
///
/// // Request permissions
/// final permission = StepsHealthDataType().readPermission;
/// ```
///
/// ## Main Classes
///
/// - [HealthDataType] - Base class for all health data types
/// - [HealthRecord] - Base class for all health records
/// - [MeasurementUnit] - Base class for measurement units
/// - [Permission] - Permission model for health data access
/// - [HealthConnectorPlatformClient] - Platform client interface
/// - [HealthConnectorException] - Exception hierarchy for error handling
///
/// ## Platform Support
///
/// - **iOS HealthKit**: Requires iOS 15.0+
/// - **Android Health Connect**: Requires Android API 26+
///
/// See also:
/// - `health_connector` - Main SDK entry point
/// - `health_connector_hk_ios` - iOS HealthKit implementation
/// - `health_connector_hc_android` - Android Health Connect implementation
library;

// Annotations
export 'src/annotations/annotations.dart';
// Config
export 'src/config/health_connector_config.dart' show HealthConnectorConfig;
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
// Models - Health Platform
export 'src/models/health_platform.dart';
// Models - Health Platform Features
export 'src/models/health_platform_features/health_platform_feature.dart';
export 'src/models/health_records/blood_pressure_records/blood_pressure_body_position.dart';
export 'src/models/health_records/blood_pressure_records/blood_pressure_measurement_location.dart';
// Models - Health Records
export 'src/models/health_records/health_record.dart'
    hide
        MacronutrientRecord,
        MineralNutrientRecord,
        VitaminNutrientRecord,
        SpeedActivityRecord,
        DistanceActivityRecord;
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
