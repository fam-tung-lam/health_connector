# Swift Documentation Comments

The `///` syntax, its callouts, and the rule for which declarations require one.
The foundation owns what a doc comment must say; this file owns how Swift spells
it.

## Write the summary, then the callouts

```swift
/// Parses a TCP port from decimal text.
///
/// The text must contain no sign, separator, or surrounding whitespace.
///
/// - Parameters:
///   - text: The decimal text to parse.
///   - allowReserved: Whether ports below 1024 are accepted.
/// - Returns: The parsed port.
/// - Throws: ``PortParseError/outOfRange(value:)`` when the number does not
///   fit a port.
public func parsePort(from text: String, allowReserved: Bool) throws -> UInt16
```

- One summary sentence comes first, on its own line, ending with a period.
- A blank `///` line separates the summary from the discussion.
- Use `- Parameter name:` for a single parameter and the indented
  `- Parameters:` list for two or more. Do not mix the two forms in one comment.
- `- Returns:` and `- Throws:` come after the parameters.
- Continue a long callout with an indented line, not a new `- Returns:`.

Link another symbol with double backticks, as in `PortParseError`. A path after
a slash reaches a member, as in `PortParseError/outOfRange(value:)`. A link that
does not resolve produces a documentation build warning, so it is checkable in a
way prose is not.

The `/** ... */` block form is also valid. Pick one form per package and stay
with it; SwiftFormat's `--doc-comments` option moves a doc comment onto the
declaration it documents.

## Document what the package publishes

| Declaration                                              | Doc comment |
| -------------------------------------------------------- | ----------- |
| `open` and `public`                                      | Required    |
| `package`, when another target calls it                  | Required    |
| `internal`, when the name and signature leave a question | Required    |
| `private`, and any member whose contract is its name     | Optional    |

Enable SwiftLint's `missing_docs` and give it the levels the package promises,
such as `warning: [open, public]`. Its `excludes_extensions` and
`excludes_inherited_types` keys control whether an extension or a conformance
also needs one, and `excludes_trivial_init` covers a parameterless `init`.

Document what the caller gets, not how the body works — a comment that restates
the signature has no reader and goes stale unnoticed. The foundation owns that
rule and the separate purpose of an explanatory comment.

## Keep `MARK` out of the contract

`// MARK: -` divides a file for the jump bar. It is navigation, not
documentation, and it never substitutes for a `///` comment on a published
declaration. SwiftFormat's `--mark-types` and `--extension-mark` options
generate and maintain them, so hand-written marks drift from the generated ones.

## Finish

Finish when every published declaration you touched carries a `///` comment
whose parameters, return, and thrown errors match the signature, every symbol
link resolves, and SwiftLint's `missing_docs` reports nothing at the package's
declared levels.
