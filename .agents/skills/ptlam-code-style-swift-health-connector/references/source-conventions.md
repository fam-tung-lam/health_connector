# Swift Source Conventions

This reference owns recurring Health Connector Swift declaration, mapper, and
extension shapes.

Keep declarations internal by default. Mark only the Flutter-reflected plugin
and types required by the generated public protocol as `public`.

Separate protocol conformances and specialized behavior with `// MARK:` sections
when the neighboring type does so.

Project mappers are extensions on the converted type. Name the destination in
the method: `toDto()`, `toHKSample()`, `toHKQuantitySample()`, or another exact
HealthKit type.

Keep multiline arguments, parameters, and collections in SwiftFormat's
before-first layout with trailing commas. Let SwiftFormat remove redundant
`self` and control line wrapping instead of hand-aligning expressions.
