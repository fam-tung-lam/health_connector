import 'package:flutter/material.dart' hide Interval, Velocity;
import 'package:health_connector/health_connector_internal.dart'
    show
        Energy,
        Frequency,
        TimeDuration,
        Length,
        Mass,
        MeasurementUnit,
        Number,
        Percentage,
        BloodGlucose,
        Power,
        Pressure,
        Temperature,
        Velocity,
        Volume;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [MeasurementUnit] to provide UI-related properties and
/// metadata.
///
/// This extension provides standard display names and icons for various
/// measurement units used throughout the Toolbox App's user interface.
extension MeasurementUnitUI on MeasurementUnit {
  /// Returns the localized display name for this measurement unit.
  ///
  /// This name is suitable for use in labels, form fields, and headings
  /// to identify the type of measurement being displayed or recorded.
  String get displayName {
    return switch (this) {
      Mass _ => AppTexts.mass,
      Number _ => AppTexts.numeric,
      TimeDuration _ => AppTexts.interval,
      Percentage _ => AppTexts.percentage,
      Length _ => AppTexts.length,
      Energy _ => AppTexts.energy,
      BloodGlucose _ => AppTexts.bloodGlucose,
      Power _ => AppTexts.power,
      Pressure _ => AppTexts.pressure,
      Temperature _ => AppTexts.temperature,
      Velocity _ => AppTexts.velocity,
      Volume _ => AppTexts.volume,
      Frequency _ => AppTexts.frequency,
    };
  }

  /// Returns a representative icon for this measurement unit.
  ///
  /// This icon should be used consistently across the app (e.g., in lists,
  /// detail views, and icons) to provide a visual cue for the unit type.
  IconData get icon {
    return switch (this) {
      Mass _ => AppIcons.mass,
      Number _ => AppIcons.numeric,
      TimeDuration _ => Icons.access_time,
      Percentage _ => AppIcons.percent,
      Length _ => AppIcons.length,
      Energy _ => AppIcons.energy,
      BloodGlucose _ => AppIcons.bloodGlucose,
      Power _ => AppIcons.power,
      Pressure _ => AppIcons.pressure,
      Temperature _ => AppIcons.temperature,
      Velocity _ => AppIcons.velocity,
      Volume _ => AppIcons.volume,
      Frequency _ => AppIcons.favorite,
    };
  }
}
