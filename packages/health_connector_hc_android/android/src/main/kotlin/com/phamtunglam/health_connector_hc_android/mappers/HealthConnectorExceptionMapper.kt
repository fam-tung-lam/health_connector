package com.phamtunglam.health_connector_hc_android.mappers

import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto

/**
 * Converts a [HealthConnectorException] to a [HealthConnectorErrorDto] for cross-platform communication.
 *
 * This method aggregates comprehensive debugging information including:
 * - Exception message and code
 * - User-provided context map
 * - Underlying exception details (message, class name, stack trace)
 * - Nested cause information
 * - Debug description
 *
 * This enriched information significantly improves debugging capabilities on the Dart side.
 *
 * @return A [HealthConnectorErrorDto] containing the error code, message, and enriched details.
 */
internal fun HealthConnectorException.toDto(): HealthConnectorErrorDto {
    val details = buildMap<String, String> {
        // Include context (converting Any values to strings)
        context?.forEach { (key, value) ->
            put(key, value.toString())
        }

        // Include underlying exception information if available
        cause?.let { throwable ->
            put("cause", throwable.message ?: throwable.toString())
            put("causeType", throwable::class.simpleName ?: throwable::class.java.simpleName)

            // Include stack trace (limited to first N frames for reasonable size)
            formatStackTrace(throwable.stackTrace)?.let { stackTrace ->
                put("causeStackTrace", stackTrace)
            }

            // Include nested cause if present
            throwable.cause?.let { nestedCause ->
                put("nestedCause", nestedCause.message ?: nestedCause.toString())
                put(
                    "nestedCauseType",
                    nestedCause::class.simpleName ?: nestedCause::class.java.simpleName,
                )
            }
        }

        // Include debug description
        // Include debug description
        put(
            "debugDescription",
            "${this@toDto::class.simpleName}(code: ${code.name}, message: $message)",
        )
    }

    return HealthConnectorErrorDto(
        code = code.name,
        message = message,
        details = details.ifEmpty { null },
    )
}

private const val MAX_STACK_TRACE_FRAMES = 10

/**
 * Formats a stack trace array into a readable string, limiting to [MAX_STACK_TRACE_FRAMES] frames.
 * Returns null if the stack trace is empty.
 */
private fun formatStackTrace(stackTrace: Array<StackTraceElement>): String? {
    val formatted = stackTrace
        .take(MAX_STACK_TRACE_FRAMES)
        .joinToString("\n") { frame ->
            "  at ${frame.className}.${frame.methodName}(${frame.fileName ?: "Unknown"}:${frame.lineNumber})"
        }
    return formatted.ifEmpty { null }
}
