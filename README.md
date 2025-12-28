# Health Connector

<p align="center">
  <img alt="Health Connector" width="200px" src="https://img.shields.io/badge/Health-Connector-2E8B57.svg?style=for-the-badge">
</p>

<p align="center">
A unified, type-safe Flutter plugin for accessing health data across Android and iOS platforms.
</p>

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector"><img src="https://img.shields.io/pub/v/health_connector.svg?style=popout"/></a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector/score"><img src="https://img.shields.io/pub/points/health_connector?color=2E8B57&label=pub%20points"/></a>
  <a title="License" href="https://github.com/fam-tung-lam/health_connector/blob/main/LICENSE"><img src="https://img.shields.io/github/license/fam-tung-lam/health_connector"/></a>
</p>

---

## 📖 Overview

**Health Connector** provides a unified interface to access health data from **Android Health
Connect** and **iOS HealthKit**. It abstracts platform differences while preserving
platform-specific capabilities, offering a consistent API for reading, writing, updating, deleting,
and aggregating health records.

---

## 📦 Packages

Health Connector is organized as a monorepo containing multiple packages:

### Core Packages

- **[health_connector](packages/health_connector)** - Main facade package providing the unified API
- **[health_connector_core](packages/health_connector_core)** - Core types, abstractions, and domain
  models
- **[health_connector_hc_android](packages/health_connector_hc_android)** - Android Health Connect
  implementation
- **[health_connector_hk_ios](packages/health_connector_hk_ios)** - iOS HealthKit implementation

### Utility Packages

- **[health_connector_lint](packages/health_connector_lint)** - Shared lint rules and analysis
  options
- **[health_connector_logger](packages/health_connector_logger)** - Structured logging utilities

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Before submitting:

- Ensure code follows the lint rules defined
  in [health_connector_lint](packages/health_connector_lint)
- Add tests for new functionality
- Update documentation as needed

For major changes, please open an issue first to discuss what you would like to change.

---

## 🐛 Issues & Feature Requests

Found a bug or have a feature request? Please open an issue on
our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues) page.

When reporting issues, please include:

- Device/OS information
- Flutter and Dart versions
- Steps to reproduce and logs
- Expected vs actual behavior

---

## 📄 License

This project is licensed under the Apache-2.0 License - see the [LICENSE](LICENSE) file for details.
