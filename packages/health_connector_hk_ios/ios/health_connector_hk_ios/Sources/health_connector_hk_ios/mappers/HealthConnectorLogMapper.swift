import Foundation
import OSLog

/// Extension for mapping `OSLogType` → `HealthConnectorLogLevelDto`.
extension OSLogType {
    /// Converts this `OSLogType` to its corresponding `HealthConnectorLogLevelDto`.
    ///
    /// - Returns: The corresponding `HealthConnectorLogLevelDto`
    func toLogLevelDto() -> HealthConnectorLogLevelDto {
        switch self {
        case .debug:
            .debug
        case .info:
            .info
        case .default:
            .warning
        case .error, .fault:
            .error
        default:
            // Treat unknown levels as debug
            .debug
        }
    }
}

/// Extension for mapping `Error` → `HealthConnectorExceptionDto`.
extension Error {
    /// Converts this `Error` to its corresponding `HealthConnectorExceptionDto`.
    ///
    /// - Returns: The corresponding `HealthConnectorExceptionDto`
    func toExceptionDto() -> HealthConnectorExceptionDto {
        if let healthError = self as? HealthConnectorError {
            HealthConnectorExceptionDto(
                code: healthError.toErrorCodeDto(),
                message: healthError.message,
                cause: (healthError.error as? NSError)?.localizedDescription
            )
        } else {
            // Generic error
            HealthConnectorExceptionDto(
                code: .unknownError,
                message: localizedDescription,
                cause: (self as NSError).localizedFailureReason
            )
        }
    }
}

/// Extension for mapping `HealthConnectorError` → `HealthConnectorErrorCodeDto`.
extension HealthConnectorError {
    /// Converts this `HealthConnectorError` to its corresponding `HealthConnectorErrorCodeDto` enum.
    ///
    /// - Returns: The corresponding `HealthConnectorErrorCodeDto`
    func toErrorCodeDto() -> HealthConnectorErrorCodeDto {
        switch self {
        case .healthServiceUnavailable:
            .healthServiceUnavailable
        case .healthServiceRestricted:
            .healthServiceRestricted
        case .healthServiceDatabaseInaccessible:
            .healthServiceDatabaseInaccessible
        case .permissionNotDeclared:
            .permissionNotDeclared
        case .invalidArgument:
            .invalidArgument
        case .unsupportedOperation:
            .unsupportedOperation
        case .unknownError:
            .unknownError
        case .permissionNotGranted:
            .permissionNotGranted
        }
    }
}
