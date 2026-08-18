# Dart Exceptions and Errors

Which Dart type a failure gets, how to catch one without widening the blast
radius, and how to keep the original stack trace.

## `Error` is a bug; `Exception` is a condition

Dart splits thrown values into two hierarchies, and the split decides who is
responsible:

| Hierarchy   | Means                                     | A caller should |
| ----------- | ----------------------------------------- | --------------- |
| `Error`     | The program broke a contract it was given | Fix the code    |
| `Exception` | A condition the caller was told to expect | Handle it       |

Throw `Error` and its subtypes for a violated precondition, and `Exception` and
your own domain types for something a caller can act on.

Enable `only_throw_errors`. It forbids throwing anything outside those two
hierarchies — a bare `String` or `int` — but permits both of them, so it does
not decide the split for you.

## Reject bad arguments with the built-in errors

| Situation                           | Throw                                         |
| ----------------------------------- | --------------------------------------------- |
| An argument's value is not allowed  | `ArgumentError.value(n, 'n', 'must be even')` |
| A required argument was null        | `ArgumentError.notNull('order')`              |
| A number sits outside a valid range | `RangeError.range(i, 0, items.length - 1)`    |
| The object is in the wrong state    | `StateError('already closed')`                |
| The operation is not available here | `UnsupportedError('web has no file system')`  |

`ArgumentError.value` records the offending value and the parameter name, so the
message names what was wrong without the caller reading source. Prefer it to a
hand-built message.

## Catch a named type, not everything

Write `on <Type> catch (e, stackTrace)`. The `avoid_catches_without_on_clauses`
lint reports a bare `catch` whose body handles the failure, and allows one whose
body only rethrows.

Enable `avoid_catching_errors` too. Catching an `Error` subtype hides a bug
behind a recovery path that was written for a condition.

Convert at the boundary that owns the dependency: catch the library's type
there, and throw or return a type your own callers already know. Above that
boundary nothing should name the library's exception class.

## Keep the stack trace

`rethrow` preserves both the value and the original trace; `throw e` inside a
catch block restarts the trace at the catch and loses where the failure began.

When the boundary replaces the failure with its own type, carry the captured
trace across with `Error.throwWithStackTrace`:

```dart
try {
  return await _client.fetch(id);
} on FormatException catch (e, stackTrace) {
  Error.throwWithStackTrace(OrdersDecodeFailure(id, e), stackTrace);
}
```

Never throw from a `finally` block; it discards whatever was already in flight.
The `throw_in_finally` lint reports it.

## Finish

Finish when every thrown value is an `Error` for a bug or an `Exception` for a
condition, every `catch` names its type or only rethrows, no library exception
escapes the boundary that owns it, and every translated failure carries the
original stack trace.
