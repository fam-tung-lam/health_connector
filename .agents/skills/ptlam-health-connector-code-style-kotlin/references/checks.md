# ktlint and detekt

This reference owns Health Connector's Kotlin check configuration and
suppression form.

ktlint reads `android/.editorconfig`. Detekt reads `android/detekt.yml`, builds
on its default configuration, and treats every unbaselined issue as a failure.
Both exclude generated `*.g.kt`; detekt's standard task analyzes main source.

| Convention                | Configured value                                     |
| ------------------------- | ---------------------------------------------------- |
| Code style                | Android Studio                                       |
| Package-name rule         | Disabled for the Flutter plugin's snake-case package |
| Trailing commas           | Required at call and declaration sites               |
| Wildcard imports          | Forbidden                                            |
| Line length               | 100; comments excluded from detekt's metric          |
| `LongMethod`              | 60 lines                                             |
| `CyclomaticComplexMethod` | 15                                                   |
| `CognitiveComplexMethod`  | 25                                                   |
| `NestedBlockDepth`        | 3                                                    |
| `LongParameterList`       | 6 for functions, 7 for constructors                  |
| `TooManyFunctions`        | 10                                                   |
| `ReturnCount`             | 3, excluding `equals`                                |

Run from the monorepo root:

```bash
melos run format:kotlin:check
melos run analyze:kotlin
```

`android/detekt-baseline.xml` records existing debt. Fix a new finding or use a
narrow in-code `@Suppress` with a comment immediately above it that names why
the rule does not fit. Baseline regeneration is a separate reviewed action, not
a routine fix.

For the wider local check that also analyzes tests, run `./gradlew lintAll` from
the plugin's `android/` directory. Do not confuse that task with the CI
equivalent: the committed Melos `analyze:kotlin` script runs `detekt` on main
source.
