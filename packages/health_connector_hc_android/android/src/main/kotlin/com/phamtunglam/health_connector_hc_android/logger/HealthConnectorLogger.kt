package com.phamtunglam.health_connector_hc_android.logger

import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toExceptionInfoDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorLogDto
import com.phamtunglam.health_connector_hc_android.pigeon.PigeonEventSink
import com.phamtunglam.health_connector_hc_android.pigeon.WatchLogEventsStreamHandler
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

        // Events from native to Flutter layer must be sent on the main thread.
        scope.launch(Dispatchers.Main.immediate) {
            eventSink?.success(
                HealthConnectorLogDto(
                    level = level.toDto(),
                    tag = "NATIVE_HC_ANDROID__$tag",
                    operation = operation,
                    millisecondsSinceEpoch = System.currentTimeMillis(),
                    message = message,
                    context = context?.mapKeys { it.key },
                    exception = exception?.toExceptionInfoDto(),
                ),
            )
        }
    }
}
