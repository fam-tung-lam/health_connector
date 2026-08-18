# Kotlin Gradle Build

How a Kotlin module declares its toolchain and its dependencies, and which
commands verify it.

The build files are the contract. A task exists because a plugin registers it or
because the build registers it, never because a README says so.

## Keep the language and the bytecode target aligned

- Declare the Kotlin version once, through the mechanism the build already uses:
  a version catalog, a `buildscript` `ext` property, or the plugins block. Never
  write a second copy of a version next to a dependency.
- Set the Kotlin `jvmTarget` and the Java `sourceCompatibility` and
  `targetCompatibility` to the same JDK release, so the Kotlin and Java
  compilation tasks agree.
- Give the detekt tasks that same target when detekt runs with type resolution,
  through `tasks.withType(Detekt).configureEach { jvmTarget = "11" }`.
- Raising the target raises the minimum runtime for every consumer. Treat it as
  a release decision, not a build cleanup.

## Declare a dependency by its reach

| Configuration        | Use for                                                        |
| -------------------- | -------------------------------------------------------------- |
| `api`                | A type that appears in this module's own public surface        |
| `implementation`     | Everything the module uses internally                          |
| `compileOnly`        | A symbol needed to compile but supplied by the host at runtime |
| `testImplementation` | A library the test sources compile against                     |
| `testRuntimeOnly`    | An engine or driver the tests need only at run time            |

Default to `implementation`. `api` leaks the dependency onto every consumer's
compile classpath, so each one becomes a caller you have to keep compatible.

A JUnit 5 module needs `junit-jupiter-api` on `testImplementation` and
`junit-jupiter-engine` on `testRuntimeOnly`. Never move a test-only library onto
`implementation` to make one import resolve.

## Register the gates the build actually runs

- Apply the ktlint and detekt plugins in the module that owns the sources, and
  keep their configuration in checked-in files rather than in ad-hoc task
  arguments. [ktlint.md](ktlint.md) and [detekt.md](detekt.md) own those files.
- Leave `ignoreFailures = false` on the ktlint extension. A gate that reports
  and passes is a report, not a gate.
- JUnit 5 does not run until the test task calls `useJUnitPlatform()`. Where
  that call goes depends on the applied plugin: a plain JVM module configures
  its `test` task, and an Android library module configures
  `testOptions.unitTests`.
- Registering an aggregate task, such as one that depends on `ktlintCheck` and
  `detekt`, is worth it when people would otherwise run one gate and forget the
  other. Give it a `group` and a `description` so `./gradlew tasks` lists it.

## Run it through the wrapper

Run `./gradlew`, never a locally installed Gradle, so every machine and CI job
compiles with the version the repository pinned.

```shell
./gradlew ktlintFormat
./gradlew ktlintCheck
./gradlew detekt
./gradlew tasks --group verification
```

The ktlint plugin registers `ktlintCheck` and `ktlintFormat`; the detekt plugin
registers `detekt` and `detektBaseline`. The test task name comes from the JVM
or platform plugin the module applies, so read it from `./gradlew tasks` instead
of assuming `test`.

Finish when one declared version drives each tool, every dependency sits in the
configuration matching its reach, and each gate you name in the handoff is a
task the build really registers.
