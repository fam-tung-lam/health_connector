# SwiftLint and SwiftFormat

This reference owns the committed Swift check configuration and commands.

SwiftLint runs from the iOS package directory in strict mode against
`swiftlint-baseline.json`. SwiftFormat receives the iOS directory and reads
`.swiftformat`. Both exclude generated Pigeon Swift.

| SwiftLint metric         | Warning | Error |
| ------------------------ | ------- | ----- |
| Cyclomatic complexity    | 10      | 15    |
| Function body length     | 100     | 200   |
| Type body length         | 300     | 500   |
| File length              | 500     | 1200  |
| Closure body length      | 30      | 50    |
| Function parameter count | 5       | 8     |

Strict mode promotes warnings such as force cast, force try, force unwrap, and
implicitly unwrapped optional to build failures. `line_length` and
`trailing_comma` are disabled in SwiftLint because SwiftFormat owns them.

SwiftFormat uses Swift 5.9, four-space indentation, 120 columns, trailing
commas, no redundant `self`, one-per-line wrapped arguments and parameters, no
semicolons, and the standard brace position.

Run from the monorepo root:

```bash
melos run format:swift:check
melos run analyze:swift
```

The SwiftLint baseline records existing debt. Fix a new violation instead of
regenerating the baseline. Baseline regeneration is a deliberate, separately
reviewed change.

CI currently runs strict SwiftLint. Its SwiftFormat step is disabled, so the
local format check is required evidence rather than a duplicate server check.
Analyzer-only SwiftLint rules also need compiler logs and are not exercised by
the committed Melos script; do not report them as checked.
