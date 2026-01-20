import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show memberAndTypeTargets;
import 'package:health_connector_core/src/models/exceptions/health_connector_exception.dart';
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:meta/meta.dart' show immutable;

/// Annotation to mark APIs that are supported only on specific health
/// platform and OS version.
///
/// This annotation indicates that an API, method, class, or health data type
/// is available exclusively on a certain health platform (e.g., Apple HealthKit
/// or Android Health Connect) or requires a minimum OS version. Platform and
/// version-specific APIs exist because different platforms support different
/// health metrics, features, or capabilities, and some features are only
/// available in newer OS versions.
///
/// ## Why Platform-Specific and Version-Specific APIs?
///
/// Health platforms have unique capabilities and data types:
/// - **Apple HealthKit** (iOS): Includes metrics like Walking Steadiness,
///   Apple Stand Time, and integration with Apple Watch sensors
/// - **Android Health Connect**: Supports metrics like Menstruation Flow,
///   Cervical Mucus, and Android-specific health sensors
///
/// Some health data types or features are only available on one platform due to
/// platform-specific implementations, hardware differences, or design choices.
///
/// Additionally, some features require specific OS versions:
/// - **iOS 16.0+**: Sleeping Wrist Temperature, Running Power, Walking Speed,
///   Running Speed, Stair Ascent Speed, Stair Descent Speed
/// - **iOS 17.0+**: Cycling Power, Cycling Pedaling Cadence
/// - **iOS 18.0+**: Rowing Distance, Paddle Sports Distance, Cross-Country
///   Skiing Distance, Skating Sports Distance
///
/// ## Behavior
///
/// When an API marked with `@SupportedOn` is called on an unsupported platform
/// or OS version, it **must** throw an [UnsupportedOperationException] with a
/// clear error message indicating which platforms or OS versions are supported.
///
/// ## Target Elements
///
/// This annotation can be applied to:
/// - Classes (especially health data types)
/// - Methods and getters
/// - Fields and properties
/// - Enum values
/// - Parameters
///
/// ## Examples
///
/// ```dart
/// // Health data type available only on Apple HealthKit
/// @supportedOnAppleHealth
/// final class WalkingSteadinessDataType extends HealthDataType
///     implements ReadableHealthDataType<WalkingSteadinessRecord> {
///   // Only available on iOS with HealthKit
/// }
///
/// // Health data type requiring iOS 16.0+
/// @supportedOnIOS16Plus
/// final class SleepingWristTemperatureDataType extends HealthDataType
///     implements ReadableHealthDataType<SleepingWristTemperatureRecord> {
///   // Only available on iOS 16.0 and later
/// }
///
/// // Health data type requiring iOS 18.0+
/// @supportedOnIOS18Plus
/// final class RowingDistanceDataType extends HealthDataType {
///   // Only available on iOS 18.0 and later
/// }
///
/// // Method available only on Android Health Connect
/// @supportedOnHealthConnect
/// Future<void> syncWithGoogleFit() async {
///   // Android-specific implementation
/// }
///
/// // Custom platform restriction
/// @SupportedOn(platform: HealthPlatform.healthConnect)
/// Future<FeatureStatus> getFeatureStatus() async {
///   if (_currentPlatform != HealthPlatform.healthConnect) {
///     throw UnsupportedOperationException(
///       'getFeatureStatus is only supported on Android Health Connect.',
///     );
///   }
///   // Implementation...
/// }
///
/// // Handling platform-specific features in your app
/// if (Platform.isIOS) {
///   // Check iOS version before using version-specific APIs
///   if (operatingSystemVersion.major >= 16) {
///     final wristTemp = await healthConnector.readRecords(
///       HealthDataType.sleepingWristTemperature,
///       timeRange: last30Days,
///     );
///   }
///
///   // Safe to use Apple HealthKit-specific APIs
///   final steadiness = await healthConnector.readRecords(
///     HealthDataType.walkingSteadiness,
///     timeRange: last30Days,
///   );
/// }
/// ```
///
/// ## Cross-Platform Development
///
/// When building cross-platform apps:
/// 1. **Check platform availability** before using platform-specific APIs
/// 2. **Check OS version** before using version-specific APIs
/// 3. **Provide alternative implementations** or gracefully handle
///    unsupported features
/// 4. **Use platform detection** (`Platform.isIOS`, `Platform.isAndroid`) to
///    conditionally call APIs
/// 5. **Inform users** when certain features are unavailable on their platform
///    or OS version
///
/// ## See also
///
/// - [HealthPlatform], which defines the available health platforms
/// - [UnsupportedOperationException], thrown when calling unsupported APIs
///
/// {@category Annotations}
@sinceV1_0_0
@memberAndTypeTargets
@immutable
final class _SupportedOn {
  /// Creates an annotation that restricts API usage to the specified platform.
  const _SupportedOn({
    required this.platform,
    this.osVersion,
  });

  /// The health platform on which this API is supported.
  final HealthPlatform platform;

  /// The minimum OS version required for this API to be supported.
  ///
  /// If the OS version is not specified, the API is supported on all OS
  /// versions.
  final String? osVersion;
}

/// Convenience annotation for APIs supported only on Android Health Connect.
///
/// {@category Annotations}
@internalUse
const supportedOnHealthConnect = _SupportedOn(
  platform: HealthPlatform.healthConnect,
);

/// Convenience annotation for APIs supported only on iOS HealthKit.
///
/// {@category Annotations}
@internalUse
const supportedOnAppleHealth = _SupportedOn(
  platform: HealthPlatform.appleHealth,
);

/// Convenience annotation for APIs supported only on iOS 16+.
///
/// {@category Annotations}
@internalUse
const supportedOnAppleHealthIOS16Plus = _SupportedOn(
  platform: HealthPlatform.appleHealth,
  osVersion: 'iOS 16+',
);

/// Convenience annotation for APIs supported only on iOS 17+.
///
/// {@category Annotations}
@internalUse
const supportedOnAppleHealthIOS17Plus = _SupportedOn(
  platform: HealthPlatform.appleHealth,
  osVersion: 'iOS 17+',
);

/// Convenience annotation for APIs supported only on iOS 18+.
///
/// {@category Annotations}
@internalUse
const supportedOnAppleHealthIOS18Plus = _SupportedOn(
  platform: HealthPlatform.appleHealth,
  osVersion: 'iOS 18+',
);
