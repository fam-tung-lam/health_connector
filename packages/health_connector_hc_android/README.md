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

---

## 🎯 Requirements

- Flutter >=3.44.0
- Dart >=3.12.0
- Android SDK: API level 26+ (Android 8.0)
- Repository Android build: Flutter 3.44.9, AGP 9.3.1, and KGP 2.3.20
- Android build JDK: 17
- Java and Kotlin bytecode target: JVM 11

The published plugin neither selects nor applies the Kotlin Gradle plugin and
uses the Built-in Kotlin-compatible `kotlin.compilerOptions` API. Repository
examples validate the Flutter 3.44.9 compatibility host lane with KGP 2.3.20,
`android.builtInKotlin=false`, and `android.newDsl=false`. Flutter 3.47 or later
client apps can enable Built-in Kotlin with `android.builtInKotlin=true` while
keeping `android.newDsl=false`.

---

## 🤝 Contributing

Contributions are welcome!

To report issues or request features, please visit our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
