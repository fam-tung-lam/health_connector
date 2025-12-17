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
        var details: [String: Any] = context ?? [:]

        // Include underlying error information if available
        if let cause = error {
            details["cause"] = cause.localizedDescription

            // Extract domain and code from NSError for deeper debugging
            if let nsError = cause as? NSError {
                details["errorDomain"] = nsError.domain
                details["errorCode"] = nsError.code

                // Include user info dictionary (filtered for serializable values)
                if !nsError.userInfo.isEmpty {
                    var serializableUserInfo: [String: Any] = [:]
                    for (key, value) in nsError.userInfo {
                        // Only include primitive types and strings for JSON serialization
                        if let stringValue = value as? String {
                            serializableUserInfo[key] = stringValue
                        } else if let numberValue = value as? NSNumber {
                            serializableUserInfo[key] = numberValue
                        } else if let boolValue = value as? Bool {
                            serializableUserInfo[key] = boolValue
                        } else {
                            // For complex objects, use their description
                            serializableUserInfo[key] = String(describing: value)
                        }
                    }
                    if !serializableUserInfo.isEmpty {
                        details["errorUserInfo"] = serializableUserInfo
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
            details["stackTrace"] = relevantFrames
        }

        return HealthConnectorErrorDto(
            code: code,
            message: message,
            details: details.isEmpty ? nil : details
        )
    }

    /// Creates a `HealthConnectorError` from an `HKError`.
    ///
    /// This factory method intelligently maps HealthKit errors to appropriate HealthConnectorError cases.
    /// It provides specialized handling for all common HealthKit error scenarios.
    ///
    /// ## HealthKit Error Mappings
    ///
    /// | HKError Code | HealthConnectorError |
    /// |--------------|---------------------|
    /// | `.errorAuthorizationDenied` | `.notAuthorized` |
    /// | `.errorAuthorizationNotDetermined` | `.notAuthorized` |
    /// | `.errorInvalidArgument` | `.invalidArgument` |
    /// | `.errorHealthDataUnavailable` | `.healthProviderUnavailable` |
    /// | `.errorDatabaseInaccessible` | `.healthProviderUnavailable` |
    /// | `.errorHealthDataRestricted` | `.healthProviderUnavailable` |
    /// | `.errorUserCanceled` | `.userCancelled` |
    /// | All others | `.unknown` (with cause) |
    ///
    /// - Parameter error: The HKError to convert
    /// - Returns: A HealthConnectorError with appropriate error type and preserved underlying error information
    ///
    /// ## Example
    /// ```swift
    /// // HealthKit authorization error
    /// healthStore.requestAuthorization(...) { success, error in
    ///     if let error = error as? HKError {
    ///         throw HealthConnectorError.create(from: error)
    ///     }
    /// }
    /// ```
    static func create(from error: HKError) -> HealthConnectorError {
        // Build context with error metadata
        var context: [String: Any] = [
            "errorDomain": HKError.errorDomain,
            "errorCode": error.errorCode,
        ]

        // Include localized failure reason if available (HKError is an NSError subclass)
        let nsError = error as NSError
        if let failureReason = nsError.localizedFailureReason {
            context["failureReason"] = failureReason
        }

        // Map based on HKError code
        switch error.code {
        case .errorAuthorizationDenied, .errorAuthorizationNotDetermined:
            return .notAuthorized(
                message: error.localizedDescription,
                context: context
            )

        case .errorInvalidArgument:
            return .invalidArgument(
                message: error.localizedDescription,
                context: context
            )

        case .errorHealthDataUnavailable, .errorDatabaseInaccessible, .errorHealthDataRestricted:
            return .healthProviderUnavailable(
                message: error.localizedDescription,
                cause: error
            )

        case .errorUserCanceled:
            return .userCancelled(
                message: error.localizedDescription
            )

        case .errorNoData:
            return .unknown(
                message: "No health data available for the requested query",
                cause: error,
                context: context
            )

        @unknown default:
            return .unknown(
                message: error.localizedDescription,
                cause: error,
                context: context
            )
        }
    }
}
