import Foundation

/// Defines a standardized set of errors that can occur.
///
/// Marked as `@unchecked Sendable` to allow crossing actor boundaries.
/// This is safe because Error instances are effectively immutable once created
/// and are passed through structured concurrency contexts.
enum HealthConnectorError: LocalizedError, CustomDebugStringConvertible, @unchecked Sendable {
    /// Indicates that the underlying health data provider is not available on the device.
    /// - Parameters:
    ///   - message: A description of why the provider is unavailable.
    ///   - cause: The underlying error, if any.
    case healthProviderUnavailable(message: String, cause: Error? = nil)

    /// Represents a configuration error, such as a missing Info.plist key.
    /// - Parameters:
    ///   - message: A description of the configuration issue.
    ///   - context: Additional key-value data for debugging.
    case invalidConfiguration(message: String, context: [String: Any]? = nil)

    /// Signals that a method was called with an invalid argument.
    /// - Parameters:
    ///   - message: A description of the invalid argument.
    ///   - context: Additional key-value data for debugging.
    case invalidArgument(message: String, context: [String: Any]? = nil)

    /// Indicates that the requested operation is not supported.
    /// - Parameters:
    ///   - message: A description of the unsupported operation.
    ///   - context: Additional key-value data for debugging.
    case unsupportedOperation(message: String, context: [String: Any]? = nil)

    /// A generic, unexpected error that doesn't fit other categories.
    /// - Parameters:
    ///   - message: A description of the unknown error.
    ///   - cause: The underlying error, if any.
    ///   - context: Additional key-value data for debugging.
    case unknown(message: String, cause: Error? = nil, context: [String: Any]? = nil)

    /// Signals that the user has not granted the necessary permissions for the operation.
    /// - Parameters:
    ///   - message: A description of the authorization failure.
    ///   - context: Additional key-value data for debugging.
    case notAuthorized(message: String, context: [String: Any]? = nil)

    /// Indicates that the user explicitly cancelled the operation (e.g., a permission prompt).
    /// - Parameters:
    ///   - message: A description confirming user cancellation.
    case userCancelled(message: String)

    /// A unique, machine-readable string code for the error.
    var code: String {
        switch self {
        case .healthProviderUnavailable: "HEALTH_PROVIDER_UNAVAILABLE"
        case .invalidConfiguration: "INVALID_CONFIGURATION"
        case .invalidArgument: "INVALID_ARGUMENT"
        case .unsupportedOperation: "UNSUPPORTED_OPERATION"
        case .unknown: "UNKNOWN_ERROR"
        case .notAuthorized: "NOT_AUTHORIZED"
        case .userCancelled: "USER_CANCELLED"
        }
    }

    /// The primary, human-readable description of the error.
    var message: String {
        switch self {
        case let .healthProviderUnavailable(msg, _),
             let .invalidConfiguration(msg, _),
             let .invalidArgument(msg, _),
             let .unsupportedOperation(msg, _),
             let .unknown(msg, _, _),
             let .notAuthorized(msg, _),
             let .userCancelled(msg):
            msg
        }
    }

    /// The underlying `Error` that caused this error, if any.
    var error: Error? {
        switch self {
        case let .healthProviderUnavailable(_, cause),
             let .unknown(_, cause, _):
            cause
        default:
            nil
        }
    }

    /// Additional key-value data providing context about the error.
    var context: [String: Any]? {
        switch self {
        case let .invalidConfiguration(_, ctx),
             let .invalidArgument(_, ctx),
             let .unsupportedOperation(_, ctx),
             let .unknown(_, _, ctx),
             let .notAuthorized(_, ctx):
            ctx
        default:
            nil
        }
    }

    /// A localized description of the error, conforming to `LocalizedError`.
    var errorDescription: String? {
        message
    }

    /// A localized description of the reason for the failure, conforming to `LocalizedError`.
    ///
    /// This value is derived from the underlying `cause` error, if one exists.
    var failureReason: String? {
        error?.localizedDescription
    }

    /// A localized message suggesting how to recover from the failure, conforming to `LocalizedError`.
    var recoverySuggestion: String? {
        switch self {
        case .invalidConfiguration:
            "Check your Info.plist configuration."
        case .notAuthorized:
            "Check system Settings for permissions."
        default:
            nil
        }
    }

    /// A string representation for debugging purposes, conforming to `CustomDebugStringConvertible`.
    var debugDescription: String {
        "HealthConnectorError(code: \(code), message: \(message))"
    }
}
