import Foundation

/// Defines a standardized set of errors that can occur.
///
/// Marked as `@unchecked Sendable` to allow crossing actor boundaries.
/// This is safe because Error instances are effectively immutable once created
/// and are passed through structured concurrency contexts.
enum HealthConnectorError: LocalizedError, CustomDebugStringConvertible, @unchecked Sendable {
    // MARK: - Authorization Errors

    /// User denied permission or dismissed authorization prompt.
    /// - Parameters:
    ///   - message: A description of the authorization denial.
    ///   - context: Additional key-value data for debugging.
    case authorizationDenied(message: String, context: [String: Any]? = nil)

    /// Authorization has not been requested yet.
    /// - Parameters:
    ///   - message: A description indicating permissions need to be requested.
    ///   - context: Additional key-value data for debugging.
    case authorizationNotDetermined(message: String, context: [String: Any]? = nil)

    // MARK: - Configuration Errors

    /// Required permission not declared in app configuration.
    /// - Parameters:
    ///   - message: A description of the missing permission declaration.
    ///   - context: Additional key-value data for debugging.
    case permissionNotDeclared(message: String, context: [String: Any]? = nil)

    // MARK: - Health Service Unavailable Errors

    /// Health service is not available on this device.
    /// - Parameters:
    ///   - message: A description of why the health service is unavailable.
    ///   - cause: The underlying error, if any.
    case healthServiceUnavailable(message: String, cause: Error? = nil)

    /// Health service usage is restricted by policy.
    /// - Parameters:
    ///   - message: A description of the restriction.
    ///   - context: Additional key-value data for debugging.
    case healthServiceRestricted(message: String, context: [String: Any]? = nil)

    // MARK: - Health Service Exception Errors

    /// Health database is protected and inaccessible.
    /// - Parameters:
    ///   - message: A description of the database access issue.
    ///   - cause: The underlying error, if any.
    case healthServiceDatabaseInaccessible(message: String, cause: Error? = nil)

    /// Storage read/write operation failed.
    /// - Parameters:
    ///   - message: A description of the I/O failure.
    ///   - cause: The underlying error, if any.
    case ioError(message: String, cause: Error? = nil)

    /// IPC communication with health service failed.
    /// - Parameters:
    ///   - message: A description of the communication failure.
    ///   - cause: The underlying error, if any.
    case remoteError(message: String, cause: Error? = nil)

    /// API rate limit has been exhausted.
    /// - Parameters:
    ///   - message: A description of the rate limit issue.
    ///   - context: Additional key-value data for debugging.
    case rateLimitExceeded(message: String, context: [String: Any]? = nil)

    /// Health service is syncing data, operations blocked.
    /// - Parameters:
    ///   - message: A description indicating sync is in progress.
    ///   - context: Additional key-value data for debugging.
    case dataSyncInProgress(message: String, context: [String: Any]? = nil)

    // MARK: - Invalid Argument Error

    /// Signals that a method was called with an invalid argument.
    /// - Parameters:
    ///   - message: A description of the invalid argument.
    ///   - context: Additional key-value data for debugging.
    case invalidArgument(message: String, context: [String: Any]? = nil)

    // MARK: - Unsupported Operation Error

    /// Indicates that the requested operation is not supported.
    /// - Parameters:
    ///   - message: A description of the unsupported operation.
    ///   - context: Additional key-value data for debugging.
    case unsupportedOperation(message: String, context: [String: Any]? = nil)

    // MARK: - Unknown Error

    /// A generic, unexpected error that doesn't fit other categories.
    /// - Parameters:
    ///   - message: A description of the unknown error.
    ///   - cause: The underlying error, if any.
    ///   - context: Additional key-value data for debugging.
    case unknownError(message: String, cause: Error? = nil, context: [String: Any]? = nil)

    /// A unique, machine-readable string code for the error.
    var code: String {
        switch self {
        case .authorizationDenied: "AUTHORIZATION_DENIED"
        case .authorizationNotDetermined: "AUTHORIZATION_NOT_DETERMINED"
        case .permissionNotDeclared: "PERMISSION_NOT_DECLARED"
        case .healthServiceUnavailable: "HEALTH_SERVICE_UNAVAILABLE"
        case .healthServiceRestricted: "HEALTH_SERVICE_RESTRICTED"
        case .healthServiceDatabaseInaccessible: "HEALTH_SERVICE_DATABASE_INACCESSIBLE"
        case .ioError: "IO_ERROR"
        case .remoteError: "REMOTE_ERROR"
        case .rateLimitExceeded: "RATE_LIMIT_EXCEEDED"
        case .dataSyncInProgress: "DATA_SYNC_IN_PROGRESS"
        case .invalidArgument: "INVALID_ARGUMENT"
        case .unsupportedOperation: "UNSUPPORTED_OPERATION"
        case .unknownError: "UNKNOWN_ERROR"
        }
    }

    /// The primary, human-readable description of the error.
    var message: String {
        switch self {
        case let .authorizationDenied(msg, _),
             let .authorizationNotDetermined(msg, _),

             let .permissionNotDeclared(msg, _),
             let .healthServiceUnavailable(msg, _),
             let .healthServiceRestricted(msg, _),
             let .healthServiceDatabaseInaccessible(msg, _),
             let .ioError(msg, _),
             let .remoteError(msg, _),
             let .rateLimitExceeded(msg, _),
             let .dataSyncInProgress(msg, _),
             let .invalidArgument(msg, _),
             let .unsupportedOperation(msg, _),
             let .unknownError(msg, _, _):
            msg
        }
    }

    /// The underlying `Error` that caused this error, if any.
    var error: Error? {
        switch self {
        case let .healthServiceUnavailable(_, cause),
             let .healthServiceDatabaseInaccessible(_, cause),
             let .ioError(_, cause),
             let .remoteError(_, cause),
             let .unknownError(_, cause, _):
            cause
        default:
            nil
        }
    }

    /// Additional key-value data providing context about the error.
    var context: [String: Any]? {
        switch self {
        case let .authorizationDenied(_, ctx),
             let .authorizationNotDetermined(_, ctx),

             let .permissionNotDeclared(_, ctx),
             let .healthServiceRestricted(_, ctx),
             let .rateLimitExceeded(_, ctx),
             let .dataSyncInProgress(_, ctx),
             let .invalidArgument(_, ctx),
             let .unsupportedOperation(_, ctx),
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
        case .authorizationDenied, .authorizationNotDetermined:
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
