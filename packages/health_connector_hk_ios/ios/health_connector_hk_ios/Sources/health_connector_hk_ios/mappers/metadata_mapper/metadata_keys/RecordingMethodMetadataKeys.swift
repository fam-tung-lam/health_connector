import Foundation

// MARK: - StringSerializable Conformance

extension RecordingMethodDto: StringSerializable {
    private enum Constants {
        static let activelyRecorded = "activelyRecorded"
        static let automaticallyRecorded = "automaticallyRecorded"
        static let manualEntry = "manualEntry"
        static let unknown = "unknown"
    }

    func toMetadataString() -> String {
        switch self {
        case .activelyRecorded: Constants.activelyRecorded
        case .automaticallyRecorded: Constants.automaticallyRecorded
        case .manualEntry: Constants.manualEntry
        case .unknown: Constants.unknown
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.activelyRecorded: .activelyRecorded
        case Constants.automaticallyRecorded: .automaticallyRecorded
        case Constants.manualEntry: .manualEntry
        case Constants.unknown: .unknown
        default: nil
        }
    }
}

// MARK: - Metadata Keys

/// Custom metadata key for storing recording method.
///
/// **Why this exists:**
/// HealthKit has no native support for recording method metadata. This key allows
/// tracking how health data was recorded (actively, automatically, or manually entered).
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_recording_method`
enum RecordingMethodKey: StringEnumMetadataKey {
    typealias Value = RecordingMethodDto

    static let keySuffix = "recording_method"
    static let defaultValue: RecordingMethodDto = .unknown
}
