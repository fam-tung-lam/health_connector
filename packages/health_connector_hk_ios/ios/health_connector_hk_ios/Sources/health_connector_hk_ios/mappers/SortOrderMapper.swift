import Foundation
import HealthKit

/// Extension for mapping `SortOrderDto` → `(sortIdentifier: HKSampleSortIdentifier, ascending: Bool)`.
extension SortOrderDto {
    /// Converts this `SortOrderDto` to HealthKit sort descriptor configuration.
    ///
    /// - Returns: Tuple of (sortIdentifier, ascending)
    func toHKSampleSortIdentifier() -> (identifier: String, ascending: Bool) {
        switch self {
        case .timeAscending:
            (HKSampleSortIdentifierStartDate, true)
        case .timeDescending:
            (HKSampleSortIdentifierStartDate, false)
        }
    }
}
