# Running Dart Tests

The `package:test` runner, expression, and matcher mechanics. This file owns how
a Dart test is spelled and run, not what it must prove.

Add the runner as a development dependency with `dart pub add dev:test`.

## The runner finds `_test.dart` and nothing else

Put tests under `test/` in files whose names end `_test.dart`. A helper named
`test/helper.dart` is never executed, which is what makes it a safe place for
shared setup.

```bash
dart test                              # every suite
dart test test/orders_test.dart        # one file
dart test -n 'rejects an empty id'     # by name, as a regular expression
dart test -N 'rejects'                 # by plain-text name
dart test -t slow                      # by tag
dart test --coverage=coverage          # collect coverage into a directory
```

Put settings every run should share in `dart_test.yaml` beside `pubspec.yaml` —
`timeout`, `concurrency`, tag definitions — so a developer and CI select the
same behavior without repeating flags.

## Structure with `group` and `test`

Nest `group` to name the declaration under test, and let each `test` name the
observable outcome. Setup runs per test, not per file:

```dart
void main() {
  late OrdersRepository repository;

  setUp(() {
    repository = OrdersRepository(FakeOrdersApi());
  });

  group('place', () {
    test('returns a confirmation for an accepted order', () async {
      expect(await repository.place(order), isA<Confirmation>());
    });
  });
}
```

`setUp` and `tearDown` run around every test in their group. Prefer
`addTearDown(subject.dispose)` inside the test that created the resource: the
cleanup sits beside the acquisition and cannot outlive it.

## Match the outcome, not the mechanism

| Outcome                       | Matcher                                                    |
| ----------------------------- | ---------------------------------------------------------- |
| A value                       | `expect(actual, equals(expected))`                         |
| A type                        | `expect(actual, isA<Confirmation>())`                      |
| A field of a thrown error     | `isA<ArgumentError>().having((e) => e.name, 'name', 'id')` |
| A specific throw              | `expect(() => f(), throwsArgumentError)`                   |
| No throw                      | `expect(() => f(), returnsNormally)`                       |
| A future's value              | `await expectLater(future, completion(equals(1)))`         |
| A stream's values, then close | `expect(stream, emitsInOrder(<Object>[1, 2, emitsDone]))`  |

Wrap the call in a closure for any `throws…` matcher; `expect(f(), …)` throws
before the matcher ever runs.

## Get the asynchrony right

Make the callback `async` and `await` the thing under test, or return its
future. A `test` body that starts work without awaiting it passes before the
work finishes.

Use `expectLater` — not `expect` — whenever the matcher itself completes later,
such as `completion` or a stream matcher, and await the result.

The default timeout is 30 seconds per test. Change it deliberately with
`@Timeout(Duration(seconds: 5))` above the file's `library;` directive, a
`timeout:` argument on a `group` or `test`, or `--timeout` for one run. A test
that needs longer usually needs a controlled clock instead.

Mark a known-unfinished case `skip: 'reason'` rather than commenting it out. The
runner then reports it, so it cannot be forgotten.

## Finish

Finish when every new test file ends `_test.dart`, each test awaits everything
it starts, every resource it creates is released by an `addTearDown` or
`tearDown`, and the affected suites pass under `dart test`.
