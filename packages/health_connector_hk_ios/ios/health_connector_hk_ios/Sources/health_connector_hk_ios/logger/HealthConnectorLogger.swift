import Foundation
import OSLog

/// A singleton logger.
///
/// Implements `WatchLogEventsStreamHandler` to provide log event streaming
/// to Flutter via Pigeon EventChannel.
final class HealthConnectorLogger: WatchLogEventsStreamHandler {
    /// Lock for thread-safe access to _isEnabled
    ///
    /// Uses `NSLock` to protect the `isEnabled` flag for thread-safe access across concurrency domains.
    /// NSLock is used instead of Mutex for iOS 15+ compatibility (Mutex requires iOS 18+).
    private static let lock = NSLock()

    /// Whether logging is enabled (backing storage).
    ///
    /// When set to `false`, all logging methods will return immediately without
    /// logging any messages. Defaults to `true`.
    ///
    /// **Thread Safety:** Access protected by NSLock. Use the `isEnabled` property accessor.
    /// Marked nonisolated(unsafe) for iOS 15+ compatibility with NSLock-based synchronization.
    private nonisolated(unsafe) static var _isEnabled: Bool = true

    /// Whether logging is enabled.
    ///
    /// **Thread Safety:** Protected by NSLock for safe concurrent access.
    static var isEnabled: Bool {
        get {
            lock.lock()
            defer { lock.unlock() }
            return _isEnabled
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            _isEnabled = newValue
        }
    }

    /// Singleton instance of the logger
    static let shared = HealthConnectorLogger()

    /// Thread-safe reference to the event sink for streaming logs to Flutter.
    private var eventSink: PigeonEventSink<HealthConnectorLogDto>?
    private let sinkLock = NSLock()

    /// Private initializer to enforce singleton pattern
    override private init() {
        super.init()
    }

    /// Sets whether logging is enabled.
    ///
    /// - Parameter enabled: Whether to enable logging.
    static func setEnabled(_ enabled: Bool) {
        isEnabled = enabled
    }

    /// Internal method that formats and logs the message.
    ///
    /// Handles all logging logic including enabled check, message formatting,
    /// and output. Formats the message according to the specified format:
    /// ```
    /// [{datetime}][{level}]:
    /// {
    ///    operation: {operation},
    ///    message: {message},
    ///    exception: {
    ///      cause: {exception},
    ///      stack_trace: {stackTrace},
    ///    },
    ///    context: {
    ///      key1: value1,
    ///    },
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - level: The log level (DEBUG, INFO, WARNING, ERROR).
    ///   - tag: The tag for categorizing the log entry (converted to uppercase).
    ///   - operation: The operation being performed.
    ///   - message: Optional message to include in the log.
    ///   - context: Optional contextual information.
    ///   - exception: Optional error object.
    private static func log(
        level: OSLogType,
        tag: String,
        operation: String,
        message: String? = nil,
        context: [String: Any?]? = nil,
        exception: Error? = nil
    ) {
        guard isEnabled else {
            return
        }

        // Extract stack trace from exception if available
        let stackTrace: String? =
            if exception != nil {
                Thread.callStackSymbols.joined(separator: "\n")
            } else {
                nil
            }

        // Emit log event to Flutter stream if listening
        shared.sinkLock.lock()
        let sink = shared.eventSink
        shared.sinkLock.unlock()

        if let sink {
            let timestampMs = Int64(Date().timeIntervalSince1970 * 1000)

            // Convert context to [String?: String?] for codec compatibility
            // All values must be converted to strings to avoid codec serialization errors
            let convertedContext: [String?: String?]? = context?.reduce(into: [:]) { result, pair in
                if let value = pair.value {
                    result[pair.key as String?] = String(describing: value)
                } else {
                    result[pair.key as String?] = nil
                }
            }

            let logDto = HealthConnectorLogDto(
                level: level.toDto(),
                tag: tag.uppercased(),
                millisecondsSinceEpoch: timestampMs,
                message: message ?? "",
                operation: operation,
                exception: exception?.toExceptionInfoDto(),
                stackTrace: exception != nil
                    ? Thread.callStackSymbols.joined(separator: "\n") : nil,
                context: convertedContext
            )

            // Must emit on main thread for Flutter channel safety
            DispatchQueue.main.async {
                sink.success(logDto)
            }
        }
    }

    /// Logs a debug message.
    ///
    /// Use this method for detailed diagnostic information that is typically
    /// only of interest when diagnosing problems.
    ///
    /// - Parameters:
    ///   - tag: A tag for categorizing the log entry (converted to uppercase).
    ///   - operation: The operation being performed.
    ///   - message: Optional message to include in the log.
    ///   - context: Optional contextual information.
    ///   - exception: Optional error object to include in the log.
    static func debug(
        tag: String,
        operation: String,
        message: String? = nil,
        context: [String: Any?]? = nil,
        exception: Error? = nil
    ) {
        log(
            level: .debug,
            tag: tag,
            operation: operation,
            message: message,
            context: context,
            exception: exception
        )
    }

    /// Logs an informational message.
    ///
    /// Use this method for general informational messages that describe normal
    /// application flow.
    ///
    /// - Parameters:
    ///   - tag: A tag for categorizing the log entry (converted to uppercase).
    ///   - operation: The operation being performed.
    ///   - message: Optional message to include in the log.
    ///   - context: Optional contextual information.
    ///   - exception: Optional error object to include in the log.
    static func info(
        tag: String,
        operation: String,
        message: String? = nil,
        context: [String: Any?]? = nil,
        exception: Error? = nil
    ) {
        log(
            level: .info,
            tag: tag,
            operation: operation,
            message: message,
            context: context,
            exception: exception
        )
    }

    /// Logs a warning message.
    ///
    /// Use this method for warning messages that indicate potential problems or
    /// unexpected behavior that doesn't prevent the application from functioning.
    ///
    /// - Parameters:
    ///   - tag: A tag for categorizing the log entry (converted to uppercase).
    ///   - operation: The operation being performed.
    ///   - message: Optional message to include in the log.
    ///   - context: Optional contextual information.
    ///   - exception: Optional error object to include in the log.
    static func warning(
        tag: String,
        operation: String,
        message: String? = nil,
        context: [String: Any?]? = nil,
        exception: Error? = nil
    ) {
        log(
            level: .default,
            tag: tag,
            operation: operation,
            message: message,
            context: context,
            exception: exception
        )
    }

    /// Logs an error message.
    ///
    /// Use this method for error messages that indicate serious problems that
    /// may prevent the application from functioning correctly.
    ///
    /// - Parameters:
    ///   - tag: A tag for categorizing the log entry (converted to uppercase).
    ///   - operation: The operation being performed.
    ///   - message: Optional message to include in the log.
    ///   - context: Optional contextual information.
    ///   - exception: Optional error object to include in the log.
    static func error(
        tag: String,
        operation: String,
        message: String? = nil,
        context: [String: Any?]? = nil,
        exception: Error? = nil
    ) {
        log(
            level: .error,
            tag: tag,
            operation: operation,
            message: message,
            context: context,
            exception: exception
        )
    }

    // MARK: - WatchLogEventsStreamHandler Implementation

    /// Called when Flutter starts listening to the log event stream.
    override func onListen(
        withArguments _: Any?,
        sink: PigeonEventSink<HealthConnectorLogDto>
    ) {
        sinkLock.lock()
        defer { sinkLock.unlock() }
        eventSink = sink
    }

    /// Called when Flutter stops listening to the log event stream.
    override func onCancel(withArguments _: Any?) {
        sinkLock.lock()
        defer { sinkLock.unlock() }
        eventSink = nil
    }
}
