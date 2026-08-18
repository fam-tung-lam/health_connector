# ktlint

ktlint owns Kotlin formatting and the mechanical style rules. `.editorconfig` is
its configuration surface; the Gradle `ktlint` extension owns only which files
it sees and how it reports.

Formatting is the tool's decision and never a review comment. This file records
which properties that tool reads.

## Configure the style in `.editorconfig`

Put Kotlin settings in a `[*.{kt,kts}]` section of an `.editorconfig` with
`root = true` at the top of the module or repository.

| Property                                              | Sets                                                     |
| ----------------------------------------------------- | -------------------------------------------------------- |
| `ktlint_code_style`                                   | The rule set ktlint applies before any override          |
| `indent_size`                                         | Indentation width in spaces                              |
| `ij_kotlin_continuation_indent_size`                  | Indentation of a wrapped continuation line               |
| `max_line_length`                                     | The hard wrap ktlint enforces                            |
| `ktlint_standard_<rule-id>`                           | `enabled` or `disabled` for one standard rule            |
| `ij_kotlin_imports_layout`                            | Import group order, with `\|` forcing a blank line       |
| `ij_kotlin_allow_trailing_comma`                      | Trailing comma at a declaration site                     |
| `ij_kotlin_allow_trailing_comma_on_call_site`         | Trailing comma at a call site                            |
| `ij_kotlin_name_count_to_use_star_import`             | Imports from one package before a wildcard replaces them |
| `ij_kotlin_name_count_to_use_star_import_for_members` | The same count for member imports                        |

Keep the module's existing `ktlint_code_style` value. Changing it reformats
every file and buries the change you were asked to make.

## Hold these settings in every module

- Indent with four spaces and set the continuation indent to the same width, so
  a wrapped argument list does not double-indent.
- Set `max_line_length` and detekt's `MaxLineLength` to the same number. Two
  limits produce a file that passes one gate and fails the other.
- Ban wildcard imports. Enable `ktlint_standard_no-wildcard-imports`, and raise
  both star-import counts past any real import count so an IDE's
  optimize-imports action cannot reintroduce one.
- Enable `ktlint_standard_no-unused-imports` and `ktlint_standard_filename`.
- Enable trailing commas on both declaration and call sites, and allow them
  through the matching `ij_kotlin_allow_trailing_comma` properties. Adding an
  argument then costs one changed line instead of two.
- Write the import layout down. Group order is a convention nobody can infer
  from the code, and `ij_kotlin_imports_layout` is where a reader finds it.

## Turn a rule off where a reader will find it

Disable a standard rule in `.editorconfig`, on the `ktlint_standard_<rule-id>`
property, with a comment naming what forced it. A rule turned off in a build
argument or a per-file annotation is invisible to the next author.

Exclude generated sources at the Gradle `filter` block:

```groovy
ktlint {
    filter {
        exclude("**/*.g.kt")
        exclude("**/generated/**")
    }
}
```

An `.editorconfig` section for the same glob that sets `ktlint = disabled` does
the same job for editors as well as the build. Use one of the two and say which
in a comment; keeping both in step is manual work.

## Run format before check

Run `./gradlew ktlintFormat`, read the resulting diff, then run
`./gradlew ktlintCheck`. `ktlintFormat` rewrites sources, so an unreviewed run
lands unrelated changes in your commit.

A ktlint failure names the file, the position, and the rule id. Fix the code
against that rule id; reach for configuration only when the rule is wrong for
the whole module.

Finish when `ktlintCheck` passes, every disabled rule carries its reason in
`.editorconfig`, and the formatter diff contains nothing you did not intend.
