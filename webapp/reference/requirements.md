# Requirements

Version floors for the current release, and what each one is actually for.

## Toolchain

| Component | Requirement |
|---|---|
| Flutter | ≥ 3.35.7 |
| Dart | `^3.9.2` (declared in the package's `pubspec.yaml`) |
| Android OS | API 26+ (Android 8.0) at build time |
| Kotlin | 2.1.0 |
| Java | 17 |
| iOS | 15.0+ |
| Swift | 5.9 |

::: warning The Flutter floor is enforced by pub, not advisory
`sdk: ^3.9.2` resolves only against Flutter 3.35.x and later. On Flutter 3.32 (Dart 3.8) `pub get` fails outright — there is no way to use this package on an older Flutter.

Upgrading is normally cheap, though: Flutter 3.35.7 is source-compatible with apps written for 3.32.0, and for 3.27.0 if you are already on Material 3. Swift 5.9 accepts Swift 5.0 code and Kotlin 2.1 accepts Kotlin 2.0, so the native side is a version bump in your build files.
:::

## Android build configuration

| Setting | Value | Why |
|---|---|---|
| `minSdkVersion` | `26` | Compile floor of the Health Connect client library |
| `compileSdkExtension` | `19` | Required by Health Connect 1.2.0-alpha03, which Health Connector v3.9.0+ builds against |
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
