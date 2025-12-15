import Foundation
import HealthKit

/// Internal service responsible for validating the application's Info.plist configuration.
///
/// This service ensures that the integration requirements for HealthKit are met before attempting to request
/// permissions at runtime.
struct HealthConnectorInfoPListService: Taggable {
    /// Keys required in Info.plist for HealthKit integration
    ///
    /// These keys are displayed to users in permission dialogs.
    /// Missing or empty keys will cause authorization requests to fail silently or crash at runtime.
    private enum Keys {
        static let read = "NSHealthShareUsageDescription"
        static let write = "NSHealthUpdateUsageDescription"
    }

    /// Checks that required HealthKit usage description keys are present.
    ///
    /// - Parameters:
    ///    - bundle: The bundle to inspect. Defaults to `Bundle.main`.
    static func validate(in bundle: Bundle = .main) {
        var missingKeys: [String] = []

        if !hasKey(Keys.read, in: bundle) {
            missingKeys.append(Keys.read)
        }

        if !hasKey(Keys.write, in: bundle) {
            missingKeys.append(Keys.write)
        }

        if !missingKeys.isEmpty {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: "configuration_check",
                message: "Missing HealthKit Info.plist keys. App may crash on permission request.",
                context: [
                    "missing_keys": missingKeys.joined(separator: ", "),
                    "guidance": "Add the missing keys to Info.plist with valid descriptions.",
                ]
            )
        } else {
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: "configuration_check",
                message: "Info.plist is correctly configured for requested HealthKit permissions."
            )
        }
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
