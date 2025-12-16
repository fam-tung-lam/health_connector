import Foundation

/// Utility class responsible for validating the application's Info.plist configuration.
enum HealthConnectorPlistValidator: Taggable {
    private enum Keys {
        static let read = "NSHealthShareUsageDescription"
        static let write = "NSHealthUpdateUsageDescription"
    }

    /// Validates that required HealthKit usage description keys are present.
    ///
    /// - Parameter bundle: The bundle to inspect. Defaults to `Bundle.main`.
    /// - Throws: `HealthConnectorError.invalidConfiguration` if keys are missing.
    static func validateUsageDescriptions(bundle: Bundle = .main) throws {
        var missingKeys: [String] = []

        if !hasKey(Keys.read, in: bundle) {
            missingKeys.append(Keys.read)
        }

        if !hasKey(Keys.write, in: bundle) {
            missingKeys.append(Keys.write)
        }

        guard missingKeys.isEmpty else {
            let message = "Missing Info.plist keys: \(missingKeys.joined(separator: ", "))"

            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: "configuration_check",
                message: message,
                context: ["missing_keys": missingKeys.joined(separator: ", ")]
            )

            throw HealthConnectorError.invalidConfiguration(
                message: message,
                context: ["missing_keys": missingKeys.joined(separator: ", ")]
            )
        }

        HealthConnectorLogger.debug(
            tag: Self.tag,
            operation: "configuration_check",
            message: "Info.plist is correctly configured for HealthKit."
        )
    }

    /// Checks if a key exists and has a non-empty value.
    ///
    /// - Parameters:
    ///   - key: The Info.plist key to check
    ///   - bundle: The bundle to check
    /// - Returns: `true` if the key exists and has a non-empty trimmed value, `false` otherwise
    private static func hasKey(_ key: String, in bundle: Bundle) -> Bool {
        guard let value = bundle.object(forInfoDictionaryKey: key) as? String else {
            return false
        }
        return !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
