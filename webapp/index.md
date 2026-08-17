---
layout: home
title: Flutter health data, one typed API

hero:
  name: Health Connector SDK
  text: One Flutter API for every health platform.
  tagline: >-
    Read, write, aggregate, and sync health data across Android Health Connect
    and Apple HealthKit — with one shared domain model, compile-time safety, and
    a zero-logging default.
  actions:
    - theme: brand
      text: Start integrating
      link: /guide/quickstart
    - theme: alt
      text: What is Health Connector SDK?
      link: /guide/
    - theme: alt
      text: Browse data types
      link: /reference/health-data-types

features:
  - title: One domain model, both stores
    details: >-
      A WeightRecord carries a Mass on Android and on iOS. Write the feature
      once instead of maintaining two parallel health layers.
    link: /guide/concepts/records
    linkText: Learn the data model
  - title: Capabilities enforced by the compiler
    details: >-
      Each HealthDataType exposes only the operations it actually supports, and
      reads return the matching record type. No runtime casts, no guessing.
    link: /guide/concepts/data-types
    linkText: How typing works
  - title: Platform differences stay visible
    details: >-
      iOS cannot reveal read-permission status and HealthKit records are
      immutable. Those rules are documented and typed, never papered over.
    link: /guide/concepts/platform-differences
    linkText: See the differences
  - title: Private until you say otherwise
    details: >-
      The SDK writes nothing to any log by default. Opt into logging with
      processors you control, including native Kotlin and Swift output.
    link: /guide/tasks/logging
    linkText: Configure logging
---

<div class="hc-home">

## Ship your first read in about ten minutes

Install the package, declare what your app needs on the platform you target, then call one connector.

<PlatformTabs>
<template #android>

```bash
flutter pub add health_connector
```

Declare each data type you touch in `android/app/src/main/AndroidManifest.xml`, and make
`MainActivity` extend `FlutterFragmentActivity`:

```xml
<uses-permission android:name="android.permission.health.READ_STEPS" />
<uses-permission android:name="android.permission.health.WRITE_STEPS" />
```

[Full Android setup →](/guide/installation#android-health-connect)

</template>
<template #ios>

```bash
flutter pub add health_connector
```

Add the **HealthKit** capability in Xcode, then describe your usage in `ios/Runner/Info.plist` — one key for reading, one for writing:

```xml
<key>NSHealthShareUsageDescription</key>
<string>Shows your step history alongside your training plan.</string>

<key>NSHealthUpdateUsageDescription</key>
<string>Saves completed workouts back to Apple Health.</string>
```

[Full iOS setup →](/guide/installation#ios-healthkit)

</template>
</PlatformTabs>

The Dart is identical on both platforms:

```dart
final connector = await HealthConnector.create();

await connector.requestPermissions([HealthDataType.steps.readPermission]);

final response = await connector.readRecords(
  HealthDataType.steps.readInTimeRange(
    startTime: DateTime.now().subtract(const Duration(days: 7)),
    endTime: DateTime.now(),
  ),
);

// Statically inferred as List<StepsRecord> — no cast required.
for (final record in response.records) {
  print('${record.count.value} steps at ${record.startTime}');
}
```

## What the SDK covers

<StatBand />

<UsedBy />

## Pick your entry point

<NextSteps
  title=""
  :links="[
    { text: 'Your first integration', link: '/guide/quickstart', description: 'An end-to-end walkthrough: permissions, write, read, aggregate, delete.' },
    { text: 'Core concepts', link: '/guide/concepts/architecture', description: 'The mental model behind records, units, permissions, and platform routing.' },
    { text: 'Task guides', link: '/guide/tasks/read', description: 'Focused answers to “how do I read, write, sync, or aggregate?”' },
    { text: 'App recipes', link: '/recipes/', description: 'Complete flows for nutrition, mindfulness, and fitness products.' },
    { text: 'Health data type explorer', link: '/reference/health-data-types', description: 'Search every supported type by platform and aggregation.' },
    { text: 'Error code lookup', link: '/reference/error-codes', description: 'Paste the code you hit and get the recovery strategy.' },
  ]"
/>

</div>
