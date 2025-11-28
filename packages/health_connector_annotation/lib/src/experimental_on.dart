import 'package:health_connector_annotation/src/internal_use.dart'
    show internalUse;
import 'package:health_connector_annotation/src/meta_targets.dart'
    show memberAndTypeTargets;
import 'package:health_connector_annotation/src/since.dart' show sinceV1_0_0;
import 'package:health_connector_core/health_connector_core.dart'
    show HealthPlatform;
import 'package:meta/meta.dart' show immutable;

/// Annotation to mark platform implementations that are experimental or
/// have platform-specific caveats.
///
/// Supply a map of platforms to explanation strings that describe the known
/// limitations or caveats for each platform. This is useful for preview
/// features where APIs may change, behave differently, or be removed.
///
/// ## Example
///
/// ```dart
/// @ExperimentalOn({
///   HealthPlatform.android: 'Requires Health Connect beta channel.',
///   HealthPlatform.appleHealth: 'Sampling rate may be throttled by the OS.',
/// })
/// Future<void> startContinuousMonitoring();
/// ```
@sinceV1_0_0
@memberAndTypeTargets
@internalUse
@immutable
final class ExperimentalOn {
  const ExperimentalOn(this.platforms);

  final Map<HealthPlatform, String> platforms;
}
