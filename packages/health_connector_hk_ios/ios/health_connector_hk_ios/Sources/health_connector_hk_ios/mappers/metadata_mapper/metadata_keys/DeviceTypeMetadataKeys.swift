import Foundation

// MARK: - StringSerializable Conformance

extension DeviceTypeDto: StringSerializable {
    private enum Constants {
        static let chestStrap = "chest_strap"
        static let fitnessBand = "fitness_band"
        static let headMounted = "head_mounted"
        static let phone = "phone"
        static let ring = "ring"
        static let scale = "scale"
        static let smartDisplay = "smart_display"
        static let unknown = "unknown"
        static let watch = "watch"
    }

    func toMetadataString() -> String {
        switch self {
        case .chestStrap: Constants.chestStrap
        case .fitnessBand: Constants.fitnessBand
        case .headMounted: Constants.headMounted
        case .phone: Constants.phone
        case .ring: Constants.ring
        case .scale: Constants.scale
        case .smartDisplay: Constants.smartDisplay
        case .unknown: Constants.unknown
        case .watch: Constants.watch
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.chestStrap: .chestStrap
        case Constants.fitnessBand: .fitnessBand
        case Constants.headMounted: .headMounted
        case Constants.phone: .phone
        case Constants.ring: .ring
        case Constants.scale: .scale
        case Constants.smartDisplay: .smartDisplay
        case Constants.unknown: .unknown
        case Constants.watch: .watch
        default: nil
        }
    }
}

// MARK: - Metadata Keys

/// Custom metadata key for storing device type.
///
/// **Why this exists:**
/// While HealthKit's `HKDevice` includes some device information (name, manufacturer, model, etc.),
/// it doesn't have a standardized device type classification. We store the device type in custom
/// metadata to maintain full fidelity with the cross-platform data model and enable device-type-based
/// filtering and analysis.
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_device_type`
enum DeviceTypeKey: StringEnumMetadataKey {
    typealias Value = DeviceTypeDto

    static let keySuffix = "device_type"
    static let defaultValue: DeviceTypeDto = .unknown
}
