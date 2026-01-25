# health_connector_core

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector_core">
    <img src="https://img.shields.io/pub/v/health_connector_core.svg?style=popout" alt="Pub"/>
  </a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector_core/score">
    <img src="https://img.shields.io/pub/points/health_connector_core?color=2E8B57&label=pub%20points" alt="Pub Points"/>
  </a>
</p>

---

## 📖 Overview

`health_connector_core` provides the foundational types and abstractions
used across the Health Connector plugin ecosystem:

- [health_connector](../health_connector) is the main facade package
- [health_connector_hc_android](../health_connector_hc_android) is a wrapper for Android Health
  Connect SDK
- [health_connector_hk_ios](../health_connector_hk_ios) is a wrapper for iOS HealthKit SDK

### Purpose

- **Domain Model**: Defines health records, data types, and measurement units
- **Platform Interface**: Specifies the contract that platform implementations must fulfill
- **Shared Utilities**: Provides common validation and error handling

### Acknowledgments: Android Health Connect SDK

The health record and measurement unit hierarchy in this project is
inspired by the architectural structure of the
[Android Health Connect SDK](https://developer.android.com/jetpack/androidx/releases/health-connect).

All code presented here is an **original Dart implementation** developed specifically for Flutter
and is not a direct port of the Android source.

---

## Contributing

Contributions are welcome!

To report issues or request features, please visit our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
