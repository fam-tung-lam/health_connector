# Packages

Health Connector is a Melos-managed monorepo. Applications depend on the facade only.

## Add this and nothing else

```yaml
dependencies:
  health_connector: ^3.9.4
```

```dart
import 'package:health_connector/health_connector.dart';
```

Everything below arrives transitively. Keeping the platform implementations transitive is what lets the facade guarantee that the Android adapter, iOS adapter, core, and logger are on mutually compatible versions.

## Runtime packages

| Package | Role | Depend on it directly? |
|---|---|---|
| [`health_connector`](https://pub.dev/packages/health_connector) | The unified public API | **Yes** |
| [`health_connector_core`](https://pub.dev/packages/health_connector_core) | Records, units, permissions, annotations, exceptions | Transitive |
| [`health_connector_hc_android`](https://pub.dev/packages/health_connector_hc_android) | Health Connect implementation | Transitive |
| [`health_connector_hk_ios`](https://pub.dev/packages/health_connector_hk_ios) | HealthKit implementation | Transitive |
| [`health_connector_logger`](https://pub.dev/packages/health_connector_logger) | Logging contracts and built-in processors | Transitive |

The only reason to name a lower-level package in your own `pubspec.yaml` is if your code imports one of its libraries directly — which is rare, since the facade re-exports the public surface of core and logger.

## Development package

[`health_connector_lint`](https://pub.dev/packages/health_connector_lint) holds the shared analysis rules the workspace uses. It is independent: adopt it in your own app if you want the same lint policy, or ignore it. A future release will add custom rules that surface the SDK's [annotations](/reference/annotations) through the Dart analyzer.

## Repository layout

```text
packages/
├── health_connector/             # public facade
├── health_connector_core/        # shared domain model
├── health_connector_hc_android/  # Health Connect adapter
├── health_connector_hk_ios/      # HealthKit adapter
├── health_connector_logger/      # logging
└── health_connector_lint/        # analysis rules
```

The facade has no native code of its own. All Kotlin and Swift lives in the two platform adapters — see [Architecture](/guide/concepts/architecture).

<NextSteps
  :links="[
    { text: 'Architecture', link: '/guide/concepts/architecture', description: 'How these packages fit together at runtime.' },
    { text: 'Install & configure', link: '/guide/installation', description: 'Adding the facade and configuring each platform.' },
    { text: 'Project & community', link: '/resources/project', description: 'Contributing, issues, and licensing.' },
  ]"
/>
