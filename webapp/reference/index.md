# Reference

Lookup material: searchable catalogs, the complete API surface, and the version and platform facts you need when planning a feature.

For workflows and decisions, use the [Guide](/guide/). For API constraints and lookup material, use the reference pages below.

<NextSteps
  title="Searchable catalogs"
  :links="[
    { text: 'Health data types', link: '/reference/health-data-types', description: '140 types filterable by platform, category, and aggregation.' },
    { text: 'Exercise types', link: '/reference/exercise-types', description: '96 workout types with per-platform availability.' },
    { text: 'Error codes', link: '/reference/error-codes', description: 'Every code with its cause and recovery strategy.' },
  ]"
/>

<NextSteps
  title="API and constraints"
  :links="[
    { text: 'API cheat sheet', link: '/reference/api-cheat-sheet', description: 'Every method on HealthConnector, on one page.' },
    { text: 'Annotations', link: '/reference/annotations', description: 'How platform and version constraints are marked.' },
    { text: 'Platform support', link: '/reference/platform-support', description: 'The operation matrix and version floors.' },
    { text: 'Requirements', link: '/reference/requirements', description: 'Toolchain versions and why each floor exists.' },
    { text: 'Packages', link: '/reference/packages', description: 'What each package in the monorepo does.' },
  ]"
/>

## The primary types

| Type | Purpose |
|---|---|
| `HealthConnector` | The client. Creates itself for the current platform and runs every operation. |
| `HealthConnectorConfig` | Configuration passed at creation, including logging. |
| `HealthDataType` | The origin of permissions, requests, and capabilities. |
| `HealthRecord` | Base of every record model, in instant, interval, and series shapes. |
| `MeasurementUnit` | Type-safe values — `Mass`, `Length`, `Energy`, and the rest. |
| `HealthPlatformFeature` | Optional native capabilities such as background reads. |
| `HealthConnectorException` | Base of the error hierarchy, each carrying a `HealthConnectorErrorCode`. |

## Where each source of truth lives

| You need | Go to |
|---|---|
| API surface and common signatures | [API cheat sheet](/reference/api-cheat-sheet) |
| Which types and metrics exist | [Health data types](/reference/health-data-types) |
| How to accomplish a task | [Guide → Tasks](/guide/tasks/read) |
| Why the platforms differ | [Platform differences](/guide/concepts/platform-differences) |
| What changed between versions | [Changelog](https://pub.dev/packages/health_connector/changelog) and [migration guides](/resources/migration) |
| The source | [GitHub](https://github.com/fam-tung-lam/health_connector) |
