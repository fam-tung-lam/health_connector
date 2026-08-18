# SwiftFormat

SwiftFormat configuration and invocation. SwiftFormat rewrites Swift source; it
does not judge design.

## Configure it in one file per package

SwiftFormat reads `.swiftformat` by walking up from each file it formats, so a
nested config overrides the package-level one for the directory it sits in.
Write one option per line as `--option value`, and add `# comments` freely.

Set the language level or SwiftFormat disables its version-gated rules and warns
on every run. Either put `--swift-version 5.9` in the config or keep a
`.swift-version` file beside it; SwiftFormat reads both.

SwiftFormat 0.60 renamed its options to kebab-case, and the older one-word
spellings still parse. `--maxwidth` and `--max-width` both work. Use whichever
spelling the file already uses and do not mix the two.

## Set the options that carry a decision

| Decision            | Option                                  | Note                                                      |
| ------------------- | --------------------------------------- | --------------------------------------------------------- |
| Indent width        | `--indent`                              | Give SwiftLint's `indentation` the same number            |
| Line width          | `--max-width`                           | Defaults to `none`, so nothing wraps until you set it     |
| Argument wrapping   | `--wrap-arguments`, `--wrap-parameters` | `before-first` puts every argument on its own line        |
| Collection wrapping | `--wrap-collections`                    | Match it to the argument wrapping                         |
| Closing paren       | `--closing-paren`                       | `balanced` gives the wrapped call its own closing line    |
| Trailing commas     | `--trailing-commas`                     | `always` keeps a one-line diff when a list grows          |
| Explicit `self`     | `--self`                                | `remove` is the default; `insert` makes capture visible   |
| Empty braces        | `--empty-braces`                        | `linebreak`, `spaced`, or `no-space`                      |
| Semicolons          | `--semicolons`                          | `never` deletes them; `inline-only` is the default        |
| File headers        | `--header`                              | `ignore` preserves whatever each file already has         |
| Trailing closures   | `--trailing-closures`                   | Comma-delimited list of functions using the trailing form |
| Excluded paths      | `--exclude`                             | Glob syntax, comma-delimited                              |

Exclude generated sources such as `**/pigeon` or `**/*.g.swift`. Excluding them
from the formatter but not the linter leaves two gates disagreeing about the
same file.

Run `swiftformat --options` to print every option this installed version accepts
before you add one. An unknown option fails the run with a suggestion.

## Check in CI, write locally

| Command                          | Effect                                                    |
| -------------------------------- | --------------------------------------------------------- |
| `swiftformat .`                  | Rewrites every file in place                              |
| `swiftformat --lint .`           | Lists each violation and exits non-zero, changing no file |
| `swiftformat --lenient --lint .` | Lists violations and exits zero                           |
| `swiftformat --verbose .`        | Names each rule that fired, for diagnosing one file       |

Use `--lint` in every verification job. A job that rewrites source cannot fail
on unformatted code, because it fixed the evidence before checking it.

## Give a conflict to the formatter

When SwiftFormat and SwiftLint disagree about the same text, disable the
SwiftLint rule and let SwiftFormat own it. Formatting is one tool's job, and a
second opinion produces a file that both tools keep rewriting.

The pairs that collide in practice are `--max-width` against SwiftLint's
`line_length`, and `--trailing-commas always` against `trailing_comma`.

## Finish

Finish when `swiftformat --lint` reports no violation across the package, the
config names a Swift version, generated sources are excluded from both tools,
and no SwiftLint rule contests a decision this file makes.
