import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show allTargets;
import 'package:meta/meta.dart' show immutable;

/// Annotation to mark APIs as experimental and subject to change.
///
/// APIs marked with this annotation are **not considered stable** and may be
/// modified, renamed, or removed in future SDK releases **without following
/// strict semantic versioning rules**. This means breaking changes to
/// experimental APIs can occur in minor or patch releases, not just major
/// versions.
///
/// ## What Does Experimental Mean?
///
/// Experimental APIs are:
/// - **Under active development**: The design and behavior may still
///   evolve
/// - **Not feature-complete**: Missing functionality or edge case
///   handling
/// - **Subject to feedback**: May change based on developer feedback and
///   testing
///
/// ## When Are APIs Marked Experimental?
///
/// APIs are typically marked experimental when:
/// - Testing new features or approaches before committing to a stable API
/// - Exploring platform-specific capabilities that may need adjustments
/// - Gathering feedback from early adopters before finalizing the design
/// - Implementing features that depend on evolving platform APIs
///
/// ## Should You Use Experimental APIs?
///
/// **Use with caution in production apps.** Consider:
///
/// ✅ **Good use cases:**
/// - Prototyping and testing new features
/// - Non-critical features where API changes are acceptable
/// - Apps with frequent update cycles
/// - Early feedback and testing
///
/// ❌ **Avoid for:**
/// - Core functionality in production apps
/// - Enterprise apps with strict stability requirements
/// - Apps with infrequent update cycles
/// - Features requiring long-term API stability
///
/// ## Migration and Stability
///
/// When an experimental API becomes stable:
/// 1. The `@experimentalApi` annotation is removed
/// 2. The API is marked with `@Since('x.y.z')` to indicate when it became
///    stable
/// 3. A changelog entry documents the stabilization
/// 4. Semantic versioning guarantees apply from that version forward
///
/// If an experimental API is removed or significantly changed, the SDK will
/// provide migration guidance in the changelog and release notes.
///
/// ## Example
///
/// ```dart
/// // Experimental feature - API may change
/// @experimentalApi
/// final class AdvancedAnalyticsFeature {
///   // This API is not stable and may change in future releases
/// }
///
/// // Using an experimental API in your app
/// // You should be prepared for potential breaking changes
/// @experimentalApi
/// Future<void> tryNewFeature() async {
///   final analytics = AdvancedAnalyticsFeature();
///   // Use with understanding that this may break in updates
/// }
/// ```
///
/// ## See also
///
/// - The `Since` annotation class, which marks when stable APIs were introduced
/// - The SDK changelog for information about experimental API changes
///
/// {@category Annotations}
@allTargets
@immutable
final class _ExperimentalApi {
  /// Creates an [experimentalApi] annotation.
  const _ExperimentalApi();
}

/// Marks APIs as experimental and subject to change.
///
/// {@category Annotations}
@internalUse
const experimentalApi = _ExperimentalApi();
