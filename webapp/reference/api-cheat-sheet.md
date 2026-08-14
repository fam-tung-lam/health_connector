# API cheat sheet

Every method on `HealthConnector`, with the platform constraint that applies. Exact signatures live in the [generated API docs](https://pub.dev/documentation/health_connector/latest/).

## Setup & status

| Call | Static | Platform | What it does |
|---|:---:|---|---|
| `HealthConnector.create(config)` | ✓ | Both | Builds the client for the current platform |
| `HealthConnector.getHealthPlatformStatus()` | ✓ | Both | Whether a usable health store exists |
| `HealthConnector.launchHealthAppPageInAppStore()` | ✓ | Android | Sends the user to install or update Health Connect |

```dart
final status = await HealthConnector.getHealthPlatformStatus();
if (status != HealthPlatformStatus.available) return;

final connector = await HealthConnector.create();
```

## Permissions

| Call | Platform | Notes |
|---|---|---|
| `requestPermissions(permissions)` | Both | iOS prompts once per data type, ever |
| `getPermissionStatus(permission)` | Both | iOS reads always return `unknown` |
| `getGrantedPermissions()` | Android | Throws `UnsupportedOperationException` on iOS |
| `revokeAllPermissions()` | Android | Throws `UnsupportedOperationException` on iOS |

## Features

| Call | Platform | Notes |
|---|---|---|
| `getFeatureStatus(feature)` | Both | iOS always returns `available` |

## Reading

| Call | Returns | Notes |
|---|---|---|
| `readRecord(request)` | The record, or `null` | Build with `.readById(...)` |
| `readRecords(request)` | One page of records | Follow `nextPageRequest` for the rest |
| `readExerciseRoute(recordId)` | The route, or `null` | Requires the route permission |

## Writing & mutating

| Call | Platform | Atomic | Notes |
|---|---|:---:|---|
| `writeRecord(record)` | Both | — | Returns the assigned `HealthRecordId` |
| `writeRecords(records)` | Both | ✓ | May mix record types |
| `updateRecord(record)` | Android | — | HealthKit records are immutable |
| `updateRecords(records)` | Android | ✓ | Same constraint |
| `deleteRecords(request)` | Both | ✓ | Only records your app wrote |

## Aggregating & syncing

| Call | Notes |
|---|---|
| `aggregate(request)` | Computed on device; result keeps its unit |
| `synchronize(dataTypes:, syncToken:)` | `syncToken: null` sets a checkpoint; otherwise returns changes |

## Request builders on `HealthDataType`

| Builder | Produces |
|---|---|
| `.readPermission` / `.writePermission` | A `Permission` |
| `.readExerciseRoutePermission` / `.writeExerciseRoutePermission` | Route permissions (exercise session only) |
| `.readById(id)` | A single-record read request |
| `.readInTimeRange(startTime:, endTime:, pageSize:, sortDescriptor:)` | A paged read request |
| `.deleteByIds(ids)` | A delete request |
| `.deleteInTimeRange(startTime:, endTime:)` | A ranged delete request |
| `.aggregateSum/Avg/Min/Max(startTime:, endTime:)` | An aggregate request, where the type supports it |

## Statuses and enums you will branch on

```dart
HealthPlatformStatus.available        // and its unavailable variants
PermissionStatus.granted | denied | unknown
HealthPlatformFeatureStatus.available
SortDescriptor.timeAscending | timeDescending
HealthConnectorLogLevel.values
```

## Exception hierarchy

```text
HealthConnectorException
├── AuthorizationException              permission not granted
├── ConfigurationException              your manifest or Info.plist
├── HealthServiceUnavailableException   no usable store on this device
├── HealthServiceException              transient store failure — retry
├── InvalidArgumentException            bad input or expired sync token
├── UnsupportedOperationException       not on this platform or OS version
└── UnknownException                    unclassified
```

Each carries a `HealthConnectorErrorCode` — look any of them up in the [error code reference](/reference/error-codes).

<NextSteps
  :links="[
    { text: 'Generated API docs', link: 'https://pub.dev/documentation/health_connector/latest/', description: 'Exact signatures for every class and member.' },
    { text: 'Health data types', link: '/reference/health-data-types', description: 'Which types support which of these calls.' },
    { text: 'Task guides', link: '/guide/tasks/read', description: 'Each call in context, with working code.' },
  ]"
/>
