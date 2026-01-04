import 'package:health_connector_core/src/annotations/annotations.dart';

/// Utility extensions for mapping [DateTime] to DTO values.
@sinceV2_3_2
@internalUse
extension DateTimeToDto on DateTime {
  /// Returns [zoneOffsetSeconds] if non-null, otherwise computes
  /// the zone offset from the current [DateTime] (if not UTC).
  ///
  /// Returns [zoneOffsetSeconds] if [zoneOffsetSeconds] is `null` and
  /// the current [DateTime] is UTC.
  int? resolveZoneOffsetSeconds(int? zoneOffsetSeconds) {
    if (zoneOffsetSeconds != null) {
      return zoneOffsetSeconds;
    }

    return isUtc ? zoneOffsetSeconds : timeZoneOffset.inSeconds;
  }
}
