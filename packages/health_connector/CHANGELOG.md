## 1.4.0

- **FEAT**: Add blood glucose data type. ([eed289b4](https://github.com/fam-tung-lam/health_connector/commit/eed289b40c6d079b0997f16ad7f75881f84ec196)) ([c018d008](https://github.com/fam-tung-lam/health_connector/commit/c018d008bbf012bfa1c609025bd41d920dd4b53a)) ([18803d0f](https://github.com/fam-tung-lam/health_connector/commit/18803d0f6b182595f1dc1d747cdb8760a7423f1f))

## 1.3.0

 - **CHORE**: Update a dependency to the latest release.
 - **FEAT**: Add VO2Max data type. ([1f885539](https://github.com/fam-tung-lam/health_connector/commit/1f8855396649275b9bc16e62dbbd2b66ef6745e0)) ([2a61940f](https://github.com/fam-tung-lam/health_connector/commit/2a61940f010c7f8e7bfca438c5f969ed178193ad)) ([3e51085a](https://github.com/fam-tung-lam/health_connector/commit/3e51085a1602e50febddde9f501002ec6867d649))
 - **FEAT**: Add respiratory rate data type. ([75ba9138](https://github.com/fam-tung-lam/health_connector/commit/75ba913811f39879cb81c6eb121e1cf789ef5311)) ([b6081fa6](https://github.com/fam-tung-lam/health_connector/commit/b6081fa6f99772e0b64b7ca272acf822854cc766)) ([a67dabba](https://github.com/fam-tung-lam/health_connector/commit/a67dabba093393d4064f60f99769edb71d584236))
 - **FEAT**: Add oxygen saturation data type. ([8c0876b0](https://github.com/fam-tung-lam/health_connector/commit/8c0876b04480b311a3b8d516a2977a11feaff6b8)) ([51022aa1](https://github.com/fam-tung-lam/health_connector/commit/51022aa15d7d2d1c91b3512517f1edbbb0af9473)) ([b8928fc7](https://github.com/fam-tung-lam/health_connector/commit/b8928fc785128757bd57d9b07c7ce6c0d436912f))
 - **FEAT**: Add resting heart rate data type. ([7bb5bbea](https://github.com/fam-tung-lam/health_connector/commit/7bb5bbea8b385d0915ec34257964e53f1d3fc4b5)) ([17bbf3b1](https://github.com/fam-tung-lam/health_connector/commit/17bbf3b142a15b17bf4ffb5a51ada4ca5b3fef0f)) ([4972b907](https://github.com/fam-tung-lam/health_connector/commit/4972b9078563225fee0aa7b8506102d9955867e4))

## 1.2.2

- Update `health_connector_lint` to the latest release.
- **REFACTOR**(health_connector_hc_android): Simplify `TAG` initialization with null-coalescing
  operator to avoid redundant null
  checks. ([7ee0217f](https://github.com/fam-tung-lam/health_connector/commit/7ee0217fb0b87ee3ca3ab6e75f104b7070b81678))
- **REFACTOR**(health_connector_hc_android): Replace null/0 returns with explicit error throwing for
  type guard failures for all
  handlers. ([ae151cf5](https://github.com/fam-tung-lam/health_connector/commit/ae151cf5eb03e55321783029eecf3f9983b4e33a))
- **REFACTOR**(health_connector_hc_android): Improve permission mapping and error
  handling. ([29d29b17](https://github.com/fam-tung-lam/health_connector/commit/29d29b17910c9fd100397a1aaf2d39209548b947))
- **REFACTOR**(health_connector_hc_android): Separate health record mapper files for each health
  record
  type. ([e72390d2](https://github.com/fam-tung-lam/health_connector/commit/e72390d255423fb4a59af2d11c7921a43ef02daf))
- **FIX**(health_connector_hc_android): Prevent infinite recursion in nutrient record
  mappers. ([4f09dd9c](https://github.com/fam-tung-lam/health_connector/commit/4f09dd9c80695ff0d092bccd614d6974f7295931))
- **FIX**(health_connector_hc_android): Add missing blood pressure permission
  mapping. ([9728770f](https://github.com/fam-tung-lam/health_connector/commit/9728770f9e1b2dea78142deb6ae74cff78a859cb))
- **REFACTOR**(health_connector_hk_ios): Replace nil returns with explicit error throwing and add
  `extractAggregateValue` to all
  handlers. ([4e175f1b](https://github.com/fam-tung-lam/health_connector/commit/4e175f1b0130a1e492a625d9e87b5e6581527777))
- **REFACTOR**(health_connector_hk_ios): Separate health record mapper files for each health record
  type. ([a5763c37](https://github.com/fam-tung-lam/health_connector/commit/a5763c3750648a8c76f4519de43821c311e615af))
- **FIX**(health_connector_hk_ios): Prevent infinite recursion in nutrient record
  mappers. ([4f09dd9c](https://github.com/fam-tung-lam/health_connector/commit/4f09dd9c80695ff0d092bccd614d6974f7295931))
- **FIX**(health_connector_hk_ios): Request auth for correlation component types not correlation
  itself. ([668afefa](https://github.com/fam-tung-lam/health_connector/commit/668afefaf435c764e02151f685bc9a99b7709d57))

## 1.2.1

- **FIX**(health_connector_hk_ios): Ensure Pigeon completion callbacks execute on main
  thread. ([bc8c1d98](https://github.com/fam-tung-lam/health_connector/commit/bc8c1d98e6520b3bb8d5f8cb1264eae49f21e64c))
- **FIX**(health_connector_hk_ios): Map blood pressure types to corresponding HealthKit
  types. ([ff057529](https://github.com/fam-tung-lam/health_connector/commit/ff057529d7397b80196b6063036526842973ff8d))
- **REFACTOR**(health_connector_hc_android): Add `complete()` helper for Pigeon
  callbacks. ([d72e1bfc](https://github.com/fam-tung-lam/health_connector/commit/d72e1bfcd661b4df9c3540ea4f5c38e87638d5b1))

## 1.2.0

- **FEAT**: Add support for blood pressure data types.

## 1.1.0

- **FEAT**: Add nutrient and nutrition records and data
  types. ([77e3a8d0](https://github.com/fam-tung-lam/health_connector/commit/77e3a8d00e6afaf43f56a24eb7c55621d82f63ad))

## 1.0.0

- **FEAT**: Implement `HealthConnector` facade providing unified API across platforms.
- **FEAT**: Add support for health data types:
    - Distance
    - Active calories burned
    - Floors climbed
    - Wheelchair pushes
    - Height
    - Body temperature
    - Lean body mass
    - Hydration
    - Heart rate
    - Sleep stage (iOS HealthKit) and session (Android Health Connect)
