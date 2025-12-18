# health_connector_core

<p align="center">
  <a title="Pub" href="https://pub.dev/packages/health_connector_core"><img src="https://img.shields.io/pub/v/health_connector_core.svg?style=popout"/></a>
  <a title="Pub Points" href="https://pub.dev/packages/health_connector_core/score"><img src="https://img.shields.io/pub/points/health_connector_core?color=2E8B57&label=pub%20points"/></a>
</p>

---

## 📖 Overview

`health_connector_core` provides the foundational types and abstractions used across the Health
Connector plugin ecosystem:

- [health_connector](../health_connector) is the main facade package
- [health_connector_hc_android](../health_connector_hc_android) is a wrapper for Android Health
  Connect SDK
- [health_connector_hk_ios](../health_connector_hk_ios) is a wrapper for iOS HealthKit SDK

### Purpose

- **Domain Model**: Defines health records, data types, and measurement units
- **Platform Interface**: Specifies the contract that platform implementations must fulfill
- **Shared Utilities**: Provides common validation and error handling

### Acknowledgments: Android Health Connect SDK

The health record and measurement unit hierarchy in this project is inspired by the architectural
structure of the [Android Health Connect SDK](https://developer.android.com/jetpack/androidx/releases/health-connect).

All code presented here is an **original Dart implementation** developed specifically for Flutter
and is not a direct port of the Android source.

---

## 🎯 Requirements

- Dart >=3.9.2
- Flutter >=3.3.0 (for Flutter projects)

---

## ⚙️ Key Components

### Health Data Types

| Component                            | Description                          | Example                    |
|--------------------------------------|--------------------------------------|----------------------------|
| `HealthDataType<R, U>`               | Base class for all health data types | Generic health data type   |
| `ActiveCaloriesBurnedHealthDataType` | Active calories burned data          | Exercise calories tracking |
| `DistanceHealthDataType`             | Distance traveled data               | Walking/running distance   |
| `FloorsClimbedHealthDataType`        | Floors climbed data                  | Stair climbing tracking    |
| `StepsHealthDataType`                | Step count data                      | Daily step tracking        |
| `WeightHealthDataType`               | Body weight measurements             | Weight monitoring          |
| ...                                  | ...                                  | ...                        |

### Health Data Type Capabilities

| Capability        | Description                    | Example Operations                 |
|-------------------|--------------------------------|------------------------------------|
| `Readable`        | Can be read from the platform  | `readRecord()`, `readRecords()`    |
| `Writeable`       | Can be written to the platform | `writeRecord()`, `writeRecords()`  |
| `SumAggregatable` | Supports sum aggregation       | Total steps, total calories        |
| `AvgAggregatable` | Supports average aggregation   | Average weight, average heart rate |
| `MinAggregatable` | Supports minimum aggregation   | Min weight, min temperature        |
| `MaxAggregatable` | Supports maximum aggregation   | Max heart rate, max temperature    |

### Health Records

Three base types model different temporal patterns:

| Record Type            | Temporal Model           | Use Cases                                        | Concrete Examples                                                                   |
|------------------------|--------------------------|--------------------------------------------------|-------------------------------------------------------------------------------------|
| `InstantHealthRecord`  | Single point in time     | Weight, blood pressure, temperature              | `WeightRecord`                                                                      |
| `IntervalHealthRecord` | Time range (start → end) | Steps, calories burned, distance, floors climbed | `StepsRecord`, `ActiveCaloriesBurnedRecord`, `DistanceRecord`, `FloorsClimbedRecord` |
| `SeriesHealthRecord`   | Time-series samples      | Heart rate monitoring, GPS routes                | `HeartRateRecord`                                                                   |

### Measurement Units

| Unit Class     | Measures             | Supported Units   | Use Cases                       |
|----------------|----------------------|-------------------|---------------------------------|
| `Numeric`      | Dimensionless counts | value             | Steps, heart beats, repetitions |
| `Mass`         | Weight/mass          | kg, lb, g, oz     | Body weight, food weight        |
| `Length`       | Distance             | m, km, mi, ft, in | Walking distance, height        |
| `Energy`       | Energy/calories      | kcal, kJ, cal     | Calories burned, nutrition      |
| `Temperature`  | Temperature          | °C, °F, K         | Body temperature                |
| `Pressure`     | Pressure             | mmHg, Pa, kPa     | Blood pressure                  |
| `Volume`       | Liquid volume        | L, mL, fl oz, gal | Water intake, blood volume      |
| `Velocity`     | Speed                | m/s, km/h, mph    | Running speed, cycling          |
| `Power`        | Power output         | W, kW             | Cycling power, watts            |
| `BloodGlucose` | Blood sugar          | mg/dL, mmol/L     | Diabetes management             |

### Permissions

| Permission Type                   | Purpose                               | Examples                       |
|-----------------------------------|---------------------------------------|--------------------------------|
| `HealthDataPermission`            | Read/write specific health data types | Steps read, Weight write       |
| `HealthPlatformFeaturePermission` | Access platform features              | Background access, History     |
| `PermissionStatus`                | Permission state                      | `granted`, `denied`, `unknown` |
| `PermissionRequestResult`         | Result of permission request          | Contains permission + status   |

### Platform Features

| Feature                             | Description                   | Availability        |
|-------------------------------------|-------------------------------|---------------------|
| `ReadHealthDataHistoryFeature`      | Access historical health data | Both platforms      |
| `ReadHealthDataInBackgroundFeature` | Background data access        | Health Connect only |

### Exceptions

`HealthConnectorException` provides structured error handling:

| Error Code                     | Meaning                            | When Thrown                            |
|--------------------------------|------------------------------------|----------------------------------------|
| `healthPlatformUnavailable`    | Platform not supported             | Health Connect/HealthKit unavailable   |
| `installationOrUpdateRequired` | Platform needs installation/update | Health Connect not installed (Android) |
| `securityError`                | Permission denied                  | Missing or denied permissions          |
| `invalidArgument`              | Invalid parameter                  | Bad input values                       |
| `unsupportedHealthPlatformApi` | API not available on platform      | Using Android-only API on iOS          |
| `unknown`                      | Unexpected error                   | Unhandled platform errors              |
| ...                            | ...                                | ...                                    |

### Platform Client Interface

`HealthConnectorPlatformClient` defines the contract for platform implementations:

```dart
abstract interface class HealthConnectorPlatformClient {
  Future<HealthPlatformStatus> getHealthPlatformStatus();
  Future<List<PermissionRequestResult>> requestPermissions(List<Permission> permissions);
  Future<R?> readRecord<R extends HealthRecord>(ReadRecordRequest<R> request);
  Future<ReadRecordsResponse<R>> readRecords<R extends HealthRecord>(ReadRecordsRequest<R> request);
  Future<HealthRecordId> writeRecord<R extends HealthRecord>(R record);
  Future<List<HealthRecordId>> writeRecords<R extends HealthRecord>(List<R> records);
  Future<AggregateResponse<R, U>> aggregate<R extends HealthRecord, U extends MeasurementUnit>(AggregateRequest<R, U> request);
  Future<void> deleteRecords<R extends HealthRecord>({required HealthDataType<R, MeasurementUnit> dataType, required DateTime startTime, required DateTime endTime});
  Future<void> deleteRecordsByIds<R extends HealthRecord>({required HealthDataType<R, MeasurementUnit> dataType, required List<HealthRecordId> recordIds});
  Future<HealthRecordId> updateRecord<R extends HealthRecord>(R record);
}
```

---

## Contributing

Contributions are welcome!

To report issues or request features, please visit our [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
