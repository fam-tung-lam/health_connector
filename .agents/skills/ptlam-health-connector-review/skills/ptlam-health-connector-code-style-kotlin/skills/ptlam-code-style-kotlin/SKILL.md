---
name: ptlam-code-style-kotlin
description:
  Write, review, and fix Kotlin library and application code against conventions
  for language mechanics, null safety, coroutines, the Gradle, ktlint, and
  detekt toolchain, KDoc comments, and JUnit tests. Use when starting or
  standardizing a Kotlin module, changing Kotlin code or its build and lint
  configuration, reviewing Kotlin-specific design, or resolving a ktlint,
  detekt, or JUnit failure. Apply ptlam-code-style first for the standard these
  mechanics satisfy. Use as the foundation for Kotlin platform and project
  specializations. Do not use for Java or for another JVM language.
---

# PTLam Kotlin Code Style

Conventions for Kotlin library and application code: the Gradle build, the
ktlint and detekt gates, module visibility, null safety, data modeling,
functions, failure design, coroutines, KDoc, and JUnit 5 tests. This skill owns
Kotlin language and toolchain mechanics only. The foundation owns the standard
they satisfy, and a platform or repository specialization owns everything above
them.

## Required skills

### `ptlam-code-style`

**Reason:** Provides the language-neutral conventions and testing doctrine the Kotlin mechanics satisfy.

**Instructions:** Read and apply ptlam-code-style first.
Let it own precedence; the structure, boundary, naming, readability,
data-modeling, contract, failure, documentation, and logging
standards; the universal behavior contract; test levels; test
placement; and test doubles.
Use this skill only for Kotlin language, module, and tool mechanics
that satisfy those standards.
This specialization may be stricter than the foundation, never looser.

Read [ptlam-code-style](skills/ptlam-code-style/SKILL.md).

## Before the first edit

1. Resolve the Gradle module that owns the files in scope, then read every
   applicable `AGENTS.md` from the repository root down to those files.
2. Read `settings.gradle*`, the module's `build.gradle` or `build.gradle.kts`,
   the version catalog when one exists, `.editorconfig`, the detekt
   configuration, and the nearest sources under `src/main/kotlin` and
   `src/test/kotlin`.
3. Record the Kotlin version, the `jvmTarget`, the applied plugins, the check
   tasks those plugins register, and the test framework. These are the
   mechanics. A dependency on the classpath does not prove a task runs it.
4. Confirm a task name with `./gradlew tasks` before you quote it in a handoff.
   Task names differ between a plain JVM module and a platform variant module.
5. Apply the rules below to code you add or substantively change. Leave
   unrelated legacy inconsistencies alone.

For a new module, apply the Kotlin Gradle plugin,
`org.jlleitschuh.gradle.ktlint` with a checked-in `.editorconfig`,
`io.gitlab.arturbosch.detekt` with a checked-in configuration file, and JUnit 5
with MockK, Kotest assertions, and `kotlinx-coroutines-test`. In an existing
module, keep its working toolchain until replacing it is part of the task.

## Pick a reference

| Concern                                                             | Reference                                                         |
| ------------------------------------------------------------------- | ----------------------------------------------------------------- |
| Changing the build, a version, a dependency, or a check task        | [gradle-build.md](references/gradle-build.md)                     |
| Configuring ktlint or resolving a formatting failure                | [ktlint.md](references/ktlint.md)                                 |
| Configuring detekt, a threshold, a baseline, or a suppression       | [detekt.md](references/detekt.md)                                 |
| Placing a file, naming a package, or choosing a visibility modifier | [modules-and-visibility.md](references/modules-and-visibility.md) |
| Removing a `!!`, or receiving a value from Java                     | [null-safety.md](references/null-safety.md)                       |
| Declaring a domain type, a closed state set, or a collection        | [data-modeling.md](references/data-modeling.md)                   |
| Writing a function body, a parameter list, or a scope-function call | [functions.md](references/functions.md)                           |
| Signalling, typing, or catching a failure                           | [errors.md](references/errors.md)                                 |
| Writing a `suspend` function, launching work, or exposing a `Flow`  | [coroutines.md](references/coroutines.md)                         |
| Writing a KDoc comment                                              | [documentation.md](references/documentation.md)                   |
| Writing, placing, or restructuring a JUnit 5 test                   | [testing.md](references/testing.md)                               |

## Apply the mechanics

1. Give every declaration you add the narrowest visibility its real consumers
   allow, and an explicit return type on anything not `private`.
2. Remove every `!!` from code you touch, and give each value crossing a Java
   boundary an explicit Kotlin type.
3. Keep public properties, parameters, and return types on `val` and read-only
   collection types.
4. Take dispatchers as an injected dependency, and keep every coroutine inside a
   scope something owns.
5. Add or update JUnit 5 tests in the module's existing test home for the
   normal, boundary, and failure cases the change touches.
6. Run the checks narrow to broad: the focused test class, then `ktlintFormat`
   and `ktlintCheck`, then `detekt`, then the module's test task, then the
   module build.

Inspect the diff after `ktlintFormat` or any other write-mode task. Report the
exact commands, their results, the lint exclusions that affect confidence, and
every check you did not run.

## Finish

Finish when the changed code compiles at the module's `jvmTarget`, passes ktlint
and detekt with no new finding and no new baseline entry, exposes no unintended
public surface, leaks no coroutine outside an owned scope, and passes the
affected JUnit 5 tests under the module's own tasks.
