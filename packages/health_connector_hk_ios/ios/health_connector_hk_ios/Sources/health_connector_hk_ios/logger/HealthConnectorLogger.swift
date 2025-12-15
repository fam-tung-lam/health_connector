import Foundation
import OSLog

/// A singleton logger that wraps Apple's OSLog framework.
///
/// This logger provides a consistent structured logging interface with formatted messages across the plugin.
enum HealthConnectorLogger {
    /// OSLog subsystem identifier for Health Connector iOS plugin.
    private static let subsystem = "com.phamtunglam.health_connector_hk_ios"

    /// Whether logging is enabled.
    ///
    /// When set to `false`, all logging methods will return immediately without
    /// logging any messages. Defaults to `true`.
    private static var _isEnabled: Bool = true

    /// Whether logging is enabled.
    static var isEnabled: Bool {
        get {
            _isEnabled
        }
        set {
            _isEnabled = newValue
        }
    }

    /// Sets whether logging is enabled.
    ///
    /// - Parameter enabled: Whether to enable logging.
    static func setEnabled(_ enabled: Bool) {
        isEnabled = enabled
    }

    /// Base indentation unit (4 spaces).
    private static let indentation = "    "

    /// Maximum depth for cached indentation strings.
    private static let maxCachedIndentDepth = 10

    /// Cached indentation strings for depths 0 to [maxCachedIndentDepth].
    ///
    /// Pre-computed to avoid repeated string concatenation during formatting.
    private static let indentCache: [String] = {
        var cache: [String] = []
        for depth in 0 ... maxCachedIndentDepth {
            cache.append(String(repeating: indentation, count: depth + 1))
        }
        return cache
    }()

    /// Gets the indentation string for the given depth.
    ///
    /// Uses cached values for depths up to [maxCachedIndentDepth],
    /// otherwise computes the indentation string dynamically.
    ///
    /// - Parameter depth: The nesting depth (0 for top-level).
    /// - Returns: The indentation string for the given depth.
    private static func getIndent(depth: Int) -> String {
        if depth <= maxCachedIndentDepth {
            return indentCache[depth]
        }
        return String(repeating: indentation, count: depth + 1)
    }

    /// Date formatter for timestamps: day-month-year hour:minute:second.millisecond
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        return formatter
    }()

    /// Recursively formats a value with proper indentation based on
    /// nesting depth, writing directly to the provided buffer.
    ///
    /// Dictionaries and arrays are formatted with increasing indentation for each nesting level.
    ///
    /// - Parameters:
    ///   - buffer: The string buffer to write the formatted value to (inout).
    ///   - value: The value to format (can be a dictionary, array, or any other type).
    ///   - depth: The current nesting depth (0 for top-level, increases with nesting).
    private static func formatValueTo(_ buffer: inout String, value: Any?, depth: Int) {
        let currentIndent = getIndent(depth: depth)
        let nextIndent = getIndent(depth: depth + 1)

        // Handle dictionaries
        if let dict = value as? [String: Any?] {
            if dict.isEmpty {
                buffer += "{}"
                return
            }
            buffer += "{\n"
            var isFirst = true
            for (key, dictValue) in dict {
                if !isFirst {
                    buffer += "\n"
                }
                isFirst = false
                buffer += "\(nextIndent)\(key): "
                formatValueTo(&buffer, value: dictValue, depth: depth + 1)
                buffer += ","
            }
            buffer += "\n\(currentIndent)}"
            return
        }

        // Handle arrays
        if let array = value as? [Any?] {
            if array.isEmpty {
                buffer += "[]"
                return
            }
            buffer += "[\n"
            var isFirst = true
            for element in array {
                if !isFirst {
                    buffer += "\n"
                }
                isFirst = false
                buffer += nextIndent
                formatValueTo(&buffer, value: element, depth: depth + 1)
                buffer += ","
            }
            buffer += "\n\(currentIndent)]"
            return
        }

        // Handle other types - convert to string
        buffer += String(describing: value ?? "null")
    }

    /// Formats a structured log message in JSON-like format.
    ///
    /// Creates a formatted message with indentation, including only non-nil fields.
    ///
    /// - Parameters:
    ///   - operation: The operation being performed (e.g., 'readRecords').
    ///   - message: Optional message to include in the log.
    ///   - context: Optional dictionary of contextual information.
    ///   - exception: Optional error object.
    ///   - stackTrace: Optional stack trace string.
    /// - Returns: A formatted string in JSON-like format with indentation.
    private static func formatStructuredMessage(
        operation: String,
        message: String? = nil,
        context: [String: Any?]? = nil,
        exception: Error? = nil,
        stackTrace: String? = nil
    ) -> String {
        var buffer = ""

        // Always include operation
        buffer += "{\n"
        buffer += "\(getIndent(depth: 0))operation: \(operation),"

        // Include message if provided
        if let message {
            buffer += "\n\(getIndent(depth: 0))message: \(message),"
        }

        // Include exception block if exception or stackTrace is provided
        if exception != nil || stackTrace != nil {
            buffer += "\n\(getIndent(depth: 0))exception: {"
            if let exception {
                buffer += "\n\(getIndent(depth: 1))cause: \(String(describing: exception)),"
            }
            if let stackTrace {
                buffer += "\n\(getIndent(depth: 1))stack_trace: \(stackTrace),"
            }
            buffer += "\n\(getIndent(depth: 0))},"
        }

        // Include context if provided and not empty
        if let context, !context.isEmpty {
            buffer += "\n\(getIndent(depth: 0))context: {"
            for (key, value) in context {
                buffer += "\n"
                buffer += "\(getIndent(depth: 1))\(key): "
                formatValueTo(&buffer, value: value, depth: 1)
                buffer += ","
            }
            buffer += "\n\(getIndent(depth: 0))},"
        }

        buffer += "\n}"

        return buffer
    }

    /// Formats a Date to the log format:
    /// `day-month-year hour:minute:second.millisecond`.
    ///
    /// - Parameter date: The date to format.
    /// - Returns: A formatted string in the format `day-month-year hour:minute:second.millisecond`.
    private static func formatDateTime(_ date: Date) -> String {
        dateFormatter.string(from: date)
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

        let structuredMessage = formatStructuredMessage(
            operation: operation,
            message: message,
            context: context,
            exception: exception,
            stackTrace: stackTrace
        )

        let now = Date()
        let formattedDateTime = formatDateTime(now)
        let levelName = levelName(for: level)
        let formattedMessage = "[\(formattedDateTime)][\(levelName)]: \n\(structuredMessage)"

        let uppercaseTag = tag.uppercased()
        let logger = Logger(subsystem: subsystem, category: uppercaseTag)

        // Use OSLog with appropriate level
        switch level {
        case .debug:
            logger.debug("\(formattedMessage)")
        case .info:
            logger.info("\(formattedMessage)")
        case .default:
            logger.log("\(formattedMessage)")
        case .error, .fault:
            logger.error("\(formattedMessage)")
        default:
            logger.log("\(formattedMessage)")
        }
    }

    /// Gets the string name for a log level.
    ///
    /// - Parameter level: The OSLog level.
    /// - Returns: The string representation of the level.
    private static func levelName(for level: OSLogType) -> String {
        switch level {
        case .debug:
            "DEBUG"
        case .info:
            "INFO"
        case .default:
            "WARNING"
        case .error, .fault:
            "ERROR"
        default:
            "UNKNOWN"
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
}
