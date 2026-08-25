# Requirements

Version floors for the current release, and what each one is actually for.

## Toolchain

| Component | Requirement |
|---|---|
| Flutter | ≥ 3.44.0 |
| Dart | `^3.12.0` (declared in the package's `pubspec.yaml`) |
| Android OS | API 26+ (Android 8.0) at build time |
| Kotlin | 2.1.0 |
| Java | 17 |
| iOS | 15.0+ |
| Swift | 5.9 |

::: warning Flutter 3.44 is the published floor
The package declares `flutter: '>=3.44.0'` and `sdk: ^3.12.0`, so `pub get` fails on older Flutter and Dart versions.

Flutter 3.44 consumers using AGP 9 must set `android.builtInKotlin=false`. Enable Built-in Kotlin in application hosts
only when using Flutter 3.47 or later. The repository validates Built-in Kotlin with Flutter 3.47.1.
:::

## Android build configuration

| Setting | Value | Why |
|---|---|---|
| `minSdkVersion` | `26` | Compile floor of the Health Connect client library |
| `compileSdkExtension` | `19` | Required by Health Connect 1.2.0-alpha03, which Health Connector SDK v3.9.0+ builds against |
| `android.useAndroidX` | `true` | Health Connect is built on AndroidX |
| `android.enableJetifier` | *omit* | Deprecated; only needed for legacy support-library dependencies |
| `MainActivity` base class | `FlutterFragmentActivity` | Permission requests use `registerForActivityResult`, which needs a `FragmentActivity` host |

```groovy
android {
    compileSdkExtension 19

    defaultConfig {
        minSdkVersion 26
    }
}
```

::: warning `compileSdkExtension 19` is not the same as SDK Extension 21
Extension 19 satisfies the build. Writing `ExerciseSessionSegmentEvent.weight` separately requires the **device's** Health Connect Mainline module to be at Extension 21, checked at runtime. [Details](/reference/annotations#exercise-segment-weight-and-sdk-extension-21).
:::

## iOS build configuration

| Setting | Value | Why |
|---|---|---|
| Minimum Deployments | `15.0` | SDK floor |
| HealthKit capability | Enabled | Required entitlement |
| `NSHealthShareUsageDescription` | Specific string | Shown when requesting read access |
| `NSHealthUpdateUsageDescription` | Specific string | Shown when requesting write access |

Some data types require newer iOS versions than 15.0 — those carry an `@supportedOnAppleHealthIOS16Plus`-style annotation and throw below their floor. See [Annotations](/reference/annotations).

## Runtime availability

Meeting the build requirements does not guarantee a usable health store. Always check first:

```dart
final status = await HealthConnector.getHealthPlatformStatus();
```

| Situation | Platform | Result |
|---|---|---|
| Health Connect missing or outdated | Android | Unavailable — call `launchHealthAppPageInAppStore()` |
| Device policy restricts health data | Both | Unavailable — no code fix |
| iPad | iOS | HealthKit not present |

<NextSteps
  :links="[
    { text: 'Install & configure', link: '/guide/installation', description: 'Applying all of this step by step.' },
    { text: 'Setup troubleshooting', link: '/guide/troubleshooting', description: 'When the build or first run fails.' },
    { text: 'Platform support', link: '/reference/platform-support', description: 'Which operations exist on each platform.' },
  ]"
/>
