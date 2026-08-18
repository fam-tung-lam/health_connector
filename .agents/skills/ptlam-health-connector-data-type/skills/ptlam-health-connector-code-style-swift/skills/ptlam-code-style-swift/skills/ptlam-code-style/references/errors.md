# Failure and Recovery

How code fails, what it says when it does, and what it does about someone else's
failure. The specialization owns the exception, result, or error-value
mechanics.

## Design the error as part of the interface

A caller can only handle what you hand them. Name each failure for what
happened, carry the identifier of the affected thing, and make the message say
what to do next. "Something went wrong" hands the problem back to the reader
unchanged.

## Decide each dependency's failure mode now

For every dependency, decide what happens when it is slow, down, or wrong before
shipping the call. Unspecified means unpredictable, and production picks for you
at the worst moment.

## Fail fast at startup

Missing or invalid configuration stops the process immediately, with a message
naming the setting. A process that starts anyway surfaces the same problem three
hours into a batch job, far from its cause.

## Separate an expected outcome from a bug

"Card declined" is business flow. "Column missing" is an alarm. Conflating them
teaches everyone to ignore both: the expected outcome belongs in the return
type, and the bug belongs in the alert.

## Never swallow a failure

Handle it, or add context and let it travel on. An empty catch is a decision to
be confused later, and it is nearly invisible in review. Record the failure
once, where it is handled — [logging.md](logging.md) owns the record.

## Bound every retry

Every remote call gets a timeout. Every retry gets exponential backoff with
jitter and a budget that stops it. Retry only what the other side made safe to
repeat, as [contracts.md](contracts.md) requires. Unbounded retries turn someone
else's hiccup into an outage you caused.

## Prefer a clean crash to a limping process

A predictable death with a clean restart beats a process quietly writing corrupt
data for six hours. When an invariant is gone, stop instead of continuing on a
guess.

## Finish

Finish when every failure a caller can act on is named and typed, every remote
call is bounded by a timeout and a retry budget, invalid configuration stops
startup, and no path discards a cause.
