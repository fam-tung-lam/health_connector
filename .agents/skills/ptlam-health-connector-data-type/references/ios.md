# iOS HealthKit Path

This reference owns end-to-end iOS registration after Pigeon generation.

1. Confirm the regenerated Swift file contains the public DTO and
   `HealthDataTypeDto` case. If visibility is wrong, repair the committed Python
   post-processor and regenerate; never patch `*.g.swift` directly.
2. Add `HealthDataTypeDto.toHKSampleType()` and gate identifiers newer than the
   package floor with `if #available`. The older branch throws a precise
   unsupported-operation error.
3. Add the reverse `HKSample.healthDataType` case and the DTO `id` and
   `dataType` cases used by batch writes and sync.
4. Create one mapper file under `mappers/health_record_mappers/` with both DTO
   to HealthKit and HealthKit to DTO conversions. Add both dispatch cases in
   `HealthRecordMapper.swift`.
5. Create a `final` handler under `handlers/health_record_handlers/`. Bind its
   DTO and sample associated types, inject `HKHealthStore`, declare the static
   data type, and conform only to supported capability protocols.
6. Keep the handler immutable. If it is `@unchecked Sendable`, its only stored
   state must remain thread-safe. Put specialized operation overrides in a
   `// MARK:`-separated extension and keep the method as a protocol requirement
   so dynamic dispatch still reaches it.
7. Register the handler in `registerAllHandlers()`. Missing registration ships
   and fails only on a user's device.

Use `AggregatableQuantityHealthRecordHandler` for a standard HealthKit
statistics query. Supply the supported metric set and exact `HKUnit` conversion.
Use a custom aggregation implementation only for a type the statistics API
cannot represent.

Confirm the public permission behavior matches HealthKit: read authorization
returns `unknown`, samples are immutable, and types unavailable on the running
iOS version fail explicitly. Add or update host usage descriptions only when the
new capability changes what the app reads or writes.

The package has no effective native Swift test target. Do not invent a passing
`swift test` result. Verify the native path with SwiftLint, SwiftFormat, source
review, and the strongest available device, simulator, or Xcode evidence, then
state the remaining gap.
