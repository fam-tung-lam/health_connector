# Kotlin Functions

How a Kotlin function states its contract, takes its arguments, and uses the
scope functions without hiding what it does.

## Write the body the shortest honest way

- Use an expression body when the function is one expression:
  `internal fun SortOrder.isAscending(): Boolean = this == TIME_ASCENDING`.
- Declare the return type explicitly on every declaration that is not `private`.
  An inferred public return type changes silently when someone edits the body,
  and the change reaches consumers without appearing in the diff.
- Use a block body as soon as the function needs a statement, a guard, or a
  local name a reader will thank you for.

Kotlin spells a guard clause as `?: return`, an early `return`, or a `require`
call. [null-safety.md](null-safety.md) owns the nullable form and
[errors.md](errors.md) owns the failing form.

## Prefer a default argument to an overload

- Give an optional parameter a default value instead of adding an overload. One
  declaration then carries the whole contract, and KDoc has one place to live.
- Use named arguments at the call site as soon as two parameters share a type,
  or any argument is a bare boolean. `buildClient(supportsExtension = false)`
  survives a parameter reorder that `buildClient(false)` does not.
- Put a lambda parameter last so callers can use trailing-lambda syntax.
- When the parameter list reaches detekt's `LongParameterList` threshold, group
  the parameters that always travel together into a type rather than raising the
  threshold. [data-modeling.md](data-modeling.md) owns that type.

## Use an extension to add a verb to a type you do not own

Declare an extension function where the calling code lives, and keep it
`internal` or `private` unless it is part of the module's published surface.

An extension is resolved statically on the declared type of the receiver. It
cannot override a member, and a member with the same signature always wins. Do
not use one to try to change the behaviour of an existing type.

Never write an extension on a type your module owns when a member would do. The
member is discoverable from the class; the extension is discoverable only by
someone who already knows it exists.

## Pick the scope function by what it returns

| Function | Receiver is | Returns       | Use it for                                             |
| -------- | ----------- | ------------- | ------------------------------------------------------ |
| `let`    | `it`        | Lambda result | Acting on a nullable after `?.`, or mapping to a value |
| `run`    | `this`      | Lambda result | Computing a value from the receiver's own members      |
| `apply`  | `this`      | The receiver  | Configuring an object you just built                   |
| `also`   | `it`        | The receiver  | A side effect on a value that passes straight through  |
| `with`   | `this`      | Lambda result | Several calls on one non-null receiver                 |

Rules that keep the table usable:

- One scope function per expression. Never nest two, because the reader then has
  to track which `this` or `it` belongs to which receiver.
- Name the lambda parameter when `it` is not obvious from one line away.
- Never use `apply` or `also` for work whose result matters. Their return value
  is the receiver, so a computed result silently disappears.
- Reach for a plain local `val` whenever it reads better than any of the five. A
  scope function is a tool for chaining, not a style requirement.

Finish when each function you touched declares its non-private return type,
needs no overload a default argument would replace, and uses at most one scope
function per expression.
