# SwiftLint

SwiftLint rule selection, thresholds, analyzer runs, baselines, and
suppressions.

## Verify a rule before you name it

Run `swiftlint rules` to print every rule this installed version knows, with
whether it is opt-in, correctable, an analyzer rule, and enabled in the current
config. Run `swiftlint rules <rule_id>` for one rule's configuration keys and
its triggering examples. Never write a rule name you have not seen there.

SwiftLint reports a misspelled rule as a warning on the run itself:
`The key(s) '...' used as rule identifier(s) is/are invalid.` A config change
that produces that line disabled nothing.

## Select the rule set

`.swiftlint.yml` sits at the package root, and SwiftLint walks up from each
linted path to find it. `--config` takes an explicit path, and several paths are
merged as a parent-child hierarchy.

| Key              | Effect                                                            |
| ---------------- | ----------------------------------------------------------------- |
| `opt_in_rules`   | Adds rules that are off by default                                |
| `disabled_rules` | Removes rules that are on by default                              |
| `only_rules`     | Replaces the whole set with exactly these rules                   |
| `analyzer_rules` | Selects rules that `swiftlint analyze` runs and `lint` never does |
| `excluded`       | Paths SwiftLint skips, glob syntax                                |
| `reporter`       | Output format, such as `xcode` for editor-clickable lines         |

Enable `force_unwrapping`, `implicitly_unwrapped_optional`, and
`fatal_error_message` on any package that ships. Enable `missing_docs` once the
package has a published surface; it takes the access levels to require, as in
`warning: [open, public]`.

Set a rule's severity by name, such as `force_cast: warning`, when the package
is migrating and an error would stop every build before the migration lands.

## Set thresholds as debts, not as decisions

`cyclomatic_complexity`, `function_body_length`, `type_body_length`,
`file_length`, `nesting`, `function_parameter_count`, and `identifier_name` each
take a `warning` and an `error` number.

Raising one records what the package tolerates today. Write beside it what work
brings the number back down, so the next reader can tell an accepted limit from
a deferred cleanup.

## Run analyzer rules against a build

`capture_variable`, `explicit_self`, `typesafe_array_init`,
`unused_declaration`, and `unused_import` need the compiler's output. They run
only under `swiftlint analyze`, which needs a build log or a compilation
database:

```shell
xcodebuild -scheme MyScheme build > build.log
swiftlint analyze --strict --compiler-log-path build.log
swiftlint analyze --strict --compile-commands compile_commands.json
```

`swiftlint lint` silently runs none of them, so a package that lists analyzer
rules and never calls `analyze` is not enforcing them.

## Fail on warnings, and freeze old debt in a baseline

`swiftlint lint --strict` turns every warning into an error. Use it in CI so
warnings cannot accumulate below the failure line.

| Command                                               | Effect                                           |
| ----------------------------------------------------- | ------------------------------------------------ |
| `swiftlint lint --write-baseline <path>`              | Records today's violations as the accepted set   |
| `swiftlint lint --baseline <path>`                    | Reports only violations absent from the baseline |
| `swiftlint baseline report <path>`                    | Prints what the baseline currently holds         |
| `swiftlint baseline compare <a> --other-baseline <b>` | Names violations `b` has that `a` lacks          |

A baseline exists so new code is held to the full rule set while legacy code is
scheduled. It may shrink and never grow. Rewriting it to absorb a violation you
introduced turns the gate off without changing a line of configuration, so
regenerate it only when the recorded count goes down.

## Suppress one line, with its reason

| Comment                                   | Silences                             |
| ----------------------------------------- | ------------------------------------ |
| `// swiftlint:disable:next <rule_id>`     | The following line                   |
| `// swiftlint:disable:this <rule_id>`     | The line the comment sits on         |
| `// swiftlint:disable:previous <rule_id>` | The preceding line                   |
| `// swiftlint:disable <rule_id>`          | Everything until a matching `enable` |

Prefer `disable:next` and put the reason on the same line after the rule name. A
region left open runs to the end of the file and silently covers code written
months later.

When the same suppression appears a third time, the configuration is wrong or
the code is. Change the rule's severity or threshold with a written reason, or
change the code. Scattered copies of one exception hide both.

## Finish

Finish when `swiftlint lint --strict` passes, every listed analyzer rule is
covered by an `analyze` run, every suppression names a reason, and the baseline
holds no violation introduced by this change.
