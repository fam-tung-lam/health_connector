import Foundation
import HealthKit

/// Extension for mapping `HKCategorySample` → `PersistentIntermenstrualBleedingEventRecordDto`.
extension HKCategorySample {
    /// Converts this HealthKit sample to an `PersistentIntermenstrualBleedingEventRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a persistent intermenstrual bleeding
    /// event
    /// sample.
    @available(iOS 16.0, *)
    func toPersistentIntermenstrualBleedingEventRecordDto() throws
        -> PersistentIntermenstrualBleedingEventRecordDto
    {
        guard
            categoryType.identifier
            == HKCategoryTypeIdentifier.persistentIntermenstrualBleeding.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected persistent intermenstrual bleeding event category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.persistentIntermenstrualBleeding.rawValue,
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

        // Extract timezone offset from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try PersistentIntermenstrualBleedingEventRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
