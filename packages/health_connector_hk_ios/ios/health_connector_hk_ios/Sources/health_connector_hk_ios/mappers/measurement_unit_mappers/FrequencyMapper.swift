import Foundation

/// Converts a numeric frequency value (events per minute) to a `FrequencyDto`.
func toFrequencyDto(_ value: Double) -> FrequencyDto {
    FrequencyDto(perMinute: value)
}
