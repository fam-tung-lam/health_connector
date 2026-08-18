# Swift Optionals

How Swift code reads a value that may be absent. The foundation owns how a
domain represents absence; this file owns the unwrapping mechanics.

## Never force the value out

`value!` traps the process when the value is `nil`. Enable SwiftLint's
`force_unwrapping` and remove every occurrence from code you touch, including
the ones that look locally safe. A refactor two commits from now makes them
unsafe without touching the line.

`as!` traps the same way. Use `as?` and handle the failure. SwiftLint's
`force_cast` flags it, and `force_try` flags the `try!` form that the errors
reference owns.

An implicitly unwrapped optional `T!` is a force-unwrap on every read. Use it
only for a property a framework assigns between allocation and first use, such
as an Interface Builder outlet. Enable `implicitly_unwrapped_optional`.

## Bind at the top, then run unindented

Use `guard let` when absence ends the current work:

```swift
guard let session = store.currentSession else {
    throw SessionError.notStarted
}
```

Use the shorthand `guard let session else { ... }` when the bound name matches
the optional's name. Use `if let` only when the absent case is a real branch
rather than an exit, and `switch` when several optionals decide the outcome
together.

Bind several values in one `guard` by separating them with commas, and put any
Boolean condition in the same comma-separated list, so the reader sees every
precondition before the body starts.

## Read a chain, and default it deliberately

Optional chaining `account?.owner?.name` produces an optional. Assigning through
a chain, as in `delegate?.didFinish()`, is a silent no-op when any link is
`nil`; check the result when the call was required to happen.

`??` supplies a fallback for a value the caller does not need to know was
missing. When the caller must know, throw instead of defaulting — the errors
reference owns that choice.

Use `map` and `flatMap` to transform an optional without unwrapping it, and
`compactMap` to drop the empty elements of a sequence.

## Do not let `Optional` name a state

`Optional` says only that a value may be absent. When `nil` carries a meaning
the reader has to remember, such as "not yet loaded", the domain needs a named
type instead; the foundation owns that decision.

Swift's own signal for the mistake is `Bool?`, which packs three states into a
type with a name for two. Enable SwiftLint's `discouraged_optional_boolean` to
find the existing ones.

## Finish

Finish when no code you touched contains `!`, `as!`, or `T!`, every optional is
bound by `guard let` or `if let` before use, and no optional Boolean stands in
for a named set of states.
