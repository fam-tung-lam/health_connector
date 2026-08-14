---
outline: false
---

# Error codes

Every `HealthConnectorErrorCode` the SDK can raise, the exception it arrives as, why it happens, and what to do about it. Paste the code from your stack trace into the search box.

<ErrorCodeExplorer />

## Reading the badges

**Fix in your app config** means no runtime handling will help. The permission is missing from `AndroidManifest.xml`, or a usage description is missing from `Info.plist`. Only a rebuild resolves it.

**Retryable** means the store failed transiently and the same call is likely to succeed shortly. Use exponential backoff — a tight retry loop against `rateLimitExceeded` makes the situation worse. There is a ready-made helper in [Handle errors](/guide/tasks/errors#retryable-versus-terminal).

Codes with neither badge need a decision: either the user must act (`permissionNotGranted`) or your code must change (`unsupportedOperation`).

<NextSteps
  :links="[
    { text: 'Handle errors', link: '/guide/tasks/errors', description: 'Structuring catch blocks and retry logic.' },
    { text: 'Setup troubleshooting', link: '/guide/troubleshooting', description: 'Symptoms that never reach a catch block.' },
    { text: 'Platform differences', link: '/guide/concepts/platform-differences', description: 'Why unsupportedOperation exists at all.' },
  ]"
/>
