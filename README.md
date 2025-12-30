please see the adding new data type support guidance @ADDING_NEW_HEALTH_DATA_TYPE_GUIDE.md and add
support for energy/calories burned types and records.

## Android Health Connect

### BasalMetabolicRateRecord (Android Health Connect Only)

BasalMetabolicRateRecord in Health Connect represents BMR as a power value (for example kcal/day) at
a given time, conceptually an instantaneous rate that can be treated as constant until updated.

Health Connect API: [`BasalMetabolicRateRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalMetabolicRateRecord)

We will have a single type and record:
- `BasalMetabolicRateRecord` class that is `InstantHealthRecord` and related `BasalMetabolicRateDataType` data type

Use `Power` measurement unit.

#### Supported Aggregation Metrics

- SUM -> BasalMetabolicRateRecord.BASAL_CALORIES_TOTAL -> returns `Energy` (not `Power`) measurement unit.

### TotalCaloriesBurnedRecord (Android Health Connect Only)

Health Connect API: [`TotalCaloriesBurnedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/TotalCaloriesBurnedRecord)

We will have a single type and record:
- `TotalCaloriesBurnedRecord` class that is `IntervalHealthRecord` and related `TotalCaloriesBurnedDataType` data type

Use `Energy` measurement unit.

#### Supported Aggregation Metrics

- SUM -> TotalCaloriesBurnedRecord.ENERGY_TOTAL -> returns `Energy` measurement unit.

---

## iOS HealthKit

### BasalEnergyBurnedRecord (iOS HealthKit Only)

`HKQuantityTypeIdentifier.basalEnergyBurned` is a quantity type with cumulative aggregation style, 
meaning samples represent an amount of energy over a time span with startDate and endDate.

Each HKQuantitySample for this type is therefore an interval sample, representing total resting 
energy burned during that period.

HealthKit API: [`HKQuantityTypeIdentifier.basalenergyburned`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalenergyburned)

We will have a single type and record:
- `BasalEnergyBurnedRecord` class that is `IntervalHealthRecord` and related `BasalEnergyBurnedDataType` data type

Use `Energy` measurement unit.

### Supported Aggregation Metrics

- SUM -> HKStatisticsOptions.cumulativeSum -> returns `Energy` measurement unit.
