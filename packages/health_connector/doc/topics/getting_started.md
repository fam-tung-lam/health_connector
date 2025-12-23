# Getting Started

Quick start guide for integrating health data into your Flutter app.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  health_connector: ^1.4.0
```

## Platform Setup

### iOS (HealthKit)

- Add HealthKit capability in Xcode
- Add usage descriptions to `Info.plist`

### Android (Health Connect)

- Minimum SDK: 26 (Android 8.0+)
- Add permissions to `AndroidManifest.xml`
- Declare health data types in Play Console
