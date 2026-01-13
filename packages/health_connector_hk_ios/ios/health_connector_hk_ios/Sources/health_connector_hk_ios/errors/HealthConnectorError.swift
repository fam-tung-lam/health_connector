import Foundation

/// Defines a standardized set of errors that can occur.
///
/// Marked as `@unchecked Sendable` to allow crossing actor boundaries.
/// This is safe because Error instances are effectively immutable once created
/// and are passed through structured concurrency contexts.
enum HealthConnectorError: LocalizedError, CustomDebugStringConvertible, @unchecked Sendable {
    /// Permission to access health data was not granted.
    /// - Parameters:
    ///   - message: A description of the authorization denial.
    ///   - cause: The underlying error, if any.
    ///   - context: Additional key-value data for debugging.
    case permissionNotGranted(message: String, cause: Error? = nil, context: [String: Any]? = nil)

    /// Required permission not declared in app configuration.
    /// - Parameters:
    ///   - message: A description of the missing permission declaration.
    ///   - cause: The underlying error, if any.
    ///   - context: Additional key-value data for debugging.
    case permissionNotDeclared(message: String, cause: Error? = nil, context: [String: Any]? = nil)

    /// Invalid parameter, malformed record, or expired change token.
    /// - Parameters:
    ///   - message: A description of the invalid argument.
    ///   - cause: The underlying error, if any.
    ///   - context: Additional key-value data for debugging.
    case invalidArgument(message: String, cause: Error? = nil, context: [String: Any]? = nil)

    /// Health service is not available on this device.
    /// - Parameters:
    ///   - message: A description of why the health service is unavailable.
    ///   - cause: The underlying error, if any.
    case healthServiceUnavailable(message: String, cause: Error? = nil)

    /// Health service usage is restricted by policy.
    /// - Parameters:
    ///   - message: A description of the restriction.
    ///   - cause: The underlying error, if any.
    ///   - context: Additional key-value data for debugging.
    case healthServiceRestricted(
        message: String, cause: Error? = nil, context: [String: Any]? = nil
    )

    /// Health database is protected and inaccessible.
    /// - Parameters:
    ///   - message: A description of the database access issue.
    ///   - cause: The underlying error, if any.
    case healthServiceDatabaseInaccessible(message: String, cause: Error? = nil)

    /// Operation or data type not supported on this platform.
    /// - Parameters:
    ///   - message: A description of the unsupported operation.
    ///   - cause: The underlying error, if any.
    ///   - context: Additional key-value data for debugging.
    case unsupportedOperation(message: String, cause: Error? = nil, context: [String: Any]? = nil)

    /// An unclassified or internal system error occurred.
    /// - Parameters:
    ///   - message: A description of the unknown error.
    ///   - cause: The underlying error, if any.
    ///   - context: Additional key-value data for debugging.
    case unknownError(message: String, cause: Error? = nil, context: [String: Any]? = nil)

    /// A unique, machine-readable string code for the error.
    var code: String {
        switch self {
        case .permissionNotGranted: "PERMISSION_NOT_GRANTED"
        case .permissionNotDeclared: "PERMISSION_NOT_DECLARED"
        case .invalidArgument: "INVALID_ARGUMENT"
        case .healthServiceUnavailable: "HEALTH_SERVICE_UNAVAILABLE"
        case .healthServiceRestricted: "HEALTH_SERVICE_RESTRICTED"
        case .healthServiceDatabaseInaccessible: "HEALTH_SERVICE_DATABASE_INACCESSIBLE"
        case .unsupportedOperation: "UNSUPPORTED_OPERATION"
        case .unknownError: "UNKNOWN_ERROR"
        }
    }

    /// The primary, human-readable description of the error.
    var message: String {
        switch self {
        case let .permissionNotGranted(msg, _, _),
             let .permissionNotDeclared(msg, _, _),
             let .invalidArgument(msg, _, _),
             let .healthServiceUnavailable(msg, _),
             let .healthServiceRestricted(msg, _, _),
             let .healthServiceDatabaseInaccessible(msg, _),
             let .unsupportedOperation(msg, _, _),
             let .unknownError(msg, _, _):
            msg
        }
    }

    /// The underlying `Error` that caused this error, if any.
    /// The underlying `Error` that caused this error, if any.
    var error: Error? {
        switch self {
        case let .permissionNotGranted(_, cause, _),
             let .permissionNotDeclared(_, cause, _),
             let .invalidArgument(_, cause, _),
             let .healthServiceUnavailable(_, cause),
             let .healthServiceRestricted(_, cause, _),
             let .healthServiceDatabaseInaccessible(_, cause),
             let .unsupportedOperation(_, cause, _),
             let .unknownError(_, cause, _):
            cause
        }
    }

    /// Additional key-value data providing context about the error.
    /// Additional key-value data providing context about the error.
    var context: [String: Any]? {
        switch self {
        case let .permissionNotGranted(_, _, ctx),
             let .permissionNotDeclared(_, _, ctx),
             let .invalidArgument(_, _, ctx),
             let .healthServiceRestricted(_, _, ctx),
             let .unsupportedOperation(_, _, ctx),
             let .unknownError(_, _, ctx):
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
        case .permissionNotDeclared:
            "Check your Info.plist configuration for required HealthKit usage descriptions."
        case .permissionNotGranted:
            "Request HealthKit permissions or check system Settings."
        case .healthServiceRestricted:
            "Check system restrictions or parental controls."
        default:
            nil
        }
    }

    /// A string representation for debugging purposes, conforming to `CustomDebugStringConvertible`.
    var debugDescription: String {
        "HealthConnectorError(code: \(code), message: \(message))"
    }
}
