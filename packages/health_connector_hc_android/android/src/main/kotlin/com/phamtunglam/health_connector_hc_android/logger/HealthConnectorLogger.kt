package com.phamtunglam.health_connector_hc_android.logger

import android.util.Log
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger.MAX_CACHED_INDENT_DEPTH
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toExceptionInfoDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorLogDto
import com.phamtunglam.health_connector_hc_android.pigeon.PigeonEventSink
import com.phamtunglam.health_connector_hc_android.pigeon.WatchLogEventsStreamHandler
import java.util.Locale
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/**
 * A singleton logger.
 *
 * This logger provides a consistent structured logging interface with
 * formatted messages across the plugin. It supports structured logging with
 * operation, phase, optional message, and context.
 *
 * Extends [WatchLogEventsStreamHandler] to provide log event streaming
 * to Flutter via Pigeon EventChannel.
 */
internal object HealthConnectorLogger : WatchLogEventsStreamHandler() {
    /**
     * Coroutine scope for executing asynchronous operations.
     */
    lateinit var scope: CoroutineScope

    fun initialize(externalScope: CoroutineScope) {
        if (!this::scope.isInitialized) {
            scope = externalScope
        }
    }

    /**
     * Flag for whether logging is enabled.
     */
    var isEnabled = false

    /**
     * Logs a debug message.
     *
     * Use this method for detailed diagnostic information that is typically
     * only of interest when diagnosing problems.
     *
     * @param tag A tag for categorizing the log entry (converted to uppercase).
     * @param operation The operation being performed.
     * @param message Optional message to include in the log.
     * @param context Optional contextual information.
     * @param exception Optional exception object to include in the log.
     */
    fun debug(
        tag: String,
        message: String,
        operation: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
    ) {
        log(
            level = LogLevel.DEBUG,
            tag = tag,
            operation = operation,
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
     * @param message Optional message to include in the log.
     * @param context Optional contextual information.
     * @param exception Optional exception object to include in the log.
     */
    fun info(
        tag: String,
        message: String,
        operation: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
    ) {
        log(
            level = LogLevel.INFO,
            tag = tag,
            operation = operation,
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
     * @param message Optional message to include in the log.
     * @param context Optional contextual information.
     * @param exception Optional exception object to include in the log.
     */
    fun warning(
        tag: String,
        message: String,
        operation: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
    ) {
        log(
            level = LogLevel.WARNING,
            tag = tag,
            operation = operation,
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
     * @param message Optional message to include in the log.
     * @param context Optional contextual information.
     * @param exception Optional exception object to include in the log.
     */
    fun error(
        tag: String,
        message: String,
        operation: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
    ) {
        log(
            level = LogLevel.ERROR,
            tag = tag,
            operation = operation,
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
    enum class LogLevel {
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
     * Thread-safe reference to the event sink for streaming logs to Flutter.
     */
    private var eventSink: PigeonEventSink<HealthConnectorLogDto>? = null

    /**
     * Called when Flutter starts listening to the log event stream.
     */
    override fun onListen(p0: Any?, sink: PigeonEventSink<HealthConnectorLogDto>) {
        eventSink = sink
    }

    /**
     * Called when Flutter stops listening to the log event stream.
     */
    override fun onCancel(p0: Any?) {
        eventSink?.endOfStream()
        eventSink = null
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
     * @param message Optional message to include in the log.
     * @param context Optional map of contextual information.
     * @param exception Optional exception object.
     * @param stackTrace Optional stack trace.
     * @return A formatted string in JSON-like format with indentation.
     */
    private fun formatStructuredMessage(
        message: String,
        operation: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
        stackTrace: Array<StackTraceElement>? = null,
    ): String {
        val buffer = StringBuilder()

        // Always include message
        buffer.appendLine("{")
        buffer.append("\n${getIndent(0)}message: $message,")

        // Include operation if provided
        if (operation != null) {
            buffer.append("${getIndent(0)}operation: $operation,")
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
     * stream emission, and output. When logging is disabled, neither prints
     * nor emits to the stream.
     *
     * @param level The log level (DEBUG, INFO, WARNING, ERROR).
     * @param tag The tag for categorizing the log entry (converted to uppercase).
     * @param operation The operation being performed.
     * @param message Optional message to include in the log.
     * @param context Optional contextual information.
     * @param exception Optional exception object.
     */
    private fun log(
        level: LogLevel,
        tag: String,
        message: String,
        operation: String? = null,
        context: Map<String, Any?>? = null,
        exception: Throwable? = null,
    ) {
        if (!isEnabled) {
            return
        }

        val stackTrace = exception?.stackTrace
        val structuredMessage = formatStructuredMessage(
            operation = operation,
            message = message,
            context = context,
            exception = exception,
            stackTrace = stackTrace,
        )
        val uppercaseTag = tag.uppercase(Locale.US)

        when (level) {
            LogLevel.DEBUG -> Log.d(uppercaseTag, structuredMessage, exception)
            LogLevel.INFO -> Log.i(uppercaseTag, structuredMessage, exception)
            LogLevel.WARNING -> Log.w(uppercaseTag, structuredMessage, exception)
            LogLevel.ERROR -> Log.e(uppercaseTag, structuredMessage, exception)
        }

        // Events from native to Flutter layer must be sent on the main thread.
        scope.launch(Dispatchers.Main.immediate) {
            eventSink?.success(
                HealthConnectorLogDto(
                    level = level.toDto(),
                    tag = tag,
                    operation = operation,
                    millisecondsSinceEpoch = System.currentTimeMillis(),
                    message = message,
                    context = context?.mapKeys { it.key },
                    exception = exception?.toExceptionInfoDto(),
                    structuredMessage = structuredMessage,
                ),
            )
        }
    }
}
