# Analyzer and Formatter Configuration

What `analysis_options.yaml` controls, how strict a Dart project should be, and
how to suppress a diagnostic without hiding it.

Keep one `analysis_options.yaml` per package, and keep the existing one when the
project already has it. This file describes the baseline, not the resolved
configuration.

## Start from a published rule set

Include a maintained set rather than listing rules by hand:

```yaml
include: package:lints/recommended.yaml
```

`package:lints` is the Dart team's set. A project that already includes another
published set keeps it. Do not stack two sets in one file: the last `include`
wins and the earlier one silently stops applying.

Add or remove individual rules under `linter: rules:` beneath the include, and
write the reason for each removal beside it.

The analyzer rejects an unknown name with `undefined_lint`, and rejects a
contradictory pair with `incompatible_lint`. Fix both in the configuration, not
in the code.

## Turn on the three strict language modes

```yaml
analyzer:
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
```

| Mode               | Closes                                                        |
| ------------------ | ------------------------------------------------------------- |
| `strict-casts`     | An implicit downcast from `dynamic` to a specific type        |
| `strict-inference` | A type the analyzer could only infer as `dynamic`             |
| `strict-raw-types` | A generic written without type arguments, such as bare `List` |

These are the routes by which `dynamic` re-enters a typed codebase. Turn all
three on for a new package. Turn them on one at a time in an existing package so
each batch of failures has a single cause.

## Promote what must fail the build

`analyzer: errors:` re-ranks any diagnostic by its code, to `error`, `warning`,
`info`, or `ignore`:

```yaml
analyzer:
  errors:
    missing_required_param: error
    avoid_print: error
    todo: ignore
```

`dart analyze` exits `3` when it reports an error. Warnings are fatal by
default; pass `--fatal-infos` when info-level diagnostics must stop CI as well.
Promote a rule here rather than relying on a reviewer to notice it.

## Exclude generated files from analysis only

```yaml
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
```

`analyzer: exclude` stops analysis. It does not stop `dart format`, which still
rewrites an excluded file. Keep generated output away from the formatter through
the generator's own settings or the repository's ignore rules.

## Set the formatter in the same file

```yaml
formatter:
  page_width: 100
  trailing_commas: preserve
```

`page_width` moves the column at which `dart format` wraps; the default is 80.
`trailing_commas: preserve` keeps a construct split wherever the author left a
trailing comma. Under the default the formatter removes that comma and joins the
construct whenever it fits on one line.

## Suppress narrowly, with the reason

Put one `// ignore:` on the line above the diagnostic, and the reason above
that:

```dart
// The platform channel returns an untyped map on this SDK version.
// ignore: avoid_dynamic_calls
final id = payload.id;
```

Use `// ignore_for_file:` only for a file that is exempt as a whole, such as
generated output. Never disable a rule project-wide to silence one call site.

A suppression with no reason gets deleted at the next review, because nobody can
tell whether it still applies.

When the same suppression appears a third time, either the rule is wrong for
this project or the code is. Decide which, then change the configuration or the
code.

## Finish

Finish when the file includes one published rule set, the three strict modes are
on or their absence is explained, every gate CI depends on is promoted here, and
each remaining suppression names one diagnostic and its reason.
