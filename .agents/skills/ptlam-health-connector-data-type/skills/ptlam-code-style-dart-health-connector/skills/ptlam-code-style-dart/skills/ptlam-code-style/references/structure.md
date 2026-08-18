# Source Tree Structure

Where code lives, and how a directory listing reads to someone who arrived
today. The specialization owns the directory names a framework requires.

## Name the top level after the domain

`billing/`, `scheduling/`, `ingest/` — not `controllers/`, `services/`, or
`models/`. The top-level listing should teach a newcomer what the system does,
not which framework built it.

Layer names belong inside a capability, where the framework needs them, never at
the level that describes the product.

## Use the words the team uses

If people say "the reconciliation job" in standup, something in the tree is
called reconciliation. Every gap between the spoken word and the written one is
paid again in every conversation, review, and incident.

When the domain renames a concept, rename the code in a change of its own.

## Leave one obvious front door

Someone new should find the entry point and follow the main flow outward without
asking anyone. Keep one entry point per runnable thing, and keep it thin enough
to read in a single screen.

## Keep each listing readable at its own level

A directory is a table of contents. Aim for roughly five to nine meaningful
entries per level, each named after what it holds.

Add a directory when its first real file needs it. An empty layer tree invites
files that do not belong, and a directory holding one file is a rename waiting
to happen.

## Match nesting to conceptual depth

Depth mirrors how the domain nests, not how careful the author felt. Seven
directories holding three files charge every reader seven decisions and return
nothing.

## Keep what changes together, together

Files that keep appearing in the same commit belong next to each other. Distance
in the tree should track conceptual distance, so a change lands in one place
instead of six.

## Make a capability deletable

Removing a feature should mean deleting its directory and the one place that
registers it. When removal turns into archaeology, the boundary is in the wrong
place — see [boundaries.md](boundaries.md).

## Prefer the structure people guess correctly

A tree someone can predict beats a better one they must learn. Uniformity is
what makes the tenth capability cheaper than the first; spend the invention on
the problem the product actually has.

## Keep the README about this repository

The README says what this is, how to run it, how to test it, where the main
pieces are, and who to ask. Everything else belongs in the document that owns
it.

## Finish

Finish when the top level names the domain, every new file sits with what it
changes with, each listing reads at its own level, and a capability can be
removed by deleting its directory and its registration.
