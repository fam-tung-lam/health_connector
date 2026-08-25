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
- Repository Android build: AGP 9.3.1 with Built-in Kotlin 2.2.10
- Android build JDK: 17
- Java and Kotlin bytecode target: JVM 11

AGP 9.3.1 supplies the Built-in Kotlin 2.2.10 compiler. Consumers do not
select or apply the Kotlin Gradle plugin for this package. Flutter 3.44
consumers using AGP 9 must set `android.builtInKotlin=false` and
`android.newDsl=false`. Flutter 3.47 or later hosts can enable Built-in Kotlin
with `android.builtInKotlin=true`, but must keep `android.newDsl=false`. The
repository validates that configuration with Flutter 3.47.1.

---

## 🤝 Contributing

Contributions are welcome!

To report issues or request features, please visit our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
