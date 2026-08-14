export type ErrorPlatform = "both" | "android" | "ios";

export interface ErrorCode {
  code: string;
  exception: string;
  platform: ErrorPlatform;
  /** Whether the fault is in the app's own configuration rather than the runtime. */
  developerError?: boolean;
  retryable?: boolean;
  cause: string;
  recovery: string;
}

export const errorCodes: ErrorCode[] = [
  {
    code: "permissionNotGranted",
    exception: "AuthorizationException",
    platform: "both",
    cause: "The user denied the permission, revoked it later, or never answered the prompt.",
    recovery:
      "Call requestPermissions() again, or send the user to the platform settings screen if they previously declined.",
  },
  {
    code: "permissionNotDeclared",
    exception: "ConfigurationException",
    platform: "both",
    developerError: true,
    cause:
      "A required permission is missing from AndroidManifest.xml, or a usage description is missing from Info.plist.",
    recovery:
      "Add the missing declaration to your app configuration and rebuild. This never resolves itself at runtime.",
  },
  {
    code: "healthServiceUnavailable",
    exception: "HealthServiceUnavailableException",
    platform: "both",
    cause: "The device has no health store — Health Connect is unsupported, or HealthKit is absent (iPad).",
    recovery: "Check HealthConnector.getHealthPlatformStatus() at startup and hide health features gracefully.",
  },
  {
    code: "healthServiceRestricted",
    exception: "HealthServiceUnavailableException",
    platform: "both",
    cause: "System policy blocks health data access — for example parental controls or an MDM profile.",
    recovery: "Disable health features and explain to the user that a device policy is blocking access.",
  },
  {
    code: "healthServiceNotInstalledOrUpdateRequired",
    exception: "HealthServiceUnavailableException",
    platform: "android",
    cause: "The Health Connect app is not installed, or its version is older than the SDK requires.",
    recovery: "Prompt the user and call HealthConnector.launchHealthAppPageInAppStore().",
  },
  {
    code: "healthServiceDatabaseInaccessible",
    exception: "HealthServiceException",
    platform: "ios",
    retryable: true,
    cause: "The device is locked, so the encrypted health database cannot be opened.",
    recovery: "Defer the operation until the app is foregrounded and unlocked, then retry.",
  },
  {
    code: "ioError",
    exception: "HealthServiceException",
    platform: "android",
    retryable: true,
    cause: "Device storage I/O failed while reading or writing records.",
    recovery: "Retry with exponential backoff.",
  },
  {
    code: "remoteError",
    exception: "HealthServiceException",
    platform: "android",
    retryable: true,
    cause: "IPC with the Health Connect service failed.",
    recovery: "Retry — this is usually a transient system condition.",
  },
  {
    code: "rateLimitExceeded",
    exception: "HealthServiceException",
    platform: "android",
    retryable: true,
    cause: "The app exhausted its Health Connect API quota.",
    recovery: "Back off exponentially and batch your reads and writes more aggressively.",
  },
  {
    code: "dataSyncInProgress",
    exception: "HealthServiceException",
    platform: "android",
    retryable: true,
    cause: "Health Connect is syncing and has locked the data store.",
    recovery: "Retry after a short delay.",
  },
  {
    code: "invalidArgument",
    exception: "InvalidArgumentException",
    platform: "both",
    cause: "A parameter was invalid, a record was malformed, or a sync token expired.",
    recovery:
      "Validate input before calling. For an expired sync token, restart the sync with syncToken: null.",
  },
  {
    code: "unsupportedOperation",
    exception: "UnsupportedOperationException",
    platform: "both",
    cause:
      "The operation does not exist on this platform or OS version — for example updating a record on iOS.",
    recovery:
      "Check the @supportedOn annotations before calling, and branch on HealthConnector.healthPlatform.",
  },
  {
    code: "unknownError",
    exception: "UnknownException",
    platform: "both",
    cause: "An unclassified internal failure.",
    recovery: "Log the message and stack trace, and open a GitHub issue if it reproduces.",
  },
];
