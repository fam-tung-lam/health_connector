import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/models/health_platform.dart'
    show HealthPlatform;
import 'package:meta/meta.dart' show immutable, internal;

/// Base class for all data that have platform-specific support.
///
/// This abstract class provides a contract for determining which
/// health platforms support a particular feature, data type, or permission.
@sinceV1_0_0
@internal
@immutable
abstract interface class HealthPlatformData {
  /// The list of health platforms that support this data.
  List<HealthPlatform> get supportedHealthPlatforms;
}
