# Migration guides

Health Connector follows semantic versioning: only major releases contain breaking changes. Each has a dedicated guide with before-and-after code for every change.

## v2.x.x → v3.0.0

**Difficulty: moderate · roughly 30 minutes for a typical app**

[Read the full guide →](https://github.com/fam-tung-lam/health_connector/blob/main/doc/guides/migration_guides/migration-guide-v2.x.x-to-v3.0.0.md)

| Breaking change | What it affects |
|---|---|
| Logging system redesign | `HealthConnectorLoggerConfig` and log processors replace the previous logging setup |
| API renaming | The largest section — many method and type names changed |
| Health record property types | Properties moved to typed measurement units |
| Meal type unification | One `MealType` vocabulary across platforms |
| Metadata constructor changes | `Metadata.manualEntry()` / `Metadata.automaticallyRecorded()` |
| Exception hierarchy & error handling | Typed exceptions carrying `HealthConnectorErrorCode` |

New in v3.0.0: the [incremental sync API](/guide/tasks/synchronize), [record sorting](/guide/tasks/read#sort-by-time), and `HealthDataTypeCategory`.

## v1.x.x → v2.0.0

**Difficulty: moderate · roughly 15–30 minutes for a typical app**

[Read the full guide →](https://github.com/fam-tung-lam/health_connector/blob/main/doc/guides/migration_guides/migration-guide-v1.x.x-to-v2.0.0.md)

| Breaking change | What it affects |
|---|---|
| Delete records API redesign | Delete requests are now built from a `HealthDataType` |
| Read records method rename | Method naming aligned with the rest of the API |
| Error code changes | Codes renamed and regrouped |
| Aggregate response type | Aggregates return typed results |
| Update record return type | Return value simplified |

New in v2.0.0: individual permission status checks, batch updates (Android), activity-specific distance types (iOS), speed data types, and exercise session support.

## Upgrading within a major version

Minor and patch releases are backward compatible. Note two version-specific build requirements introduced along the way:

- **v3.9.0+** requires `compileSdkExtension 19` in your Android Gradle configuration, because it builds against Health Connect 1.2.0-alpha03. See [Requirements](/reference/requirements#android-build-configuration).
- **`ExerciseSessionSegmentEvent.weight`** additionally requires the device's Health Connect Mainline module to be at SDK Extension 21, checked at runtime. See [Annotations](/reference/annotations#exercise-segment-weight-and-sdk-extension-21).

The [changelog](https://pub.dev/packages/health_connector/changelog) lists every release.

<NextSteps
  :links="[
    { text: 'Requirements', link: '/reference/requirements', description: 'Version floors for the current release.' },
    { text: 'Changelog', link: 'https://pub.dev/packages/health_connector/changelog', description: 'Every release, on pub.dev.' },
    { text: 'API cheat sheet', link: '/reference/api-cheat-sheet', description: 'The current API surface after migrating.' },
  ]"
/>
