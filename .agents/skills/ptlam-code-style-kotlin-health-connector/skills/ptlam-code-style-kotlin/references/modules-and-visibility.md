# Kotlin Modules, Files, and Visibility

Where a Kotlin declaration lives and who can see it.

## Match the package to the directory

Sources live under `src/main/kotlin`, tests under `src/test/kotlin`, and the
package statement matches the directory path below that root. detekt's
`PackageNaming` and ktlint's `package-name` rule both check the spelling.

Disable either rule only for a package name something outside the module forces,
and record that reason where the rule is disabled. [ktlint.md](ktlint.md) and
[detekt.md](detekt.md) own those files.

## Name the file after what it holds

- A file with one top-level type takes that type's name.
  `ktlint_standard_filename` enforces it.
- A file holding several small related declarations, such as a set of conversion
  extensions, takes the name of the responsibility they share.
- Prefer a top-level function or extension over a class that exists only to hold
  functions. Kotlin has no reason for a holder type, and the holder attracts
  unrelated code.

## Choose the visibility before you write the declaration

| Reach                                        | Modifier   |
| -------------------------------------------- | ---------- |
| The declaring file, class, or companion      | `private`  |
| Any file in the same Gradle module           | `internal` |
| A consumer that compiles against this module | `public`   |

Kotlin's default is `public`, so a declaration with no modifier is a published
promise you did not write down. Start a new declaration at `private`, widen it
to `internal` when a second file in the module needs it, and write `public`
explicitly only when a consumer outside the module compiles against it.

A declaration must be `internal` when it exists to serve this module's own
composition: adapters, mappers, registries, dispatcher providers, and the
implementation types behind a published interface. The compiler is happy without
the modifier, and that is exactly why it gets forgotten.

The module's own `src/test/kotlin` source set sees its `internal` declarations.
Never widen a declaration to `public` so a unit test can reach it.

## Keep constants where their scope is

Use `private const val` at file scope for a compile-time constant one file uses,
and a `companion object` constant for one that belongs to a type's contract. A
named constant also removes the detekt `MagicNumber` finding, which is a symptom
of the same problem.

Finish when every declaration you added states the narrowest visibility its real
consumers allow, no test forced a widening, and each new file is named after the
one thing it holds.
