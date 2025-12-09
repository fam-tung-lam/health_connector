# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2025-12-09

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`health_connector_core` - `v1.2.0`](#health_connector_core---v120)
 - [`health_connector_hc_android` - `v1.2.0`](#health_connector_hc_android---v120)
 - [`health_connector_hk_ios` - `v1.2.0`](#health_connector_hk_ios---v120)
 - [`health_connector` - `v1.1.1`](#health_connector---v111)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `health_connector` - `v1.1.1`

---

#### `health_connector_core` - `v1.2.0`

 - **FEAT**(health_connector_core): Introduce sealed class hierarchy for `AggregateRequest` with `CommonAggregateRequest` and `BloodPressureAggregateRequest` subclasses. ([88b73707](https://github.com/fam-tung-lam/health_connector/commit/88b73707c7eeb4de4d8e429c4e87802bd9899913))
 - **FEAT**(health_connector_core): Add blood pressure records and data types. ([750251a9](https://github.com/fam-tung-lam/health_connector/commit/750251a9149b4d12f11e196261552db8689c0473))

#### `health_connector_hc_android` - `v1.2.0`

 - **FEAT**(health_connector_hc_android): Introduce specialized aggregation requests. ([55f00e29](https://github.com/fam-tung-lam/health_connector/commit/55f00e294d41f91c95d034768d99315baebd7208))
 - **FEAT**(health_connector_hc_android): Add support for blood pressure records and data types. ([c5dc5fc9](https://github.com/fam-tung-lam/health_connector/commit/c5dc5fc90afd2c010e77a799bb2a5a04709ecbcf))

#### `health_connector_hk_ios` - `v1.2.0`

 - **FEAT**(health_connector_hk_ios): Add support for blood pressure records and data types. ([7c3d9525](https://github.com/fam-tung-lam/health_connector/commit/7c3d9525f880e13e893b7831c35185997b1b46cf))


## 2025-12-07

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`health_connector` - `v1.1.0`](#health_connector---v110)
 - [`health_connector_core` - `v1.1.0`](#health_connector_core---v110)
 - [`health_connector_hc_android` - `v1.1.0`](#health_connector_hc_android---v110)
 - [`health_connector_hk_ios` - `v1.1.0`](#health_connector_hk_ios---v110)

---

#### `health_connector` - `v1.1.0`

 - **FEAT**: Add nutrient and nutrition records and data types. ([77e3a8d0](https://github.com/fam-tung-lam/health_connector/commit/77e3a8d00e6afaf43f56a24eb7c55621d82f63ad))

#### `health_connector_core` - `v1.1.0`

 - **FIX**: Correct import paths in annotation files to remove redundant slashes. ([c299d235](https://github.com/fam-tung-lam/health_connector/commit/c299d2350025811499af9b4639156ed9294fedf8))
 - **FEAT**(health_connector_hc_android): Add support for nutrient and nutrition health data types. ([be34f9ed](https://github.com/fam-tung-lam/health_connector/commit/be34f9eda6adb25341b1f4c4b6f0513fad97d237))
 - **FEAT**: Add nutrient and nutrition records and data types. ([77e3a8d0](https://github.com/fam-tung-lam/health_connector/commit/77e3a8d00e6afaf43f56a24eb7c55621d82f63ad))

#### `health_connector_hc_android` - `v1.1.0`

 - **REFACTOR**: Simplify record extraction in clients and remove unused `ReadRecordResponseDto` extension. ([7303bfb0](https://github.com/fam-tung-lam/health_connector/commit/7303bfb0df6f7e87612e23e23732f2d2b694f961))
 - **FEAT**(health_connector_hc_android): Implement nutrient health data permissions based on nutrition permission status. ([a39ab697](https://github.com/fam-tung-lam/health_connector/commit/a39ab6970f70fe2078a60ce141edc466ac3f6dfd))
 - **FEAT**(health_connector_hc_android): Add support for nutrient and nutrition health data types. ([be34f9ed](https://github.com/fam-tung-lam/health_connector/commit/be34f9eda6adb25341b1f4c4b6f0513fad97d237))
 - **FEAT**: Add nutrient and nutrition records and data types. ([77e3a8d0](https://github.com/fam-tung-lam/health_connector/commit/77e3a8d00e6afaf43f56a24eb7c55621d82f63ad))

#### `health_connector_hk_ios` - `v1.1.0`

 - **REFACTOR**: Simplify record extraction in clients and remove unused `ReadRecordResponseDto` extension. ([7303bfb0](https://github.com/fam-tung-lam/health_connector/commit/7303bfb0df6f7e87612e23e23732f2d2b694f961))
 - **FEAT**(health_connector_hk_ios): Add support for nutrient and nutrition health data types. ([2c4d049a](https://github.com/fam-tung-lam/health_connector/commit/2c4d049af240da1f3841b1fa83e8351e51ab1fe2))
 - **FEAT**(health_connector_hk_ios): Mark nutrient and nutrition records as unimplemented. ([8777868f](https://github.com/fam-tung-lam/health_connector/commit/8777868fc1d62e1dfbbf357877e9b24d7dbbb97e))

