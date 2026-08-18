# Kotlin Testing Mechanics

JUnit 5, MockK, Kotest assertions, and `kotlinx-coroutines-test`. This file owns
how Kotlin spells a testing decision, never the decision itself: what a test
must prove, which level it belongs at, where it goes, and when a double is
justified are all settled before you open it.

Tests live in `src/test/kotlin` under the package path of the code they cover.
Use that layout when the repository has no established one of its own.

The test source set of a module sees that module's `internal` declarations, so a
test never justifies widening a declaration to `public`.

## Structure a JUnit 5 class

- No runner and no base class. A plain class with `@Test` functions is enough
  once the Gradle test task calls `useJUnitPlatform()`, which
  [gradle-build.md](gradle-build.md) owns.
- Group the cases for one behaviour in a `@Nested inner class`.
- Name the test function after the observable behaviour, in backticks when a
  sentence reads better than an identifier.
- Put the Given-When-Then sentence in `@DisplayName`, on the class and on the
  test, so the failure report reads as a specification.
- Set up with `@BeforeEach` and tear down with `@AfterEach`.
- Drive one rule with several inputs through `@ParameterizedTest` and
  `@MethodSource`. A non-static method source needs
  `@TestInstance(TestInstance.Lifecycle.PER_CLASS)` on the enclosing class.
- Put shared lifecycle behaviour in an extension implementing
  `BeforeEachCallback` and `AfterEachCallback`, and apply it with `@ExtendWith`.
- Keep literals in `private const val` at file scope rather than repeating them.

## Assert with Kotest

Use the Kotest assertion library and keep one assertion vocabulary per module.

| Assertion                       | Import from                                   |
| ------------------------------- | --------------------------------------------- |
| `result shouldBe expected`      | `io.kotest.matchers.shouldBe`                 |
| `shouldThrow<T> { ... }`        | `io.kotest.assertions.throwables.shouldThrow` |
| `value.shouldBeInstanceOf<T>()` | `io.kotest.matchers.types.shouldBeInstanceOf` |

`shouldThrow` returns the thrown exception, so assert on its type and message
from the returned value instead of catching it by hand.

## Double a boundary with MockK

- Create a double with `mockk<T>()`, and stub with `every { ... } returns ...`.
  Verify with `verify { ... }`, and only for an interaction that is part of the
  contract.
- Stubbing or verifying a `suspend` call needs MockK's suspending counterpart of
  those functions. Read its exact name from the installed MockK rather than
  guessing it.
- Declare an annotated double with `@MockK` or `@RelaxedMockK`, and initialise
  it with `MockKAnnotations.init(this)` in `@BeforeEach`.
- Prefer a strict `mockk()`. A relaxed mock answers every unstubbed call with a
  default, which quietly satisfies an assertion that should have failed. Relax
  only where the unstubbed surface cannot affect the outcome.
- Call `unmockkAll()` in `@AfterEach` when the test replaced any global or
  static behaviour, so the next test starts clean.
- Prefer a hand-written fake for a collaborator that has real behaviour worth
  keeping. MockK is for a boundary, not for a value.

## Control coroutines instead of waiting for them

- Run any test of a suspending function inside `runTest { ... }`. It supplies a
  `TestScope` with virtual time, so a delay completes immediately.
- Create one `StandardTestDispatcher()` per test and pass it into both
  `runTest(testDispatcher)` and the code under test, through the same dispatcher
  dependency [coroutines.md](coroutines.md) requires. The test then decides when
  the coroutines run.
- Replace `Dispatchers.Main` in an extension: `Dispatchers.setMain(dispatcher)`
  in `beforeEach` and `Dispatchers.resetMain()` in `afterEach`. Resetting is
  what stops one test leaking its dispatcher into the next.
- Never add a real delay or a sleep to let work finish. Advance the test
  scheduler, or the suite becomes a function of machine speed.

Finish when each test states one behaviour in its `@DisplayName`, controls its
own dispatchers, replaces only real boundaries, and leaves no global state
behind for the next test.
