# Reading Code Up Close

How a function reads to someone holding no context. The specialization owns the
language constructs that spell each rule.

## One screen, one held thought

A function fits in a screen and in one thought. The limit is not a line count:
it is whether a reader can still hold the beginning while reading the end.

## One level of abstraction per function

Do not mix "charge the customer" with byte shuffling in one body. Mixed
altitudes make the reader refocus on every line, which is where they start
skipping lines.

## Put the story first

High-level flow at the top of the file, supporting detail below it. A reader
should be able to stop as soon as they know enough.

## Keep the happy path down the left margin

Handle the exceptional cases first with guard clauses and early returns, then
let the main path run unindented to the end. Nesting the success case inside
three conditions hides the thing the file exists for.

## Keep the reader's mental stack small

Deep nesting plus mutable state forces someone to simulate execution in their
head, which is the most expensive thing you can ask of a reader. Prefer
straight-line flow and values that do not change underneath them.

## Say it in the code, not around it

No hidden global mutation, no action at a distance, no behavior that depends on
a setting three repositories away. When understanding a line needs invisible
context, make that context an argument.

## Let the tool own formatting

The repository's formatter decides whitespace, wrapping, and quotes. Run it,
take its output, and never spend a review comment on it.

## Match the code you are standing in

Local consistency beats personal preference. When the surrounding file uses a
convention you dislike, follow it and raise the convention separately. A file
with two styles costs more than either style alone.

## Finish

Finish when each function you touched holds one level of abstraction, its happy
path runs unindented, and nothing it does depends on context the reader cannot
see from the file.
