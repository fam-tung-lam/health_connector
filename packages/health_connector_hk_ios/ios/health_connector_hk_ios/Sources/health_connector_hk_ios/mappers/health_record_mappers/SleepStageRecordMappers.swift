import Foundation
import HealthKit

/// Mappers for converting SleepStageRecordDto to HKCategorySample
///
/// This extension provides conversion from our platform-agnostic sleep stage DTOs
/// to HealthKit's native category samples.
///
/// **Usage:**
/// ```swift
/// let dto = SleepStageRecordDto(...)
/// let sample = try dto.toHealthKit()
/// try await healthStore.save(sample)
/// ```
///
/// **Compatibility:** iOS 15+
/// **Verified:** December 1, 2025
extension SleepStageRecordDto {
    /// Convert SleepStageRecordDto to HKCategorySample
    ///
    /// Creates an HKCategorySample with:
    /// - Category type: `.sleepAnalysis`
    /// - Value: Corresponding HKCategoryValueSleepAnalysis
    /// - Start/end dates: From DTO timestamps
    /// - Metadata: Including timezone offsets and device info
    ///
    /// - Returns: HKCategorySample representing this sleep stage
    /// - Throws: NSError if the category type cannot be created
    ///
    /// **Example:**
    /// ```swift
    /// let dto = SleepStageRecordDto(
    ///     id: nil,  // Will be assigned by HealthKit
    ///     startTime: 1640995200000,  // 11:00 PM
    ///     endTime: 1641002400000,    // 1:00 AM
    ///     metadata: MetadataDto(...),
    ///     stageType: .deep
    /// )
    /// let sample = try dto.toHealthKit()
    /// ```
    func toHealthKit() throws -> HKCategorySample {
        // Get the sleep analysis category type
        guard let categoryType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create sleep analysis category type"]
            )
        }

        // Convert stage type to HealthKit value
        let value = HKCategoryValueSleepAnalysis.from(dto: stageType).rawValue

        // Convert timestamps to Date objects
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

        // Build metadata dictionary
        var metadataDict = metadata.toHealthKitMetadata(timeZone: TimeZone.current)

        // Add timezone offsets if provided
        // Note: We store both start and end offsets since sleep spans can cross DST boundaries
        if let startOffset = startZoneOffsetSeconds {
            metadataDict[HKMetadataKeyTimeZone] = TimeZone(secondsFromGMT: Int(startOffset))?.identifier
        }

        // If end offset differs from start, we note that in custom metadata
        // (HealthKit doesn't have native support for dual timezone offsets per sample)
        if let endOffset = endZoneOffsetSeconds,
           endOffset != startZoneOffsetSeconds {
            metadataDict["EndTimeZoneOffset"] = endOffset
        }

        // Create the category sample
        return HKCategorySample(
            type: categoryType,
            value: value,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadataDict
        )
    }
}

/// Mappers for HKCategoryValueSleepAnalysis to SleepStageTypeDto
extension HKCategoryValueSleepAnalysis {
    /// Convert HKCategoryValueSleepAnalysis to SleepStageTypeDto
    ///
    /// Maps iOS HealthKit sleep analysis values to our platform-agnostic enum.
    ///
    /// **iOS Sleep Analysis Values:**
    /// - `.inBed` - User is in bed (not necessarily asleep)
    /// - `.asleep` - Asleep (generic, when stage detail unavailable) [deprecated in iOS 16]
    /// - `.awake` - Awake in bed
    /// - `.core` - Core sleep (iOS 16+, replaces asleep)
    /// - `.deep` - Deep sleep
    /// - `.rem` - REM sleep
    /// - `.unspecified` - Unknown/unspecified
    ///
    /// - Returns: Corresponding SleepStageTypeDto value
    func toDto() -> SleepStageTypeDto {
        switch self {
        case .inBed:
            return .inBed
        case .asleep:
            // Generic "asleep" state (used in iOS 15 and earlier)
            return .sleeping
        case .awake:
            return .awake
        #if compiler(>=5.5) // iOS 16+
        @unknown default:
            // Handle new iOS 16+ sleep stages
            // Note: We need to use rawValue comparison because Swift doesn't allow
            // switch on @unknown cases with specific values
            if #available(iOS 16.0, *) {
                // iOS 16 introduced new sleep stages:
                // - HKCategoryValueSleepAnalysis.core (rawValue: 5)
                // - HKCategoryValueSleepAnalysis.deep (rawValue: 3)
                // - HKCategoryValueSleepAnalysis.REM (rawValue: 4)
                switch rawValue {
                case 3: // .deep
                    return .deep
                case 4: // .rem
                    return .rem
                case 5: // .core (light sleep)
                    return .light
                default:
                    return .unknown
                }
            }
            return .unknown
        #endif
        }
    }

    /// Convert SleepStageTypeDto to HKCategoryValueSleepAnalysis
    ///
    /// Maps our platform-agnostic enum to iOS HealthKit sleep analysis values.
    ///
    /// - Parameter dto: The SleepStageTypeDto to convert
    /// - Returns: Corresponding HKCategoryValueSleepAnalysis value
    ///
    /// **Note:** iOS 16+ has more detailed stages. On iOS 15, some stages
    /// fall back to `.asleep` (generic sleep state).
    static func from(dto: SleepStageTypeDto) -> HKCategoryValueSleepAnalysis {
        switch dto {
        case .inBed:
            return .inBed
        case .sleeping:
            return .asleep
        case .awake:
            return .awake
        case .outOfBed:
            // HealthKit doesn't have an explicit "out of bed" state
            // Map to awake as the closest equivalent
            return .awake
        case .light:
            // iOS 16+: Use .core for light sleep
            // iOS 15: Fall back to generic .asleep
            if #available(iOS 16.0, *) {
                return HKCategoryValueSleepAnalysis(rawValue: 5)! // .core
            } else {
                return .asleep
            }
        case .deep:
            // iOS 16+: Use .deep
            // iOS 15: Fall back to generic .asleep
            if #available(iOS 16.0, *) {
                return HKCategoryValueSleepAnalysis(rawValue: 3)! // .deep
            } else {
                return .asleep
            }
        case .rem:
            // iOS 16+: Use .REM
            // iOS 15: Fall back to generic .asleep
            if #available(iOS 16.0, *) {
                return HKCategoryValueSleepAnalysis(rawValue: 4)! // .REM
            } else {
                return .asleep
            }
        case .unknown:
            // Use generic asleep for unknown stages
            return .asleep
        }
    }
}