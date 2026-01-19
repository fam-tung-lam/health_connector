import Foundation
import HealthKit

extension DevicePlacementSideDto {
    /// Converts this DTO to a HealthKit device placement side.
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

extension HKDevicePlacementSide {
    /// Converts this HealthKit device placement side to a DTO.
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
