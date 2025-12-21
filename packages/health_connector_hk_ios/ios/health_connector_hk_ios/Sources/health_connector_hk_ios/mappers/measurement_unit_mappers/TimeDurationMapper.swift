import Foundation
import HealthKit

extension TimeDurationDto {
    /// Converts this DTO to a TimeInterval (seconds as Double).
    func toTimeInterval() -> TimeInterval {
        let seconds: Double =
            switch unit {
            case .seconds:
                value
            case .minutes:
                value * 60.0
            case .hours:
                value * 3600.0
            }
        return TimeInterval(seconds)
    }
}

extension TimeInterval {
    /// Converts a TimeInterval (seconds) to an TimeDurationDto.
    ///
    /// Uses seconds as the transfer unit for consistency.
    func toIntervalDto() -> TimeDurationDto {
        TimeDurationDto(unit: .seconds, value: self)
    }
}
