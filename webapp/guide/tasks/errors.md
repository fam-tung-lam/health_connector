# Handle errors

Every `HealthConnectorException` carries a `HealthConnectorErrorCode`. The exception type tells you what kind of problem it is; the code tells you exactly which one.

## The categories

Structuring your `catch` blocks around the hierarchy handles most cases without inspecting codes at all:

| Exception | Means | Your move |
|---|---|---|
| `AuthorizationException` | The user has not granted this access | Request permissions, or guide them to settings |
| `ConfigurationException` | Your app is misconfigured | **Fix your build** — this never resolves at runtime |
| `HealthServiceUnavailableException` | No usable health store on this device | Disable health features gracefully |
| `HealthServiceException` | The store failed transiently | Retry with backoff |
| `InvalidArgumentException` | Bad input, or an expired sync token | Validate; reset the token |
| `UnsupportedOperationException` | Not available on this platform or OS version | Branch, or omit the feature |
| `UnknownException` | Unclassified internal failure | Log it and report it |

## A complete handler

```dart
try {
  await connector.writeRecord(record);
} on AuthorizationException catch (e) {
  print('Authorization failed: ${e.message}');
} on HealthServiceUnavailableException catch (e) {
  print('Health service unavailable: ${e.code}');
} on HealthServiceException catch (e) {
  switch (e.code) {
    case HealthConnectorErrorCode.rateLimitExceeded:
      print('Rate limit exceeded. Retrying in 5s...');
      break;

    case HealthConnectorErrorCode.dataSyncInProgress:
      print('Health Connect is busy syncing... Retrying later...');
      break;

    case HealthConnectorErrorCode.remoteError:
    case HealthConnectorErrorCode.ioError:
      print('Temporary system glitch. Retrying later...');
      break;

    default:
      print('Health Service Warning: ${e.message}');
      break;
  }
} on InvalidArgumentException catch (e) {
  print('Invalid data or expired token: ${e.message}');
} catch (e, stack) {
  print('Unexpected system error: $e\n$stack');
}
```

Order matters: Dart matches the first `on` clause that fits, so list specific types before general ones.

::: tip `HealthConnectorException` is a sealed class
Because the hierarchy is sealed, you can switch over it exhaustively instead of chaining `on` clauses — the compiler then tells you when a new exception type is added:

```dart
try {
  await connector.writeRecord(record);
} on HealthConnectorException catch (e) {
  final message = switch (e) {
    AuthorizationException() => 'Grant health access to continue.',
    ConfigurationException() => 'Build misconfigured: ${e.message}',
    HealthServiceUnavailableException() => 'Health data is unavailable here.',
    HealthServiceException() => 'Temporary problem — try again shortly.',
    InvalidArgumentException() => 'Invalid request: ${e.message}',
    UnsupportedOperationException() => 'Not supported on this device.',
    UnknownException() => 'Something went wrong.',
  };

  showBanner(message);
}
```
:::

## Retryable versus terminal

Only a subset of failures are worth retrying. Retrying the rest just delays the real fix.

**Retry with exponential backoff:** `ioError`, `remoteError`, `rateLimitExceeded`, `dataSyncInProgress`, and `healthServiceDatabaseInaccessible` (wait for unlock).

**Never retry:** `permissionNotDeclared` needs a build change. `unsupportedOperation` needs a code change. `permissionNotGranted` needs the user, not another attempt.

```dart
const _retryableCodes = {
  HealthConnectorErrorCode.ioError,
  HealthConnectorErrorCode.remoteError,
  HealthConnectorErrorCode.rateLimitExceeded,
  HealthConnectorErrorCode.dataSyncInProgress,
  HealthConnectorErrorCode.healthServiceDatabaseInaccessible,
};

final _random = Random();

Future<T> withRetry<T>(Future<T> Function() operation, {int attempts = 3}) async {
  for (var attempt = 0; ; attempt++) {
    try {
      return await operation();
    } on HealthServiceException catch (e) {
      if (!_retryableCodes.contains(e.code) || attempt >= attempts - 1) rethrow;

      // Jitter matters: without it, every queued operation retries in lockstep
      // and you re-trigger the same rate limit you are backing off from.
      final backoff = Duration(seconds: 1 << attempt);
      final jitter = Duration(milliseconds: _random.nextInt(500));
      await Future<void>.delayed(backoff + jitter);
    }
  }
}
```

`healthServiceDatabaseInaccessible` is in that set because it means the iOS device is locked — worth retrying, though the more reliable fix is to defer the work until your app is next foregrounded.

## Two codes that mean "you", not "the device"

`permissionNotDeclared` is the one developers most often misread as a denial. It means the permission is missing from `AndroidManifest.xml`, or a usage description is missing from `Info.plist`. No user action can grant it — only a rebuild.

`unsupportedOperation` means the API does not exist on this platform or OS version. Check the [annotations](/reference/annotations) before calling, and catch it as the platform-branching mechanism it is:

```dart
try {
  await connector.updateRecord(updated);
} on UnsupportedOperationException {
  // iOS: delete and recreate instead.
}
```

## Look up any code

<NextSteps
  :links="[
    { text: 'Error code reference', link: '/reference/error-codes', description: 'Search every code with its cause and recovery.' },
    { text: 'Setup troubleshooting', link: '/guide/troubleshooting', description: 'Symptoms that never reach a catch block.' },
    { text: 'Configure logging', link: '/guide/tasks/logging', description: 'Route SDK diagnostics to your crash reporter.' },
  ]"
/>
