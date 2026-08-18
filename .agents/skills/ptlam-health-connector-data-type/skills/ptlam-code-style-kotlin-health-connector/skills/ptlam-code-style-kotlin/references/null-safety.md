# Kotlin Null Safety

How absence is spelled in Kotlin, and how it stops being spelled `!!`.

The type carries nullability. A value that can be absent has type `T?`, and
nothing else stands in for absence.

## Replace every `!!`

`!!` throws a `NullPointerException` that names no value and no reason. Pick the
replacement that matches why you believed the value was there.

| Why you believed it                     | Write instead                                                              |
| --------------------------------------- | -------------------------------------------------------------------------- |
| The caller promised it                  | `requireNotNull(value) { "..." }`, which throws `IllegalArgumentException` |
| This object's own state guarantees it   | `checkNotNull(value) { "..." }`, which throws `IllegalStateException`      |
| The caller can act on absence           | Return `T?` and let them use `?.` and `?:`                                 |
| An earlier branch already proved it     | Bind it: `val id = record.id ?: return null`, then use `id`                |
| A framework assigns it before first use | `lateinit var`, which throws an error naming the property                  |

`requireNotNull` and `checkNotNull` return the value, so they replace the `!!`
in place. Their message lambda runs only on failure, so put the identifier of
the affected thing in it.

`lateinit` works only on a non-nullable `var` of a reference type. Declare `T?`
instead when the value is genuinely optional.

## Keep a chain readable and diagnosable

- `?.` returns null for the whole expression as soon as one link is null. A
  chain crossing more than one boundary hides which link was absent, so bind the
  intermediate value and fail with a message naming it.
- Use `?:` to supply a real default or to leave the function, as `?: return`,
  `?: return null`, or `?: error("...")`.
- Never use `?:` to substitute a sentinel such as `-1` or an empty string. That
  moves the absence out of the type and into every reader's memory.
- Prefer `emptyList()` to `null` for "no elements". Keep `List<Foo>?` for a list
  that may itself be unknown, and say in KDoc which of the two you mean.

## Annotate the Java boundary

A value arriving from Java has a platform type, written `T!`. The compiler
enforces nothing on it, so a null flows into non-nullable Kotlin code and fails
somewhere later with no clue where it came from.

Give every value crossing from Java or a platform SDK an explicit Kotlin type at
the first Kotlin declaration that receives it:

```kotlin
val name: String? = javaApi.readName()
```

Then decide once, at that boundary, whether absence is legal. Honour the Java
side's `@Nullable` and `@NonNull` annotations when it has them, and treat an
unannotated Java API as nullable until you have proof otherwise.

Finish when the changed code contains no `!!`, every failure on absence names
the value that was missing, and each Java-sourced value has a declared Kotlin
type at its boundary.
