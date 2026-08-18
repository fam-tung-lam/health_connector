# detekt

detekt owns static analysis: complexity, style thresholds, naming patterns, and
bug patterns that formatting cannot see. It also owns how a finding is exempted.

## Configure the deltas, not the whole rule set

- Set `buildUponDefaultConfig = true` and check in one configuration file. The
  file then records only what this module changes, and a detekt upgrade brings
  its new rules with it.
- Point `config.setFrom(...)` at that file, and set `baseline` only when a
  baseline file exists.
- Set `build.maxIssues` to `0`. The gate is whether a finding exists, not how
  many the module tolerates.
- Restrict `source.setFrom(...)` to the module's real source roots, and exclude
  generated code with the same globs [ktlint.md](ktlint.md) uses.
- Configure `jvmTarget` on the detekt tasks so type resolution runs. Without it
  the rules that need resolved types report nothing and the gate looks clean.

## Set a threshold once, deliberately

| Rule set     | Rules that carry a threshold                                                                                                                                     |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `complexity` | `CyclomaticComplexMethod`, `CognitiveComplexMethod`, `LongMethod`, `LongParameterList`, `TooManyFunctions`, `NestedBlockDepth`, `ComplexCondition`, `LargeClass` |
| `style`      | `MaxLineLength`, `MagicNumber`, `ReturnCount`, `UnusedPrivateMember`, `UnusedPrivateClass`, `FunctionOnlyReturningConstant`                                      |
| `naming`     | `FunctionNaming`, `VariableNaming`, `ConstructorParameterNaming`, `EnumNaming`, `PackageNaming`                                                                  |
| `exceptions` | `ExceptionRaisedInUnexpectedLocation`                                                                                                                            |
| `coroutines` | `SuspendFunWithCoroutineScopeReceiver`                                                                                                                           |

A threshold applies to every file the module will ever have. Raising one to
admit today's function buys silence on all of them, so split the function first
and change the threshold only when the whole module disagrees with the default.

Turn a naming rule off only for a spelling something outside the module forces,
such as a package name a host tool requires. Write that reason in the
configuration file beside the rule.

## Exempt a finding by the smallest mechanism that fits

| Situation                                         | Mechanism                                                                       |
| ------------------------------------------------- | ------------------------------------------------------------------------------- |
| A new finding in code you are changing            | Fix the code                                                                    |
| One site that genuinely cannot satisfy the rule   | `@Suppress("RuleId")` on the smallest declaration, with the reason in a comment |
| A rule the module rejects everywhere              | Turn it off in the detekt configuration, with the reason beside it              |
| Adopting detekt on a module that already has debt | One baseline, generated once with `./gradlew detektBaseline`                    |

A baseline records the debt that existed the day the gate was switched on.
Regenerating it to make a red build green deletes the record of every issue
someone still meant to fix, and nobody notices what left the file. Never
regenerate a baseline to silence a new finding. Remove entries as you fix them,
and delete the file when it empties.

Put a `@Suppress` on the function, the class, or the property that needs it, and
never on a file or a package. Name the reason in a comment beside it, because
the rule id alone says what was silenced and not why.

When the same suppression appears a third time, stop suppressing. Either the
rule is wrong for this module, and belongs in the configuration file once with
its reason, or the shape is wrong and the code needs splitting. Decide which and
say so in the handoff.

Compiler warnings take the same discipline: `@Suppress("UNCHECKED_CAST")` sits
on the narrowest declaration that needs it and carries the reason the cast is
safe.

Finish when `./gradlew detekt` reports no finding, no baseline entry was added,
and every suppression and disabled rule names what forced it.
