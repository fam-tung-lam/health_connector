import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/start_date_time_picker_page_state_mixin.dart';

/// Base state class that provides start date/time state management with duration
/// support for pages that need a start date, time, and duration selection.
mixin StartDateTimePickerWithDurationPageStateMixin<T extends StatefulWidget>
    on StartDateTimePickerPageStateMixin<T> {
  TimeOfDay? _duration;

  /// The selected duration (as TimeOfDay).
  TimeOfDay? get duration => _duration;

  /// Calculates the end DateTime from start DateTime and duration.
  /// Returns null if either startDateTime or duration is not available,
  /// or if duration is zero.
  DateTime? get endDateTime {
    final start = startDateTime;
    if (start == null || _duration == null) {
      return null;
    }

    // Convert duration (TimeOfDay) to Duration
    final durationMinutes = _duration!.hour * 60 + _duration!.minute;
    if (durationMinutes == 0) {
      return null;
    }

    return start.add(Duration(minutes: durationMinutes));
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    // Set start date/time to now - 30 minutes
    final nowMinus30Min = DateTime.now().subtract(const Duration(minutes: 30));
    setDate(
      DateTime(
        nowMinus30Min.year,
        nowMinus30Min.month,
        nowMinus30Min.day,
      ),
    );
    setTime(
      TimeOfDay(
        hour: nowMinus30Min.hour,
        minute: nowMinus30Min.minute,
      ),
    );
    // Set duration to 30 minutes
    _duration = const TimeOfDay(hour: 0, minute: 30);
  }

  /// Sets the duration.
  void setDuration(TimeOfDay? duration) {
    setState(() {
      _duration = duration;
    });
  }

  /// Resets the duration field to null.
  void resetDuration() {
    setState(() {
      _duration = null;
    });
  }

  /// Resets both date, time, and duration fields to null.
  @override
  void resetDateTime() {
    super.resetDateTime();
    resetDuration();
  }

  /// Returns a validator function for duration fields.
  /// Validates that:
  /// - Duration is selected
  /// - Duration is greater than 0
  /// - Start date/time is selected
  /// - End date/time can be calculated
  String? Function(TimeOfDay?) get durationValidator {
    return (TimeOfDay? value) {
      if (value == null) {
        return '${AppTexts.pleaseSelect} Duration';
      }
      final durationMinutes = value.hour * 60 + value.minute;
      if (durationMinutes == 0) {
        return 'Duration must be greater than 0';
      }
      if (startDateTime == null) {
        return AppTexts.pleaseSelectDateTime;
      }
      // Verify endDateTime can be calculated
      final end = endDateTime;
      if (end == null) {
        return 'Failed to calculate end time';
      }
      return null;
    };
  }
}
