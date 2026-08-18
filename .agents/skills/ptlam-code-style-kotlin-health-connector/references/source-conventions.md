# Kotlin Source Conventions

This reference owns recurring Health Connector Kotlin declaration, mapper, and
logging-call shapes.

Keep new declarations `internal` unless Flutter must instantiate the plugin or
the declaration belongs to the native exception surface. Use
`@VisibleForTesting` for a test seam rather than widening production access.

Keep the Flutter plugin's snake-case package name unchanged. Both ktlint and
detekt disable their package-name rule for this deliberate Flutter convention.

Project mappers are `internal` extension functions or properties. Name a Health
Connect destination `toHealthConnect()` or `toHealthConnect<Name>()` and a
Pigeon destination `toDto()` or `to<Name>Dto()`.

Structured logs call the shared `HealthConnectorLogger` with a type tag, stable
operation, sentence message, and small context:

```kotlin
HealthConnectorLogger.info(
    tag = tag,
    operation = "read_records",
    message = "Records read successfully",
    context = mapOf("record_count" to records.size),
)
```

Use `snake_case` for new context keys. Follow the operation style already used
by the edited layer rather than renaming unrelated logs. Pass the original
throwable through `exception` on a failure log. Never interpolate health values,
record ids, user-owned dates, or device names.
