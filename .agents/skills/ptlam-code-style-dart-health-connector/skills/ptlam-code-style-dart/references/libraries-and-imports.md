# Dart Libraries, Visibility, and Imports

How a Dart package spells its published surface, and how one library reaches
another.

## `lib/src/` is the private half of the package

Dart gives a package two visibility levels above the underscore:

| Location                      | Who may import it                                 |
| ----------------------------- | ------------------------------------------------- |
| `lib/<name>.dart` and `lib/*` | Any package, through `package:<name>/<file>.dart` |
| `lib/src/**`                  | This package only                                 |
| A leading underscore          | The declaring library and its parts only          |

Put implementation files in `lib/src/`. The `implementation_imports` lint fails
another package that reaches into them, and consumers get no compatibility
promise for what lives there.

Underscore privacy is library-scoped, not class-scoped: every declaration in the
same file, including its parts, can read a `_private` member of any other
declaration in that file.

## Publish through one entry-point library

Give the package one `lib/<package_name>.dart` that re-exports the supported
surface and nothing else:

```dart
/// Order placement and tracking.
library;

export 'src/orders_repository.dart' show OrdersRepository;
export 'src/order.dart';
```

Use `show` when a source file holds more than the surface deserves. Adding an
export is cheap; removing one breaks a consumer you never met, so export a
declaration only once something outside the package needs it.

Mark a public declaration inside `lib/src/` with `@internal` from `package:meta`
when it must stay usable across the package's own libraries but carries no
promise to consumers. The analyzer reports `invalid_internal_annotation` if you
place it on a declaration that is already publicly exported, so `@internal`
documents the private half rather than narrowing the public one.

## Use `part` only where the language requires it

A `part` file is not a module. It cannot carry a single directive of its own —
the analyzer reports `non_part_of_directive_in_part` for any `import` inside one
— so every part shares the library's imports and its private names.

Reserve parts for generated output and for a split the generator dictates. Use
the string form, `part of 'orders.dart';`, which
`use_string_in_part_of_directives` enforces. Anything else becomes a separate
library with its own imports.

## Order directives, then pick one import style

Write `dart:` imports, then `package:` imports, then relative imports, each
group alphabetized and separated by a blank line. Put every `export` after every
`import`. The `directives_ordering` lint checks all of it.

Choose one style for reaching another file inside the same package and enable
its lint. `always_use_package_imports` and `prefer_relative_imports` contradict
each other, and the analyzer refuses both at once with `incompatible_lint`:

| Enabled rule                 | Inside `lib/`, write                      |
| ---------------------------- | ----------------------------------------- |
| `always_use_package_imports` | `import 'package:orders/src/order.dart';` |
| `prefer_relative_imports`    | `import '../order.dart';`                 |

A test always reaches production code through `package:<name>/…`, whichever rule
the project chose, because `test/` is not inside `lib/`.

## Finish

Finish when every implementation file sits under `lib/src/`, the entry-point
library exports only what consumers may depend on, no part file wants its own
import, and one import-style lint is enabled.
