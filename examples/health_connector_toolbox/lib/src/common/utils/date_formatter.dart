import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Utility class for formatting dates and times.
abstract class DateFormatter {
  DateFormatter._();

  /// Formatter for 'dd-MM-yyyy HH:mm' pattern.
  static final DateFormat ddMMyyyyHHmm = DateFormat('dd-MM-yyyy HH:mm');

  /// Formats a [DateTime] to a string in 'yyyy-MM-dd' format.
  ///
  /// Returns an empty string if [date] is null.
  static String formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Formats a [DateTime] to a string in 'yyyy-MM-dd HH:mm' format.
  ///
  /// Returns an empty string if [dateTime] is null.
  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  /// Formats a [TimeOfDay] to a string in 'HH:mm' format.
  ///
  /// Returns an empty string if [time] is null.
  static String formatTime(TimeOfDay? time) {
    if (time == null) {
      return '';
    }
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Combines a [DateTime] (for date) with a [TimeOfDay] (for time) into a
  /// single [DateTime].
  ///
  /// Returns null if either [date] or [time] is null.
  static DateTime? combine(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) {
      return null;
    }
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
