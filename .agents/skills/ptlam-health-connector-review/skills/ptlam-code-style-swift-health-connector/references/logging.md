# Native Swift Logging

This reference owns the project-specific Swift log call shape.

Call `HealthConnectorLogger.debug`, `.info`, `.warning`, or `.error` with the
same named arguments:

```swift
HealthConnectorLogger.error(
    tag: Self.tag,
    operation: "readRecord",
    message: "Failed to read record",
    context: ["data_type": request.dataType],
    exception: error,
)
```

| Argument    | Content                                                                                       |
| ----------- | --------------------------------------------------------------------------------------------- |
| `tag`       | `Self.tag` from `Taggable`, or the established concrete-type fallback in a protocol extension |
| `operation` | One stable method or operation name across start, success, and failure logs                   |
| `message`   | A sentence about the event; no interpolated exception or health value                         |
| `context`   | Small counts, data types, spans, and flags with new keys in `snake_case`                      |
| `exception` | The original `Error` on a failure record                                                      |

Use `debug` at operation start, `info` on success, `warning` for a degraded but
recoverable outcome, and `error` where a failure is propagated. Follow the
operation-name style in the edited layer rather than renaming unrelated logs.

Never include measured health values, record identifiers, user-owned dates,
source device names, or other identifying data. Swift logs go to the device log
and may also cross Pigeon into Dart.

Logging may be disabled. Keep every argument side-effect-free and never read a
log outcome to decide control flow.
