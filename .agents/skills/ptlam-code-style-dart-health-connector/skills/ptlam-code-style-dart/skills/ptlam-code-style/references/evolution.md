# Changing Code Over Time

How today's change leaves the code for the twentieth one. The specialization
owns the migration, deprecation, and release tooling.

## Optimize the change you will make twenty times

Find the axis the work actually moves along — a new payment method, a new
report, a new locale — and make that one cheap. A structure tuned for a change
nobody repeats charges rent on every change somebody does.

## Wait for the third case before abstracting

Two similar blocks are a coincidence. The third shows the shape. A wrong
abstraction costs far more than duplication, because duplication is visible and
load-bearing abstractions are not.

## Spend deliberation on what you cannot undo

A stored data format, a published API, and an identifier scheme deserve a week.
A folder layout, an internal name, and a private helper deserve a decision and a
move on. Ask what reversal would cost, then spend accordingly.

## Migrate in parallel

Expand, migrate, contract: add the new shape beside the old one, move readers
and writers across, then remove the old one when nothing uses it. Every
intermediate state ships. A big-bang switch is a rollback you cannot perform.

Keep the reverse of each step available and practiced: one command to release,
one to roll back. Heroics during an incident mean the tooling failed before the
incident started.

## Keep the refactor out of the behavior change

A diff that both moves code and changes what it does is unreviewable and
unrevertable. Restructure in one commit, change behavior in the next, and say
which is which.

## Record what forced the decision

When a choice constrains the future — a format, a boundary, a dependency — write
down what you chose, what you rejected, and what forced it. Apply
`ptlam-creating-adr` to decide whether the choice warrants the repository's
architecture decision record. The code survives; the reasoning evaporates in
about six months.

## Finish

Finish when the frequent change is the cheap one, every new abstraction has a
third case behind it, each migration ships in stages, and any constraining
decision is written down with its cause.
