# Exceptions

Every `HealthConnectorException` thrown by the SDK includes a `HealthConnectorErrorCode` that
provides specific details about what went wrong. Use this code to handle errors programmatically.

## Exception Types

| Error Code                                  | Platform | Exception Type                      | Description & Causes                                                     | Recovery Strategy                                                             |
|:--------------------------------------------|:---------|:------------------------------------|:-------------------------------------------------------------------------|:------------------------------------------------------------------------------|
| `permissionNotGranted`                      | Both     | `AuthorizationException`            | Permission denied, revoked, or not determined.                           | Request permissions or guide user to settings.                                |
| `permissionNotDeclared`                     | All      | `ConfigurationException`            | Missing required permission in `AndroidManifest.xml` or `Info.plist`.    | **Developer Error:** Add missing permissions to your app configuration.       |
| `healthServiceUnavailable`                  | All      | `HealthServiceUnavailableException` | Device doesn't support Health Connect (Android) or HealthKit (iPad).     | Check `getHealthPlatformStatus()`. Gracefully disable health features.        |
| `healthServiceRestricted`                   | All      | `HealthServiceUnavailableException` | Health data access restricted by system policy (e.g. parental controls). | Gracefully disable health features and inform the user.                       |
| `healthServiceNotInstalledOrUpdateRequired` | Android  | `HealthServiceUnavailableException` | Health Connect app is missing or needs an update.                        | Prompt user to install/update via `launchHealthAppPageInAppStore()`.          |
| `healthServiceDatabaseInaccessible`         | iOS      | `HealthServiceException`            | Device is locked and health database is encrypted/inaccessible.          | Wait for device unlock or notify user to unlock their device.                 |
| `ioError`                                   | Android  | `HealthServiceException`            | Device storage I/O failed while reading/writing records.                 | Retry operation with exponential backoff.                                     |
| `remoteError`                               | Android  | `HealthServiceException`            | IPC communication with the underlying health service failed.             | Retry operation; usually a temporary system glitch.                           |
| `rateLimitExceeded`                         | Android  | `HealthServiceException`            | API request quota exhausted.                                             | Wait and retry later. Implement exponential backoff.                          |
| `dataSyncInProgress`                        | Android  | `HealthServiceException`            | Health Connect is currently syncing data; operations locked.             | Retry after a short delay or show a "Syncing..." status.                      |
| `invalidArgument`                           | All      | `InvalidArgumentException`          | Invalid parameter, malformed record, or expired usage of a token.        | Validate input. For expired sync tokens, restart sync with `syncToken: null`. |
| `unsupportedOperation`                      | All      | `UnsupportedOperationException`     | The requested operation is not supported on this platform/version.       | Check capability with `getFeatureStatus()` before calling.                    |
| `unknownError`                              | All      | `UnknownException`                  | An unclassified internal system error occurred.                          | Log the error details for debugging.                                          |

## Example: Robust Error Handling

```dart
try {
  await connector.writeRecord(record);
} on AuthorizationException catch (e) {
  // 1. Permission Issues
  // The user likely revoked permission in system settings.
  print('🔒 Authorization failed: ${e.message}');

  // Suggested: Show a dialog explaining why permission is needed, 
  // then link to system settings.
  _showPermissionExplanationDialog();

} on HealthServiceUnavailableException catch (e) {
  // 2. Service Availability Issues
  // Health Connect missing (Android) or device unsupported (iOS).
  print('❌ Service unavailable: ${e.code}');

  if (e.code == HealthConnectorErrorCode.healthServiceNotInstalledOrUpdateRequired) {
    // Android: Prompt user to install/update Health Connect
    _promptToInstallHealthConnect();
  } else {
    // iOS/Android: Device capability missing. Disable health features.
    _disableHealthIntegration();
  }

} on HealthServiceException catch (e) {
  // 3. Runtime/Operational Errors
  switch (e.code) {
    case HealthConnectorErrorCode.rateLimitExceeded:
      // API quota exhausted. Wait and retry with backoff.
      print('⏳ Rate limit exceeded. Retrying in 5s...');
      await Future.delayed(Duration(seconds: 5));
      _retryWrite();
      break;

    case HealthConnectorErrorCode.dataSyncInProgress:
      // Health Connect is busy syncing.
      print('🔄 Syncing... please wait.');
      break;

    case HealthConnectorErrorCode.remoteError:
    case HealthConnectorErrorCode.ioError:
      // Temporary system glitches. Retry once or twice.
      print('💥 Transient error: ${e.message}');
      _retryWithBackoff();
      break;

    default:
      print('⚠️ Health Service Warning: ${e.message}');
  }
} on InvalidArgumentException catch (e) {
  // 4. Input Errors
  print('⚠️ Invalid data or expired token: ${e.message}');
} catch (e, stack) {
  // 5. Unknown/Unexpected Errors
  print('⁉️ Unexpected system error: $e');
  // reportToCrashlytics(e, stack);
}
```
