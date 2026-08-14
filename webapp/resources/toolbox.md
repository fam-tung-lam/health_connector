# Toolbox demo app

The Health Connector Toolbox runs every SDK operation against a real device on both platforms. It is the fastest way to see a flow working before you build it — and the fastest way to tell whether a problem is in your app's configuration or in the SDK.

## Run it

```bash
git clone https://github.com/fam-tung-lam/health_connector.git
cd health_connector/examples/health_connector_toolbox
flutter pub get && flutter run
```

::: info It is a testing tool, not a reference app
The toolbox exists to demonstrate features and to manually exercise the SDK during development. Its architecture is not a production template — for patterns worth copying, use the [app recipes](/recipes/).
:::

## What it demonstrates

### Request permissions

<PlatformTabs>
<template #ios>

![Requesting permissions on iOS](/doc/assets/videos/ios_request_permissions_demo.gif)

</template>
<template #android>

![Requesting permissions on Android](/doc/assets/videos/android_request_permissions_demo.gif)

</template>
</PlatformTabs>

### Read data

<PlatformTabs>
<template #ios>

![Reading health records on iOS](/doc/assets/videos/ios_read_health_records_demo.gif)

</template>
<template #android>

![Reading health records on Android](/doc/assets/videos/android_read_health_records_demo.gif)

</template>
</PlatformTabs>

### Write data

<PlatformTabs>
<template #ios>

![Writing a health record on iOS](/doc/assets/videos/ios_write_health_record_demo.gif)

</template>
<template #android>

![Writing a health record on Android](/doc/assets/videos/android_write_health_record_demo.gif)

</template>
</PlatformTabs>

### Delete data

<PlatformTabs>
<template #ios>

![Deleting health records on iOS](/doc/assets/videos/ios_delete_health_records_demo.gif)

</template>
<template #android>

![Deleting health records on Android](/doc/assets/videos/android_delete_health_records_demo.gif)

</template>
</PlatformTabs>

### Aggregate data

<PlatformTabs>
<template #ios>

![Aggregating health data on iOS](/doc/assets/videos/ios_aggregate_health_data_demo.gif)

</template>
<template #android>

![Aggregating health data on Android](/doc/assets/videos/android_aggregate_health_data_demo.gif)

</template>
</PlatformTabs>

## Using it to debug your own app

If a flow works in the toolbox on the same device but not in your app, the difference is configuration — usually a missing `<uses-permission>` on Android or a missing usage description on iOS. Start with [Setup troubleshooting](/guide/troubleshooting).

If it fails in the toolbox too, that is worth reporting. Include your device, OS version, Flutter version, and the output from a `PrintLogProcessor`.

<NextSteps
  :links="[
    { text: 'Your first integration', link: '/guide/quickstart', description: 'Build the same flows in your own app.' },
    { text: 'Setup troubleshooting', link: '/guide/troubleshooting', description: 'When the toolbox works and your app does not.' },
    { text: 'Report an issue', link: 'https://github.com/fam-tung-lam/health_connector/issues', description: 'When the toolbox fails too.' },
  ]"
/>
