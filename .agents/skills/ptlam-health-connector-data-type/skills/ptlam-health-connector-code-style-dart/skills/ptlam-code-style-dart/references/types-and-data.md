# Dart Types, Constants, and Data Classes

Which Dart keyword carries a value, and how a domain type spells equality,
exhaustiveness, and copying.

## Bind with `final`, and reach for `const`

| Keyword | Use for                                                               |
| ------- | --------------------------------------------------------------------- |
| `const` | A value the compiler can build, canonicalized and shared at every use |
| `final` | A binding assigned once at runtime                                    |
| `var`   | A binding that genuinely gets reassigned                              |

Default to `final` for every local, parameter, and field. Promote to `const`
wherever the analyzer accepts it: a `const` value is created once for the whole
program rather than on every call.

A `const` constructor requires every field to be `final`; the analyzer reports
`const_constructor_with_non_final_field` otherwise. That constraint is the point
— it is how Dart proves the value cannot change after construction.

## Annotate the surface, infer the inside

Declare the parameter and return types of every public declaration, and the type
of every field. Omit the annotation on a local whose initializer already states
it, which `omit_local_variable_types` enforces.

Never write `dynamic`. It disables every check the analyzer could make, and
`avoid_dynamic_calls` only catches the call sites, not the spread. When a value
is genuinely unknown, type it `Object?` and narrow it where you read it:

```dart
final Object? raw = payload['total'];
if (raw is num) {
  return Money(raw.toInt(), 'EUR');
}
```

The three strict language modes close the routes by which `dynamic` returns
implicitly.

Use `?` only where absence is a real state of the domain. A nullable type
obliges every reader to answer for the null, so prefer an empty collection to a
nullable one.

## Close the hierarchy with a class modifier

| Modifier    | Says                                                                 |
| ----------- | -------------------------------------------------------------------- |
| `sealed`    | Every subtype is in this library, so a `switch` over it is checkable |
| `final`     | No one may extend, implement, or mix in this class                   |
| `interface` | Others may implement it, not extend it                               |
| `base`      | Every subtype must itself be `base`, `final`, or `sealed`            |

Make a closed set of states a `sealed` class and match it with a `switch`
expression carrying no default branch. The analyzer then reports
`non_exhaustive_switch_expression` at compile time in every place a new variant
must be handled:

```dart
sealed class Shape {}

final class Circle extends Shape {}

final class Square extends Shape {}

String describe(Shape shape) => switch (shape) {
  Circle() => 'circle',
  Square() => 'square',
};
```

A default branch, or a `_` wildcard, throws that check away and lets the new
variant ship unhandled.

Use an `enum` for a closed vocabulary with no per-variant data. An enhanced enum
carries fields, a `const` constructor, and methods, which covers a fixed lookup
table without a class. Reach for `sealed` once a variant needs data the others
do not have.

## Equality, copying, and anonymous shapes

Override `==` and `hashCode` together — `hash_and_equals` fails either one alone
— and only on a type annotated `@immutable` from `package:meta`, which
`avoid_equals_and_hash_code_on_mutable_classes` checks. Build the hash with
`Object.hash(a, b, …)` or `Object.hashAll` rather than combining fields by hand.

Give a value type a `copyWith` whose parameters are all named and all nullable,
so a caller names only what changes. Say in the doc comment what an omitted
argument does, because `amount ?? this.amount` cannot distinguish "not passed"
from "explicitly null"; when a field must be settable to null, give it its own
sentinel parameter rather than pretending otherwise.

Use a record, such as `(int, String)`, for an anonymous multi-value return that
never leaves the library. It already has structural equality and needs no
declaration. Give the shape a named type the moment it crosses a public boundary
or acquires a rule.

Generated data classes are an alternative to writing this by hand. Whichever
generator a project uses, it owns the same four things: equality, `hashCode`,
`copyWith`, and the sealed union.

## Finish

Finish when every binding you added is `final` or `const`, no signature mentions
`dynamic`, each closed state set is `sealed` and matched without a default
branch, and every type overriding `==` also overrides `hashCode` and is
immutable.
