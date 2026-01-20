import Foundation
import HealthKit

/// Extension for mapping `HKCategorySample` → `HighHeartRateEventRecordDto`.
extension HKCategorySample {
    /// Converts this HealthKit sample to a `HighHeartRateEventRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a high heart rate event sample.
    func toHighHeartRateEventRecordDto() throws -> HighHeartRateEventRecordDto {
        guard categoryType.identifier == HKCategoryTypeIdentifier.highHeartRateEvent.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected high heart rate event category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.highHeartRateEvent.rawValue,
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

        return try HighHeartRateEventRecordDto(
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
