# Logging

What a log record must contain and which level it belongs at. The specialization
owns the logging package and the facade.

Logs are how someone reads the system while it is running. Design them with the
care you give the code they describe.

## Log through one owned facade

Application code calls the project's own logging facade, never a logging package
directly. One facade means the sink, the format, and the level policy change in
one place.

Give every logger a name derived from its module, under one root the whole
project shares. An application embedding the project can then raise or silence
all of it with one call.

## Pick the level by who must act

| Level   | Use when                                                               |
| ------- | ---------------------------------------------------------------------- |
| Error   | The operation failed and a person must act                             |
| Warning | The operation continued through a degraded or unexpected path          |
| Info    | A significant lifecycle event happened that an operator would look for |
| Debug   | A maintainer diagnosing this code path needs the detail                |

Default to debug. Info is for events an operator would search for, not for
tracing normal control flow. An error the code already handles is a warning.

## Say what happened and what it affected

A record names the operation, its outcome, and the identifier a reader needs to
find the affected thing. `Refresh failed` sends the reader hunting;
`token refresh failed for session <id>` does not.

Pass values as arguments where the facade supports it, so the message is only
built when the level is enabled.

Log an error with its cause and stack trace attached, not flattened into the
message string.

Write for the person debugging at three in the morning with no context and no
time. Each record either helps that person act or costs them a search.

## Carry one identifier through the whole operation

Attach the same correlation identifier to every record produced by one request,
job, or user action, and pass it across process boundaries.

Someone must be able to answer "what happened to order 12345" from a single
identifier. Records that cannot be joined that way are timestamps, not evidence.

## Never log a secret or a person

Credentials, tokens, keys, authorization headers, and full request bodies stay
out of every record at every level, including debug. So do names, addresses,
contact details, precise location, and message contents.

When a reader needs to correlate records, log an identifier that means nothing
outside the system, not the underlying value.

Logs get shipped, indexed, and retained beyond the code's lifetime. Treat every
record as if it will be read by someone outside the team.

## Log once per event

Log a failure where it is handled, not at every frame it passes through.
Rethrowing after logging produces the same failure twice in the record.

## Finish

Finish when every record names its operation and outcome, sits at the level
matching who must act, carries the identifier that joins it to the rest of the
operation, holds no secret or personal data, and appears once.
