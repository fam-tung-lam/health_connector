# Health Connector Toolbox

[![Flutter](https://img.shields.io/badge/Flutter-3.38.0+-02569B?logo=flutter)](https://flutter.dev)

---

## 📖 Overview

A personal health-data inspector for Apple Health and Health Connect. Its main
screen provides privacy information and SDK operations for permissions,
records, writes, aggregation, and incremental sync through the
[`health_connector`](../../packages/health_connector) plugin.

---

## 🚀 Getting Started

### Prerequisites

- Flutter >=3.38.0
- Dart >=3.10.0 (bundled with Flutter 3.38.0)
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
│       └── incremental_data_sync/         # Incremental sync operations
```

---

## 🤝 Contributing

This toolbox app is part of the `health_connector` project. Contributions are welcome!

To report issues or request features, please visit
our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
