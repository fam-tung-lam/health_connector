import Foundation
import HealthKit

/// Mappers for converting HKCategorySample to SleepStageRecordDto
extension HKCategorySample {
    /// Convert HKCategorySample to SleepStageRecordDto
    func toSleepStageRecordDto() -> SleepStageRecordDto? {
        guard categoryType.identifier == HKCategoryTypeIdentifier.sleepAnalysis.rawValue else {
            return nil
        }

        let stageType = HKCategoryValueSleepAnalysis(rawValue: value)?.toDto() ?? .unknown
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
