# Dart Documentation Conventions

This reference owns the shape of Health Connector public doc comments. The
general Dart guidance owns dartdoc syntax and the shared code-style foundation
owns what deserves documentation.

Open with one sentence naming the declaration, then add only the applicable
sections in this order:

| Section               | Use when                                                          |
| --------------------- | ----------------------------------------------------------------- |
| `## Platform Mapping` | The symbol maps to named Health Connect or HealthKit types        |
| `## Capabilities`     | A data type exposes a subset of read, write, aggregate, or delete |
| `## Parameters`       | Named parameters need contract detail                             |
| `## Returns`          | The signature does not express the full result                    |
| `## Throws`           | A caller can receive a named exception or error                   |
| `## Example`          | Assembly or call order would otherwise be ambiguous               |
| `## See also`         | A paired type, alternative, or enforcing annotation matters       |

Parameter and throw sections use `- [name]: ...` bullets. A throw entry names
the exact type and condition. Platform differences belong on the member that
exposes them, not only in a library comment.

Close exported comments with one configured `{@category ...}` tag: `Core API`,
`Health Records`, `Permissions`, `Exceptions`, `Logging`, or `Annotations`. Add
a new category, its topic file, and dartdoc configuration before using a new
tag.

Every public type and member carries its historical `@sinceVx_y_z` annotation.
Use `/// @nodoc` for an exported internal helper that must satisfy documentation
lints without appearing in generated docs.

`comment_references` requires each `[Symbol]` to resolve. Dartdoc also treats
broken links as errors. Run strict analysis after a rename and
`melos run doc:generate` after a public documentation change.
