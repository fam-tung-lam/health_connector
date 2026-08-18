# Kotlin Unit-Test Conventions

This reference owns test placement, naming, doubles, and coroutine control in
the Android package.

Tests live under
`android/src/test/kotlin/com/phamtunglam/health_connector_hc_android/`.
`unit_tests/` mirrors the production tree; `utils/` owns shared dispatcher and
test helpers. Name a file `<TypeUnderTest>Test.kt`.

Every class uses `@DisplayName` for the subject. Name a behavior with
`GIVEN <state> → WHEN <action> → THEN <outcome>` in its display name. Follow the
neighboring file's established Kotlin method style.

Hold the subject in `private lateinit var systemUnderTest`. Disable the global
native logger in `setUp` so one test cannot forward through another test's
scope.

Prefer `FakeHealthConnectClient` and `FakePermissionController` for behavior
that reaches the SDK. Use MockK for this project's collaborators. Assert with
Kotest and name the exact project exception subtype when failure type matters.

For coroutine code, register the repository's `MainDispatcherExtension`, pass
`Dispatchers.Main.immediate` only after the extension replaces Main, or inject
`TestDispatcherProvider`. Leave no logger state behind.

Run the suite through:

```bash
melos run test:kotlin
```

The script invokes `testDebugUnitTest` from the example app. Running the plugin
module alone omits the Flutter embedding and is not an equivalent check.
