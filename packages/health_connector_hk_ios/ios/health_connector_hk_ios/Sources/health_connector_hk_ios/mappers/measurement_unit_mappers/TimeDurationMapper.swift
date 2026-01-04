import Foundation
import HealthKit

extension TimeDurationDto {
    /// Converts this DTO to a TimeInterval (seconds as Double).
    func toTimeInterval() -> TimeInterval {
        TimeInterval(seconds)
    }
}

extension TimeInterval {
    /// Converts a TimeInterval (seconds) to an TimeDurationDto.
    ///
    /// Uses seconds as the transfer unit for consistency.
    func toIntervalDto() -> TimeDurationDto {
        TimeDurationDto(seconds: self)
    }
}
