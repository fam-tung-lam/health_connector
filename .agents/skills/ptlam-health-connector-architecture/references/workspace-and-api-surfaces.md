# Workspace and API Surfaces

This reference owns package direction, Dart library audiences, and the durable
public API rules.

## Package direction

The root `pubspec.yaml` owns the Melos workspace and shared dependency versions.
Member packages use workspace resolution.

| Package                       | Responsibility                                                                                    |
| ----------------------------- | ------------------------------------------------------------------------------------------------- |
| `health_connector`            | Public facade and platform selection                                                              |
| `health_connector_core`       | Domain records, data types, requests, responses, annotations, and `HealthConnectorPlatformClient` |
| `health_connector_hc_android` | Dart client and DTO mappers for Android Health Connect                                            |
| `health_connector_hk_ios`     | Dart client and DTO mappers for iOS HealthKit                                                     |
| `health_connector_logger`     | Shared structured logs and processors                                                             |
| `health_connector_lint`       | Shared Dart analyzer configuration; no Dart implementation                                        |

The facade depends on core, both platform packages, and logger. Each platform
package depends on core and logger. Core never imports a platform package. One
platform package never imports the other or the facade.

## Library audiences

| Library                                                         | Audience and rule                                                                             |
| --------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `health_connector/lib/health_connector.dart`                    | Application developers; re-exports the public core and logger surfaces plus `HealthConnector` |
| `health_connector/lib/health_connector_internal.dart`           | Platform packages; re-exports core internals and the full logger                              |
| `health_connector_core/lib/health_connector_core.dart`          | Application developers; explicit `show` exports define the public API                         |
| `health_connector_core/lib/health_connector_core_internal.dart` | Facade and platform packages; broad exports with deliberate `hide` clauses                    |
| Each platform package's top-level library                       | Facade only; exports its Dart client                                                          |

A public core symbol does not exist for consumers until the explicit public
export names it. Keep shared abstract intermediates internal even when their
concrete subtypes are public. Use `@experimentalApi` only for an intentionally
unstable public API.

Every public type or member carries the `@sinceVx_y_z` constant for the release
that introduced it. The annotation records history. Removing or changing a
published API follows the repository's deprecation policy and semantic
versioning; do not rewrite an existing `@since` value.

## Platform promises

`supportedHealthPlatforms` is the runtime source for whether a data type or
permission works on Android, iOS, or both. The `@supportedOn...` annotations and
dartdoc must agree with it. An unsupported operation fails explicitly rather
than silently switching semantics.

Android supports record updates, accurate read-permission status, listing
granted permissions, and revocation. HealthKit records are immutable, hides read
authorization as `unknown`, and has no equivalent permission-list or revocation
operation. Keep those differences visible in the public contract.
