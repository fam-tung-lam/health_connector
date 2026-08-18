# Dart SDK and Package Resolution

How a Dart package declares which SDK and dependencies it runs on, and how a
build reproduces that resolution.

## The SDK constraint is a gate, not a note

`environment: sdk:` in `pubspec.yaml` decides which SDKs may resolve the
package. `dart pub get` refuses the resolution outright when the running SDK
falls outside it:

```text
The current Dart SDK version is 3.12.2.

Because dartprobe requires SDK version >=4.0.0 <5.0.0, version solving failed.
```

Set the constraint to the lowest SDK you test against, in caret form such as
`^3.9.0`. Raising it is a breaking change for consumers, so raise it in a change
of its own that says why.

Use a language feature only when every SDK the constraint admits has it. The
analyzer reports the feature as unavailable rather than guessing.

## Let pub edit the pubspec

Add and remove dependencies through pub so the constraint and the lockfile move
together:

| Task                               | Command                             |
| ---------------------------------- | ----------------------------------- |
| Add a runtime dependency           | `dart pub add <package>`            |
| Add a development-only dependency  | `dart pub add dev:<package>`        |
| Remove a dependency                | `dart pub remove <package>`         |
| Install the locked versions        | `dart pub get`                      |
| Fail when the lockfile is stale    | `dart pub get --enforce-lockfile`   |
| See what a newer resolution offers | `dart pub outdated`                 |
| Move within existing constraints   | `dart pub upgrade`                  |
| Raise constraints to a new major   | `dart pub upgrade --major-versions` |
| Explain why a package is present   | `dart pub deps`                     |

Never hand-edit `pubspec.lock`. Keep `dependencies` and `dev_dependencies`
alphabetized; the `sort_pub_dependencies` lint checks this when enabled.

Keep a package a test-only dependency unless production code imports it. The
`depend_on_referenced_packages` lint catches an import with no declared
dependency behind it.

## Track the lockfile only where it means something

An application pins its resolution so every machine builds the same bytes, and
commits `pubspec.lock`. A published library resolves fresh against each
consumer's constraints, so it leaves the lockfile untracked — the SDK's own
`dart create -t package` template gitignores it for exactly that reason.

In CI, install with `dart pub get --enforce-lockfile` so a pubspec change
without a matching lockfile change fails the job instead of silently resolving
something new.

## Fix what the analyzer can fix

`dart fix --dry-run` lists the diagnostics that carry an automated fix.
`dart fix --apply` rewrites the source. Both are analyzer-driven, so they only
act on rules the project's `analysis_options.yaml` enables.

Run `dart fix --dry-run` first, apply, then read the diff. An automated fix that
changes behavior is your change once you commit it.

## Finish

Finish when `dart pub get --enforce-lockfile` succeeds, every import has a
declared dependency, the lockfile's tracked state matches the package's kind,
and the SDK constraint names the lowest version you actually tested.
