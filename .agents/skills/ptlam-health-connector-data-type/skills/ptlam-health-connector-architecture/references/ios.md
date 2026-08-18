# iOS HealthKit Architecture

This reference owns the Swift call path, isolation model, and HealthKit and
host-app constraints.

| Layer       | Owner                             | Responsibility                                                          |
| ----------- | --------------------------------- | ----------------------------------------------------------------------- |
| Entry point | `HealthConnectorHkIosPlugin`      | Pigeon conformance, client lifetime, logging setup, main-thread replies |
| Client      | `HealthConnectorClient` actor     | Validation, handler lookup, response assembly, cross-handler operations |
| Services    | Permission and data-sync structs  | Cross-type authorization and anchored synchronization                   |
| Registry    | `HealthRecordHandlerRegistry`     | Thread-safe data-type and capability lookup                             |
| Handler     | One class per `HealthDataTypeDto` | HealthKit operations for one record type                                |
| Mapper      | Extensions under `mappers/`       | Pure DTO and HealthKit conversion                                       |

The client is an actor. Handlers are immutable `final` classes marked
`@unchecked Sendable` because they hold only thread-safe `HKHealthStore` state.
The registry uses `NSLock` because the deployment floor predates Swift's newer
mutex. A handler shared across requests must not gain mutable stored state.

Capability protocols supply default read, write, delete, and aggregation
behavior. A specialized handler overrides a protocol requirement in a
`// MARK:`-separated extension. The registry is the only path to a handler;
missing registration fails on a device as an unsupported operation.

The host app must provide non-empty `NSHealthShareUsageDescription` and
`NSHealthUpdateUsageDescription` values before HealthKit access. Client creation
also checks `HKHealthStore.isHealthDataAvailable()`.

HealthKit does not reveal read authorization. Return `unknown`; never infer
denial from an empty query. HealthKit samples are immutable, so the shared
update API remains Android-only. Gate identifiers newer than iOS 15 where a data
type maps to HealthKit and return a precise unsupported-operation error on older
systems.

The Swift package currently has no effective native test target. Dart tests
prove only the Dart client and DTO mappers. Swift-only behavior therefore needs
lint, format, source review, and manual device or simulator evidence; do not
claim `swift test` coverage unless a real target and runner have been added.
