package com.phamtunglam.health_connector_hc_android.logger

import android.util.Log
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger.MAX_CACHED_INDENT_DEPTH
import java.util.Locale

/**
 * A singleton logger that wraps Android's [android.util.Log] class.
 *
 * This logger provides a consistent structured logging interface with
 * formatted messages across the plugin. It supports structured logging with
 * operation, phase, optional message, and context.
 */
internal object HealthConnectorLogger {
    /**
     * Whether logging is enabled.
     *
     * When set to `false`, all logging methods will return immediately without
     * logging any messages. Defaults to `true`.
     */
    var isEnabled: Boolean = true
        private set

    /**
     * Sets whether logging is enabled.
     *
     * When set to `false`, all logging methods will return immediately without
     * logging any messages.
     *
     * @param enabled Whether to enable logging.
     */
    @Suppress("unused")
    fun setEnabled(enabled: Boolean) {
        isEnabled = enabled
    }

    /**
     * Base indentation unit (4 spaces).
     */
    private const val INDENTATION = "    "

    /**
     * Maximum depth for cached indentation strings.
     */
    private const val MAX_CACHED_INDENT_DEPTH = 10

    /**
     * Cached indentation strings for depths 0 to [MAX_CACHED_INDENT_DEPTH].
     *
     * Pre-computed to avoid repeated string concatenation during formatting.
     */
    private val indentCache: List<String> = (0..MAX_CACHED_INDENT_DEPTH).map { depth ->
        INDENTATION.repeat(depth + 1)
    }

    /**
     * Gets the indentation string for the given depth.
     *
     * Uses cached values for depths up to [MAX_CACHED_INDENT_DEPTH],
     * otherwise computes the indentation string dynamically.
     *
     * @param depth The nesting depth (0 for top-level).
     * @return The indentation string for the given depth.
     */
    private fun getIndent(depth: Int): String = if (depth <= MAX_CACHED_INDENT_DEPTH) {
        indentCache[depth]
    } else {
        INDENTATION.repeat(depth + 1)
    }

    /**
     * Recursively formats a value with proper indentation based on
     * nesting depth, writing directly to the provided buffer.
     *
     * Handles maps, lists, and other types. Maps and lists are formatted with
     * increasing indentation for each nesting level.
     *
     * @param buffer The StringBuilder to write the formatted value to.
     * @param value The value to format (can be a map, list, or any other type).
     * @param depth The current nesting depth (0 for top-level, increases with nesting).
     */
    private fun formatValueTo(buffer: StringBuilder, value: Any?, depth: Int) {
        val currentIndent = getIndent(depth)
        val nextIndent = getIndent(depth + 1)

        // Handle maps
        if (value is Map<*, *>) {
            if (value.isEmpty()) {
                buffer.append("{}")
                return
            }
            buffer.append("{\n")
            var isFirst = true
            for ((key, mapValue) in value) {
                if (!isFirst) {
                    buffer.append("\n")
                }
                isFirst = false
                buffer.append("$nextIndent$key: ")
                formatValueTo(buffer, mapValue, depth + 1)
                buffer.append(",")
            }
            buffer.append("\n$currentIndent}")
            return
        }

        // Handle lists
        if (value is List<*>) {
            if (value.isEmpty()) {
                buffer.append("[]")
                return
            }
            buffer.append("[\n")
            var isFirst = true
            for (element in value) {
                if (!isFirst) {
                    buffer.append("\n")
                }
                isFirst = false
                buffer.append(nextIndent)
                formatValueTo(buffer, element, depth + 1)
                buffer.append(",")
            }
            buffer.append("\n$currentIndent]")
            return
        }

        // Handle other types - convert to string
        buffer.append(value.toString())
    }

    /**
     * Formats a structured log message in JSON-like format.
     *
     * Creates a formatted message with indentation, including
     * only non-null fields.
     *
     * @param operation The operation being performed (e.g., 'readRecords').
     * @param phase The phase of the operation (e.g., 'entry', 'completed').
     * @param message Optional message to include in the log.
     * @param context Optional map of contextual information.
     * @param exception Optional exception object.
     * @param stackTrace Optional stack trace.
     * @return A formatted string in JSON-like format with indentation.
     */
    private fun formatStructuredMessage(
        operation: String,
        phase: String,
        message: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
        stackTrace: Array<StackTraceElement>? = null,
    ): String {
        val buffer = StringBuilder()

        // Always include operation
        buffer.appendLine("{")
        buffer.append("${getIndent(0)}operation: $operation,")

        // Include phase if provided
        buffer.append("\n${getIndent(0)}phase: $phase,")

        // Include message if provided
        if (message != null) {
            buffer.append("\n${getIndent(0)}message: $message,")
        }

        // Include exception block if exception or stackTrace is provided
        if (exception != null || stackTrace != null) {
            buffer.append("\n${getIndent(0)}exception: {")
            if (exception != null) {
                buffer.append("\n${getIndent(1)}cause: $exception,")
            }
            if (stackTrace != null) {
                val stackTraceString = stackTrace.joinToString("\n") { it.toString() }
                buffer.append("\n${getIndent(1)}stack_trace: $stackTraceString,")
            }
            buffer.append("\n${getIndent(0)}},")
        }

        // Include context if provided and not empty
        if (context != null && context.isNotEmpty()) {
            buffer.append("\n${getIndent(0)}context: {")
            for ((key, value) in context) {
                buffer.append("\n")
                buffer.append("${getIndent(1)}$key: ")
                formatValueTo(buffer, value, 1)
                buffer.append(",")
            }
            buffer.append("\n${getIndent(0)}},")
        }

        buffer.append("\n}")

        return buffer.toString()
    }

    /**
     * Internal method that formats and logs the message.
     *
     * Handles all logging logic including enabled check, message formatting,
     * and output. Formats the message according to the specified format:
     * ```
     * {
     *    operation: {operation},
     *    phase: {phase},
     *    message: {message},
     *    exception: {
     *      cause: {exception},
     *      stack_trace: {stackTrace},
     *    },
     *    context: {
     *      key1: value1,
     *    },
     * }
     * ```
     *
     * Note: DateTime and log level are provided by Android's Log class
     * and are not included in the message.
     *
     * @param level The log level (DEBUG, INFO, WARNING, ERROR).
     * @param tag The tag for categorizing the log entry (converted to uppercase).
     * @param operation The operation being performed.
     * @param phase The phase of the operation.
     * @param message Optional message to include in the log.
     * @param context Optional contextual information.
     * @param exception Optional exception object.
     */
    private fun log(
        level: LogLevel,
        tag: String,
        operation: String,
        phase: String,
        message: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
    ) {
        if (!isEnabled) {
            return
        }

        val stackTrace = exception?.stackTrace
        val structuredMessage = formatStructuredMessage(
            operation = operation,
            phase = phase,
            message = message,
            context = context,
            exception = exception,
            stackTrace = stackTrace,
        )

        val uppercaseTag = tag.uppercase(Locale.US)

        // Use Android Log with exception parameter when exception is provided
        when (level) {
            LogLevel.DEBUG -> {
                if (exception != null) {
                    Log.d(uppercaseTag, structuredMessage, exception)
                } else {
                    Log.d(uppercaseTag, structuredMessage)
                }
            }

            LogLevel.INFO -> {
                if (exception != null) {
                    Log.i(uppercaseTag, structuredMessage, exception)
                } else {
                    Log.i(uppercaseTag, structuredMessage)
                }
            }

            LogLevel.WARNING -> {
                if (exception != null) {
                    Log.w(uppercaseTag, structuredMessage, exception)
                } else {
                    Log.w(uppercaseTag, structuredMessage)
                }
            }

            LogLevel.ERROR -> {
                if (exception != null) {
                    Log.e(uppercaseTag, structuredMessage, exception)
                } else {
                    Log.e(uppercaseTag, structuredMessage)
                }
            }
        }
    }

    /**
     * Logs a debug message.
     *
     * Use this method for detailed diagnostic information that is typically
     * only of interest when diagnosing problems.
     *
     * @param tag A tag for categorizing the log entry (converted to uppercase).
     * @param operation The operation being performed.
     * @param phase The phase of the operation.
     * @param message Optional message to include in the log.
     * @param context Optional contextual information.
     * @param exception Optional exception object to include in the log.
     */
    fun debug(
        tag: String,
        operation: String,
        phase: String,
        message: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
    ) {
        log(
            level = LogLevel.DEBUG,
            tag = tag,
            operation = operation,
            phase = phase,
            message = message,
            context = context,
            exception = exception,
        )
    }

    /**
     * Logs an informational message.
     *
     * Use this method for general informational messages that describe normal
     * application flow.
     *
     * @param tag A tag for categorizing the log entry (converted to uppercase).
     * @param operation The operation being performed.
     * @param phase The phase of the operation.
     * @param message Optional message to include in the log.
     * @param context Optional contextual information.
     * @param exception Optional exception object to include in the log.
     */
    fun info(
        tag: String,
        operation: String,
        phase: String,
        message: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
    ) {
        log(
            level = LogLevel.INFO,
            tag = tag,
            operation = operation,
            phase = phase,
            message = message,
            context = context,
            exception = exception,
        )
    }

    /**
     * Logs a warning message.
     *
     * Use this method for warning messages that indicate potential problems or
     * unexpected behavior that doesn't prevent the application from functioning.
     *
     * @param tag A tag for categorizing the log entry (converted to uppercase).
     * @param operation The operation being performed.
     * @param phase The phase of the operation.
     * @param message Optional message to include in the log.
     * @param context Optional contextual information.
     * @param exception Optional exception object to include in the log.
     */
    fun warning(
        tag: String,
        operation: String,
        phase: String,
        message: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
    ) {
        log(
            level = LogLevel.WARNING,
            tag = tag,
            operation = operation,
            phase = phase,
            message = message,
            context = context,
            exception = exception,
        )
    }

    /**
     * Logs an error message.
     *
     * Use this method for error messages that indicate serious problems that
     * may prevent the application from functioning correctly.
     *
     * @param tag A tag for categorizing the log entry (converted to uppercase).
     * @param operation The operation being performed.
     * @param phase The phase of the operation.
     * @param message Optional message to include in the log.
     * @param context Optional contextual information.
     * @param exception Optional exception object to include in the log.
     */
    fun error(
        tag: String,
        operation: String,
        phase: String,
        message: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
    ) {
        log(
            level = LogLevel.ERROR,
            tag = tag,
            operation = operation,
            phase = phase,
            message = message,
            context = context,
            exception = exception,
        )
    }

    /**
     * Enum representing the different log levels.
     *
     * Each level uses the built-in [name] property from [Enum] which contains
     * the string representation of the log level.
     */
    private enum class LogLevel {
        /**
         * Debug level for detailed diagnostic information.
         */
        DEBUG,

        /**
         * Info level for general informational messages.
         */
        INFO,

        /**
         * Warning level for potential problems or unexpected behavior.
         */
        WARNING,

        /**
         * Error level for serious problems.
         */
        ERROR,
    }
}
