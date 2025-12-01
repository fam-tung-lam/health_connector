import Foundation
import HealthKit

/// Mappers for converting HKCategorySample to SleepStageRecordDto
///
/// This extension provides bidirectional mapping between HealthKit's sleep analysis
/// category samples and our platform-agnostic sleep stage DTOs.
///
/// **HealthKit Sleep Analysis:**
/// - Uses `HKCategoryTypeIdentifier.sleepAnalysis`
/// - Each sample represents a continuous period in one sleep stage
/// - Complete sleep session = multiple samples (one per stage transition)
///
/// **Compatibility:** iOS 15+
/// **Verified:** December 1, 2025
extension HKCategorySample {
    /// Convert HKCategorySample to SleepStageRecordDto
    ///
    /// - Returns: SleepStageRecordDto if this is a sleep analysis sample, nil otherwise
    ///
    /// **Example:**
    /// ```swift
    /// let categorySample: HKCategorySample = // ... sleep sample from HealthKit
    /// let dto = categorySample.toSleepStageRecordDto()
    /// print("Sleep stage: \(dto?.stageType)")
    /// ```
    func toSleepStageRecordDto() -> SleepStageRecordDto? {
        // Verify this is a sleep analysis sample
        guard categoryType.identifier == HKCategoryTypeIdentifier.sleepAnalysis.rawValue else {
            return nil
        }

        // Convert HKCategoryValueSleepAnalysis to SleepStageTypeDto
        let stageType = HKCategoryValueSleepAnalysis(rawValue: value)?.toDto() ?? .unknown

        // Extract timezone offsets from metadata
        let metadataDict = metadata ?? [:]
        let startZoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let endZoneOffset = metadataDict.extractTimeZoneOffset(for: endDate)

        return SleepStageRecordDto(
            id: uuid.uuidString,
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            stageType: stageType,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
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
