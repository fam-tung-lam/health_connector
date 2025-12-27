/// @docImport 'package:health_connector/health_connector.dart';
/// @docImport 'package:health_connector_core/health_connector_core.dart';
///
/// Cross-platform health and fitness data integration for Flutter.
///
/// This SDK provides a unified API for accessing health data from native
/// platforms: **HealthKit** on iOS and **Health Connect** on Android.
/// It handles permission flows, data queries, aggregations, and synchronization
/// with platform-specific health stores.
///
/// ## Quick Start
///
/// ### 1. Installation
///
/// Add to your `pubspec.yaml`:
///
/// ```yaml
/// dependencies:
///   health_connector: ^1.0.0
/// ```
///
/// ### 2. Platform Setup
///
/// **iOS HealthKit**:
/// - Add HealthKit capability in Xcode
/// - Add usage descriptions to `Info.plist`:
///   ```xml
///   <key>NSHealthShareUsageDescription</key>
///   <string>We need access to read your health data</string>
///   <key>NSHealthUpdateUsageDescription</key>
///   <string>We need access to write your health data</string>
///   ```
///
/// **Android Health Connect**:
/// - Minimum SDK: 26 (Android 8.0+)
/// - Add permissions to `AndroidManifest.xml`
/// - Declare health data types in Play Console
///
/// ### 3. Usage
///
/// ```dart
/// import 'package:health_connector/health_connector.dart';
///
/// final healthConnector = HealthConnector();
///
/// // Request permissions
/// final permissions = [
///   StepsHealthDataType().readPermission,
///   WeightHealthDataType().writePermission,
/// ];
/// await healthConnector.requestPermissions(permissions);
///
/// // Read step count for today
/// final now = DateTime.now();
/// final startOfDay = DateTime(now.year, now.month, now.day);
/// final request = ReadRecordsInTimeRangeRequest(
///   dataType: StepsHealthDataType(),
///   startTime: startOfDay,
///   endTime: now,
/// );
/// final response = await healthConnector.readRecords(request);
/// final totalSteps = response.records
///     .map((r) => r.count.value)
///     .fold(0.0, (a, b) => a + b);
///
/// // Write a weight record
/// final weightRecord = WeightRecord(
///   time: DateTime.now(),
///   weight: Mass.pounds(155.4),
///   metadata: Metadata.manual(),
/// );
/// await healthConnector.writeRecord(weightRecord);
///
/// // Aggregate data
/// final aggregateRequest = AggregateRequest(
///   dataType: StepsHealthDataType(),
///   metric: AggregationMetric.sum,
///   startTime: startOfDay,
///   endTime: now,
/// );
/// final totalStepsAggregate =
///     await healthConnector.aggregate(aggregateRequest);
/// ```
///
/// ## Main Classes
///
/// - [HealthConnector] - Main SDK interface for health data operations
/// - [HealthDataType] - Supported health and fitness data types
/// - [HealthRecord] - Individual health measurements and data points
/// - [Permission] - Permission management for data access
/// - [MeasurementUnit] - Type-safe units with automatic conversion
///
/// ## Features
///
/// - **Cross-platform**: Single API for iOS and Android
/// - **Type-safe**: Compile-time checks for data types and units
/// - **Permission management**: Request and check permissions
/// - **Read/Write**: Query and store health data
/// - **Aggregation**: Calculate sums, averages, min/max
/// - **Pagination**: Efficient large dataset handling
/// - **Metadata**: Track data source and recording method
///
/// ## Platform Coverage
///
/// ### iOS HealthKit
/// - Minimum: iOS 15.0
/// - All data types supported
/// - Read/write permissions
/// - Automatic background sync
///
/// ### Android Health Connect
/// - Minimum: API 26
/// - All data types supported
/// - Granular permissions
/// - Background read access (requires user approval)
///
/// ## Error Handling
///
/// All SDK methods throw [HealthConnectorException] with specific error codes:
/// - [NotAuthorizedException] - Permission denied
/// - [InvalidArgumentException] - Invalid parameters
/// - [HealthPlatformUnavailableException] - Platform not available
/// - [UnsupportedOperationException] - Feature not supported on platform
///
/// See [HealthConnectorException] for the complete error hierarchy.
library;

export 'package:health_connector_core/health_connector_core_internal.dart';

export 'src/health_connector.dart';
