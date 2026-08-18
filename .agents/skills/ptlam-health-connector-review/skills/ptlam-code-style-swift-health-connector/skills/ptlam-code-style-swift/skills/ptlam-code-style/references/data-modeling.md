# Data and Domain Modeling

How the domain's values are shaped before storage or transport touches them. The
specialization owns the type system, the data-model library, and the
serialization mechanics.

This reference owns domain types in code. `ptlam-modeling-domain` owns shared
business language, context boundaries, and business process maps. Use its terms
as evidence, then express them with the code types owned here.

## Model the domain, then persist it

Shape the core types around what the business means, then map them to storage.
When the table layout shapes the type, every business rule ends up written in
the vocabulary of the database.

## Let types carry the contract

Types are the cheapest documentation there is. `UserId` and `OrderId` are not
both "string", and money is not a float. Encode identity, unit, and currency so
the checker catches what review will not.

## Prefer immutable values

A value that cannot change is one you can pass, cache, and reason about without
tracing who touched it last. Reserve mutability for state that genuinely
evolves, and give that state one owner — see [boundaries.md](boundaries.md).

## Keep one source of truth

Store a fact once and derive the rest. Every copy is a future inconsistency with
a date on it, because the second writer never knows about the first.

## Make time explicit

Distinguish an instant from a calendar date, and event time from processing
time. Carry the zone. A bare "date" is a bug waiting for a daylight-saving
change to surface it, usually during the busiest hour of the year.

## Represent absence honestly

No `-1`, no empty string, no `1970-01-01` standing in for "we do not know". A
sentinel escapes into reports and dashboards years later, and by then nobody
remembers it was a placeholder.

## Name the legal states

Four booleans imply sixteen states, of which perhaps three are legal. Name those
three and let one type carry them.

Make an illegal state unrepresentable before defending against it with
validation. Structure that cannot be wrong beats a guard that catches wrongness
in one of the places it can occur.

## Split persistence from the domain when the shapes disagree

Keep one shape while the domain and the stored record still agree. Split them at
the moment they stop agreeing: a premature second model is ceremony, a deferred
one is a rewrite.

A specialization may require the split earlier at a boundary whose shape someone
else owns, such as a vendor's wire format.

## Finish

Finish when every value states its unit and identity in its type, absence is
representable without a sentinel, the legal states are named, and each fact is
stored in exactly one place.
