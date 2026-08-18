# health_connector

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector"><img alt="Pub Version" src="https://img.shields.io/pub/v/health_connector.svg?style=popout"/></a>
  <a href="https://github.com/fam-tung-lam/health_connector/actions"><img alt="CI" src="https://github.com/fam-tung-lam/health_connector/actions/workflows/ci-health-connector.yaml/badge.svg"/></a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector/score"><img alt="Pub Points" src="https://img.shields.io/pub/points/health_connector?color=2E8B57&label=pub%20points"/></a>
  <img alt="Platform" src="https://img.shields.io/badge/platform-iOS%20%7C%20Android-blue"/>
  <a title="License" href="LICENSE"><img alt="License" src="https://img.shields.io/badge/license-MIT-blue.svg"/></a>
</p>

A type-safe Flutter SDK for reading, writing, aggregating, and synchronizing
health data through Android Health Connect and iOS HealthKit.

The [Health Connector SDK website](https://health-connector.phamtunglam.com/)
contains the installation guide, platform configuration, recipes, API guides,
and the searchable [supported health data type catalog](https://health-connector.phamtunglam.com/reference/health-data-types).

## Install

```bash
flutter pub add health_connector
```

## Read health data

```dart
import 'package:health_connector/health_connector.dart';

final connector = await HealthConnector.create();

await connector.requestPermissions([
  HealthDataType.steps.readPermission,
]);

final now = DateTime.now();
final response = await connector.readRecords(
  HealthDataType.steps.readInTimeRange(
    startTime: now.subtract(const Duration(days: 1)),
    endTime: now,
  ),
);

for (final record in response.records) {
  print(record);
}
```

Complete the required Android and iOS setup before running this example. See
[Install and configure](https://health-connector.phamtunglam.com/guide/installation)
and [Your first integration](https://health-connector.phamtunglam.com/guide/quickstart).

## Resources

- [SDK guide](https://health-connector.phamtunglam.com/guide/)
- [API cheat sheet](https://health-connector.phamtunglam.com/reference/api-cheat-sheet)
- [Toolbox demo app](https://health-connector.phamtunglam.com/resources/toolbox)
- [Migration guides](https://health-connector.phamtunglam.com/resources/migration)
- [API reference](https://pub.dev/documentation/health_connector/latest/)

Contributions are welcome through [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
This package is licensed under the MIT License. See [LICENSE](LICENSE).
