# Swift Type Choice and Immutability

Which Swift type carries a concept, how protocols express a seam, and how
mutability is spelled. The foundation owns which values the domain needs and why
immutable ones are preferred; this file owns the Swift constructs.

## Start from the value

| The concept needs                                         | Use                  |
| --------------------------------------------------------- | -------------------- |
| To be defined entirely by its contents                    | `struct`             |
| A closed set of cases the compiler can check exhaustively | `enum`               |
| A namespace that must never be instantiated               | `enum` with no cases |
| Identity, or inheritance a framework requires             | `final class`        |
| Mutable state several concurrent callers reach            | `actor`              |

Reach past `struct` only for a stated reason. A class is right when two
references must observe the same mutation, when the type must be
`AnyObject`-constrained, or when an Objective-C API requires a class.

A case-less `enum` is the only Swift namespace that cannot be instantiated by
accident; SwiftFormat's `--enum-namespaces` option converts a struct used that
way. An `actor` is a class with enforced isolation, and the concurrency
reference owns its rules.

## Spell immutability with `let`

- Declare every binding `let` and change it to `var` only after you write the
  reassignment.
- A stored property that never changes after `init` is `let`, which also lets
  the compiler skip the setter and lets the memberwise initializer require it.
- Mark a method `mutating` only when it actually writes to `self`. The value of
  the keyword is that a `mutating` method is unavailable through a `let`
  binding, which is how a struct's immutability becomes enforceable.
- A published value type exposes `let` stored properties and an initializer that
  takes them all. Offer change as a method that returns a new value rather than
  a settable property.
- Prefer `map`, `filter`, and `reduce` over building a result in a `var`
  accumulator, so the binding stays `let`.

## Define a protocol for a seam that has two sides

Add a protocol when more than one real implementation exists, counting a test
double as one. A protocol with a single conformer and no double is indirection
without a seam.

- Use an `associatedtype` when the conformer chooses the type, and constrain it
  in the protocol rather than at every use site.
- Use `some P` for an opaque parameter or return type; the compiler keeps the
  concrete type and dispatches directly.
- Use `any P` only when the value must be stored or collected heterogeneously.
  It boxes the value and dispatches dynamically. Enabling the `ExistentialAny`
  upcoming feature makes each of those costs explicit in the source.

A method declared **only** in a protocol extension is dispatched statically. A
conformer that defines its own version is ignored when the call goes through
`any P`. Declare the method as a protocol requirement whenever a conformer is
allowed to replace it, and keep extension-only methods to conveniences no
conformer should override.

## Add behavior with an extension

Put each conformance in its own `extension` so the file shows what the type
promises and where each promise is satisfied. Extend a type instead of
subclassing it, and extend a protocol instead of adding a base class.

## Finish

Finish when each type you added is the least powerful one that carries its
concept, every binding that is never reassigned is `let`, every protocol you
added has at least two conformers, and no conformer silently loses to a protocol
extension.
