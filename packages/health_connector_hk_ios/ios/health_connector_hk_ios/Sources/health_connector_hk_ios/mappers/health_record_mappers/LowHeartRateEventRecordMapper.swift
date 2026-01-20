import Foundation
import HealthKit

/// Extension for mapping `HKCategorySample` → `LowHeartRateEventRecordDto`.
extension HKCategorySample {
    /// Converts this HealthKit sample to a `LowHeartRateEventRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a low heart rate event sample.
    func toLowHeartRateEventRecordDto() throws -> LowHeartRateEventRecordDto {
        guard categoryType.identifier == HKCategoryTypeIdentifier.lowHeartRateEvent.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected low heart rate event category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.lowHeartRateEvent.rawValue,
                    "actual": categoryType.identifier,
                ]
            )
        }

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Read threshold from metadata
        let beatsPerMinuteThreshold = metadata?[HKMetadataKeyHeartRateEventThreshold] as? Double

        // Extract timezone offset from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try LowHeartRateEventRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            beatsPerMinuteThreshold: beatsPerMinuteThreshold,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
