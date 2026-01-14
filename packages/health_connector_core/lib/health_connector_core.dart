/// Core abstractions and models for cross-platform health data integration.
///
/// This library provides platform-agnostic interfaces and data types for
/// interacting with native health APIs across iOS and Android
/// health platforms.
library;

export 'src/config/health_connector_config.dart' show HealthConnectorConfig;
export 'src/models/exceptions/health_connector_error_code.dart'
    show HealthConnectorErrorCode;
export 'src/models/exceptions/health_connector_exception.dart'
    show
        HealthConnectorException,
        AuthorizationException,
        ConfigurationException,
        InvalidArgumentException,
        HealthServiceUnavailableException,
        HealthServiceException,
        UnsupportedOperationException,
        UnknownException;
export 'src/models/health_data_sync/health_data_sync_result.dart'
    show HealthDataSyncResult;
export 'src/models/health_data_sync/health_data_sync_token.dart'
    show HealthDataSyncToken;
export 'src/models/health_data_types/health_data_type.dart'
    hide
        MineralNutrientDataType,
        NutrientDataType,
        DietaryVitaminDataType,
        MacronutrientDataType;
export 'src/models/health_platform.dart'
    show HealthPlatform, HealthPlatformStatus;
export 'src/models/health_platform_features/health_platform_feature.dart'
    show HealthPlatformFeature, HealthPlatformFeatureStatus;
export 'src/models/health_records/health_record.dart'
    hide
        DietaryMacronutrientRecord,
        DietaryMineralRecord,
        DietaryVitaminRecord,
        SpeedActivityRecord,
        DistanceActivityRecord;
export 'src/models/measurement_units/measurement_unit.dart'
    show
        MeasurementUnit,
        BloodGlucose,
        Energy,
        Frequency,
        Length,
        Mass,
        Number,
        Percentage,
        Power,
        Pressure,
        Temperature,
        TimeDuration,
        Velocity,
        Volume;
export 'src/models/metadata/metadata.dart'
    show Metadata, Device, DeviceType, RecordingMethod, DataOrigin;
export 'src/models/permissions/permission.dart'
    show
        HealthPlatformFeaturePermission,
        HealthDataPermission,
        HealthDataPermissionAccessType,
        PermissionStatus;
export 'src/models/requests/aggregation_metric.dart' show AggregationMetric;
export 'src/models/requests/sort_descriptor.dart' show SortDescriptor;
export 'src/models/responses/permission_request_result.dart'
    show PermissionRequestResult;
