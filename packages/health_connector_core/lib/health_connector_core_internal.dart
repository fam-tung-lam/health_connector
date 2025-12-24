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

// Export everything from the public API
export 'health_connector_core.dart';

// Internal: Platform client interface
export 'src/health_connector_health_platform_client.dart';

// Internal: Health data type capabilities
export 'src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';

// Internal: Utility functions
export 'src/utils/datetime.dart';
export 'src/utils/validation.dart';
