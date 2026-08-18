# Swift Error Handling

How a Swift function reports a failure and how a caller handles it. The
foundation owns which failures the interface promises; this file owns the
`throws`, `Result`, and trap mechanics.

## Give each failure domain one `Error` enum

Declare an `enum` conforming to `Error`, with one case per outcome a caller can
act on, and associated values carrying the identifiers the caller needs:

```swift
enum SessionError: Error {
    case notStarted
    case expired(sessionID: String, at: Date)
    case transport(underlying: any Error)
}
```

Conform to `LocalizedError` when a message reaches a person, and to
`CustomDebugStringConvertible` when the diagnostic string differs from it. Carry
the original failure in an associated value instead of discarding it.

## Choose the reporting mechanism

| Situation                                                  | Use                        |
| ---------------------------------------------------------- | -------------------------- |
| The caller handles the failure at the call site            | `throws`                   |
| The function only forwards its closure's failure           | `rethrows`                 |
| The failure set is closed and will not grow                | `throws(SomeError)`        |
| The outcome is stored, deferred, or crosses a callback API | `Result<Success, Failure>` |
| Absence and failure mean the same thing to the caller      | `try?`                     |

Typed throws, `func parse(_ text: String) throws(ParseError) -> Port`, narrows
what a caller must catch and lets `throw .notANumber(text)` drop the type name.
The typed list is a source-breaking promise, so use it only where the failures
really are closed.

Prefer `throws` over returning `Result` from an ordinary function; `Result`
earns its place when the value is stored or handed to a completion handler.

## Catch narrowly, and let the rest travel

Catch with a pattern rather than a bare block:

```swift
do {
    try session.refresh()
} catch let error as SessionError {
    try recover(from: error)
} catch {
    throw SessionError.transport(underlying: error)
}
```

A bare `catch` binds the value to `error` implicitly. When it only rethrows,
delete it. Use `defer` for cleanup: it runs on every exit from the scope,
including a thrown one, and in reverse order of declaration.

## Reserve the traps

| Construct        | Acceptable when                                                                              |
| ---------------- | -------------------------------------------------------------------------------------------- |
| `try!`           | A test proves the call cannot fail, such as a literal `Regex`                                |
| `fatalError(_:)` | The branch is genuinely unreachable, or a `required init?(coder:)` the type does not support |
| `precondition`   | An invariant whose violation would corrupt state; it stays in release builds                 |
| `assert`         | A debug-only check whose removal is harmless; release builds drop it                         |

None of them is acceptable for invalid input, a missing configuration value, or
a failed network call. Those are failures a caller can be told about. Always
pass a message to `fatalError`; SwiftLint's `fatal_error_message` requires one
and `force_try` flags `try!`.

## Finish

Finish when each failure a caller can act on is a case of a named `Error` type,
every `catch` either recovers or adds context, no trap stands in for a
reportable failure, and every cleanup path runs through `defer` or a scope exit
the compiler enforces.
