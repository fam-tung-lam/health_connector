import Foundation
import HealthKit

/// Extension to convert SortOrderDto to HKSampleSortIdentifier and direction.
extension SortOrderDto {
    /// Converts this DTO to HealthKit sort descriptor configuration.
    ///
    /// - Returns: Tuple of (sortIdentifier, ascending)
    func toHealthKitSort() -> (identifier: String, ascending: Bool) {
        switch self {
        case .timeAscending:
            (HKSampleSortIdentifierStartDate, true)
        case .timeDescending:
            (HKSampleSortIdentifierStartDate, false)
        }
    }
}
