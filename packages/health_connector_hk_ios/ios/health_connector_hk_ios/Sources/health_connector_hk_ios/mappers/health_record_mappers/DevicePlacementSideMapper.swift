import Foundation
import HealthKit

/// Extension for mapping `DevicePlacementSideDto` → `HKDevicePlacementSide`.
extension DevicePlacementSideDto {
    /// Converts this `DevicePlacementSideDto` to its corresponding `HKDevicePlacementSide`.
    ///
    /// - Returns: The corresponding `HKDevicePlacementSide`
    func toHealthKit() -> HKDevicePlacementSide {
        switch self {
        case .unknown:
            .unknown
        case .central:
            .central
        case .left:
            .left
        case .right:
            .right
        }
    }
}

/// Extension for mapping `HKDevicePlacementSide` → `DevicePlacementSideDto`.
extension HKDevicePlacementSide {
    /// Converts this `HKDevicePlacementSide` to its corresponding `DevicePlacementSideDto`.
    ///
    /// - Returns: The corresponding `DevicePlacementSideDto`
    func toDto() -> DevicePlacementSideDto {
        switch self {
        case .unknown:
            return .unknown
        case .central:
            return .central
        case .left:
            return .left
        case .right:
            return .right
        @unknown default:
            return .unknown
        }
    }
}
