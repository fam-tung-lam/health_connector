# Changelog

## 3.2.1

- **DEPS**: Update `health_connector_core` to `v3.5.0`.

## 3.2.0

- **FEAT**: Add support for activity intensity data type. ([153e6a7f](https://github.com/fam-tung-lam/health_connector/commit/153e6a7f6654e1ec747c53cd3d2f42758dbb0c37))

## 3.1.0

- **FEAT**: Add support for elevation gained data type. ([9e6b1ddf](https://github.com/fam-tung-lam/health_connector/commit/9e6b1ddf309da961e403720a1305f532d3d94479))
- **FEAT**: Add support for steps cadence data type. ([7e82ea09](https://github.com/fam-tung-lam/health_connector/commit/7e82ea099d0cb992b03b5442baa68cd433d16b84))

## 3.0.1

- **PERF**: Flatten Pigeon DTO to improve communication performance between
  Flutter and native layers.
  ([cca96c1d](https://github.com/fam-tung-lam/health_connector/commit/cca96c1da60ecf51f097941c25aeb1c7b00d94cb))

## 3.0.0

> Note: This release has breaking changes.

- **FEAT**: Add incremental sync API. ([b6c8e67b](https://github.com/fam-tung-lam/health_connector/commit/b6c8e67b4055a0168b35ad26a29c553732e24193))
  ([966312be](https://github.com/fam-tung-lam/health_connector/commit/966312be8ac848d56224dc85ad404e51e77d896e))
- **FEAT**: Introduce sorting capability for read-records API.
  ([c2d82fa1](https://github.com/fam-tung-lam/health_connector/commit/c2d82fa160c0ea4fd4b4d623fadbce1ea731b05f))
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
- **BREAKING** **FIX**: Remove non-functional `dataOrigin` parameters from
  `Metadata` constructors.
  ([1c90b4f5](https://github.com/fam-tung-lam/health_connector/commit/1c90b4f5caec9c6964ef3f856b17ec39de9b6fad))
- **BREAKING** **FEAT**: Enhance exception hierarchy.
  ([ddb4b8ae](https://github.com/fam-tung-lam/health_connector/commit/ddb4b8ae96008fdb5900e106fcb48e1d758619fd))
- **BREAKING** **FEAT**: Introduce `Frequency` measurement unit for
  heart/respiratory rates.
  ([80092ba3](https://github.com/fam-tung-lam/health_connector/commit/80092ba370fd989d150f9e62cafd54d5338ac8d3))

## 2.3.2

- **REFACTOR**: Remove sensitive data from logs. ([bbde572c](https://github.com/fam-tung-lam/health_connector/commit/bbde572c3f1abcb42c43c98d675ad91029a797ee))

## 2.3.1

- **FIX**: Add missing time zone offset DTO fields and correct offset
  mapping logic.
  ([26b1253c](https://github.com/fam-tung-lam/health_connector/commit/26b1253c8f22f9286a6a9b8fff620dbafd086789))

## 2.3.0

- **FEAT**: Implement launching health app page in platform's app store.
  ([fcc93efc](https://github.com/fam-tung-lam/health_connector/commit/fcc93efca89874e7e023789e2d4e0cfddd1213f0))

## 2.2.0

- **FEAT**: Add support for menstrual flow data types. ([178f272f](https://github.com/fam-tung-lam/health_connector/commit/178f272fdcfd5a13abefd4c751d42f595ee57058))
- **FEAT**: Add support for body water mass, bone mass, and heart rate
  variability RMSSD data types.
  ([321d4811](https://github.com/fam-tung-lam/health_connector/commit/321d48111704d149e659c96d89773b07f025a73d))
- **FEAT**: Add support for intermenstrual bleeding data type. ([d629f8d1](https://github.com/fam-tung-lam/health_connector/commit/d629f8d141617145d9baca1fa02afd61735ca3b3))
- **FEAT**: Add support for basal body temperature data type. ([4b0120c6](https://github.com/fam-tung-lam/health_connector/commit/4b0120c636af47a6ebd4f427fd9a23d669e2d4b9))
- **FEAT**: Add support for total energy burned data type. ([e2ecc6b9](https://github.com/fam-tung-lam/health_connector/commit/e2ecc6b9d8b17c80639d4774643b0b2f98e47484))
- **FEAT**: Add support for ovulation test result data type. ([a8f3b69a](https://github.com/fam-tung-lam/health_connector/commit/a8f3b69a47130c44970f3598304de3532d95cf0c))
- **FEAT**: Add support for cycling pedaling cadence data types. ([8a7c1830](https://github.com/fam-tung-lam/health_connector/commit/8a7c1830778ef6819f3ec44fca7037c58f213cad))

## 2.1.0

- **FIX**: Ensure health record timestamps are stored as UTC. ([7f981fc2](https://github.com/fam-tung-lam/health_connector/commit/7f981fc2868062fead0b5fa7a4ad512adf4c8f24))
- **FEAT**: Add support for sexual activity and cervical mucus data types. ([972ea406](https://github.com/fam-tung-lam/health_connector/commit/972ea406b57846f83013bb0758046524e37311e4))
- **FEAT**: Add support for mindfulness session type and record. ([d0490c9d](https://github.com/fam-tung-lam/health_connector/commit/d0490c9dba99ff77ef0b3b4f999810c9e1db0bbc))
- **FEAT**: Add support for power data types. ([af790b23](https://github.com/fam-tung-lam/health_connector/commit/af790b237e1e8a3771b579bf0fcb62698d8b69d1))

## 2.0.0

> **Note**: This release has breaking changes.

- **BREAKING** **FEAT**: Introduce `TimeDuration` unit and replace `Number` with it for sleep data types. ([459798dd](https://github.com/fam-tung-lam/health_connector/commit/459798dd25d3ff014b824f4d9d7f79aa27ac0f53))
- **BREAKING** **FEAT**: Unify deletion API with polymorphic request pattern. ([f67cf5ae](https://github.com/fam-tung-lam/health_connector/commit/f67cf5ae0cda0a513c37b844aa44e8815fde0996))
- **BREAKING** **REFACTOR**: Remove support for individual nutrient data types on Android Health Connect. ([a9f7c9e4](https://github.com/fam-tung-lam/health_connector/commit/a9f7c9e47f9c0390ba4dc4eb3d6d7ed01e5772f1))
- **BREAKING** **REFACTOR**: Standardize and synchronize error codes across platforms. ([121df395](https://github.com/fam-tung-lam/health_connector/commit/121df395899bf3ba919a4d51a3c29527c01ace0d))
- **FEAT**: Implement atomic batch writes on Android Health Connect. ([c1c8c3df](https://github.com/fam-tung-lam/health_connector/commit/c1c8c3dfe32a8624e4249b2cc84f8b7e499e936c))
- **FEAT**: Add support for exercise session data type. ([d36b528c](https://github.com/fam-tung-lam/health_connector/commit/d36b528c7f6ec5b7ae3a33e0e8137c557c870e46))
- **FEAT**: Add `updateRecords` API for batch record updates. ([04e5463e](https://github.com/fam-tung-lam/health_connector/commit/04e5463e96552c04c331b8025d6e5d831e28953e))
- **FEAT**: Add full support for distance records and data types. ([84e27c08](https://github.com/fam-tung-lam/health_connector/commit/84e27c0821bad311aaf7bf6f1d2b577b50365700))
- **FEAT**: Add full support for speed records and data types. ([f07714db](https://github.com/fam-tung-lam/health_connector/commit/f07714db7b9302eea65e19aabab9e036bafbcab6))
- **FIX**: Preserve record IDs in Health Connect update operations. ([298f98f0](https://github.com/fam-tung-lam/health_connector/commit/298f98f09f047bfe4f6db06fe161ae25ddba61ca))

## 1.4.0

- **FEAT**: Add blood glucose data type. ([c018d008](https://github.com/fam-tung-lam/health_connector/commit/c018d008bbf012bfa1c609025bd41d920dd4b53a))

## 1.3.0

- **DEPS**: Update a dependency to the latest release.
- **FEAT**: Add VO2Max data type. ([3e51085a](https://github.com/fam-tung-lam/health_connector/commit/3e51085a1602e50febddde9f501002ec6867d649))
- **FEAT**: Add respiratory rate data type. ([a67dabba](https://github.com/fam-tung-lam/health_connector/commit/a67dabba093393d4064f60f99769edb71d584236))
- **FEAT**: Add oxygen saturation data type. ([b8928fc7](https://github.com/fam-tung-lam/health_connector/commit/b8928fc785128757bd57d9b07c7ce6c0d436912f))
- **FEAT**: Add resting heart rate data type. ([4972b907](https://github.com/fam-tung-lam/health_connector/commit/4972b9078563225fee0aa7b8506102d9955867e4))

## 1.2.2

- **FIX**: Prevent infinite recursion in nutrient record mappers. ([4f09dd9c](https://github.com/fam-tung-lam/health_connector/commit/4f09dd9c80695ff0d092bccd614d6974f7295931))
- **FIX**: Add missing blood pressure permission mapping. ([9728770f](https://github.com/fam-tung-lam/health_connector/commit/9728770f9e1b2dea78142deb6ae74cff78a859cb))

## 1.2.1

- **REFACTOR**: Add `complete()` helper for Pigeon callbacks. ([d72e1bfc](https://github.com/fam-tung-lam/health_connector/commit/d72e1bfcd661b4df9c3540ea4f5c38e87638d5b1))

## 1.2.0

- **FEAT**: Introduce specialized aggregation requests. ([55f00e29](https://github.com/fam-tung-lam/health_connector/commit/55f00e294d41f91c95d034768d99315baebd7208))
- **FEAT**: Add support for blood pressure records and data types. ([c5dc5fc9](https://github.com/fam-tung-lam/health_connector/commit/c5dc5fc90afd2c010e77a799bb2a5a04709ecbcf))

## 1.1.0

- **FEAT**: Add support for nutrient and nutrition health data types. ([be34f9ed](https://github.com/fam-tung-lam/health_connector/commit/be34f9eda6adb25341b1f4c4b6f0513fad97d237))
  ([77e3a8d0](https://github.com/fam-tung-lam/health_connector/commit/77e3a8d00e6afaf43f56a24eb7c55621d82f63ad))

## 1.0.0

- **FEAT**: Implement Android Health Connect platform client.
- **FEAT**: Add support for common health data types
