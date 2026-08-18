# Platform Channel

This reference owns the cross-language contract, generated surfaces, mapper
directions, and where failures become Dart-visible.

## Source and generated ownership

Each platform package owns one Dart Pigeon input under `pigeon/`. That file is
the editable wire contract. Generated `*.g.dart`, `*.g.kt`, and `*.g.swift`
files are committed outputs and are never hand-edited.

Run `melos run pigeon` from the monorepo root after a contract change. The
script regenerates both platforms, patches public visibility into the generated
iOS DTOs, then formats the workspace. Running Pigeon directly for one package
skips part of that contract.

Pigeon DTOs contain wire-safe values. Dates cross as epoch milliseconds,
quantities as `double`, identifiers as nullable strings, and enums as separate
`*Dto` types. Hand-written mappers restore domain and platform types.

| Boundary | Domain to platform  | Platform to domain |
| -------- | ------------------- | ------------------ |
| Dart     | `toDto()`           | `toDomain()`       |
| Kotlin   | `toHealthConnect()` | `toDto()`          |
| Swift    | `toHK...()`         | `toDto()`          |

Keep dispatchers exhaustive where the language permits it. A new record type
must enter both directions and every identity or permission mapper that selects
by data type.

## Failure path

Native handlers translate platform failures into the project's native error
type. Native clients preserve already-classified failures and wrap unexpected
ones. Only the plugin entry point converts that type into the Pigeon error DTO.
Dart maps the DTO code to the public `HealthConnectorException` hierarchy.

Error-code strings are a cross-language compatibility contract. Add or rename a
code in the Pigeon definitions and every native and Dart mapper in the same
change.

## Completion and logging

Kotlin Pigeon methods launch in the plugin's supervised coroutine scope and
answer through the generated callback. Swift asynchronous Pigeon methods run in
a `Task` and route every completion through the plugin's main-thread helper;
calling a Flutter completion from a background thread can crash the host app.

Native structured logs travel back to Dart through a reverse Pigeon API. Log
context and error details cross the process boundary. They may contain data
types, counts, spans, and flags, but no health values, record identifiers,
user-owned dates, or device names.
