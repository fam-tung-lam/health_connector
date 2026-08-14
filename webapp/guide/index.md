# What is Health Connector?

Health Connector is a Flutter SDK that presents Android Health Connect and Apple HealthKit through one strongly typed Dart API.

Both platforms store the same kinds of information — steps, weight, heart rate, sleep, meals — but they disagree about almost everything else: how records are shaped, how permissions are granted, which operations exist, and how much the OS is willing to tell your app. Writing against both directly means maintaining two health layers and reconciling them in your domain code.

Health Connector collapses that into a single API surface, and it does so without hiding the parts that genuinely differ.

## The problem it solves

| Concern | Android Health Connect | Apple HealthKit | Health Connector |
|---|---|---|---|
| Health store | Separate installable app | Built into iOS | `HealthConnector` |
| Data model | Typed records | `HKSample` subclasses | Typed Dart records |
| Units | Platform primitives | `HKUnit` | `Mass`, `Length`, `Energy`, … |
| Permissions | Read/write grants, enumerable | Authorization, opaque for reads | Typed `Permission` objects |
| Change tracking | Change tokens | Anchored queries | `synchronize()` with a sync token |
| Mutability | Records can be updated | Records are immutable | `updateRecord()`, Android-only and typed as such |

## What "type-safe" means here

Three separate guarantees, all enforced before your app ships:

**Records and units cannot be mismatched.** A `WeightRecord` takes a `Mass`. Passing a `Length` is a compile error, not a runtime surprise in a user's health history.

**Reads return the right type.** Building a request from a data type carries that type through the response, so no cast is needed:

```dart
final request = HealthDataType.weight.readInTimeRange(
  startTime: DateTime.now().subtract(const Duration(days: 30)),
  endTime: DateTime.now(),
);

final response = await connector.readRecords(request);

// Inferred as List<WeightRecord>.
final records = response.records;
```

**Unsupported operations are unavailable.** A data type only exposes the operations it supports. Types that the platform computes for you, like many HealthKit summaries, do not offer a write path at all.

## What it deliberately does not hide

An abstraction that pretends the platforms are identical produces bugs that only appear on one of them. Health Connector keeps the real constraints visible:

- HealthKit never discloses whether the user denied a **read** permission, so iOS read status is reported as `unknown` — by design, not as a gap.
- HealthKit records are immutable, so `updateRecord()` exists on Android only and is marked `@supportedOnHealthConnect`.
- Health Connect requires a matching `<uses-permission>` declaration for every type you touch; a missing one is a configuration error, not a denied permission.

Each of these is documented in [Platform differences](/guide/concepts/platform-differences), and the annotations that encode them are listed in the [annotation reference](/reference/annotations).

## Privacy posture

The SDK writes nothing to `print`, `stdout`, or platform logs on its own. Logging is entirely opt-in through processors you supply, and even native Kotlin and Swift output is routed through Dart so there is a single place to control it. That default exists to keep health data out of crash reports and log aggregators unless you have decided otherwise.

<NextSteps
  :links="[
    { text: 'Install & configure', link: '/guide/installation', description: 'Add the package and set up the platform you target.' },
    { text: 'Your first integration', link: '/guide/quickstart', description: 'Permissions through delete, end to end.' },
    { text: 'Architecture', link: '/guide/concepts/architecture', description: 'How the facade routes to each native store.' },
  ]"
/>
