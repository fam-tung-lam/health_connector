import Foundation

// MARK: - StringSerializable Conformance

extension BasalBodyTemperatureMeasurementLocationDto: StringSerializable {
    private enum Constants {
        static let unknown = "unknown"
        static let armpit = "armpit"
        static let ear = "ear"
        static let finger = "finger"
        static let forehead = "forehead"
        static let mouth = "mouth"
        static let rectum = "rectum"
        static let temporalArtery = "temporalArtery"
        static let toe = "toe"
        static let vagina = "vagina"
        static let wrist = "wrist"
    }

    func toMetadataString() -> String {
        switch self {
        case .unknown: Constants.unknown
        case .armpit: Constants.armpit
        case .ear: Constants.ear
        case .finger: Constants.finger
        case .forehead: Constants.forehead
        case .mouth: Constants.mouth
        case .rectum: Constants.rectum
        case .temporalArtery: Constants.temporalArtery
        case .toe: Constants.toe
        case .vagina: Constants.vagina
        case .wrist: Constants.wrist
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.unknown: .unknown
        case Constants.armpit: .armpit
        case Constants.ear: .ear
        case Constants.finger: .finger
        case Constants.forehead: .forehead
        case Constants.mouth: .mouth
        case Constants.rectum: .rectum
        case Constants.temporalArtery: .temporalArtery
        case Constants.toe: .toe
        case Constants.vagina: .vagina
        case Constants.wrist: .wrist
        default: nil
        }
    }
}

// MARK: - Metadata Keys

/// Custom metadata key for storing basal body temperature measurement location.
///
/// **Why this exists:**
/// HealthKit has no native support for measurement location in basal body temperature records.
/// Android Health Connect provides this natively, so we store it in custom metadata to maintain
/// cross-platform parity.
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_basal_body_temperature_measurement_location`
enum BasalBodyTemperatureMeasurementLocationKey: StringEnumMetadataKey {
    typealias Value = BasalBodyTemperatureMeasurementLocationDto

    static let keySuffix = "basal_body_temperature_measurement_location"
    static let defaultValue: BasalBodyTemperatureMeasurementLocationDto = .unknown
}
