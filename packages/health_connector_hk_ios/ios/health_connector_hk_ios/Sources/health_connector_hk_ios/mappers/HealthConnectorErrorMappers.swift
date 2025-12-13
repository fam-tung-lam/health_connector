import Foundation

/**
 * Extension to provide string representation for `HealthConnectorErrorCodeDto`.
 */
extension HealthConnectorErrorCodeDto {
    /**
     * Returns the uppercase string representation of the error code.
     */
    var stringValue: String {
        switch self {
        case .unknown:
            "UNKNOWN"
        case .healthProviderUnavailable:
            "HEALTH_PROVIDER_UNAVAILABLE"
        case .unsupportedOperation:
            "UNSUPPORTED_OPERATION"
        case .invalidConfiguration:
            "INVALID_CONFIGURATION"
        case .invalidArgument:
            "INVALID_ARGUMENT"
        case .notAuthorized:
            "NOT_AUTHORIZED"
        case .remoteError:
            "REMOTE_ERROR"
        case .userCancelled:
            "USER_CANCELLED"
        }
    }
}

/**
 * Creates a [HealthConnectorError] from this error code with the appropriate message.
 */
extension HealthConnectorErrorCodeDto {
    func toError(details: Sendable? = nil) -> HealthConnectorError {
        let message = switch self {
        case .healthProviderUnavailable:
            "HealthKit is unavailable"
        case .invalidConfiguration:
            "Invalid platform configuration"
        case .unknown:
            "An unknown error occurred"
        case .notAuthorized:
            "Security/permission error: Access denied or insufficient permissions"
        case .invalidArgument:
            "Invalid argument: Input validation failed"
        case .unsupportedOperation:
            "Unsupported health platform API"
        case .remoteError:
            "A transient I/O or communication error occurred"
        case .userCancelled:
            "User cancelled the operation"
        }
        return HealthConnectorError(code: stringValue, message: message, details: details)
    }
}

/**
 * Factory for creating standardized error instances used throughout the Health Connector plugin.
 */
enum HealthConnectorErrors {
    /**
     * Creates a `HealthConnectorError` indicating that HealthKit is unavailable on the device.
     */
    static func healthProviderUnavailable(message: String? = nil, details: Sendable? = nil) -> HealthConnectorError {
        HealthConnectorError(
            code: HealthConnectorErrorCodeDto.healthProviderUnavailable.stringValue,
            message: "HealthKit is unavailable\(getMessageOrEmpty(message))",
            details: details
        )
    }

    /**
     * Creates a `HealthConnectorError` for unexpected or uncategorized errors.
     */
    static func unknown(message: String? = nil, details: Sendable? = nil) -> HealthConnectorError {
        HealthConnectorError(
            code: HealthConnectorErrorCodeDto.unknown.stringValue,
            message: "An unknown error occurred\(getMessageOrEmpty(message))",
            details: details
        )
    }

    /**
     * Creates a `HealthConnectorError` indicating that the requested API or feature is not
     * supported on iOS HealthKit.
     */
    static func unsupportedOperation(message: String? = nil, details: Sendable? = nil) -> HealthConnectorError {
        HealthConnectorError(
            code: HealthConnectorErrorCodeDto.unsupportedOperation.stringValue,
            message: "Unsupported health platform API\(getMessageOrEmpty(message))",
            details: details
        )
    }

    /**
     * Creates a `HealthConnectorError` for invalid platform configuration issues, f.e. missing
     * required permissions in Info.plist.
     */
    static func invalidConfiguration(message: String? = nil, details: Sendable? = nil) -> HealthConnectorError {
        HealthConnectorError(
            code: HealthConnectorErrorCodeDto.invalidConfiguration.stringValue,
            message: "Invalid platform configuration\(getMessageOrEmpty(message))",
            details: details
        )
    }

    /**
     * Creates a `HealthConnectorError` for invalid argument or input validation errors.
     */
    static func invalidArgument(message: String? = nil, details: Sendable? = nil) -> HealthConnectorError {
        HealthConnectorError(
            code: HealthConnectorErrorCodeDto.invalidArgument.stringValue,
            message: "Invalid argument: Input validation failed\(getMessageOrEmpty(message))",
            details: details
        )
    }

    /**
     * Creates a `HealthConnectorError` for security/permission errors.
     *
     * This error maps to `HKError.errorAuthorizationDenied` on iOS.
     */
    static func notAuthorized(message: String? = nil, details: Sendable? = nil) -> HealthConnectorError {
        HealthConnectorError(
            code: HealthConnectorErrorCodeDto.notAuthorized.stringValue,
            message: "Security error: Permission denied or insufficient access\(getMessageOrEmpty(message))",
            details: details
        )
    }

    private static func getMessageOrEmpty(_ message: String?) -> String {
        guard let message else { return "" }
        return ": \(message)"
    }
}
