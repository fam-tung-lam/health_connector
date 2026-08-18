# Boundaries and Dependencies

What a unit publishes, which way dependencies run, and what belongs on each side
of a seam. The specialization owns how the language spells each boundary.

## Publish a small surface

A new symbol, file, or module stays internal until a consumer outside its own
unit needs it. Widening later is cheap. Narrowing after someone depends on it is
not.

Each unit publishes through one entry point — an export file, a package index,
an explicit export list. Reaching past that entry point into an implementation
file is a defect even when the language allows it.

What you export is a promise. What you keep unexported is yours to change today,
and that freedom is the whole reason the boundary exists.

## Draw the seam where the work splits

Put a boundary where responsibility for the work divides, not where the nouns
divide. A seam that cuts across how people actually divide the work gets
violated within a quarter, and that violation is an honest signal about the
seam.

## Depend in one direction

State which way dependencies flow between layers or packages, and keep every
import consistent with it. An outer layer may know about an inner one; an inner
layer never imports its caller.

Domain logic knows nothing about HTTP, SQL, queues, or file formats. When every
arrow points inward, you can read one layer without holding the others in your
head.

## Never keep a cycle

A cycle silently merges the modules it joins into one unit that can no longer be
tested, reasoned about, or deleted separately. It says the boundary is in the
wrong place, not that the tool needs configuring.

Move the shared concept to a unit both may depend on, or merge the two.

## Push I/O to the edges

Keep decisions in the middle and effects at the rim. Computing a result and
reading or writing the world are different jobs; separating them is what makes
the middle testable without a harness.

## Wrap a third-party library in your own words

Give an external library a thin adapter that speaks the domain's vocabulary: a
seam you can swap, not a second framework. Convert the library's types and
errors at that adapter so nothing above it names the vendor.

## Duplicate rather than couple through a seam

Removing duplication is a virtue inside a module. Across a boundary, a little
copied code is often the correct price for independence — the copy is visible,
while the shared dependency introduced to avoid it is not.

## Give every piece of state one owner

Exactly one module owns each piece of state and the invariants that protect it.
Everyone else asks that owner. Shared ownership means nobody can say what is
true.

## Finish

Finish when every new symbol is as narrow as its real consumers allow, every
consumer reaches it through a published entry point, no dependency runs against
the declared direction, and each piece of state names one owner.
