# Kotlin Coroutines

How suspending work chooses its thread, who owns it, and how it stops.

`suspend` marks a function that can suspend. It does not move work anywhere. A
`suspend` function that calls a blocking API still blocks the caller's thread
until it switches context itself.

## Inject the dispatcher, never name it inline

A class that names `Dispatchers.IO` inside its body cannot be tested without
real threads. Take the dispatchers as a constructor dependency with a production
default:

```kotlin
internal interface DispatcherProvider {
    val main: CoroutineDispatcher
    val io: CoroutineDispatcher
    val default: CoroutineDispatcher
}

internal object StandardDispatcherProvider : DispatcherProvider {
    override val main: CoroutineDispatcher get() = Dispatchers.Main
    override val io: CoroutineDispatcher get() = Dispatchers.IO
    override val default: CoroutineDispatcher get() = Dispatchers.Default
}
```

Switch context with `withContext(dispatchers.io) { ... }` at the point the
blocking or CPU-bound work happens, inside the suspending function. The caller
then never has to know which thread the work needs. [testing.md](testing.md)
owns the test-side substitute.

## Give every coroutine an owner

| Need                                              | Use                                                                    |
| ------------------------------------------------- | ---------------------------------------------------------------------- |
| Children that must all finish before you continue | `coroutineScope { ... }`                                               |
| Siblings where one failure must not cancel others | `supervisorScope { ... }`, or a `SupervisorJob` in the scope's context |
| Work outliving one call                           | A `CoroutineScope` a component owns and cancels                        |

Never use `GlobalScope`. It has no parent, no lifetime, and no owner, so nothing
can cancel it and a leak has nowhere to be noticed. Long-lived work belongs to a
scope whose owner cancels it when the owner ends.

Do not declare `CoroutineScope` as the receiver of a `suspend` function; detekt
flags it as `SuspendFunWithCoroutineScopeReceiver`. The function then hands its
caller a scope with a lifetime it does not control.

Bound every remote call with `withTimeout`, and treat a timeout as a distinct
outcome from a caller's cancellation.

## Keep cancellation cooperative

Cancellation arrives as a `CancellationException` thrown at the next suspension
point. Three rules follow, and the first one is where the bugs are:

- Rethrow `CancellationException` before any broader catch. Swallowing it makes
  a cancelled coroutine report success, and its parent waits for work that will
  never finish.
- `catch (e: Exception)` and `runCatching` both capture it, because
  `CancellationException` is an `Exception`. Handle it explicitly in either.
- Call `ensureActive()` inside a long non-suspending loop, so a cancelled
  coroutine stops instead of running to completion.

Run cleanup that must survive cancellation in a `finally` block, and keep it off
the cancelled context when it suspends.

## Expose a `Flow`, keep the mutable side private

A `Flow` is cold: nothing runs until something collects it, and each collector
runs the builder again. Build one with `flow { ... }` and choose its upstream
context with `flowOn`, not with `withContext` inside the builder, which throws
because emission must stay on the collector's context.

Publish a `StateFlow` while the `MutableStateFlow` behind it stays private, so
one owner writes the state and everyone else observes it.

Finish when no class names a dispatcher inline, no coroutine starts outside an
owned scope, every broad catch rethrows cancellation, and each `Flow` picks its
context with `flowOn`.
