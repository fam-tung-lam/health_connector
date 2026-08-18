# Swift Package Tests

The test target, the test framework, and the commands that run them. The
foundation owns what a test must prove, which level to pick, where the file
goes, and when a double is justified; this file owns the Swift mechanics.

## Declare the test target

```swift
.testTarget(
    name: "SessionKitTests",
    dependencies: ["SessionKit"]
)
```

Sources live in `Tests/SessionKitTests/`. The target is never listed in a
product, so it ships to nobody.

`@testable import SessionKit` raises the module's `internal` declarations to the
test's view. It requires a debug build and it lets a test bind to something the
package does not promise, so reach for it only when the public surface genuinely
cannot express the behavior.

## Use Swift Testing for new tests

`import Testing` is available with the Swift 6 toolchain and is what
`swift package init` generates. Keep XCTest where a package already uses it, and
keep it for performance measurement and UI automation, which Swift Testing does
not provide.

```swift
import Testing
@testable import SessionKit

@Suite("session expiry")
struct SessionExpiryTests {
    @Test("an expired session refuses to refresh")
    func expiredSessionRefusesRefresh() throws {
        // Given
        let session = Session(expiresAt: .distantPast)
        // When / Then
        #expect(throws: SessionError.self) { try session.refresh() }
    }
}
```

| Mechanic                              | Use for                                                |
| ------------------------------------- | ------------------------------------------------------ |
| `@Suite("...")`                       | Naming a group of behaviors                            |
| `@Test("...")`                        | Naming one observable behavior                         |
| `#expect(condition)`                  | Recording a failure and continuing                     |
| `try #require(condition)`             | Stopping the test when continuing would be meaningless |
| `try #require(optional)`              | Unwrapping without a force-unwrap                      |
| `#expect(throws: SomeError.self) { }` | Asserting the promised failure                         |
| `@Test(arguments: [...])`             | Running one behavior over several inputs               |
| `confirmation(expectedCount:)`        | Proving a callback fired the promised number of times  |
| `withKnownIssue { }`                  | Recording a failure that is already tracked            |

Give a suite type a `struct`. Swift Testing builds a fresh instance for every
test in it, so per-test state is isolated with no teardown step. Put setup in
the suite's `init`. A `struct` has no `deinit`; make the suite a `final class`
when a test genuinely needs teardown code to run.

Swift Testing runs its tests in parallel by default. Apply `.serialized` to a
suite only when its tests share a resource you cannot isolate, and name that
resource in the trait's comment.

Other traits carry conditions: `.disabled("reason")`, `.enabled(if: condition)`,
`.timeLimit(...)`, `.tags(...)`, and `.bug(...)`.

A `@Test` function may be `async throws`. Awaiting an actor's member inside a
test needs no extra setup; the test runs in its own task.

## Run them

| Command                                  | Runs                                            |
| ---------------------------------------- | ----------------------------------------------- |
| `swift test`                             | Every test target in the package                |
| `swift test --filter SessionExpiryTests` | Tests whose type or function name matches       |
| `swift test --parallel`                  | XCTest cases in parallel; the default is serial |

`--filter` matches the Swift symbol name, not the display name in
`@Test("...")`, so filtering on the quoted string silently runs nothing and
reports success.

## Finish

Finish when the test target builds, the new tests fail for the broken behavior
and pass for the implemented one, no test depends on another's ordering under
parallel execution, and `swift test` passes for the whole package.
