# Contracts Across a Boundary

What you promise to something you cannot change in the same commit: another
process, another team, or a released version. The specialization owns the
transport, the schema format, and the versioning tool.

## Write the shape down and version it

Anything crossing a process, team, or release boundary has an explicit written
shape and a version. Consumers you have never met depend on it, and their
upgrade schedule is not yours.

## Change additively

Adding a field is safe. Deprecating one is manageable. Repurposing an existing
field is how you break the consumer nobody knew about, silently, in production.

## Validate once, at the edge

Check input where it enters, reject it with a message that names what was wrong,
and let the inside trust it. The same check repeated in every layer is noise
that hides where the real gate is.

## Make the safe path the easy one

The default value, the default call, and the shortest correct usage are the safe
ones. When doing the right thing requires remembering an extra argument, the
wrong thing ships.

## Make a repeated request boring

Anything crossing a network will be retried by a client, a proxy, or an
operator. Give a write a natural key or an idempotency key so a duplicate
returns the original outcome instead of creating a second one.
[errors.md](errors.md) owns the retry policy on the calling side.

## Bound every collection

Design paging, a maximum page size, filtering, and a stable order when the
operation is created. "It returns all of them" is a design that expires quietly
the first time real data arrives.

## Name the capability, not the consumer

`checkout/v2`, not `mobile-endpoint`. A consumer-named surface multiplies until
every client owns a private copy of the system and no change is safe anywhere.

## Put one real example beside the schema

Show one concrete request and one concrete response next to the specification.
People pattern-match from an example far faster than they parse a type
definition, and a stale example is caught the first time someone runs it.

## Finish

Finish when every crossing has a written versioned shape, no released field
changed meaning, every collection is bounded, and a retried write produces one
outcome.
