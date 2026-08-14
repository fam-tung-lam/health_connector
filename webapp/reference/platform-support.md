# Platform support

What works where. For the reasoning behind each difference, see [Platform differences](/guide/concepts/platform-differences).

## Baseline

| Platform | Minimum OS | Native API | Health store |
|---|---|---|---|
| Android | 8.0 / API 26 | Health Connect | Separate installable app |
| iOS | 15.0 | HealthKit | Built into the OS |

## Operations

| Operation | Android | iOS | Notes |
|---|:---:|:---:|---|
| Read | Yes | Yes | Type and OS availability vary |
| Write | Yes | Yes | Requires per-type authorization |
| Update | Yes | — | HealthKit records are immutable |
| Delete | Yes | Yes | Only records your app created |
| Aggregate | Yes | Yes | Available metrics vary by data type |
| Incremental sync | Yes | Yes | Change tokens vs. anchored queries, unified |
| Exercise routes | Yes | Yes | Needs both route and session permissions |
| Background read | Capability-based | Capability-based | Requires permission and OS scheduling |

## Permissions

| Capability | Android | iOS |
|---|:---:|:---:|
| Request permissions | Yes | Yes |
| Read write-permission status | Yes | Yes |
| Read **read**-permission status | Yes | — |
| Enumerate granted permissions | Yes | — |
| Revoke programmatically | Yes | — |
| Re-prompt after a decision | Limited | Never |
| Per-type manifest declaration required | Yes | — |

## The four differences that change designs

### iOS never reveals read authorization

HealthKit does not disclose whether a read permission was denied, because that would let an app infer what a user is hiding. Read status is always `unknown` on iOS. Run the query and treat an empty result as valid.

### Android requires a declaration per type

Every requested Health Connect type needs a matching `<uses-permission>` entry. A missing one produces `ConfigurationException` / `permissionNotDeclared` before the operation runs — a build fix, not a runtime one.

### Android capability is dynamic

Health Connect is an updatable app, so newer records and operations can depend on its version, the OS version, or the device's Mainline module level. Check `getFeatureStatus()` for anything optional and keep a fallback path. iOS features ship with the OS.

### Records do not map one to one

Not every conceptual record has an equivalent on both stores, and some — nutrition especially — are modelled at different granularity. Check the [data type explorer](/reference/health-data-types) and the [annotations](/reference/annotations) on a type before designing a cross-platform feature around it.

## History windows

| Platform | Default reach | Extending it |
|---|---|---|
| Android | 30 days | `HealthPlatformFeature.readHealthDataHistory` |
| iOS | Unrestricted | Not applicable |

<NextSteps
  :links="[
    { text: 'Platform differences', link: '/guide/concepts/platform-differences', description: 'The same facts, with the reasoning.' },
    { text: 'Requirements', link: '/reference/requirements', description: 'Toolchain versions and why each floor exists.' },
    { text: 'Check platform features', link: '/guide/tasks/features', description: 'Detecting optional capabilities at runtime.' },
  ]"
/>
