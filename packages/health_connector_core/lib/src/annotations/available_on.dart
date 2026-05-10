import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/annotations/meta_targets.dart'
    show memberAndTypeTargets;
import 'package:meta/meta.dart' show immutable;

/// Annotation to mark APIs that are available only on specific health
/// platforms, returning `null` on unsupported platforms rather than
/// throwing an error.
///
/// This annotation is distinct from `SupportedOn`: use `@AvailableOn` when
/// an API is present on all platforms but yields meaningful data only on the
/// specified platform (the field is non-null only there). Use `@SupportedOn`
/// when calling the API on an unsupported platform must result in an
/// [UnsupportedOperationException].
///
/// ## Behavior
///
/// When a field or getter marked with `@AvailableOn` is accessed on a platform
/// that is not listed, it returns `null`. The nullable type on the annotated
/// member communicates this to callers at compile time.
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
/// ## Example
///
/// ```dart
/// // Field that is populated only on Android Health Connect; null on iOS
/// @availableOnHealthConnectSinceAndroidSdkExtension21
/// final Mass? weight;
/// ```
///
/// {@category Annotations}
@sinceV3_9_0
@memberAndTypeTargets
@immutable
final class _AvailableOn {
  /// Creates an annotation that documents which platform provides a non-null
  /// value for the annotated member.
  const _AvailableOn({
    required this.platform,
  });

  /// The health platform on which this API returns a non-null value.
  final HealthPlatform platform;
}

/// Convenience annotation for fields whose values are only persisted and
/// returned by Android Health Connect when the Android device's Health Connect
/// Mainline module is **SDK Extension 21 or higher**
/// (`SdkExtensions.getExtensionVersion(UPSIDE_DOWN_CAKE) >= 21` at runtime).
///
/// On any other platform — and on Android devices whose Health Connect module
/// reports Extension < 21 — the annotated member is `null`:
/// - On iOS HealthKit, the field is structurally absent.
/// - On Android devices below Extension 21 (including all Android versions
///   older than 14, and Android 14+ devices that have not yet received the
///   Mainline update that bundles Extension 21), the underlying Health Connect
///   SDK silently drops the value on **write** and reconstructs it as `null`
///   on **read**, so callers cannot rely on round-tripping it.
///
/// Use this in preference to a generic Health-Connect-only annotation
/// whenever the field maps to a Health Connect SDK property gated by
/// `isAtLeastSdkExtension21()` (e.g. `ExerciseSegment.weight`,
/// `ExerciseSegment.setIndex`, `ExerciseSegment.rateOfPerceivedExertion`),
/// so that callers understand the runtime device requirement and do not
/// mistake a `null` result for a write/read bug in this plugin.
///
/// ## References
///
/// To verify the runtime requirement and trace the gating logic for any
/// field annotated with this:
///
/// - **AOSP Health Connect SDK source** — the actual
///   `isAtLeastSdkExtension21()` helper plus the
///   `if (isAtLeastSdkExtension21()) { … }` guards in `RecordConverters.kt`
///   that drop these fields on devices below the threshold (browse the
///   version matching the `health_connect_version` pin in
///   `health_connector_hc_android/android/build.gradle`):
///   <https://cs.android.com/androidx/platform/frameworks/support/+/androidx-main:health/connect/connect-client/src/main/java/androidx/health/connect/client/records/Utils.kt>
///   and
///   <https://cs.android.com/androidx/platform/frameworks/support/+/androidx-main:health/connect/connect-client/src/main/java/androidx/health/connect/client/impl/platform/records/RecordConverters.kt>
///
/// {@category Annotations}
@internalUse
const availableOnHealthConnectSinceAndroidSdkExtension21 = _AvailableOn(
  platform: HealthPlatform.healthConnect,
);
