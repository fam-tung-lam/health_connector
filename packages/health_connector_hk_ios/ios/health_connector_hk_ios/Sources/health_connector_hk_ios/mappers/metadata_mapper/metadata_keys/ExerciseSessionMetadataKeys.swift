import Foundation

// MARK: - Exercise Session Metadata Keys

/// Custom metadata key for storing workout title.
///
/// **Why this exists:**
/// HealthKit does not have a standard metadata key for workout titles.
/// We use a custom key to preserve user-entered titles across the platform bridge.
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_workout_title`
enum ExerciseSessionTitleKey: CustomMetadataKey {
    typealias Value = String

    static let keySuffix = "workout_title"

    static func serialize(_ value: String) -> Any { value }
    static func deserialize(_ rawValue: Any?) -> String? { rawValue as? String }
}

/// Custom metadata key for storing workout notes.
///
/// **Why this exists:**
/// HealthKit does not have a standard metadata key for workout notes.
/// We use a custom key to preserve user-entered notes across the platform bridge.
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_workout_notes`
enum ExerciseSessionNotesKey: CustomMetadataKey {
    typealias Value = String

    static let keySuffix = "workout_notes"

    static func serialize(_ value: String) -> Any { value }
    static func deserialize(_ rawValue: Any?) -> String? { rawValue as? String }
}
