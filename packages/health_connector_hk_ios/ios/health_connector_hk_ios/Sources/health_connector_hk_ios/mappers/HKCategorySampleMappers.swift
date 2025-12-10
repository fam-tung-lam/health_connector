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
