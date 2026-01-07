import 'package:health_connector_core/health_connector_core_internal.dart'
    show sinceV3_0_0;
import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0;
import 'package:meta/meta.dart' show immutable;

part 'blood_glucose.dart';
part 'energy.dart';
part 'frequency.dart';
part 'length.dart';
part 'mass.dart';
part 'number.dart';
part 'percentage.dart';
part 'power.dart';
part 'pressure.dart';
part 'temperature.dart';
part 'time_duration.dart';
part 'velocity.dart';
part 'volume.dart';

/// Base abstract class for all measurement units in the health connector.
///
/// ## Acknowledgments
///
/// **Android Health Connect SDK**
///
/// - The type-safe unit classes design pattern (Mass, Energy, etc.)
///   follows Health Connect's approach to physical measurements
/// - **Source**: https://developer.android.com/jetpack/androidx/releases/health-connect
/// - **Documentation**: https://developer.android.com/health-and-fitness/guides/health-connect
///
/// **Implementation Details:**
///
/// - All code in this file is an **original Dart implementation** written
///   specifically for Flutter
/// - No source code has been copied from Health Connect SDK (written in
///   Kotlin/Java)
/// - The design follows functional organizational patterns that are
///   industry-standard for health data categorization
/// - This is a **cross-platform abstraction layer** designed for
///   interoperability between Android and iOS health platforms
///
/// {@category Measurement Units}
@sinceV1_0_0
@immutable
sealed class MeasurementUnit {
  const MeasurementUnit();
}
