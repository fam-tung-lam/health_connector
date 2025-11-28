import 'package:health_connector_annotation/src/internal_use.dart'
    show internalUse;
import 'package:health_connector_annotation/src/meta_targets.dart'
    show memberAndTypeTargets;
import 'package:health_connector_annotation/src/since.dart' show sinceV1_0_0;
import 'package:health_connector_core/health_connector_core.dart'
    show HealthPlatform;
import 'package:meta/meta.dart' show immutable;

/// Documents platform-specific behaviors for health platform APIs.
///
/// Use this annotation to describe how an API behaves differently across
/// various health platforms.
/// This is essential for internal plugin development where platform differences
/// must be clearly communicated to maintainers.
///
/// ## Example
///
/// ```
/// @PlatformSpecificBehaviors({
///   HealthPlatform.healthKit: 'Returns UTC timestamps',
///   HealthPlatform.healthConnect: 'Returns local time',
/// })
/// @internalUse
/// Future<DateTime?> getLastSyncTime(HealthDataType dataType) async {
///   // Implementation with platform-specific handling
/// }
/// ```
@sinceV1_0_0
@memberAndTypeTargets
@internalUse
@immutable
final class PlatformSpecificBehaviors {
  /// Creates a platform-specific behaviors annotation.
  ///
  /// The [platforms] map describes how the annotated API behaves on each
  /// specified platform. Each platform should have a concise description
  /// of its unique behavior, limitations, or implementation characteristics.
  const PlatformSpecificBehaviors(this.platforms);

  /// Maps each health platform to its specific behavior description.
  ///
  /// Each string should briefly describe the platform-specific behavior,
  /// such as differences in data format, timestamp handling, permissions,
  /// or availability constraints.
  final Map<HealthPlatform, String> platforms;
}
