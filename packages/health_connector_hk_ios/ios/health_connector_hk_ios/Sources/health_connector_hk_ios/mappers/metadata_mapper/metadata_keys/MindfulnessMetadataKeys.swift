import Foundation

// MARK: - StringSerializable Conformance

extension MindfulnessSessionTypeDto: StringSerializable {
    private enum Constants {
        static let unknown = "unknown"
        static let meditation = "meditation"
        static let breathing = "breathing"
        static let music = "music"
        static let movement = "movement"
        static let unguided = "unguided"
    }

    func toMetadataString() -> String {
        switch self {
        case .unknown: Constants.unknown
        case .meditation: Constants.meditation
        case .breathing: Constants.breathing
        case .music: Constants.music
        case .movement: Constants.movement
        case .unguided: Constants.unguided
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.unknown: .unknown
        case Constants.meditation: .meditation
        case Constants.breathing: .breathing
        case Constants.music: .music
        case Constants.movement: .movement
        case Constants.unguided: .unguided
        default: nil
        }
    }
}

// MARK: - Metadata Keys

/// Custom metadata key for storing mindfulness session type.
///
/// ## Why this exists
///
/// HealthKit only supports a generic `mindfulSession` category type with no native
/// field to distinguish between different session types (meditation, breathing, etc.).
/// We store the specific session type in custom metadata to maintain full fidelity
/// with the cross-platform data model.
enum MindfulnessSessionTypeKey: StringEnumMetadataKey {
    typealias Value = MindfulnessSessionTypeDto

    static let keySuffix = "session_type"
    static let defaultValue: MindfulnessSessionTypeDto = .unknown
}

/// Custom metadata key for storing mindfulness session notes.
///
/// ## Why this exists
///
/// HealthKit has no standard metadata key for session notes. We use a custom key
/// to preserve user-entered notes across the platform bridge.
enum MindfulnessSessionNotesKey: CustomMetadataKey {
    typealias Value = String

    static let keySuffix = "session_notes"

    static func serialize(_ value: String) -> Any {
        value
    }

    static func deserialize(_ rawValue: Any?) -> String? {
        rawValue as? String
    }
}
