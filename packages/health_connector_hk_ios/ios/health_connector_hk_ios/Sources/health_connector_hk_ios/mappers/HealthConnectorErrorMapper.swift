import Foundation
import HealthKit

extension HealthConnectorError {
    /// Converts the error into a serializable data transfer object.
    ///
    /// This method aggregates comprehensive debugging information including:
    /// - User-provided context dictionary
    /// - Underlying error domain and code (for NSError instances)
    /// - Stack trace symbols (when available)
    /// - Recovery suggestions
    /// - Debug description
    ///
    /// This enriched information significantly improves debugging capabilities on the Dart side.
    ///
    /// - Returns: A `HealthConnectorErrorDto` containing the error code, message, and enriched details.
    func toDto() -> HealthConnectorErrorDto {
        // Use [String: String] for Sendable compatibility
        var details: [String: String] = [:]

        // Include context (converting Any values to strings)
        if let ctx = context {
            for (key, value) in ctx {
                details[key] = String(describing: value)
            }
        }

        // Include underlying error information if available
        if let cause = error {
            details["cause"] = cause.localizedDescription

            // Extract domain and code from NSError for deeper debugging
            if let nsError = cause as? NSError {
                details["errorDomain"] = nsError.domain
                details["errorCode"] = String(nsError.code)

                // Include user info dictionary (converted to strings)
                if !nsError.userInfo.isEmpty {
                    for (key, value) in nsError.userInfo {
                        details["errorUserInfo_\(key)"] = String(describing: value)
                    }
                }
            }

            // Include failure reason if available
            if let localized = cause as? LocalizedError, let failureReason = localized.failureReason {
                details["failureReason"] = failureReason
            }
        }

        // Include recovery suggestion if available
        if let suggestion = recoverySuggestion {
            details["recoverySuggestion"] = suggestion
        }

        // Include debug description for development/logging
        details["debugDescription"] = debugDescription

        // Include call stack symbols for debugging (limited to first 10 frames for size)
        let stackSymbols = Thread.callStackSymbols
        if stackSymbols.count > 1 {
            // Skip first frame (this method) and limit to 10 frames for reasonable size
            let relevantFrames = Array(stackSymbols.dropFirst().prefix(10))
            details["stackTrace"] = relevantFrames.joined(separator: "\n")
        }

        return HealthConnectorErrorDto(
            code: code,
            message: message,
            details: details.isEmpty ? nil : details
        )
    }

    /// Creates a `HealthConnectorError` from an `Error`.
    ///
    /// This factory method intelligently maps errors to appropriate HealthConnectorError cases.
    /// It provides specialized handling for HealthKit errors (`HKError`) and falls back to generic handling for others.
    ///
    /// ## HealthKit Error Mappings
    ///
    /// | HKError Code | HealthConnectorError |
    /// |--------------|---------------------|
    /// | `.errorAuthorizationDenied` | `.notAuthorized` |
    /// | `.errorAuthorizationNotDetermined` | `.notAuthorized` |
    /// | `.errorInvalidArgument` | `.invalidArgument` |
    /// | `.errorHealthDataUnavailable` | `.healthPlatformUnavailable` |
    /// | `.errorDatabaseInaccessible` | `.healthPlatformUnavailable` |
    /// | `.errorHealthDataRestricted` | `.healthPlatformUnavailable` |
    /// | `.errorUserCanceled` | `.notAuthorized` |
    /// | All others | `.unknown` (with cause) |
    ///
    /// - Parameter error: The Error to convert
    /// - Returns: A HealthConnectorError with appropriate error type and preserved underlying error information
    static func create(from error: Error) -> HealthConnectorError {
        // Build context with basic error metadata
        var context: [String: Any] = [:]

        // If it's an NSError, capture domain and code
        let nsError = error as NSError
        context["errorDomain"] = nsError.domain
        context["errorCode"] = nsError.code

        if let failureReason = nsError.localizedFailureReason {
            context["failureReason"] = failureReason
        }

        // specialized handling for HKError
        if let hkError = error as? HKError {
            // Include HealthKit-specific context
            context["errorDomain"] = HKError.errorDomain

            switch hkError.code {
            case .errorAuthorizationDenied, .errorAuthorizationNotDetermined:
                return .notAuthorized(
                    message: hkError.localizedDescription,
                    context: context
                )

            case .errorInvalidArgument:
                return .invalidArgument(
                    message: hkError.localizedDescription,
                    context: context
                )

            case .errorHealthDataUnavailable, .errorDatabaseInaccessible,
                 .errorHealthDataRestricted:
                return .healthPlatformUnavailable(
                    message: hkError.localizedDescription,
                    cause: hkError
                )

            case .errorUserCanceled:
                return .userCancelled(
                    message: hkError.localizedDescription
                )

            case .errorNoData:
                return .unknown(
                    message: "No health data available for the requested query",
                    cause: hkError,
                    context: context
                )

            @unknown default:
                return .unknown(
                    message: hkError.localizedDescription,
                    cause: hkError,
                    context: context
                )
            }
        }

        // Generic error handling
        return .unknown(
            message: error.localizedDescription,
            cause: error,
            context: context.isEmpty ? nil : context
        )
    }
}
