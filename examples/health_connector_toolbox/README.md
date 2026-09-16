# Health Connector Toolbox

[![Flutter](https://img.shields.io/badge/Flutter-3.38.0+-02569B?logo=flutter)](https://flutter.dev)

---

## 📖 Overview

A personal health-data inspector for Apple Health and Health Connect. Its main
screen provides privacy information and SDK operations for permissions,
records, writes, aggregation, incremental sync, and background incremental
sync through the [`health_connector`](../../packages/health_connector) plugin,
plus a diagnostics console that shows every SDK log event.

---

## 🚀 Getting Started

### Prerequisites

- Flutter >=3.38.0
- Dart >=3.10.0
- **Android**:
  - Android SDK API 26+ (Android 8.0)
  - Health Connect app installed (or built-in on Android 14+)
- **iOS**:
  - iOS 15.0+
  - Xcode 14.0+
  - HealthKit capability enabled

### Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/fam-tung-lam/health_connector.git
   cd health_connector
   ```

2. **Navigate to the toolbox app**:

   ```bash
   cd examples/health_connector_toolbox
   ```

3. **Get dependencies**:

   ```bash
   flutter pub get
   ```

4. **Run the app**:

   ```bash
   flutter run
   ```

---

## 🔄 Background Incremental Data Sync

The **Background Incremental Data Sync** screen is a reference implementation
of periodic, incremental synchronization that keeps running while the app is
closed. It pairs `HealthConnector.synchronize` with the
[`workmanager`](https://pub.dev/packages/workmanager) plugin (0.10.10).

### How it works

1. `main()` calls `Workmanager().initialize(backgroundSyncCallbackDispatcher)`.
   The dispatcher is a top-level `@pragma('vm:entry-point')` function that the
   platform starts in a headless isolate.
2. Enabling background sync registers one periodic task. The same string,
   `com.phamtunglam.healthconnector.background_sync`, is used as unique name
   and task name because iOS submits the unique name to `BGTaskScheduler` and
   Android hands the task name to Dart.
3. Each run executes `BackgroundSyncWorker`, which loads the selected data
   types and the stored `HealthDataSyncToken`, drains every `synchronize`
   page, stores the new token, and writes a `BackgroundSyncReport`. Only the
   latest report is kept.
4. The worker re-baselines once when the token was rejected (Android tokens
   expire after about 30 days) or covers other data types. Transient errors
   such as `rateLimitExceeded`, `dataSyncInProgress`, and
   `healthServiceDatabaseInaccessible` return `false` to the scheduler so
   Android retries with backoff; permission errors do not.
5. Settings, token, and report live in `SharedPreferencesAsync`, which has no
   per-isolate cache, so the UI sees what the background isolate wrote. The
   screen polls every 10 seconds and on resume.

**Run sync now** executes the same worker in the foreground, which is the
fastest way to debug the sync logic before waiting for the scheduler.

Files: `lib/src/features/background_incremental_data_sync/`.

### Platform setup in this app

- **Android**: `READ_HEALTH_DATA_IN_BACKGROUND` is declared in the manifest
  and requestable from the permissions page and the sync screen. Health
  Connect rejects reads from a WorkManager job without it.
  `ToolboxApplication` installs `HealthConnectorWorkmanagerDebugHandler`,
  which forwards WorkManager task status updates into the SDK native logger.
- **iOS**: `Info.plist` declares `UIBackgroundModes: fetch` and the task
  identifier in `BGTaskSchedulerPermittedIdentifiers`. `AppDelegate` calls
  `WorkmanagerPlugin.registerLaunchHandlers()`, registers the plugin
  registrant for the background engine, and installs the plugin's
  `LoggingDebugHandler`. `workmanager_apple` 0.9.x does not let another module
  subclass `WorkmanagerDebug`, so iOS task status goes to the unified log.

### Platform behaviour to expect

- Android runs the task at least 15 minutes apart and may delay it under
  OEM battery optimization.
- iOS runs app refresh tasks opportunistically for about 30 seconds and cannot
  read HealthKit while the device is locked; such runs fail with
  `healthServiceDatabaseInaccessible` and are retried by the next run.

### Forcing a run while debugging

```bash
# Android: inspect and force the scheduled job (debug builds only)
adb shell dumpsys jobscheduler | grep com.phamtunglam.healthconnector
adb shell cmd jobscheduler run -f com.phamtunglam.healthconnector <JOB_ID>
```

```objc
// iOS: pause the app in the Xcode debugger, then run in the console
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.phamtunglam.healthconnector.background_sync"]
```

---

## 🧾 SDK Console Logs

Every SDK log event, from Dart and from the native layers, is captured by a
`ConsoleLogProcessor` registered through `HealthConnectorLoggerConfig` and
kept in the app-wide `ConsoleLogStore`. Entries are persisted per isolate, so
logs written by the background sync isolate are merged into the same console
the next time the store reloads. The **SDK Console Logs** screen filters by
level, searches, copies, and clears the log; the background sync screen embeds
the same console.

---

## 🗃️ Project Structure

```shell
lib/
├── main.dart                              # App entry point
├── src/
│   ├── health_connector_toolbox_app.dart  # Main app widget
│   ├── common/                            # Shared utilities
│   │   ├── constants/                     # App constants and texts
│   │   ├── theme/                         # App theming
│   │   ├── utils/                         # Utility functions
│   │   └── widgets/                       # Reusable widgets
│   └── features/                          # Feature modules
│       ├── home/                          # Home page
│       ├── privacy/                       # Platform privacy information
│       ├── permissions/                   # Permission management
│       ├── read_health_records/           # Read operations
│       ├── write_health_record/           # Write operations
│       ├── aggregate_health_data/         # Aggregation operations
│       ├── incremental_data_sync/         # Incremental sync operations
│       ├── background_incremental_data_sync/ # Scheduled background sync
│       └── console_logs/                  # Central SDK log console
```

---

## 🤝 Contributing

This toolbox app is part of the `health_connector` project. Contributions are welcome!

To report issues or request features, please visit
our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
