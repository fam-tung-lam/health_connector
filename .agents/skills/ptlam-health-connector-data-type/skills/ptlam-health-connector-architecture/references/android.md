# Android Health Connect Architecture

This reference owns the Kotlin call path, layer boundaries, concurrency model,
and host-app prerequisites.

| Layer       | Owner                            | Responsibility                                                                  |
| ----------- | -------------------------------- | ------------------------------------------------------------------------------- |
| Entry point | `HealthConnectorHCAndroidPlugin` | Flutter lifecycle, Pigeon methods, coroutine scope, callback delivery           |
| Client      | `HealthConnectorClient`          | Client creation, handler lookup, capability checks, batching, and orchestration |
| Services    | `services/`                      | Permissions, features, manifest validation, and sync                            |
| Registry    | `HealthRecordHandlerRegistry`    | One handler instance per `HealthDataTypeDto`                                    |
| Handler     | `handlers/`                      | Health Connect operations for one record type and its declared capabilities     |
| Mapper      | `mappers/`                       | Pure Pigeon DTO and Health Connect conversion                                   |

The entry point never calls Health Connect or maps a record. A service does not
know handlers. A handler does not return Flutter results. A mapper performs no
I/O and does not log.

`DispatcherProvider` carries the main, I/O, and default dispatchers from the
plugin to clients, services, the registry, and handlers. The plugin scope uses
`SupervisorJob`, is cancelled on engine detachment, and keeps one failed call
from cancelling peers. Preserve `CancellationException` through generic failure
wrappers.

Handlers declare capabilities by implementing the readable, writable, updatable,
deletable, or aggregation interfaces. The client checks the capability before
dispatch. Registration is the only route to a handler; a missing registration
becomes `UNSUPPORTED_OPERATION` at runtime.

The host application, not the plugin manifest, declares every
`android.permission.health.*` permission. The plugin manifest only queries the
Health Connect package. Permission requests require a `ComponentActivity`; the
example uses `FlutterFragmentActivity`. Treat a detached activity as a normal
runtime state and return a configuration failure.

Health Connect may be missing or require an update even above the module's
Android API floor. Check platform status before client creation. Gate fields
that require a Health Connect SDK extension at their mapper or operation
boundary and define the older-device result explicitly.
