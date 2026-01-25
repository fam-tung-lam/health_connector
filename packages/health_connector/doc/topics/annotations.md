# Annotations

The Health Connector SDK uses several annotations to communicate API
stability, platform support, versioning, and usage constraints. These
annotations help developers make informed decisions when integrating health
data features into their applications.

---

## @SupportedOn

Marks APIs that are supported only on specific health platforms (iOS
HealthKit or Android Health Connect) or require a minimum OS version.

When the annotated API is called on an unsupported platform or OS version, it **must** throw an
`UnsupportedOperationException`.

```dart
// Platform-specific health data type
@supportedOnAppleHealth
final class WalkingSteadinessDataType extends HealthDataType
    implements ReadableHealthDataType<WalkingSteadinessRecord> {
  // Only available on iOS HealthKit
}

// iOS version-specific health data type
@supportedOnIOS16Plus
final class SleepingWristTemperatureDataType extends HealthDataType
    implements ReadableHealthDataType<SleepingWristTemperatureRecord> {
  // Only available on iOS 16.0 and later
}

// Android-specific health data type
@supportedOnHealthConnect
final class MenstruationFlowDataType extends HealthDataType {
  // Only available on Android Health Connect
}

// Custom platform restriction
@SupportedOn(platform: HealthPlatform.healthConnect)
Future<void> syncWithGoogleFit() async {
  if (_currentPlatform != HealthPlatform.healthConnect) {
    throw UnsupportedOperationException(
      'syncWithGoogleFit is only supported on Android Health Connect.',
    );
  }
  // Android-specific implementation
}
```

### Platform and Version-Specific Annotations

| Annotation                  | Platform | Min OS Version | Description                                  |
|:----------------------------|:---------|:---------------|:---------------------------------------------|
| `@supportedOnHealthConnect` | Android  | N/A            | Features exclusive to Android Health Connect |
| `@supportedOnAppleHealth`   | iOS      | N/A            | Features exclusive to iOS HealthKit          |
| `@supportedOnIOS16Plus`     | iOS      | 16.0+          | Requires iOS 16.0 or later (e.g., Sleeping   |
|                             |          |                | Wrist Temperature, Running Power)            |
| `@supportedOnIOS17Plus`     | iOS      | 17.0+          | Requires iOS 17.0 or later (e.g., Cycling    |
|                             |          |                | Power, Cycling Pedaling Cadence)             |
| `@supportedOnIOS18Plus`     | iOS      | 18.0+          | Requires iOS 18.0 or later (e.g., Rowing     |
|                             |          |                | Distance, Paddle Sports Distance)            |

**When you see this annotation**:

- Check the platform at runtime using `HealthConnector.getHealthPlatformStatus()`
- For version-specific APIs on iOS, check the OS version before using the API
- Be prepared to handle `UnsupportedOperationException` if used on unsupported platforms/versions

---

## @internalUse

Marks APIs intended only for cross-package communication and
implementation details **within** the Health Connector SDK ecosystem.

**Application developers should not use or depend on APIs marked with
`@internalUse`**, as these are not considered part of the public API
surface and can be changed without notice.

```dart
@internalUse
final class AggregateRequest {}

// ❌ Not intended: Do not instantiate AggregateRequest in apps
final request = AggregateRequest();

// ✅ Intended: Use the documented approach instead
final sumAggregateRequest = HealthDataType.steps.aggregateSum(
  startTime: DateTime.now().startOfDay,
  endTime: DateTime.now(),
);
```

**When you see this annotation**: Use the higher-level, documented APIs
instead of the annotated internal implementation details.

---

## @readOnly

Marks health data types and records as read-only. These types cannot be
written, updated, or deleted through the Health Connector SDK.

Read-only data types typically represent metrics that are **automatically
calculated or derived** by the underlying health platform (e.g., Walking
Steadiness, Apple Move Time, Exercise Time). Because these values are
system-computed, platforms do not allow apps to write or modify them
directly to preserve data integrity and accuracy.

```dart
@readOnly
final class WalkingSteadinessDataType extends HealthDataType
    implements ReadableHealthDataType<WalkingSteadinessRecord> {
  // Only implements ReadableHealthDataType
  // NOT WriteableHealthDataType or DeletableHealthDataType
}

@readOnly
final class WalkingSteadinessRecord extends HealthRecord {
  // Records of this type can only be obtained through read operations
}

// ✅ Correct: Reading read-only data
final records = await healthConnector.readRecords(
  HealthDataType.walkingSteadiness,
  timeRange: TimeRangeFilter.lastNDays(30),
);

// ❌ Incorrect: Attempting to write will throw UnsupportedOperationException
try {
  await healthConnector.writeRecord(walkingSteadinessRecord);
} catch (e) {
  // Throws: UnsupportedOperationException
  print(e); // "Writing WalkingSteadinessRecord is not supported"
}
```

**When you see this annotation**: You can only use read operations (`readRecords`, `aggregate`, etc.) with this data
type. Attempting to write, update, or delete will throw an `UnsupportedOperationException`.

---

## @experimentalApi

Marks APIs as experimental and subject to change. APIs with this annotation are not considered stable and might be
changed with breaking changes without bumping the major version of the SDK.

**Application developers should use APIs marked with `@experimentalApi` with caution**, as these are not considered
part of the stable API surface and can be changed or removed without adhering to strict semantic versioning (i.e.,
breaking changes may occur in minor or patch releases).

```dart
@experimentalApi
class NewFeature {
  // This feature is still being refined and may change
}
```

**When you see this annotation**: Be prepared for potential breaking changes in future SDK updates, even in minor or
patch versions.

---

## @Since('version')

Marks the SDK version where an API was added. This helps developers understand which APIs are available based on
their SDK version.

The SDK provides convenient version-specific annotations:

```dart
@sinceV1_0_0  // Available since version 1.0.0
Future<void> coreMethod() { ... }

@sinceV2_0_0  // Available since version 2.0.0
Future<void> newerMethod() { ... }

@sinceV3_2_0  // Available since version 3.2.0
Future<void> latestMethod() { ... }
```

**When you see this annotation**: Ensure your project's `health_connector` dependency meets or exceeds the specified
version.

---

## Annotation Combinations

Annotations can be combined to provide comprehensive API metadata:

```dart
// Platform-specific + Versioning
@sinceV3_2_0
@supportedOnIOS16Plus
final class SleepingWristTemperatureDataType extends HealthDataType {
  // This API:
  // - Was added in SDK version 3.2.0
  // - Requires iOS 16.0 or later
}

// Platform-specific + Experimental
@sinceV3_0_0
@supportedOnHealthConnect
@experimentalApi
Future<void> advancedAndroidFeature() {
  // This API:
  // - Available since SDK version 3.0.0
  // - Only works on Android Health Connect
  // - Still experimental and may change
}

// Read-only + Platform + Version
@readOnly
@supportedOnAppleHealth
@supportedOnIOS16Plus
@sinceV3_2_0
final class RunningPowerDataType extends HealthDataType {
  // This API:
  // - Is read-only (cannot write/delete)
  // - Only available on iOS HealthKit
  // - Requires iOS 16.0 or later
  // - Was added in SDK version 3.2.0
}
```

When multiple annotations are present, **all constraints apply**.
