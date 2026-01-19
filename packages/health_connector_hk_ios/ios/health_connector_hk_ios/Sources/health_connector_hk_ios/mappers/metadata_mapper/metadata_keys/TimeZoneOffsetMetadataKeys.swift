import Foundation
import HealthKit

// MARK: - TimeZone Metadata Keys

/// Custom metadata key for storing start timezone offset in seconds from GMT.
///
/// ## Why this exists
///
/// HealthKit only supports a single timezone per sample via `HKMetadataKeyTimeZone`.
/// We use this custom key to explicitly store the start timezone offset, which is useful
/// for precise timezone tracking and handling daylight saving time transitions.
/// This is especially important when start and end timezones differ (e.g., travel).
enum StartTimeZoneOffsetKey: CustomMetadataKey {
    typealias Value = Int64

    static let keySuffix = "start_time_zone_offset"

    static func serialize(_ value: Int64) -> Any { NSNumber(value: value) }
    static func deserialize(_ rawValue: Any?) -> Int64? {
        (rawValue as? NSNumber)?.int64Value
    }

    /// Reads the start timezone offset from metadata.
    ///
    /// First attempts to read from our custom metadata key. If not present,
    /// falls back to extracting the offset from the native HealthKit timezone.
    ///
    /// - Parameter metadata: The HealthKit metadata dictionary
    /// - Returns: The timezone offset in seconds, or `nil` if not available
    static func read(from metadata: [String: Any]?) -> Int64? {
        // First try reading from custom key using superclass implementation
        if let customValue = deserialize(metadata?[fullKey]) {
            return customValue
        }

        // Fallback to native HealthKit timezone key
        guard let timeZoneString = metadata?[HKMetadataKeyTimeZone] as? String,
              let timeZone = TimeZone(identifier: timeZoneString)
        else {
            return nil
        }

        return Int64(timeZone.secondsFromGMT())
    }
}

/// Custom metadata key for storing end timezone offset in seconds from GMT.
///
/// ## Why this exists
///
/// HealthKit only supports a single timezone per sample via `HKMetadataKeyTimeZone`.
/// We use this custom key to explicitly store the end timezone offset, which is useful
/// for precise timezone tracking and handling daylight saving time transitions.
/// This is especially important when start and end timezones differ (e.g., travel).
enum EndTimeZoneOffsetKey: CustomMetadataKey {
    typealias Value = Int64

    static let keySuffix = "end_time_zone_offset"

    static func serialize(_ value: Int64) -> Any { NSNumber(value: value) }
    static func deserialize(_ rawValue: Any?) -> Int64? {
        (rawValue as? NSNumber)?.int64Value
    }

    /// Reads the end timezone offset from metadata.
    ///
    /// First attempts to read from our custom metadata key. If not present,
    /// falls back to extracting the offset from the native HealthKit timezone.
    ///
    /// - Parameter metadata: The HealthKit metadata dictionary
    /// - Returns: The timezone offset in seconds, or `nil` if not available
    static func read(from metadata: [String: Any]?) -> Int64? {
        // First try reading from custom key using superclass implementation
        if let customValue = deserialize(metadata?[fullKey]) {
            return customValue
        }

        // Fallback to native HealthKit timezone key
        guard let timeZoneString = metadata?[HKMetadataKeyTimeZone] as? String,
              let timeZone = TimeZone(identifier: timeZoneString)
        else {
            return nil
        }

        return Int64(timeZone.secondsFromGMT())
    }
}
