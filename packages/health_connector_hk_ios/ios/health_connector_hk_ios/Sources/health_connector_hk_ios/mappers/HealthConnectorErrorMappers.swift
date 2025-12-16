import Foundation

extension HealthConnectorError {
    /// Converts the error into a serializable data transfer object.
    ///
    /// This method aggregates the error's `context`, underlying `cause`, and `recoverySuggestion`
    /// into a single `details` dictionary for transmission to Flutter.
    ///
    /// - Returns: A `HealthConnectorErrorDto` containing the error code, message, and details.
    func toDto() -> HealthConnectorErrorDto {
        var details: [String: Any] = context ?? [:]

        if let cause = error {
            details["cause"] = cause.localizedDescription
        }

        if let suggestion = recoverySuggestion {
            details["recoverySuggestion"] = suggestion
        }

        return HealthConnectorErrorDto(
            code: code,
            message: message,
            details: details.isEmpty ? nil : details
        )
    }
}
