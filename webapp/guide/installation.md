# Install & configure

Adding the package takes one command. Most of the work is platform configuration — and you only need the platform you actually ship.

## Check your toolchain

| Component | Requirement |
|---|---|
| Flutter | ≥ 3.44.0 (the package declares `flutter: '>=3.44.0'`) |
| Dart | `^3.12.0` |
| Android | API 26+ (Android 8.0), Kotlin 2.1.0, Java 17 |
| iOS | iOS 15.0+, Swift 5.9 |

::: warning Flutter 3.44 is the published floor
The package declares `flutter: '>=3.44.0'` and `sdk: ^3.12.0`, so `pub get` fails on older Flutter and Dart versions.

Flutter 3.44 consumers using AGP 9 must set `android.builtInKotlin=false`. Enable Built-in Kotlin in application hosts
only when using Flutter 3.47 or later. The repository validates Built-in Kotlin with Flutter 3.47.1.
:::

Full details, including why each floor exists, are in [Requirements](/reference/requirements).

## Add the package

```bash
flutter pub add health_connector
```

Or declare it directly in `pubspec.yaml`:

```yaml
dependencies:
  health_connector: ^3.9.4
```

Depend only on the facade. The Android and iOS implementations arrive transitively, which lets the facade coordinate compatible releases — see [Packages](/reference/packages).

## Configure your platform

<PlatformTabs>
<template #android>

### Android · Health Connect {#android-health-connect}

<div class="steps">

1. **Declare a permission for every data type you touch.**

   Health Connect will not grant access to a type your manifest does not name. Add one `<uses-permission>` per type and direction to `android/app/src/main/AndroidManifest.xml`:

   ```xml
   <manifest xmlns:android="http://schemas.android.com/apk/res/android">
       <!-- Data permissions: one per type, per direction -->
       <uses-permission android:name="android.permission.health.READ_STEPS" />
       <uses-permission android:name="android.permission.health.WRITE_STEPS" />
       <uses-permission android:name="android.permission.health.READ_WEIGHT" />
       <uses-permission android:name="android.permission.health.WRITE_WEIGHT" />
       <uses-permission android:name="android.permission.health.READ_HEART_RATE" />
       <uses-permission android:name="android.permission.health.WRITE_HEART_RATE" />

       <!-- Exercise sessions, and GPS routes on top of them -->
       <uses-permission android:name="android.permission.health.READ_EXERCISE" />
       <uses-permission android:name="android.permission.health.WRITE_EXERCISE" />
       <uses-permission android:name="android.permission.health.READ_EXERCISE_ROUTE" />
       <uses-permission android:name="android.permission.health.WRITE_EXERCISE_ROUTE" />

       <!-- Feature permissions -->
       <uses-permission android:name="android.permission.health.READ_HEALTH_DATA_IN_BACKGROUND" />
       <uses-permission android:name="android.permission.health.READ_HEALTH_DATA_HISTORY" />
   </manifest>
   ```

   The permission name follows the data type: `HealthDataType.bloodGlucose` needs `READ_BLOOD_GLUCOSE`. Google's [Health Connect data types reference](https://developer.android.com/health-and-fitness/guides/health-connect/plan/data-types) lists every one.

2. **Declare the permissions-rationale entry points.**

   Health Connect and the Android settings UI both need a way into your app to show *why* you want health data — and they use different mechanisms per OS version. You need both, inside `<application>`:

   ```xml
   <application>
       <activity android:name=".MainActivity" android:exported="true" …>
           <!-- Your existing MAIN/LAUNCHER intent-filter -->

           <!-- Android 13 and below -->
           <intent-filter>
               <action android:name="androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE" />
           </intent-filter>
       </activity>

       <!-- Android 14 and above -->
       <activity-alias
           android:name="ViewPermissionUsageActivity"
           android:exported="true"
           android:permission="android.permission.START_VIEW_PERMISSION_USAGE"
           android:targetActivity=".MainActivity">
           <intent-filter>
               <action android:name="android.intent.action.VIEW_PERMISSION_USAGE" />
               <category android:name="android.intent.category.HEALTH_PERMISSIONS" />
           </intent-filter>
       </activity-alias>
   </application>
   ```

   ::: warning Both entries are required, and they are not interchangeable
   Putting `ACTION_SHOW_PERMISSIONS_RATIONALE` inside the `activity-alias` satisfies neither path. Google Play reviews this flow, so getting it wrong can hold up a release. The [example app's manifest](https://github.com/fam-tung-lam/health_connector/blob/main/packages/health_connector_hc_android/example/android/app/src/main/AndroidManifest.xml) is the reference.
   :::

3. **Make `MainActivity` extend `FlutterFragmentActivity`.**

   Permission requests use the modern `registerForActivityResult` API, which needs a `FragmentActivity` host. In `android/app/src/main/kotlin/.../MainActivity.kt`:

   ```kotlin
   package com.example.yourapp

   import io.flutter.embedding.android.FlutterFragmentActivity

   class MainActivity : FlutterFragmentActivity() {
       // Your existing code
   }
   ```

4. **Enable AndroidX** in `android/gradle.properties`, since Health Connect is built on AndroidX libraries:

   ```properties
   android.useAndroidX=true
   ```

   Older setup guides also add `android.enableJetifier=true`. Jetifier rewrites pre-AndroidX dependencies and is **deprecated** — it is off by default under AGP 8 and slows every build. Add it only if you still depend on a legacy support-library artifact.

5. **Raise `minSdkVersion` to 26** in `android/app/build.gradle`:

   ```groovy
   android {
       defaultConfig {
           minSdkVersion 26
       }
   }
   ```

   API 26 is what the Health Connect client library compiles against. It is **not** a promise that Health Connect exists on every API 26 device — the health store is a separate app, and on older devices it may be absent entirely. Always gate on `getHealthPlatformStatus()` at runtime.

6. **Set `compileSdkExtension 19`** (required from Health Connector SDK v3.9.0, which builds against Health Connect 1.2.0-alpha03):

   ```groovy
   // android/app/build.gradle — Groovy DSL
   android {
       compileSdkExtension 19
   }
   ```

   ```kotlin
   // android/app/build.gradle.kts — Kotlin DSL
   android {
       compileSdkExtension = 19
   }
   ```

</div>

::: warning `compileSdkExtension` is compile-time only
Setting extension 19 satisfies the build. Separately, writing a non-null `ExerciseSessionSegmentEvent.weight` performs a **runtime** device check and throws `UnsupportedOperationException` if that device's Health Connect Mainline module is below SDK Extension 21. The same binary can succeed on one Android 14 device and fail on another. See [exercise segment weight](/reference/annotations#exercise-segment-weight-and-sdk-extension-21).
:::

</template>
<template #ios>

### iOS · HealthKit {#ios-healthkit}

<div class="steps">

1. **Add the HealthKit capability in Xcode.**

   Open `ios/Runner.xcworkspace`, select your app target, then:

   - **General** → set **Minimum Deployments** to **15.0**
   - **Signing & Capabilities** → **+ Capability** → **HealthKit**

2. **Describe your usage in `ios/Runner/Info.plist`.**

   Both keys are required if your app reads and writes. iOS shows these strings verbatim in the authorization sheet.

   ```xml
   <dict>
       <!-- Existing keys -->

       <key>NSHealthShareUsageDescription</key>
       <string>Shows your step and heart-rate history alongside your training plan.</string>

       <key>NSHealthUpdateUsageDescription</key>
       <string>Saves completed workouts back to Apple Health so your rings stay accurate.</string>
   </dict>
   ```

</div>

::: warning Vague usage strings get apps rejected
App Review rejects generic descriptions. Name the specific data you access and the specific user-facing feature it powers — "This app needs health data" is not enough.
:::

::: info No per-type declaration needed
Unlike Health Connect, HealthKit does not require you to declare each data type in a manifest. You request types at runtime through `requestPermissions()`.
:::

</template>
</PlatformTabs>

## Verify the setup

Before requesting anything, confirm the device actually has a usable health store:

```dart
final status = await HealthConnector.getHealthPlatformStatus();

if (status != HealthPlatformStatus.available) {
  // On Android this commonly means Health Connect is missing or out of date.
  await HealthConnector.launchHealthAppPageInAppStore();
  return;
}

final connector = await HealthConnector.create();
```

If this returns anything other than `available`, or your first call throws, [Setup troubleshooting](/guide/troubleshooting) maps each symptom to its cause.

<NextSteps
  :links="[
    { text: 'Your first integration', link: '/guide/quickstart', description: 'Write, read, aggregate, and delete records end to end.' },
    { text: 'Setup troubleshooting', link: '/guide/troubleshooting', description: 'Fix the errors that show up on the first run.' },
    { text: 'Requirements', link: '/reference/requirements', description: 'Version floors and what each one is for.' },
  ]"
/>
