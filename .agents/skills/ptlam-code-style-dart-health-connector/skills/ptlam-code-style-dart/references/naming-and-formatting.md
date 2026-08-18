# Dart Naming and Formatting

The case conventions Dart expects, and what `dart format` decides so nobody
argues about it.

## Case follows the kind of declaration

| Kind                                           | Form                         | Example                     |
| ---------------------------------------------- | ---------------------------- | --------------------------- |
| File, directory, package                       | `lowercase_with_underscores` | `place_order_use_case.dart` |
| Class, enum, extension, mixin, typedef         | `UpperCamelCase`             | `OrdersRepository`          |
| Member, variable, parameter, named constructor | `lowerCamelCase`             | `maxRetryCount`             |
| Constant                                       | `lowerCamelCase`             | `defaultTimeout`            |
| Library-private declaration                    | Leading underscore           | `_OrdersView`               |
| Import prefix                                  | `lowercase_with_underscores` | `as http_client`            |

A Dart constant is `lowerCamelCase`, never `SCREAMING_CAPS`. Dart spells privacy
with a leading underscore and scopes it to the library, not to the class: a
private member is visible to every declaration in the same library file and its
parts.

Name a file after the single public declaration it holds, in the snake-case form
of that declaration's name. `OrdersRepository` lives in
`orders_repository.dart`.

## The formatter owns whitespace

Run it, take its output, and never spend a review comment on it:

```bash
dart format .
dart format --output=none --set-exit-if-changed .
```

The check form exits `1` when any file would change, which is what CI should
run. `dart format` rewrites files in place even when the analyzer excludes them,
so keep generated output out of its path rather than out of the analyzer.

The formatter reads `page_width` and `trailing_commas` from
`analysis_options.yaml`. Never hand-wrap around it: under the default
`trailing_commas` setting the formatter removes a trailing comma and rejoins the
construct whenever it fits, so a comma added to force a layout is undone on the
next run. Set `trailing_commas: preserve` when the project wants author-chosen
splits to survive.

## Quoting and redundant syntax

- Use single quotes. Switch to double quotes only to avoid escaping an inner
  apostrophe; `prefer_single_quotes` and `avoid_escaping_inner_quotes` enforce
  the pair.
- Omit `new`. It has been optional since Dart 2 and adds nothing.
- Omit `const` inside an already-constant context, such as a `const` list's
  elements.
- Omit `this.` outside a constructor initializer or a shadowed parameter.
- Use a `//` line comment for explanation and `///` for a doc comment. Reserve
  `/* */` for temporarily disabling code you are about to delete anyway.

## Finish

Finish when every new declaration matches the case for its kind, each file is
named after its one public declaration, and
`dart format --output=none --set-exit-if-changed .` reports no difference.
