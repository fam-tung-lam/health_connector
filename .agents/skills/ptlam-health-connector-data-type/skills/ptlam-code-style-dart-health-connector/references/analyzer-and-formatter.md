# Dart Analyzer and Formatter

This reference owns the repository's Dart check configuration and the commands
that prove handwritten Dart clean.

`packages/health_connector_lint/lib/analysis_options.yaml` is the shared source
of truth. Consumer packages include it through
`package:health_connector_lint/analysis_options.yaml`. Change a shared rule in
the lint package instead of adding package-local drift.

| Setting                                                      | Project effect                                                  |
| ------------------------------------------------------------ | --------------------------------------------------------------- |
| `strict-casts`, `strict-inference`, `strict-raw-types`       | Reject implicit downcasts, inferred `dynamic`, and raw generics |
| `dead_code`, `unused_local_variable`, `unused_import: error` | Promote these findings to errors                                |
| `todo: info` plus strict analysis                            | A TODO fails `analyze:dart:strict`                              |
| `exclude: **/*.g.dart`                                       | Generated Pigeon Dart is outside analysis                       |
| `formatter.trailing_commas: preserve`                        | Formatter respects written trailing-comma choices               |

Project lints require public and package API docs, 80-column code and comments,
package imports, braces and new lines for control bodies, typed catch clauses,
throwing only `Exception` or `Error`, trailing commas in multiline constructs,
sorted dependencies, valid comment references, ordered directives, final locals,
and no `print`.

Run these from the monorepo root:

```bash
melos run format:dart:check
melos run analyze:dart:strict
```

Use `melos run format:dart` only when the user asked to change files. Strict
analysis adds `--fatal-infos --fatal-warnings`, so an info-level rule is a real
failure. After a rename, inspect doc-comment references before assuming the
source change is complete.

Suppress only a verified false positive at the narrowest declaration or line. A
requested local rule exception is a signal to reconsider the shared lint rule;
do not create a second options hierarchy silently.
