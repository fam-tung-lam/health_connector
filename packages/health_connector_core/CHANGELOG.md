## 2.2.4

 - **FIX**: Set supported on iOS Apple Health only for nutrient data types. ([e8796482](https://github.com/fam-tung-lam/health_connector/commit/e8796482b8b296e495d8cb96091c486e7176f651))

## 2.2.3

- **FIX**: Set `BasalEnergyBurnedHealthDataType` as supported on Apple Health only. ([550cdb56](https://github.com/fam-tung-lam/health_connector/commit/550cdb565d0a3a152319117f8686fa010867a1f7))

## 2.2.2

- **REFACTOR**: Use `ListEquality` from collection` package instead of custom implementation. ([9e99bac0](https://github.com/fam-tung-lam/health_connector/commit/9e99bac0bb75cb8a554517721c79a82a39e63322))

## 2.2.1

- **FEAT**: Add `@since2_3_0` annotation

## 2.2.0

- **FEAT**: Add support for menstrual flow data types. ([178f272f](https://github.com/fam-tung-lam/health_connector/commit/178f272fdcfd5a13abefd4c751d42f595ee57058))
- **FEAT(health_connector_hc_android)**: Add support for body water mass, bone mass, and heart rate variability RMSSD data types. ([321d4811](https://github.com/fam-tung-lam/health_connector/commit/321d48111704d149e659c96d89773b07f025a73d))
- **FEAT(health_connector_hk_ios)**: Add support for body mass index, waist circumference, and heart rate variability SDNN data types. ([1d3244c5](https://github.com/fam-tung-lam/health_connector/commit/1d3244c5050f8a058d996dfdd9728ff85f602e87))
- **FEAT**: Add support for intermenstrual bleeding data type. ([d629f8d1](https://github.com/fam-tung-lam/health_connector/commit/d629f8d141617145d9baca1fa02afd61735ca3b3))
- **FEAT**: Add support for basal body temperature data type. ([4b0120c6](https://github.com/fam-tung-lam/health_connector/commit/4b0120c636af47a6ebd4f427fd9a23d669e2d4b9))
- **FEAT**: Add support for basal energy burned (iOS) and total energy burned (Android) data types. ([e2ecc6b9](https://github.com/fam-tung-lam/health_connector/commit/e2ecc6b9d8b17c80639d4774643b0b2f98e47484))
- **FEAT**: Add support for ovulation test result data type. ([a8f3b69a](https://github.com/fam-tung-lam/health_connector/commit/a8f3b69a47130c44970f3598304de3532d95cf0c))
- **FEAT**: Add support for cycling pedaling cadence data types. ([8a7c1830](https://github.com/fam-tung-lam/health_connector/commit/8a7c1830778ef6819f3ec44fca7037c58f213cad))
- **REFACTOR**: Sort `HealthDataType.values` and `HealthDataType.nutrientValues` lists. ([f45550d7](https://github.com/fam-tung-lam/health_connector/commit/f45550d7e09371099a9593384860d5a25d58045f))

## 2.1.0

- **FIX**: Ensure health record timestamps are stored as UTC. ([7f981fc2](https://github.com/fam-tung-lam/health_connector/commit/7f981fc2868062fead0b5fa7a4ad512adf4c8f24))
- **FEAT**: Add support for sexual activity and cervical mucus data types. ([972ea406](https://github.com/fam-tung-lam/health_connector/commit/972ea406b57846f83013bb0758046524e37311e4))
- **FEAT**: Add support for mindfulness session type and record. ([d0490c9d](https://github.com/fam-tung-lam/health_connector/commit/d0490c9dba99ff77ef0b3b4f999810c9e1db0bbc))
- **FEAT**: Add support for power data types. ([af790b23](https://github.com/fam-tung-lam/health_connector/commit/af790b237e1e8a3771b579bf0fcb62698d8b69d1))

## 2.0.0

> **Note**: This release has breaking changes.

- **BREAKING** **FEAT**: Introduce `TimeDuration` unit and replace `Number` with it for sleep data types. ([459798dd](https://github.com/fam-tung-lam/health_connector/commit/459798dd25d3ff014b824f4d9d7f79aa27ac0f53))
- **BREAKING** **FEAT**: Unify deletion API with polymorphic request pattern. ([f67cf5ae](https://github.com/fam-tung-lam/health_connector/commit/f67cf5ae0cda0a513c37b844aa44e8815fde0996))
- **BREAKING** **REFACTOR**: Simplify `aggregate` and `readRecord` APIs by removing request/response wrappers. ([31673d12](https://github.com/fam-tung-lam/health_connector/commit/31673d12b945e017a9a2b34bfef539cdec4fea23))
- **BREAKING** **REFACTOR**: Remove support for individual nutrient data types on Android Health Connect. ([a9f7c9e4](https://github.com/fam-tung-lam/health_connector/commit/a9f7c9e47f9c0390ba4dc4eb3d6d7ed01e5772f1))
- **BREAKING** **REFACTOR**: Standardize and synchronize error codes across platforms. ([121df395](https://github.com/fam-tung-lam/health_connector/commit/121df395899bf3ba919a4d51a3c29527c01ace0d))
- **BREAKING** **REFACTOR**: Remove support for "delete-then-create" logic for iOS HealthKit. ([e79b1772](https://github.com/fam-tung-lam/health_connector/commit/e79b177270ebe925b20b0309a5a31e9d44e648b5))
- **FEAT**: Add support for exercise session data type. ([d36b528c](https://github.com/fam-tung-lam/health_connector/commit/d36b528c7f6ec5b7ae3a33e0e8137c557c870e46))
- **FEAT**: Add `updateRecords` API for batch record updates. ([04e5463e](https://github.com/fam-tung-lam/health_connector/commit/04e5463e96552c04c331b8025d6e5d831e28953e))
- **FEAT**: Add full support for distance records and data types. ([84e27c08](https://github.com/fam-tung-lam/health_connector/commit/84e27c0821bad311aaf7bf6f1d2b577b50365700))
- **FEAT**: Add full support for speed records and data types. ([f07714db](https://github.com/fam-tung-lam/health_connector/commit/f07714db7b9302eea65e19aabab9e036bafbcab6))
- **FIX**: Fix IDs validation in `DeleteRecordsByIdsRequest` factory constructor. ([d37817e5](https://github.com/fam-tung-lam/health_connector/commit/d37817e584163d7c140fef4868f54edda9c1528e))

## 1.4.0

- **FEAT**: Add blood glucose data type. ([eed289b4](https://github.com/fam-tung-lam/health_connector/commit/eed289b40c6d079b0997f16ad7f75881f84ec196))

## 1.3.0

- **FEAT**: Add VO2Max data type. ([1f885539](https://github.com/fam-tung-lam/health_connector/commit/1f8855396649275b9bc16e62dbbd2b66ef6745e0))
- **FEAT**: Add respiratory rate data type. ([75ba9138](https://github.com/fam-tung-lam/health_connector/commit/75ba913811f39879cb81c6eb121e1cf789ef5311))
- **FEAT**: Add oxygen saturation data type. ([8c0876b0](https://github.com/fam-tung-lam/health_connector/commit/8c0876b04480b311a3b8d516a2977a11feaff6b8))
- **FEAT**: Add resting heart rate data type. ([7bb5bbea](https://github.com/fam-tung-lam/health_connector/commit/7bb5bbea8b385d0915ec34257964e53f1d3fc4b5))

## 1.2.1

- **DEPS**: Update `health_connector_lint` to the latest version.

## 1.2.0

- **FEAT**: Add blood pressure records and data types. ([750251a9](https://github.com/fam-tung-lam/health_connector/commit/750251a9149b4d12f11e196261552db8689c0473))

## 1.1.0

- **FEAT**: Add support for nutrient and nutrition health data types. ([be34f9ed](https://github.com/fam-tung-lam/health_connector/commit/be34f9eda6adb25341b1f4c4b6f0513fad97d237)) ([77e3a8d0](https://github.com/fam-tung-lam/health_connector/commit/77e3a8d00e6afaf43f56a24eb7c55621d82f63ad))

## 1.0.0

- **FEAT**: Add core foundation and health platform client.
