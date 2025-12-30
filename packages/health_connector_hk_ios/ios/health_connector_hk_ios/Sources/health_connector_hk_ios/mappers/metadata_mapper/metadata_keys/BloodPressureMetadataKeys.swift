import Foundation

// MARK: - StringSerializable Conformance

extension BodyPositionDto: StringSerializable {
    private enum Constants {
        static let unknown = "unknown"
        static let standingUp = "standingUp"
        static let sittingDown = "sittingDown"
        static let lyingDown = "lyingDown"
        static let reclining = "reclining"
    }

    func toMetadataString() -> String {
        switch self {
        case .unknown: Constants.unknown
        case .standingUp: Constants.standingUp
        case .sittingDown: Constants.sittingDown
        case .lyingDown: Constants.lyingDown
        case .reclining: Constants.reclining
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.unknown: .unknown
        case Constants.standingUp: .standingUp
        case Constants.sittingDown: .sittingDown
        case Constants.lyingDown: .lyingDown
        case Constants.reclining: .reclining
        default: nil
        }
    }
}

extension MeasurementLocationDto: StringSerializable {
    private enum Constants {
        static let unknown = "unknown"
        static let leftWrist = "leftWrist"
        static let rightWrist = "rightWrist"
        static let leftUpperArm = "leftUpperArm"
        static let rightUpperArm = "rightUpperArm"
    }

    func toMetadataString() -> String {
        switch self {
        case .unknown: Constants.unknown
        case .leftWrist: Constants.leftWrist
        case .rightWrist: Constants.rightWrist
        case .leftUpperArm: Constants.leftUpperArm
        case .rightUpperArm: Constants.rightUpperArm
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.unknown: .unknown
        case Constants.leftWrist: .leftWrist
        case Constants.rightWrist: .rightWrist
        case Constants.leftUpperArm: .leftUpperArm
        case Constants.rightUpperArm: .rightUpperArm
        default: nil
        }
    }
}

// MARK: - Metadata Keys

/// Custom metadata key for storing blood pressure body position.
///
/// **Why this exists:**
/// HealthKit has no native support for body position during blood pressure measurement.
/// This information is important for clinical accuracy as body position can significantly
/// affect blood pressure readings.
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_body_position`
enum BodyPositionKey: StringEnumMetadataKey {
    typealias Value = BodyPositionDto

    static let keySuffix = "body_position"
    static let defaultValue: BodyPositionDto = .unknown
}

/// Custom metadata key for storing blood pressure measurement location.
///
/// **Why this exists:**
/// HealthKit has no native support for measurement location (e.g., left wrist, right upper arm).
/// This information is important for clinical accuracy and consistency in blood pressure
/// monitoring.
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_measurement_location`
enum MeasurementLocationKey: StringEnumMetadataKey {
    typealias Value = MeasurementLocationDto

    static let keySuffix = "measurement_location"
    static let defaultValue: MeasurementLocationDto = .unknown
}
