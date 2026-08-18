# Swift Concurrency

`async`/`await`, actor isolation, `Sendable`, task structure, cancellation, and
bridging callback APIs.

Turn the checks on before you rely on them. A target built with
`.swiftLanguageMode(.v6)` reports data races as compile errors; a target still
on `.v5` gets the same diagnostics as warnings from
`.enableUpcomingFeature("StrictConcurrency")`. Both live in the manifest.

## Treat every `await` as a gap

Other work runs while a function is suspended at an `await`. Any state the
function read before the suspension may have changed after it, so re-read
anything you cached across one and re-check any condition you validated.

Never block a concurrency thread. No `DispatchSemaphore.wait`, no
`DispatchQueue.sync`, and no sleeping loop inside an `async` function; the pool
is small enough that a few blocked threads deadlock the program.

## Give mutable state an isolation domain

| Construct             | Guarantees                                                       |
| --------------------- | ---------------------------------------------------------------- |
| `actor`               | One task touches its stored state at a time                      |
| `@MainActor`          | The declaration runs on the main thread                          |
| `nonisolated`         | The member touches no isolated state, so callers need no `await` |
| `nonisolated(unsafe)` | The compiler stops checking; you supply the synchronization      |

Calling an actor's member from outside is implicitly `async`. Put `@MainActor`
on the whole type when everything it holds is main-thread state, rather than
repeating it on each member.

`nonisolated(unsafe)` is a promise, not a fix. Use it only beside the lock or
the immutability argument that makes it true, and write that argument in the
comment above the declaration.

## Conform to `Sendable` honestly

A `Sendable` type is safe to hand across an isolation boundary. A `struct` or
`enum` whose members are all `Sendable` conforms automatically inside its own
module; a `final class` conforms when every stored property is an immutable
`let` of a `Sendable` type.

`@unchecked Sendable` turns the check off. It is correct only when the type is
genuinely immutable after construction, or when it serializes every access
through a lock it owns. Record which of the two applies in a doc comment on the
declaration; the next reader cannot recover that from the code.

## Keep tasks structured

- `async let first = load()` starts a fixed number of children that the scope
  awaits before it exits.
- `withThrowingTaskGroup(of:)` handles a count known only at runtime.
  `group.addTask { }` starts each child; `for try await value in group` collects
  them.
- `Task { }` is unstructured and outlives the function that created it. Keep the
  handle, cancel it when the owner goes away, or do not create it.
- `Task.detached { }` also drops the actor context and the task-local values. It
  is rarely the right tool.

## Cancel cooperatively

Cancellation sets a flag; it stops nothing on its own. Call
`try Task.checkCancellation()` between units of work to throw, or read
`Task.isCancelled` to return a partial result. Cancelling a parent cancels every
structured child.

Wrap work that a callback API must be told to stop:

```swift
try await withTaskCancellationHandler {
    try await query.run()
} onCancel: {
    query.stop()
}
```

The `onCancel` closure may run on any thread and at any moment, including before
the operation starts, so it must be safe to call on a cancelled or
not-yet-started operation.

## Bridge a callback API exactly once

```swift
func loadValue() async throws -> Int {
    try await withCheckedThrowingContinuation { continuation in
        legacyLoad { result in
            continuation.resume(with: result)
        }
    }
}
```

Use `withCheckedContinuation` when the callback cannot fail. Resume exactly once
on every path: a checked continuation traps on a second resume and leaks the
awaiting task forever on none. A callback that can fire twice needs a guard
around the resume, or an `AsyncStream` instead of a continuation.

## Finish

Finish when the target compiles under its declared language mode with no
concurrency diagnostic, every `@unchecked Sendable` names what makes it safe,
every unstructured task has an owner that cancels it, and every continuation
resumes exactly once on each path.
