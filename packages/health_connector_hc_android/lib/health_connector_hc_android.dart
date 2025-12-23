///@docImport 'package:health_connector_core/health_connector_core.dart';
///
/// Android Health Connect implementation for health_connector.
///
/// This library provides the Android-specific implementation of the
/// [HealthConnectorPlatformClient] interface using Google's Health Connect API.
/// It translates cross-platform health data models into Health Connect's native
/// record types and handles Android-specific permission flows.
///
/// ## Platform Requirements
///
/// - **Minimum Android Version**: Android API 26
/// - **Health Connect App**: Required on device
/// - **AndroidManifest.xml**: Health permissions must be declared
/// - **Play Console**: Health data access declaration
///
/// ## Health Connect Integration
///
/// This plugin uses the Health Connect SDK to access health data and handles
/// mapping between:
/// - [HealthDataType] ↔ Health Connect record types (e.g., `StepsRecord`)
/// - [HealthRecord] ↔ Health Connect records and samples
/// - [MeasurementUnit] ↔ Health Connect units
///
/// ## Android-Specific Behaviors
///
/// ### Permissions
/// - **Granular permissions**: User grants access per data type and
///   access level
/// - **Permission status**: Returns accurate `granted`/`denied` status
/// - **Runtime permissions**: Uses Android 13+ runtime permission system
/// - **Background access**: Requires additional user approval for
///   background reads
///
/// ### Data Mutability
/// - Health Connect supports record updates
/// - Records can be modified if they were created by the same app
///
/// ### App Installation
/// - If Health Connect is not installed, the SDK prompts the user to install it
/// - Throws [HealthPlatformNotInstalledOrUpdateRequiredException] if
///   installation is required
/// - Apps can check installation status and direct users to Play Store
///
/// ### Data Sources
/// - Health Connect aggregates data from multiple health apps
/// - Query responses include data origin metadata
/// - Apps can filter queries by data source
///
/// ## Data Type Support
///
/// All [HealthDataType] instances are supported, including:
/// - Activity: steps, distance, active calories, exercise sessions
/// - Body measurements: weight, height, BMI, body fat percentage
/// - Vital signs: heart rate, blood pressure, oxygen saturation
/// - Nutrition: macronutrients, vitamins, minerals, hydration
/// - Sleep: sleep sessions with stage breakdowns
/// - And many more
///
/// ## Main Classes
///
/// - `HealthConnectorHcClient` - Android Health Connect client implementation
///
/// ## Usage
///
/// This plugin is automatically registered and used by `health_connector`
/// on Android. Apps should not interact with this library directly.
///
/// ```dart
/// // Use the main SDK instead:
/// import 'package:health_connector/health_connector.dart';
///
/// final healthConnector = HealthConnector();
/// // On Android, this automatically uses HealthConnectorHcClient internally
/// ```
///
/// ## See Also
///
/// - [Health Connect Documentation](https://developer.android.com/health-and-fitness/guides/health-connect)
library;

export 'src/health_connector_hc_client.dart';
