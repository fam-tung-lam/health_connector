# Swift Naming and Access Control

How Swift spells a name and how far a declaration reaches. The foundation owns
which role a name states; this file owns the Swift conventions and keywords.

## Follow the Swift API Design Guidelines

- Types and protocols are `UpperCamelCase`. Everything else is `lowerCamelCase`.
- An acronym is cased uniformly across its whole span: `HTTPHeader`,
  `urlSession`, `parseXML`.
- Argument labels make the call site read as a phrase:
  `move(from: start, to: end)`. Drop the first label when the argument completes
  the base name, as in `numbers.append(value)`.
- Omit words the signature already carries. The parameter type is visible, so
  `remove(at: index)` beats `removeElementAtIndex(index)`.
- A mutating method and its returning counterpart differ by grammar. Use a verb
  pair such as `sort()` and `sorted()`, or a noun pair such as `formUnion(_:)`
  and `union(_:)`.
- A protocol that says what a type _is_ is a noun, as in `Collection`. One that
  says what a type _can do_ ends in `-able`, `-ible`, or `-ing`, as in
  `Equatable` and `ProgressReporting`.
- A Boolean member reads as an assertion about the receiver: `line.isEmpty`,
  `token.hasExpired`.

Enforce the mechanical part with SwiftLint's `identifier_name` and `type_name`,
which carry the length and character rules. Exclude a genuinely short domain
name such as `id` in the rule's `excluded` list rather than renaming it badly.

## Pick the narrowest level that reaches the real consumers

| Level         | Reaches                                                       |
| ------------- | ------------------------------------------------------------- |
| `private`     | The enclosing declaration and its extensions in the same file |
| `fileprivate` | Every declaration in the same file                            |
| `internal`    | Every file in the same module; this is the default            |
| `package`     | Every target in the same package, and nothing outside it      |
| `public`      | Any module that imports this one                              |
| `open`        | Any importing module, which may also subclass and override    |

Start at `private` and widen only when a real consumer outside that scope needs
the declaration. The foundation owns why the surface stays small.

`package` is the level for code several targets in one package share but no
consumer may import. It works because `.target(...)` sets `packageAccess: true`
by default.

`public` grants access, not inheritance. A `public class` cannot be subclassed
from another module and a `public` method cannot be overridden there; only
`open` allows both. Choose `open` when subclassing is part of the promise.

Prefer `private` over `fileprivate`. SwiftLint's `private_over_fileprivate`
flags the redundant case and `strict_fileprivate` flags every use.

## Close a class unless something extends it

Mark every class `final` unless a subclass already exists in the codebase.
`final` lets the compiler dispatch directly instead of through a vtable, and it
tells the next reader that behavior cannot change under them.

A `private` or `fileprivate` class the compiler can prove is never subclassed
gets the same dispatch, but the keyword still carries the intent.

## State the level you mean on a published surface

When the package publishes an API, enable SwiftLint's `explicit_acl` or
`explicit_top_level_acl` so an implicit `internal` never reaches review as an
undecided access level.

Put an access modifier on the `extension` when every member shares it, or on
each member when they differ. SwiftFormat's `--extension-acl` option decides
which of the two the package uses, so set it once.

## Finish

Finish when every name you added follows the Swift casing and grammar rules,
every declaration you touched sits at the narrowest level its consumers allow,
and every class you added is `final` or has a subclass in this codebase.
