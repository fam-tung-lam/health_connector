part of '../health_record.dart';

/// Whether the user completed the Stand or Roll goal during an hour.
@sinceV3_11_0
enum AppleStandHourStatus {
  /// The user stood or rolled and moved for at least one continuous minute.
  stood,

  /// The user did not stand or roll and move for at least one continuous
  /// minute.
  idle,
}
