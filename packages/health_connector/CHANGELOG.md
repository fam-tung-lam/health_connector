# Changelog

## 3.5.1

- **DOC**: Add retraction notice for `v3.3.0` and `v3.4.0` in changelog. ([6041450f](https://github.com/fam-tung-lam/health_connector/commit/6041450fb54c0c4e4aa3d87442a550730b2a48b5))

## 3.5.0

> Note: This release has a minor breaking change.

- **FEAT**(health_connector_hk_iOS): Add support for running stride length
  and ground contact data types.
  ([204aa90b](https://github.com/fam-tung-lam/health_connector/commit/204aa90b7c5abc48e722accd4b137e9cf605ef89))
  ([e1031455](https://github.com/fam-tung-lam/health_connector/commit/e1031455b997d79d6337e573f3ecb05cb818870d))
- **FEAT**(health_connector_hk_iOS): Add support for heart rate recovery one minute data type.
  ([6659d324](https://github.com/fam-tung-lam/health_connector/commit/6659d324405690a73938a47c595f7ff85455ac0a))
  ([e1031455](https://github.com/fam-tung-lam/health_connector/commit/e1031455b997d79d6337e573f3ecb05cb818870d))
- **FEAT**(health_connector_hk_iOS): Add support for inhaler usage data type.
  ([85b48b3e](https://github.com/fam-tung-lam/health_connector/commit/85b48b3e444dfc4c0609682fb7214d409b1ec35f))
  ([e1031455](https://github.com/fam-tung-lam/health_connector/commit/e1031455b997d79d6337e573f3ecb05cb818870d))
- **FEAT**(health_connector_hk_iOS): Add support for electrodermal activity data type.
  ([01287c2e](https://github.com/fam-tung-lam/health_connector/commit/01287c2e2ffbb5beaa8a7df327389a7b84b96b20))
  ([e1031455](https://github.com/fam-tung-lam/health_connector/commit/e1031455b997d79d6337e573f3ecb05cb818870d))
- **FEAT**(health_connector_hk_iOS): Add support for insulin delivery data type.
  ([18970e7b](https://github.com/fam-tung-lam/health_connector/commit/18970e7b82ca32a27e1bd5dd42820fb673bcd196))
  ([e1031455](https://github.com/fam-tung-lam/health_connector/commit/e1031455b997d79d6337e573f3ecb05cb818870d))
- **FEAT**(health_connector_hk_iOS): Add support for number of times fallen data type.
  ([1dcfc1ca](https://github.com/fam-tung-lam/health_connector/commit/1dcfc1ca5db255c76b0835e876da526394f4032a))
  ([e1031455](https://github.com/fam-tung-lam/health_connector/commit/e1031455b997d79d6337e573f3ecb05cb818870d))
- **BREAKING** **FIX**: Use correct measurement unit types for health record
  aggregation results.
  ([273025e3](https://github.com/fam-tung-lam/health_connector/commit/273025e340122744afc06455a89fd29582d39e47))
  - Aggregation method return types changed from `AggregateRequest<Number>` to properly typed measurement units:
    - `AggregateRequest<Frequency>` for:
      - `HeartRateDataType`
      - `HeartRateSeriesDataType`
      - `RestingHeartRateDataType`
      - `HeartRateRecoveryOneMinuteDataType`
      - `CyclingPedalingCadenceDataType`
      - `CyclingPedalingCadenceSeriesDataType`
      - `RespiratoryRateDataType`
    - `AggregateRequest<TimeDuration>` for:
      - `HeartRateVariabilitySDNNDataType`
  - The plugin primarily relies on type inference, so you won’t need to change any aggregation request/response code.

## 3.4.0

> **RETRACTED**: This release added new data types but depended on an outdated `health_connector_hc_android` version that
> didn’t yet handle them. This could lead to build failures.
>
> Please use `v3.5.0`.
>
> See: [Issue #120](https://github.com/fam-tung-lam/health_connector/issues/120)

- **FEAT**(health_connector_hk_iOS): Add support for forced expiratory
  volume data type.
  ([4abcf879](https://github.com/fam-tung-lam/health_connector/commit/4abcf8791ff0dc6d32f07fab5db55c9550fbdd88))
- **FEAT**(health_connector_hk_iOS): Add support for walking heart rate
  average data type.
  ([bf3d2e26](https://github.com/fam-tung-lam/health_connector/commit/bf3d2e261bf72e4500d27775423bb429a879a41f))
- **FEAT**(health_connector_hk_iOS): Add support for atrial fibrillation
  burden data type.
  ([9c9048c8](https://github.com/fam-tung-lam/health_connector/commit/9c9048c883bdb1d3d72ca931256273ed21391b65))
- **FEAT**(health_connector_hk_iOS): Add support for prolonged menstrual
  period event data type.
  ([419d825c](https://github.com/fam-tung-lam/health_connector/commit/419d825c02e09880f2ba726c76ba33d4790dea49))
- **FEAT**(health_connector_hk_iOS): Add support for persistent
  intermenstrual bleeding event data type.
  ([125df1d2](https://github.com/fam-tung-lam/health_connector/commit/125df1d247ab22c6e447afb7c46cede4d227bd4b))
- **FEAT**(health_connector_hk_iOS): Add support for irregular menstrual
  cycle event data type.
  ([ff15998d](https://github.com/fam-tung-lam/health_connector/commit/ff15998d0c40b7b02fc65cc1cd3e6f7c3e1d6bda))
- **FEAT**(health_connector_hk_iOS): Add support for infrequent menstrual
  cycle event data type.
  ([e4f533fe](https://github.com/fam-tung-lam/health_connector/commit/e4f533fe1709730ad4402d79904cd9564e866380))
- **FEAT**(health_connector_hk_iOS): Add support for walking steadiness
  event data types.
  ([6e140efb](https://github.com/fam-tung-lam/health_connector/commit/6e140efb85d128ce6c36e7054ffc1d592ef4aa02))

## 3.3.0

> **RETRACTED**: This release added new data types but depended on an outdated `health_connector_hc_android` version that
> didn’t yet handle them. This could lead to build failures.
>
> Please use `v3.5.0`.
>
> See: [Issue #120](https://github.com/fam-tung-lam/health_connector/issues/120)

- **FEAT**(health_connector_hk_iOS): Add support for high heart event data
  type.
  ([8125ab49](https://github.com/fam-tung-lam/health_connector/commit/8125ab4987d062aa8eceebeb392999aa7e1542a2))
- **FEAT**(health_connector_hk_iOS): Add support for low heart event data
  type.
  ([8125ab49](https://github.com/fam-tung-lam/health_connector/commit/8125ab4987d062aa8eceebeb392999aa7e1542a2))
- **FEAT**(health_connector_hk_iOS): Add support for irregular heart rhythm
  event data type.
  ([8125ab49](https://github.com/fam-tung-lam/health_connector/commit/8125ab4987d062aa8eceebeb392999aa7e1542a2))

## 3.2.0

- **FEAT(health_connector_hk_ios)**: Add support for sleeping wrist
  temperature data type.
  ([db9b4993](https://github.com/fam-tung-lam/health_connector/commit/db9b4993dcfdc16e922e5e96a5628b9aaf1230e9))
- **FEAT(health_connector_hk_ios)**: Add support for walking step length
  data type.
  ([f3f9bfac](https://github.com/fam-tung-lam/health_connector/commit/f3f9bfacb2343c37fa727c577ffe246d8b498866))
- **FEAT(health_connector_hk_ios)**: Add support for Apple walking double
  support percentage data type.
  ([fafc83d0](https://github.com/fam-tung-lam/health_connector/commit/fafc83d0b395eb9f979dca28f19e42c16ec79715))
- **FEAT(health_connector_hk_ios)**: Add support for Apple walking asymmetry
  percentage data type.
  ([bd6592ea](https://github.com/fam-tung-lam/health_connector/commit/bd6592ea3d8312a1084ada140bbbe979cb8a91e0))
- **FEAT(health_connector_hk_ios)**: Add support for Apple walking
  steadiness data type.
  ([11147080](https://github.com/fam-tung-lam/health_connector/commit/11147080babf700748dc495c3929c074074859b9))
- **FEAT(health_connector_hk_ios)**: Add support for Apple stand time data
  type.
  ([bd654375](https://github.com/fam-tung-lam/health_connector/commit/bd6543759e179d43efae470e61b4c93576c15447))
- **FEAT(health_connector_hk_ios)**: Add support for Apple move time data
  type.
  ([72fa7772](https://github.com/fam-tung-lam/health_connector/commit/72fa7772bf559fe3caf0a75669702ab7be597885))
- **FEAT(health_connector_hk_ios)**: Add support for Apple exercise time
  data type.
  ([11bf1067](https://github.com/fam-tung-lam/health_connector/commit/11bf1067b0f2ecbd03a55fff1b41eaed45c82408))
- **FEAT(health_connector_hc_android)**: Add support for activity intensity
  data type.
  ([153e6a7f](https://github.com/fam-tung-lam/health_connector/commit/153e6a7f6654e1ec747c53cd3d2f42758dbb0c37))

## 3.1.0

- **FEAT(health_connector_hk_ios)**: Add support for forced vital capacity
  data type.
  ([fc61f630](https://github.com/fam-tung-lam/health_connector/commit/fc61f6304e77beaa4b3a2cc521042f71d05c2a1c))
- **FEAT(health_connector_hk_ios)**: Add support for peripheral perfusion
  index data type.
  ([d65e7a64](https://github.com/fam-tung-lam/health_connector/commit/d65e7a64801740e1e9ca590c8ec1d9d73aaf8d31))
- **FEAT(health_connector_hk_ios)**: Add support for blood alcohol content
  data type.
  ([b51edfa3](https://github.com/fam-tung-lam/health_connector/commit/b51edfa30fc65584a30360773fd12658480c0c32))
- **FEAT(health_connector_hk_ios)**: Add support for swimming strokes data
  type.
  ([003e3962](https://github.com/fam-tung-lam/health_connector/commit/003e39628a51fd801b1cd6fabc66c5aaa873655a))
- **FEAT(health_connector_hk_ios)**: Add support for alcoholic beverages
  data type.
  ([f181f0c8](https://github.com/fam-tung-lam/health_connector/commit/f181f0c82037b6e3c4eaa21cbdf4217683694c82))
- **FEAT(health_connector_hk_ios)**: Add support for contraceptive data
  type.
  ([bb1c4a2b](https://github.com/fam-tung-lam/health_connector/commit/bb1c4a2be7ffa26e54970a5d75d074913e7a0a68))
- **FEAT(health_connector_hk_ios)**: Add support for pregnancy data type.
  ([cd76cadd](https://github.com/fam-tung-lam/health_connector/commit/cd76caddf578842920bbfa8a173d01a0e744569f))
- **FEAT(health_connector_hk_ios)**: Add support for lactation data type.
  ([7bc3e945](https://github.com/fam-tung-lam/health_connector/commit/7bc3e945bc0ca993d52927a848ebd360cfbd3dbf))
- **FEAT(health_connector_hk_ios)**: Add support for progesterone test
  data type.
  ([85da283d](https://github.com/fam-tung-lam/health_connector/commit/85da283db70785e35e02a7d3e59c952766de37c9))
- **FEAT(health_connector_hk_ios)**: Add support for pregnancy test data
  type.
  ([7cfc4ed2](https://github.com/fam-tung-lam/health_connector/commit/7cfc4ed2b2a1991fad67f1fb4d11efd319a5e462))
- **FEAT(health_connector_hk_ios)**: Add support for running power data
  type.
  ([2a27d5d7](https://github.com/fam-tung-lam/health_connector/commit/2a27d5d7b60a17fe274d84456274f41cecf259f9))
- **FEAT(health_connector_hc_android)**: Add support for elevation gained
  data type.
  ([9e6b1ddf](https://github.com/fam-tung-lam/health_connector/commit/9e6b1ddf309da961e403720a1305f532d3d94479))
- **FEAT(health_connector_hc_android)**: Add support for steps cadence
  data type.
  ([7e82ea09](https://github.com/fam-tung-lam/health_connector/commit/7e82ea099d0cb992b03b5442baa68cd433d16b84))

## 3.0.1

- **FIX**: Add missing device parameter to `manualEntry` factory.
  ([81ada9ed](https://github.com/fam-tung-lam/health_connector/commit/81ada9edb01d3fb0f623e054dae8098d27810936))
- **PERF**: Flatten Pigeon DTO to improve communication performance between
  Flutter and native layers.
  ([cca96c1d](https://github.com/fam-tung-lam/health_connector/commit/cca96c1da60ecf51f097941c25aeb1c7b00d94cb))

## 3.0.0

> Note: This release has breaking changes.
>
> See the [Migration Guide v2.x.x → v3.0.0](../../doc/guides/migration_guides/migration-guide-v2.x.x-to-v3.0.0.md).

- **FEAT**: Add new `ExperimentalApi` annotation. ([b22c4236](https://github.com/fam-tung-lam/health_connector/commit/b22c42366f8686ed6388a398f188cb33ec2d331f))
- **FEAT**: Add incremental sync API. ([b6c8e67b](https://github.com/fam-tung-lam/health_connector/commit/b6c8e67b4055a0168b35ad26a29c553732e24193))
  ([966312be](https://github.com/fam-tung-lam/health_connector/commit/966312be8ac848d56224dc85ad404e51e77d896e))
- **FEAT**: Introduce sorting capability for read-records API.
  ([c2d82fa1](https://github.com/fam-tung-lam/health_connector/commit/c2d82fa160c0ea4fd4b4d623fadbce1ea731b05f))
- **FEAT**: Introduce `HealthDataTypeCategory` enum to group health data
  types into meaningful categories.
  ([1d11eb43](https://github.com/fam-tung-lam/health_connector/commit/1d11eb4395e1115c3295ac253e8391cb4fb9d78c))
- **FIX(health_connector_hk_ios)**: Add missing nutrient and health record
  DTOs to mappers and extensions.
  ([c74fdfa5](https://github.com/fam-tung-lam/health_connector/commit/c74fdfa5652cff62c021f2e7b443de6ffd2615ab))
- **BREAKING** **REFACTOR**: Standardize naming conventions across health
  data models and APIs.
  ([aa824f72](https://github.com/fam-tung-lam/health_connector/commit/aa824f72c79fc6aac717c40c0dbbf784c2da9136),
  [ce45f8dc](https://github.com/fam-tung-lam/health_connector/commit/ce45f8dc884305bcddfa38ef1a5b785448fb0b6b),
  [1ba99856](https://github.com/fam-tung-lam/health_connector/commit/1ba99856a29f11f59fa04548da83d7fdd536ced1),
  [059c9ea0](https://github.com/fam-tung-lam/health_connector/commit/059c9ea071c9f122e8450f098703ea4b124288db),
  [399ebbe5](https://github.com/fam-tung-lam/health_connector/commit/399ebbe54f68fc27dd684ba1cf0df7002344a712),
  [6dd617fa](https://github.com/fam-tung-lam/health_connector/commit/6dd617fa02038900ab6bdcb42b2461b9d5b55c91),
  [50cbe79b](https://github.com/fam-tung-lam/health_connector/commit/50cbe79baf89d00edaa1de6d7368e0bee17e6818),
  [d83fc055](https://github.com/fam-tung-lam/health_connector/commit/d83fc055410d7780a33b4c5195a0bef223712062),
  [371d3679](https://github.com/fam-tung-lam/health_connector/commit/371d367926ffc5807e8aefe57df018ec7c29d63c),
  [29d9faac](https://github.com/fam-tung-lam/health_connector/commit/29d9faac930b1a4d52390551b45fb4e99f1274c1))
- **BREAKING** **REFACTOR**: Unify meal type enums across records. ([c70c336c](https://github.com/fam-tung-lam/health_connector/commit/c70c336c2021b9c19e26ac1e8902c28bfe70333c))
- **BREAKING** **REFACTOR**: Flatten `HeartRateMeasurementRecord` structure. ([4e0b5a7f](https://github.com/fam-tung-lam/health_connector/commit/4e0b5a7ffdfdd577234ba3750d9742ce76ffe9bc))
- **BREAKING** **FIX**: Remove non-functional `dataOrigin` parameters from `Metadata` constructors. ([1c90b4f5](https://github.com/fam-tung-lam/health_connector/commit/1c90b4f5caec9c6964ef3f856b17ec39de9b6fad))
- **BREAKING** **FEAT**: Enhance exception hierarchy. ([ddb4b8ae](https://github.com/fam-tung-lam/health_connector/commit/ddb4b8ae96008fdb5900e106fcb48e1d758619fd))
- **BREAKING** **FEAT**: Introduce `Frequency` measurement unit for
  heart/respiratory rates.
  ([80092ba3](https://github.com/fam-tung-lam/health_connector/commit/80092ba370fd989d150f9e62cafd54d5338ac8d3))
- **BREAKING** **FEAT**: Add validation range enforcement at instance
  creation.
  ([76cf37b6](https://github.com/fam-tung-lam/health_connector/commit/76cf37b6a2ab9a96fa80cf75a99254233ac47a09))

## 2.4.0

- **FEAT**: Expose logger through main package exports. ([003a98b8](https://github.com/fam-tung-lam/health_connector/commit/003a98b8b31f0147b91aa65d03c672bf0a3c7998))
- **FEAT**: Centralize Dart, Swift, and Kotlin logging in Flutter layer.
  ([6e071974](https://github.com/fam-tung-lam/health_connector/commit/6e07197463800a576f303bfd791a8f10995356ec))
- **REFACTOR**: Remove sensitive data from logs.
  ([bbde572c](https://github.com/fam-tung-lam/health_connector/commit/bbde572c3f1abcb42c43c98d675ad91029a797ee))
  ([8a8ee3ea](https://github.com/fam-tung-lam/health_connector/commit/8a8ee3eaba51d58295c866d272def757f1275d6a))
- **FIX**: Set supported on iOS Apple Health only for nutrient data types.
  ([e8796482](https://github.com/fam-tung-lam/health_connector/commit/e8796482b8b296e495d8cb96091c486e7176f651))
- **FIX**: Fix infinite mapping loop when convert measurement unit DTO to
  domain model.
  ([93cce205](https://github.com/fam-tung-lam/health_connector/commit/93cce2059b0cbdd94212772071a029c131343c79))

## 2.3.2

- **FIX**: Add missing time zone offset DTO fields and correct offset
  mapping logic.
  ([26b1253c](https://github.com/fam-tung-lam/health_connector/commit/26b1253c8f22f9286a6a9b8fff620dbafd086789))
- **FIX**: Set `BasalEnergyBurnedHealthDataType` as supported on Apple
  Health only.
  ([550cdb56](https://github.com/fam-tung-lam/health_connector/commit/550cdb565d0a3a152319117f8686fa010867a1f7))

## 2.3.1

- **DOC**: Update `README.md` documentation. ([92b74719](https://github.com/fam-tung-lam/health_connector/commit/92b747198c4e4b8a97b205c86c5dfb1cf1ad0a83))

## 2.3.0

- **FEAT**(health_connector_hc_Android): Implement launching health app
  page in platform's app store.
  ([fcc93efc](https://github.com/fam-tung-lam/health_connector/commit/fcc93efca89874e7e023789e2d4e0cfddd1213f0))

## 2.2.0

- **FEAT**: Add support for menstrual flow data types. ([178f272f](https://github.com/fam-tung-lam/health_connector/commit/178f272fdcfd5a13abefd4c751d42f595ee57058))
- **FEAT(health_connector_hc_android)**: Add support for body water mass,
  bone mass, and heart rate variability RMSSD data types.
  ([321d4811](https://github.com/fam-tung-lam/health_connector/commit/321d48111704d149e659c96d89773b07f025a73d))
- **FEAT(health_connector_hk_ios)**: Add support for body mass index, waist
  circumference, and heart rate variability SDNN data types.
  ([1d3244c5](https://github.com/fam-tung-lam/health_connector/commit/1d3244c5050f8a058d996dfdd9728ff85f602e87))
- **FEAT**: Add support for intermenstrual bleeding data type. ([d629f8d1](https://github.com/fam-tung-lam/health_connector/commit/d629f8d141617145d9baca1fa02afd61735ca3b3))
- **FEAT**: Add support for basal body temperature data type. ([4b0120c6](https://github.com/fam-tung-lam/health_connector/commit/4b0120c636af47a6ebd4f427fd9a23d669e2d4b9))
- **FEAT**: Add support for basal energy burned (iOS) and total energy
  burned (Android) data types.
  ([e2ecc6b9](https://github.com/fam-tung-lam/health_connector/commit/e2ecc6b9d8b17c80639d4774643b0b2f98e47484))
- **FEAT**: Add support for ovulation test result data type. ([a8f3b69a](https://github.com/fam-tung-lam/health_connector/commit/a8f3b69a47130c44970f3598304de3532d95cf0c))
- **FEAT**: Add support for cycling pedaling cadence data types. ([8a7c1830](https://github.com/fam-tung-lam/health_connector/commit/8a7c1830778ef6819f3ec44fca7037c58f213cad))

## 2.1.0

- **FEAT**: Add support for sexual activity and cervical mucus data types. ([972ea406](https://github.com/fam-tung-lam/health_connector/commit/972ea406b57846f83013bb0758046524e37311e4))
- **FEAT**: Add support for mindfulness session type and record. ([d0490c9d](https://github.com/fam-tung-lam/health_connector/commit/d0490c9dba99ff77ef0b3b4f999810c9e1db0bbc))
- **FEAT**: Add support for power data types. ([af790b23](https://github.com/fam-tung-lam/health_connector/commit/af790b237e1e8a3771b579bf0fcb62698d8b69d1))
- **FIX(health_connector_hk_ios)**: Persist blood pressure body position
  and measurement location data in custom metadata keys.
  ([32ae4e7e](https://github.com/fam-tung-lam/health_connector/commit/32ae4e7ebe1a07b0bc99a88df62aa8418b0f94e0))
- **FIX**: Ensure health record timestamps are stored as UTC. ([7f981fc2](https://github.com/fam-tung-lam/health_connector/commit/7f981fc2868062fead0b5fa7a4ad512adf4c8f24))

## 2.0.0

> **Note**: This release has breaking changes.
>
> See the [Migration Guide](../../doc/guides/migration_guides/migration-guide-v1.x.x-to-v2.x.x.md) for detailed
> instructions on upgrading from v1.x.x to v2.0.0.

- **BREAKING** **FEAT**: Introduce `TimeDuration` unit and replace `Number` with it for sleep data types. ([459798dd](https://github.com/fam-tung-lam/health_connector/commit/459798dd25d3ff014b824f4d9d7f79aa27ac0f53))
- **BREAKING** **FEAT**: Introduce `HealthConnector interface with default`HealthConnectorImpl` implementation. ([5bbe4f8c](https://github.com/fam-tung-lam/health_connector/commit/5bbe4f8c51bf84155c641df4086b07cda2b09021))
- **BREAKING** **FEAT**: Unify deletion API with polymorphic request pattern. ([f67cf5ae](https://github.com/fam-tung-lam/health_connector/commit/f67cf5ae0cda0a513c37b844aa44e8815fde0996))
- **BREAKING** **REFACTOR**: Remove support for "delete-then-create" logic for iOS HealthKit. ([e79b1772](https://github.com/fam-tung-lam/health_connector/commit/e79b177270ebe925b20b0309a5a31e9d44e648b5))
- **BREAKING** **REFACTOR**: Simplify `aggregate` and `readRecord` APIs by removing request/response wrappers. ([31673d12](https://github.com/fam-tung-lam/health_connector/commit/31673d12b945e017a9a2b34bfef539cdec4fea23))
- **BREAKING** **REFACTOR**: Remove support for individual nutrient data types on Android Health Connect. ([a9f7c9e4](https://github.com/fam-tung-lam/health_connector/commit/a9f7c9e47f9c0390ba4dc4eb3d6d7ed01e5772f1))
- **BREAKING** **REFACTOR**: Standardize and synchronize error codes across platforms. ([121df395](https://github.com/fam-tung-lam/health_connector/commit/121df395899bf3ba919a4d51a3c29527c01ace0d))
- **FEAT**: Implement atomic batch writes on iOS HealthKit and Android Health Connect.
  ([9dbbd181](https://github.com/fam-tung-lam/health_connector/commit/9dbbd181792039140a704ebe404a4d03d6191f95))
  ([c1c8c3df](https://github.com/fam-tung-lam/health_connector/commit/c1c8c3dfe32a8624e4249b2cc84f8b7e499e936c))
- **FEAT**: Add support for exercise session data type. ([d36b528c](https://github.com/fam-tung-lam/health_connector/commit/d36b528c7f6ec5b7ae3a33e0e8137c557c870e46))
- **FEAT**: Add `updateRecords` API for batch record updates. ([04e5463e](https://github.com/fam-tung-lam/health_connector/commit/04e5463e96552c04c331b8025d6e5d831e28953e))
- **FEAT**: Implement `HealthConnectorInfiPListService` for validating the application's Info.plist configuration. ([7846492f](https://github.com/fam-tung-lam/health_connector/commit/7846492fd7ad77c1da66ed3f9a08d1bf6361a59d))
- **FEAT**: Add full support for distance records and data types. ([84e27c08](https://github.com/fam-tung-lam/health_connector/commit/84e27c0821bad311aaf7bf6f1d2b577b50365700))
- **FEAT**: Add full support for speed records and data types. ([f07714db](https://github.com/fam-tung-lam/health_connector/commit/f07714db7b9302eea65e19aabab9e036bafbcab6))
- **PERF**: Use HealthKit batch delete API instead of for-loop deletion. ([b4159af1](https://github.com/fam-tung-lam/health_connector/commit/b4159af1ff015cf9890feab2418a22bc1e034b99))
- **FIX**: Preserve record IDs in Health Connect update operations. ([298f98f0](https://github.com/fam-tung-lam/health_connector/commit/298f98f09f047bfe4f6db06fe161ae25ddba61ca))
- **FIX**: Implement missing health record objects deletion for correlation sample types. ([655d865e](https://github.com/fam-tung-lam/health_connector/commit/655d865e8dce71c69280fefce476335164b04b4f))
- **FIX**: Fix IDs validation in `DeleteRecordsByIdsRequest` factory constructor. ([d37817e5](https://github.com/fam-tung-lam/health_connector/commit/d37817e584163d7c140fef4868f54edda9c1528e))

## 1.4.0

- **FEAT**: Add blood glucose data type. ([eed289b4](https://github.com/fam-tung-lam/health_connector/commit/eed289b40c6d079b0997f16ad7f75881f84ec196))
  ([c018d008](https://github.com/fam-tung-lam/health_connector/commit/c018d008bbf012bfa1c609025bd41d920dd4b53a))
  ([18803d0f](https://github.com/fam-tung-lam/health_connector/commit/18803d0f6b182595f1dc1d747cdb8760a7423f1f))

## 1.3.0

- **FEAT**: Add VO2Max data type. ([1f885539](https://github.com/fam-tung-lam/health_connector/commit/1f8855396649275b9bc16e62dbbd2b66ef6745e0))
  ([2a61940f](https://github.com/fam-tung-lam/health_connector/commit/2a61940f010c7f8e7bfca438c5f969ed178193ad))
  ([3e51085a](https://github.com/fam-tung-lam/health_connector/commit/3e51085a1602e50febddde9f501002ec6867d649))
- **FEAT**: Add respiratory rate data type. ([75ba9138](https://github.com/fam-tung-lam/health_connector/commit/75ba913811f39879cb81c6eb121e1cf789ef5311))
  ([b6081fa6](https://github.com/fam-tung-lam/health_connector/commit/b6081fa6f99772e0b64b7ca272acf822854cc766))
  ([a67dabba](https://github.com/fam-tung-lam/health_connector/commit/a67dabba093393d4064f60f99769edb71d584236))
- **FEAT**: Add oxygen saturation data type. ([8c0876b0](https://github.com/fam-tung-lam/health_connector/commit/8c0876b04480b311a3b8d516a2977a11feaff6b8))
  ([51022aa1](https://github.com/fam-tung-lam/health_connector/commit/51022aa15d7d2d1c91b3512517f1edbbb0af9473))
  ([b8928fc7](https://github.com/fam-tung-lam/health_connector/commit/b8928fc785128757bd57d9b07c7ce6c0d436912f))
- **FEAT**: Add resting heart rate data type. ([7bb5bbea](https://github.com/fam-tung-lam/health_connector/commit/7bb5bbea8b385d0915ec34257964e53f1d3fc4b5))
  ([17bbf3b1](https://github.com/fam-tung-lam/health_connector/commit/17bbf3b142a15b17bf4ffb5a51ada4ca5b3fef0f))
  ([4972b907](https://github.com/fam-tung-lam/health_connector/commit/4972b9078563225fee0aa7b8506102d9955867e4))

## 1.2.2

- **DEPS**: Update `health_connector_lint` to the latest version.

## 1.2.1

- **FIX**: Map blood pressure types to corresponding HealthKit types. ([ff057529](https://github.com/fam-tung-lam/health_connector/commit/ff057529d7397b80196b6063036526842973ff8d))

## 1.2.0

- **FEAT**: Add support for blood pressure data types.

## 1.1.0

- **FEAT**: Add support for nutrient and nutrition records and data types. ([77e3a8d0](https://github.com/fam-tung-lam/health_connector/commit/77e3a8d00e6afaf43f56a24eb7c55621d82f63ad))

## 1.0.0

- **FEAT**: Implement `HealthConnector` facade providing unified API across platforms.
- **FEAT**: Add support for common health data types.
