# Test Placement

This foundation's fallback layout for a new test file, and the rules for
relocating a misplaced one.

## Who owns placement

An established repository layout beats a specialization fallback. A
specialization may define a stack default when repository evidence is silent.
Use this file only when neither of them answers.

## The fallback layout

Map the production root to the repository's test root, keep the production or
capability scope, then add the test-level segment.

```text
<production-root>/<capability-scope>/<source-file>
-> <test-root>/<capability-scope>/<test-level>/<test-file>
```

Use the repository's own names for the roots, the capability directories, the
level directories, and the test filenames.

Mirror the remaining source directories and filenames when one test corresponds
to one production file. For a user journey or a capability with no single source
file, organize by that capability before its level.

## Tests already in the wrong place

Leave unrelated existing tests where they are.

When a test you are already touching violates the active placement owner, tell
the user. Move it only when relocation is already in scope or separately
authorized. After a move, remove the old location, update imports and
configuration, then rerun the affected tests.
