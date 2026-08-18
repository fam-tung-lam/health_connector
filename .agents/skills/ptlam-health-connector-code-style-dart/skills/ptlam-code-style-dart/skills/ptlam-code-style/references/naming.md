# Naming

How a name earns its place. The specialization owns the case conventions and the
suffixes its ecosystem expects.

## Names are the interface people actually read

Most readers never open the implementation. They read names and infer the rest,
so time spent on a name is repaid every time someone skims the file.

## Scale the name to its scope

`i` inside a three-line loop is fine. A module-level export has to survive being
read a thousand lines from its definition, by someone who will never open the
file that defines it.

## Name the role, not the construction

`Cache`, not `RedisHashWrapper`. `Clock`, not `SystemTimeProvider`. The
implementation changes; the role the caller depends on usually does not.

## Ban the empty names

`Manager`, `Helper`, `Processor`, `Handler`, `Data`, `Info`, and `Utils` say
that naming stopped early. Say what the thing manages or does.

`common`, `shared`, `utils`, and `misc` name a location rather than a
responsibility, so unrelated code accumulates there and eventually everything
depends on it. When a project keeps one shared area anyway, give it an entry
rule — a file arrives only once a second consumer exists — and split it out
under a real name as soon as one appears.

## One term per concept, one concept per term

If the domain says `customer`, the code does not say `client` and the database
does not say `user`. Pick the domain's word, use it in every layer, and rename
the strays in the files you already touch.

## Booleans read as assertions

`isExpired`, `hasAccess`, `canRetry`. Never negate a negative: `notDisabled`
turns every use site into a puzzle and produces bugs at review speed.

## Keep grammar consistent

Functions are verb phrases. Types are noun phrases. A predicate reads naturally
inside an `if`. Consistent grammar lets someone skim without parsing.

## Keep opposites symmetric

open/close, load/save, acquire/release, encode/decode. An asymmetric pair sends
the reader hunting for a subtlety that is not there.

## Treat a hard name as a design signal

When no name fits, the thing usually does two jobs or does not match a real
concept. Split it, or rename the concept it belongs to. Settling for a vaguer
word hides the design problem instead of solving it.

## Finish

Finish when every name you added states its role in the domain's vocabulary, no
name carries an empty suffix, and every boolean reads as a positive assertion.
