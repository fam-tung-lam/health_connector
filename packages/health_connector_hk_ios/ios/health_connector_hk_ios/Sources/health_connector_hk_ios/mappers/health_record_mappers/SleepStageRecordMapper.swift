import Foundation
import HealthKit

/// iOS 16+ sleep stage raw values.
///
/// HealthKit introduced detailed sleep stages in iOS 16 with specific raw values.
/// These constants provide type-safe access to those values.
private enum iOS16SleepStage: Int {
    case deep = 3
    case rem = 4
    case light = 5 // HealthKit calls this "core" sleep
}

/// Mappers for converting SleepStageRecordDto to HKCategorySample
extension SleepStageRecordDto {
    /// Convert SleepStageRecordDto to HKCategorySample
    func toHealthKit() throws -> HKCategorySample {
        let categoryType = try HKCategoryType.make(from: HKCategoryTypeIdentifier.sleepAnalysis)

        let value = try HKCategoryValueSleepAnalysis.from(dto: stageType).rawValue
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)
        var metadataDict = metadata.toHealthKitMetadata(timeZone: TimeZone.current)
        if let startOffset = startZoneOffsetSeconds {
            metadataDict[HKMetadataKeyTimeZone] =
                TimeZone(secondsFromGMT: Int(startOffset))?.identifier
        }

        // If end offset differs from start, we note that in custom metadata
        // (HealthKit doesn't have native support for dual timezone offsets per sample)
        if let endOffset = endZoneOffsetSeconds,
           endOffset != startZoneOffsetSeconds
        {
            metadataDict["EndTimeZoneOffset"] = endOffset
        }

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
                    // iOS 16 introduced detailed sleep stages with specific raw values
                    switch rawValue {
                    case iOS16SleepStage.deep.rawValue:
                        return .deep
                    case iOS16SleepStage.rem.rawValue:
                        return .rem
                    case iOS16SleepStage.light.rawValue:
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
    /// - Throws: HealthConnectorError if sleep stage value is not supported
    static func from(dto: SleepStageTypeDto) throws -> HKCategoryValueSleepAnalysis {
        switch dto {
        case .inBed:
            .inBed
        case .sleeping:
            .asleep
        case .awake:
            .awake
        case .outOfBed:
            // HealthKit doesn't have an explicit "out of bed" state
            // Map to awake as the closest equivalent
            .awake
        case .light:
            // iOS 16+: Use .core for light sleep (rawValue: 5)
            try HKCategoryValueSleepAnalysis.make(from: 5)
        case .deep:
            // iOS 16+: Use .deep (rawValue: 3)
            try HKCategoryValueSleepAnalysis.make(from: 3)
        case .rem:
            // iOS 16+: Use .REM (rawValue: 4)
            try HKCategoryValueSleepAnalysis.make(from: 4)
        case .unknown:
            .asleep
        }
    }
}
