# Android Health Connect Path

This reference owns end-to-end Android registration after Pigeon generation.

1. Confirm the regenerated Kotlin file contains the DTO and `HealthDataTypeDto`
   entry. Generated `*.g.kt` remains untouched.
2. Add the platform record mapper under `mappers/health_record_mappers/`. Map
   Pigeon DTOs to the exact Health Connect record and back. Throw
   `IllegalArgumentException` for invalid conversion and let the handler
   boundary classify it.
3. Update every exhaustive selector that identifies the record:

   | Selector                           | Typical owner                |
   | ---------------------------------- | ---------------------------- |
   | DTO to Health Connect record class | `HealthDataTypeMapper.kt`    |
   | DTO to record and record to DTO    | `HealthRecordMapper.kt`      |
   | DTO data type                      | `HealthRecordMapper.kt`      |
   | DTO id                             | `HealthRecordIdMapper.kt`    |
   | Read and write permission strings  | `PermissionRequestMapper.kt` |

4. Create `<RecordType>Handler` under `handlers/health_record_handlers/`. Supply
   the data type, injected client and dispatcher, tag, and only the capability
   interfaces Health Connect supports.
5. Use the SDK aggregation capability when Health Connect exposes an aggregate
   metric. Use the custom paging aggregator only when the SDK has no metric; it
   reads every page and is materially more expensive.
6. Register the handler in `HealthRecordHandlerRegistry` with the shared client
   and injected I/O dispatcher. Registration is required even when compilation
   succeeds without it.
7. Add the host permission to the example app manifest when the SDK record
   requires one. The plugin manifest does not declare application health
   permissions.

Add a mapper round-trip test and a handler test under the mirrored `unit_tests/`
tree. Use `FakeHealthConnectClient` and its fake permission controller when the
SDK supplies the behavior. Cover the declared capability set and registry
reachability.

The registry test compares registered handlers with the generated data-type set.
If the Pigeon contract contains an intentionally non-Android type, verify how
that invariant is represented before changing the assertion; do not weaken it
with a blanket exception.

Finish the Android path when the type maps in both directions, resolves through
the registry, exposes the right permission and capabilities, and passes the
Kotlin format, analysis, and example-app test tasks.
