import Foundation
import OSLog

/// Extension to convert OSLogType to HealthConnectorLogLevelDto.
extension OSLogType {
    /// Converts OSLogType to the Pigeon-generated HealthConnectorLogLevelDto.
    func toDto() -> HealthConnectorLogLevelDto {
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

extension Error {
    /// Converts a Swift Error to HealthConnectorExceptionDto.
    ///
    /// If the error is a HealthConnectorError, extracts the structured
    /// error code and context. Otherwise, uses UNKNOWN_ERROR error code.
    func toExceptionInfoDto() -> HealthConnectorExceptionDto {
        if let healthError = self as? HealthConnectorError {
            HealthConnectorExceptionDto(
                code: healthError.codeDto(),
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

/// Extension to convert HealthConnectorError to HealthConnectorErrorCodeDto.
extension HealthConnectorError {
    /// Converts the internal error to the Pigeon-generated HealthConnectorErrorCodeDto enum.
    func codeDto() -> HealthConnectorErrorCodeDto {
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
