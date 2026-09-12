# health_connector_hc_Android

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector_hc_android">
    <img src="https://img.shields.io/pub/v/health_connector_hc_android.svg?style=popout" alt="Pub"/>
  </a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector_hc_android/score">
    <img src="https://img.shields.io/pub/points/health_connector_hc_android?color=2E8B57&label=pub%20points" alt="Pub Points"/>
  </a>
</p>

---

## 📖 Overview

`health_connector_hc_android` is the Android platform implementation for
the Health Connector plugin. It provides integration with Android's Health
Connect SDK, enabling Flutter apps to read, write, and aggregate health
data on Android devices.

The plugin captures the Android API level and Health Connect SDK Extension
versions when the connector is created. The facade uses that immutable snapshot
to resolve runtime requirements. Exercise-segment `weight`, `setIndex`, and
`rateOfPerceivedExertion` require Android 14 with SDK Extension 21 or later when
written.

---

## 🎯 Requirements

- Flutter >=3.3.0
- Dart >=3.9.2
- Android SDK: API level 26+ (Android 8.0)
- Kotlin: 1.9.0+
- Java: 11+

---

## 🤝 Contributing

Contributions are welcome!

To report issues or request features, please visit our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
