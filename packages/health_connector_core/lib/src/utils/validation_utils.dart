import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0, internalUse;

/// Validates that a condition holds for a function argument.
///
/// ## Parameters
///
/// - [condition]: Boolean expression specifying the requirement to validate.
/// - [value]: The value being validated.
/// - [name]: The name of the parameter being validated.
/// - [message]: String describing the failed requirement in the exception.
///
/// ## Throws
///
/// - [ArgumentError.value] if [condition] is false, including the invalid
///   [value] and parameter [name] for better error messages.
///
/// @nodoc
@sinceV1_0_0
@internalUse
@internalUse
void require<T>({
  required bool condition,
  required T value,
  required String name,
  required String message,
}) {
  if (!condition) {
    throw ArgumentError.value(value, name, message);
  }
}

/// Validates that [endTime] is strictly after [startTime].
///
/// ## Parameters
///
/// - [startTime]: The expected starting point of the time interval.
/// - [endTime]: The expected ending point of the time interval.
///
/// ## Throws
///
/// - [ArgumentError] if [endTime] is not strictly after [startTime].
///
/// @nodoc
@sinceV1_0_0
@internalUse
void requireEndTimeAfterStartTime({
  required DateTime startTime,
  required DateTime endTime,
}) {
  if (!endTime.isAfter(startTime)) {
    throw ArgumentError.value(
      endTime,
      'endTime',
      'endTime must be after startTime. '
          'Got startTime=$startTime, endTime=$endTime',
    );
  }
}
