# Documentation and Comments

What belongs in a doc comment, and what an explanatory comment is for. The
specialization owns the doc-comment syntax and the tool that renders it.

## Document every public symbol

A doc comment on a public symbol states what the caller gets, not how the code
works. Cover:

- what it does, in the domain's language;
- every parameter, including what an invalid one does;
- what it returns, and what an empty or absent result means;
- every error or exception a caller can catch; and
- any constraint the signature cannot express — ordering, lifetime, threading,
  or the cost of calling it.

Add a short example only when the signature alone leaves the usage ambiguous.

Skip the doc comment on an internal symbol whose name and signature already say
everything. Write one the moment it does not.

## Explain why, not what

The code says what it does. A comment earns its place by saying why it does it
that way: the constraint, the bug, the ordering requirement, or the rejected
alternative that is invisible from the code.

A comment that restates the line below it goes stale silently and helps nobody.
Delete it.

## Mark a deliberate deviation

Anything that breaks the local pattern announces itself where it lives. Name the
rule it departs from and what forced the departure, in a comment beside the code
that surprises the reader.

A reader who meets the exception without the reason will either copy it into the
next file or "fix" it back. The note is worth more than the rule it breaks.

## Do not link out of the codebase

No links to issues, pull requests, design docs, or specifications inside a
comment. They rot faster than the code, and a reader who cannot open the link is
left with nothing.

Put the reasoning in the comment itself. Put the link in the pull request, where
it has a date and an audience.

## Mark what will go stale

When a comment records a version, a vendor behavior, an external contract, or a
deadline, say when it was true and how a reader can tell it no longer is.

## Keep comments true

A comment is part of the change. When you change the behavior it describes,
update it in the same edit or delete it. A wrong comment costs more than no
comment.

Do not leave commented-out code. Version control already remembers it.

## Finish

Finish when every public symbol you touched documents its contract, every
remaining comment explains a reason the code cannot, and nothing you changed
left a stale description behind.
