import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show allTargets;
import 'package:meta/meta.dart' show immutable;

/// Annotation to mark APIs intended only for internal SDK implementation.
///
/// APIs marked with this annotation are **internal implementation details**
/// of the Health Connector SDK ecosystem and are used for cross-package
/// communication between different Health Connector SDK modules.
///
/// **Application developers should NEVER use or depend on APIs marked with**
/// **[internalUse].** These are not part of the public API surface and can be
/// changed, renamed, or removed at any time without notice, even in patch
/// releases.
///
/// ## Why Are Some APIs Internal?
///
/// The Health Connector SDK uses a modular architecture with multiple packages:
/// - `health_connector_core`: Core models and interfaces
/// - `health_connector`: Public API facade
/// - `health_connector_hk_ios`: iOS HealthKit implementation
/// - `health_connector_hc_android`: Android Health Connect implementation
///
/// Internal APIs facilitate communication between these packages and handle
/// low-level platform integration. Exposing these to app developers would:
/// - Complicate the API surface unnecessarily
/// - Create tight coupling to implementation details
/// - Make SDK evolution and refactoring difficult
/// - Risk breaking apps when internal implementation changes
///
/// ## What's Marked as Internal?
///
/// Common internal APIs include:
/// - **Request/Response DTOs**: Low-level data transfer objects for platform communication
/// - **Mappers**: Convert between public models and platform-specific formats
/// - **Platform clients**: Direct platform integration interfaces
/// - **Internal helpers**: Utility functions for SDK implementation
///
/// ## How to Find the Public API Alternative
///
/// Internal APIs usually have public counterparts. Look for:
/// 1. **High-level methods** on `HealthConnector` class
/// 2. **Health data type classes** (e.g., `StepsDataType`)
/// 3. **Health record models** (e.g., `StepsRecord`)
/// 4. **Public request builders** and extension methods
///
/// ## Example
///
/// ```dart
/// // ❌ WRONG: Using internal implementation details
/// @internalUse
/// final class AggregateRequest {
///   // Internal DTO for platform communication
/// }
///
/// // ❌ Don't do this in your app!
/// final request = AggregateRequest(
///   dataType: 'steps',
///   startTime: DateTime.now(),
///   endTime: DateTime.now(),
///   aggregationType: 'sum',
/// );
///
/// // ✅ CORRECT: Use the public API instead
/// final aggregateRequest = HealthDataType.steps.aggregateSum(
///   startTime: DateTime.now().startOfDay,
///   endTime: DateTime.now(),
/// );
///
/// final result = await healthConnector.aggregate(aggregateRequest);
/// ```
///
/// ## Example: Internal Mapper vs Public API
///
/// ```dart
/// // ❌ WRONG: Using internal mapper directly
/// @internalUse
/// final record = StepsRecordMapper.fromPlatform(platformData);
///
/// // ✅ CORRECT: Use the high-level read API
/// final records = await healthConnector.readRecords(
///   HealthDataType.steps,
///   timeRange: TimeRangeFilter.lastNDays(7),
/// );
/// ```
///
/// ## See also
///
/// - Package README files for usage examples and guides
///
/// {@category Annotations}
@allTargets
@immutable
final class _InternalUse {
  /// Creates an [internalUse] annotation.
  const _InternalUse();
}

/// Annotation to mark APIs for internal plugin ecosystem use only.
///
/// {@category Annotations}
@_InternalUse()
const internalUse = _InternalUse();
