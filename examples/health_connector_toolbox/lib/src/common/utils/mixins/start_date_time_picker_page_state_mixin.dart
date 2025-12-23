import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/date_time_picker_row.dart';

/// Base state class that provides start date/time state management for pages
/// that only need a single start date and time selection.
mixin StartDateTimePickerPageStateMixin<T extends StatefulWidget> on State<T> {
  DateTime? _startDate;
  TimeOfDay? _startTime;

  /// The selected start date (without time).
  DateTime? get startDate => _startDate;

  /// The selected start time (without date).
  TimeOfDay? get startTime => _startTime;

  /// The combined date and time as a DateTime object.
  /// Returns null if either date or time is not selected.
  DateTime? get startDateTime {
    if (_startDate == null || _startTime == null) {
      return null;
    }
    return DateTime(
      _startDate!.year,
      _startDate!.month,
      _startDate!.day,
      _startTime!.hour,
      _startTime!.minute,
    );
  }

  /// Alias for [startDateTime] - used by health record forms.
  DateTime? get time => startDateTime;

  /// The timezone offset in seconds for the selected time.
  /// Returns the local timezone offset of the selected date/time.
  int? get zoneOffsetSeconds {
    final dt = startDateTime;
    if (dt == null) {
      return null;
    }
    return dt.timeZoneOffset.inSeconds;
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();

    setState(() {
      _startDate = DateTime.now();
      _startTime = TimeOfDay.now();
    });
  }

  /// Sets the date.
  void setDate(DateTime? date) {
    setState(() {
      _startDate = date;
    });
  }

  /// Sets the time.
  void setTime(TimeOfDay? time) {
    setState(() {
      _startTime = time;
    });
  }

  /// Resets both date and time fields to null.
  void resetDateTime() {
    setState(() {
      _startDate = null;
      _startTime = null;
    });
  }

  /// Builds the date/time picker widget.
  ///
  /// Returns a [DateTimePickerRow] widget that allows users to select
  /// both date and time.
  Widget buildDateTimePicker(BuildContext context) {
    return DateTimePickerRow(
      startDate: _startDate,
      startTime: _startTime,
      onDateChanged: setDate,
      onTimeChanged: setTime,
    );
  }
}
