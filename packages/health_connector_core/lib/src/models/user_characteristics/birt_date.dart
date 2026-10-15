import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/exceptions/health_connector_exception.dart';
import 'package:meta/meta.dart' show immutable;

/// A Gregorian birth date without a time or timezone.
///
/// {@category Core API}
@sinceV3_14_0
@immutable
final class BirtDate {
  /// Creates a birth date from Gregorian components.
  ///
  /// ## Throws
  ///
  /// - [InvalidArgumentException] if the components do not form a valid date.
  factory BirtDate({required int year, required int month, required int day}) {
    if (year < 1 || month < 1 || month > 12) {
      throw const InvalidArgumentException('Invalid birth date components.');
    }
    final leapYear = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
    final daysInMonth = switch (month) {
      2 => leapYear ? 29 : 28,
      4 || 6 || 9 || 11 => 30,
      _ => 31,
    };
    if (day < 1 || day > daysInMonth) {
      throw const InvalidArgumentException('Invalid birth date components.');
    }
    return BirtDate._(year, month, day);
  }

  const BirtDate._(this.year, this.month, this.day);

  /// The Gregorian year.
  final int year;

  /// The month, from 1 to 12.
  final int month;

  /// The day of the month.
  final int day;

  /// Returns a date replacing the supplied components.
  BirtDate copyWith({int? year, int? month, int? day}) => BirtDate(
    year: year ?? this.year,
    month: month ?? this.month,
    day: day ?? this.day,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BirtDate &&
          year == other.year &&
          month == other.month &&
          day == other.day;

  @override
  int get hashCode => Object.hash(year, month, day);
}
