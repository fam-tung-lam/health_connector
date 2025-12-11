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
        case .healthPlatformUnavailable:
            "HEALTH_PLATFORM_UNAVAILABLE"
        case .unsupportedHealthPlatformApi:
            "UNSUPPORTED_HEALTH_PLATFORM_API"
        case .invalidPlatformConfiguration:
            "INVALID_PLATFORM_CONFIGURATION"
        case .invalidArgument:
            "INVALID_ARGUMENT"
        case .securityError:
            "SECURITY_ERROR"
        }
    }
}

/**
 * Creates a [HealthConnectorError] from this error code with the appropriate message.
 */
extension HealthConnectorErrorCodeDto {
    func toError(details: Any? = nil) -> HealthConnectorError {
        let message = switch self {
        case .healthPlatformUnavailable:
            "HealthKit is unavailable"
        case .invalidPlatformConfiguration:
            "Invalid platform configuration"
        case .unknown:
            "An unknown error occurred"
        case .securityError:
            "Security/permission error: Access denied or insufficient permissions"
        case .invalidArgument:
            "Invalid argument: Input validation failed"
        case .unsupportedHealthPlatformApi:
            "Unsupported health platform API"
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
    static func healthPlatformUnavailable(message: String? = nil, details: Sendable? = nil) -> HealthConnectorError {
        HealthConnectorError(
            code: HealthConnectorErrorCodeDto.healthPlatformUnavailable.stringValue,
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
    static func unsupportedHealthPlatformApi(message: String? = nil, details: Sendable? = nil) -> HealthConnectorError {
        HealthConnectorError(
            code: HealthConnectorErrorCodeDto.unsupportedHealthPlatformApi.stringValue,
            message: "Unsupported health platform API\(getMessageOrEmpty(message))",
            details: details
        )
    }

    /**
     * Creates a `HealthConnectorError` for invalid platform configuration issues, f.e. missing
     * required permissions in Info.plist.
     */
    static func invalidPlatformConfiguration(message: String? = nil, details: Sendable? = nil) -> HealthConnectorError {
        HealthConnectorError(
            code: HealthConnectorErrorCodeDto.invalidPlatformConfiguration.stringValue,
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
    static func securityError(message: String? = nil, details: Sendable? = nil) -> HealthConnectorError {
        HealthConnectorError(
            code: HealthConnectorErrorCodeDto.securityError.stringValue,
            message: "Security error: Permission denied or insufficient access\(getMessageOrEmpty(message))",
            details: details
        )
    }

    private static func getMessageOrEmpty(_ message: String?) -> String {
        guard let message else { return "" }
        return ": \(message)"
    }
}
