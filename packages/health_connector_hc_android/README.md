# health_connector_hc_android

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector_hc_android"><img src="https://img.shields.io/pub/v/health_connector_hc_android.svg?style=popout"/></a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector_hc_android/score"><img src="https://img.shields.io/pub/points/health_connector_hc_android?color=2E8B57&label=pub%20points"/></a>
</p>

---

## 📖 Overview

`health_connector_hc_android` is the Android platform implementation for the Health Connector plugin.
It provides integration with Android's Health Connect SDK, enabling Flutter apps to read, write, and
aggregate health data on Android devices.


### ✨ Features

| Feature                         | Description                                                                                               |
|---------------------------------|-----------------------------------------------------------------------------------------------------------|
| 🔐 **Permission Management**    | Request/check/revoke permissions                                                                          |
| 📖 **Reading Health Data**      | Read a single health record by ID or multiple health records within a date/time range with **pagination** |
| ✍️ **Writing Health Data**      | Write health records                                                                                      |
| 🔄 **Updating Health Records**  | Native in-place record updates with preserved IDs                                                         |
| 🗑️ **Deleting Health Records** | Remove specific records by their IDs or within a date/time range                                          |
| ➕ **Aggregating Health Data**   | Sum/Avg/Min/Max Aggregation                                                                               |

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
