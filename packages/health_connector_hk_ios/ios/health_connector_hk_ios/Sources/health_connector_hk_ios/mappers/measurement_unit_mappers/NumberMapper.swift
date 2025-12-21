import Foundation
import HealthKit

extension NumberDto {
    /// Converts this DTO to an Int64 value (for count-based measurements).
    func toInt64() -> Int64 {
        Int64(value)
    }

    /// Converts this DTO to a Double value (for count-based measurements).
    func toDouble() -> Double {
        value
    }
}

extension Int64 {
    /// Converts an Int64 value to a `NumberDto`.
    ///
    /// Uses count unit for consistency.
    func toNumberDto() -> NumberDto {
        NumberDto(value: Double(self))
    }
}
