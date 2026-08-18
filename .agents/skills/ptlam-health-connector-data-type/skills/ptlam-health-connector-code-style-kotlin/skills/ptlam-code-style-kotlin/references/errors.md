# Kotlin Failure Design

Which Kotlin construct signals a failure, which type carries it, and where it
may be caught.

## Signal a broken assumption with the standard-library check

| Construct                       | Throws                     | Use when                                   |
| ------------------------------- | -------------------------- | ------------------------------------------ |
| `require(condition) { ... }`    | `IllegalArgumentException` | The caller passed something invalid        |
| `requireNotNull(value) { ... }` | `IllegalArgumentException` | The caller passed a null that is not legal |
| `check(condition) { ... }`      | `IllegalStateException`    | This object's own state forbids the call   |
| `checkNotNull(value) { ... }`   | `IllegalStateException`    | Internal state that should exist is absent |
| `error(message)`                | `IllegalStateException`    | A branch that must be unreachable was hit  |

The message lambda runs only on failure, so put the identifier of the affected
thing inside it. `require(id.isNotBlank()) { "record id was blank" }` costs
nothing on the passing path.

Use these for programming errors, not for outcomes the caller is meant to
handle. A declined payment is a return value; a null where an invariant promised
a value is a `checkNotNull`.

## Type a handleable failure as a sealed hierarchy

Model the failures a caller must distinguish as one `sealed class` rooted at an
exception type, with a `data class` per named failure carrying its identifiers
and its `cause`:

```kotlin
sealed class SyncException : Exception() {
    data class Unauthorized(
        override val message: String,
        override val cause: Throwable? = null,
    ) : SyncException()
}
```

Extend `Exception`, never `Throwable` directly. A boundary that catches
`Exception` will not see a bare `Throwable` subclass, so the failure escapes
every handler written the ordinary way.

The sealed root gives the caller an exhaustive `when` over the named failures;
[data-modeling.md](data-modeling.md) owns that exhaustiveness rule.

Kotlin has no checked exceptions, so a signature never tells a caller what it
throws. Document every failure with a KDoc `@throws` tag, and add
`@Throws(SyncException::class)` where a Java or platform caller has to see the
declaration. [documentation.md](documentation.md) owns the tag.

## Catch narrowly, and rethrow cancellation first

- Catch the narrowest type the current boundary can actually handle, then
  recover, translate once, or let it travel on.
- detekt's `TooGenericExceptionCaught` flags `catch (e: Exception)`. A process
  or request boundary that legitimately needs it carries
  `@Suppress("TooGenericExceptionCaught")` with its reason, as
  [detekt.md](detekt.md) requires.
- Rethrow `CancellationException` before any broader catch.
  [coroutines.md](coroutines.md) owns why, and owns the same trap in
  `runCatching`.
- Use `use { }` on a `Closeable` so the resource closes on the failure path as
  well as the success path.

## Use `Result` only where a caller branches on it

`runCatching` catches `Throwable`, which includes `CancellationException`. Do
not wrap a suspending call in it unless the surrounding code rethrows
cancellation explicitly.

Return `Result<T>` only inside a module, for a call whose immediate caller
branches on success or failure right there. When callers must distinguish more
than two outcomes, give them the sealed hierarchy above instead: `Result`
flattens every failure into one shape and pushes the reader back to the
exception type to tell them apart.

Finish when every broken assumption uses the construct matching its blame, every
handleable failure has a named type documented with `@throws`, and no catch
block swallows cancellation.
