# Kotlin Types and Immutability

Which Kotlin construct carries a domain value, a closed set of states, or an
identifier, and how those values stay unchangeable.

## Pick the construct by what the value is

| The value is                                         | Declare it as                                                    |
| ---------------------------------------------------- | ---------------------------------------------------------------- |
| Defined entirely by its properties                   | `data class` with `val` properties                               |
| A fixed vocabulary carrying no payload               | `enum class`                                                     |
| A closed set of alternatives carrying different data | `sealed interface`, or `sealed class` when they share properties |
| One underlying value with its own identity or unit   | `@JvmInline value class`                                         |
| A single stateless instance                          | `object`                                                         |

A `data class` derives `equals`, `hashCode`, `copy`, and destructuring from its
primary constructor properties only. A property declared in the class body is
invisible to all of them, which is a silent correctness bug in a cache key or a
set. Put every identifying property in the constructor.

A `value class` gives an identifier or a unit its own static type, so an order
identifier cannot be passed where a user identifier belongs. It is boxed when it
appears as a nullable or as a generic type argument, so it is cheap but not
free.

## Let a closed type make the `when` exhaustive

A `when` over a sealed type or an enum, used as an expression or as a statement
with a subject of that type, compiles only when it covers every case:

```kotlin
internal fun SortOrder.isAscending(): Boolean = when (this) {
    SortOrder.TIME_ASCENDING -> true
    SortOrder.TIME_DESCENDING -> false
}
```

Never add `else` to a `when` over a closed type. `else` converts the next added
variant from a compile error you cannot miss into a silent fallthrough you find
in production.

Keep the alternatives of a sealed hierarchy in one file, or in one package the
hierarchy owns, so a reader finds the whole set at once.

## Default to `val`

- Declare `val`. A `var` needs a reason a reader can see inside the same
  function.
- Prefer `copy` on a `data class` over mutating a `var` property, so the
  previous value stays valid for anyone still holding it.
- A `var` on a public type hands every caller a writer. Expose `val` and, when a
  value changes over time, publish the change through a function or a stream the
  owner controls.

## Declare read-only collection types

Give every property, parameter, and return type a `List`, `Set`, or `Map` type.
Use `MutableList` only for a local you fill and then return as `List`.

`List` is read-only, not immutable. The caller cannot mutate through it, but the
same object may still be a `MutableList` someone else holds. Call `toList()`
when you hand a collection across a boundary that must not observe later change.

Finish when each value's construct matches what it is, no `when` over a closed
type carries an `else`, every public property is a `val`, and no mutable
collection type appears in a signature.
