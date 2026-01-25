# Health Connector Toolbox

[![Flutter](https://img.shields.io/badge/Flutter-3.3.0+-02569B?logo=flutter)](https://flutter.dev)

---

## 📖 Overview

A comprehensive demonstration and testing application for the
[`health_connector`](../../packages/health_connector) plugin, showcasing all
major features and capabilities across Android and iOS platforms.

---

## 🚀 Getting Started

### Prerequisites

- Flutter >=3.3.0
- Dart >=3.9.2
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
│       ├── initialization/                # App initialization
│       ├── home/                          # Home page
│       ├── permissions/                   # Permission management
│       ├── read_health_records/           # Read operations
│       ├── write_health_record/           # Write operations
│       └── aggregate_health_data/         # Aggregation operations
```

---

## 🤝 Contributing

This toolbox app is part of the `health_connector` project. Contributions are welcome!

To report issues or request features, please visit
our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
