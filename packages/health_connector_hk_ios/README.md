# health_connector_hk_iOS

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector_hk_ios">
    <img src="https://img.shields.io/pub/v/health_connector_hk_ios.svg?style=popout" alt="Pub"/>
  </a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector_hk_ios/score">
    <img src="https://img.shields.io/pub/points/health_connector_hk_ios?color=2E8B57&label=pub%20points" alt="Pub Points"/>
  </a>
</p>

---

## 📖 Overview

`health_connector_hk_ios` is the iOS platform implementation for the Health
Connector plugin. It provides integration with Apple's HealthKit framework,
enabling Flutter apps to read, write, and aggregate health data on iOS
devices.

The plugin captures the iOS version when the connector is created so the
facade can resolve runtime requirements. It supports reading and sum-aggregating
Apple Stand Hour records. HealthKit does not persist exercise-segment `weight`,
`setIndex`, or `rateOfPerceivedExertion`, so non-null writes are rejected.

---

## 🎯 Requirements

- Flutter >=3.3.0
- Dart >=3.9.2
- iOS >=15.0
- Xcode >=14.0

### 🤔 Why iOS 15.0?

Although Swift's concurrency features can be back-deployed to **iOS 13.0+**
using **Xcode 13.2+**, we intentionally set **iOS 15.0** as the minimum
supported version to ensure:

- Full access to the native Swift concurrency runtime without back-deployment shims
- A simpler and more reliable runtime environment with no compatibility layers
- Better long-term maintainability and reduced technical debt

> **Note:** HealthKit itself has been available since **iOS 8.0**.
> The **iOS 15.0** requirement is a conscious architectural decision driven by native
> concurrency support - not a limitation of HealthKit.

---

## 🤝 Contributing

Contributions are welcome!

To report issues or request features, please visit our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
