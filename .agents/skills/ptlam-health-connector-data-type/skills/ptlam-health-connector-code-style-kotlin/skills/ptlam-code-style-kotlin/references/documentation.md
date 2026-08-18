# KDoc

KDoc syntax and the Kotlin declarations that require one. This file owns the
spelling and the tags, not what a doc comment has to say.

## Write the block above the declaration

A KDoc block is `/** ... */` placed directly above the declaration it documents,
with no blank line between them. The first paragraph is the summary and ends
with a period. Everything after the first blank line is detail.

```kotlin
/**
 * Reads the records written between two instants.
 *
 * @param start Inclusive lower bound of the query window.
 * @param end Exclusive upper bound of the query window.
 * @return The matching records, empty when the window holds none.
 * @throws SyncException When the platform rejects the read.
 */
```

Reference another declaration with square brackets, as `[DispatcherProvider]`.
The link resolves against the file's imports, so it survives a rename in a way
that a quoted name does not.

## Use the tag that matches the declaration

| Tag              | Documents                                                          |
| ---------------- | ------------------------------------------------------------------ |
| `@param name`    | A function parameter, or a generic type parameter                  |
| `@property name` | A property declared in a primary constructor                       |
| `@return`        | The returned value, including what an empty result means           |
| `@throws Type`   | One failure a caller can catch                                     |
| `@constructor`   | The primary constructor, when it needs more than the class summary |
| `@see`           | A related declaration a reader should know about                   |

Use `@property` for a `val` in a primary constructor and `@param` for a plain
constructor parameter. Getting this backwards is the most common KDoc mistake in
a `data class`.

`@throws` carries weight in Kotlin that it does not carry in Java: there are no
checked exceptions, so the signature tells a caller nothing. A function that
throws a failure the caller is expected to handle documents it here or nowhere.
[errors.md](errors.md) owns which failures qualify.

## Document by visibility

| Declaration                            | Needs KDoc                                          |
| -------------------------------------- | --------------------------------------------------- |
| `public`                               | Always                                              |
| `internal`                             | When the name and signature leave the contract open |
| `private`                              | Only where the reason is invisible from the code    |
| An override with an unchanged contract | No; the supertype's KDoc applies                    |

Skip the block that only restates the signature. `@return The user id.` on
`fun userId(): UserId` costs a reader a line and tells them nothing.

Keep KDoc inside the module's configured line length, and let ktlint decide the
wrapping it owns.

Finish when every public declaration you touched documents its contract, every
thrown failure a caller can handle has a `@throws` tag, and every constructor
property uses `@property`.
