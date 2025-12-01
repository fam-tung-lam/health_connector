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
