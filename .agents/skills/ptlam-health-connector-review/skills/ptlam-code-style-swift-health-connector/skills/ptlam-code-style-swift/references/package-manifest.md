# Swift Package Manifest

`Package.swift` mechanics: the tools version, platform floors, products,
targets, dependencies, resources, and build settings.

The manifest is executable Swift that Swift Package Manager runs before it
builds anything. `// swift-tools-version:` is the first line of the file and
selects which `PackageDescription` API the rest of the file may use.

## Declare the floors

Pick the lowest `swift-tools-version` that provides the manifest API you
actually use. Raising it drops every consumer whose toolchain is older.

`platforms:` sets the minimum release each Apple platform must meet, as in
`platforms: [.iOS(.v15), .macOS(.v13)]`. Omitting a platform does not exclude
it; the package then accepts that platform's oldest supported release.

Raising a floor, renaming a product, or removing one breaks consumers you cannot
recompile. The foundation's contract rules own that decision.

## Name products and targets after what they hold

A target is one module. Its sources live in `Sources/<TargetName>/` and its
tests in `Tests/<TargetName>Tests/`. Pass `path:` only when a layout you do not
control cannot move.

| Declaration                  | Produces                                                        |
| ---------------------------- | --------------------------------------------------------------- |
| `.library(name:targets:)`    | A product other packages import                                 |
| `.executable(name:targets:)` | A runnable product                                              |
| `.target(name:)`             | A module built from Swift sources                               |
| `.executableTarget(name:)`   | A module with a `main` entry point                              |
| `.testTarget(name:)`         | A test module, never shipped in a product                       |
| `.binaryTarget(name:path:)`  | A prebuilt XCFramework, whose source you cannot review or patch |

List a target in a product only when an outside consumer is meant to import it.
Every other target stays internal to the package and reachable through the
`package` access level.

Give each target exactly the dependencies its sources import. An unused entry in
`dependencies:` still forces the dependency on every consumer.

## Pin dependencies deliberately

| Form                      | Resolves to                           | Use for                             |
| ------------------------- | ------------------------------------- | ----------------------------------- |
| `.package(url:from:)`     | At or above it, below the next major  | The normal case                     |
| `.package(url:_:)`        | An explicit version range you write   | A dependency with a known bad tag   |
| `.package(url:branch:)`   | The branch tip, changing each resolve | A short-lived fork only             |
| `.package(url:revision:)` | One exact commit                      | Pinning past a broken release       |
| `.package(path:)`         | A checkout on this machine            | Local development inside a monorepo |

A `branch` or `revision` dependency makes the build non-reproducible from tags
alone. Record in the manifest comment what ends it.

Commit `Package.resolved` for an application, where it pins the exact build. A
library's resolved file does not constrain its consumers, so treat it as local
state rather than a contract.

## Set build behavior in `swiftSettings`

- `.swiftLanguageMode(.v6)` turns data-race checking into errors for that
  target. Prefer it over per-file suppression.
- `.enableUpcomingFeature("StrictConcurrency")` adopts one language change ahead
  of the next mode, so a target still on `.v5` can migrate gradually.
- `.enableUpcomingFeature("ExistentialAny")` requires an explicit `any` on every
  existential, which makes each boxing cost visible.
- `.define(_:)` sets a compilation condition for `#if`.
- `.unsafeFlags(_:)` passes raw compiler flags. Swift Package Manager refuses to
  build a package that uses it when reached as a versioned dependency, so it
  makes the package unusable to consumers.

Ship non-code files with `resources:`. Use `.process(_:)` so the toolchain
applies the platform's own rule for the file type, and `.copy(_:)` only when the
directory must reach the bundle byte-for-byte.

## Finish

Finish when `swift build` succeeds, every target lists only the dependencies it
imports, each product names the targets a consumer is meant to import, and any
moving dependency pin carries the condition that removes it.
