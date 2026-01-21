import Foundation
import HealthKit

/// Extension for mapping `HKCategorySample` → `InfrequentMenstrualCycleEventRecordDto`.
extension HKCategorySample {
    /// Converts this HealthKit sample to an `InfrequentMenstrualCycleEventRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an infrequent menstrual cycle event
    /// sample.
    @available(iOS 16.0, *)
    func toInfrequentMenstrualCycleEventRecordDto() throws -> InfrequentMenstrualCycleEventRecordDto {
        guard categoryType.identifier == HKCategoryTypeIdentifier.infrequentMenstrualCycles.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected infrequent menstrual cycle event category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.infrequentMenstrualCycles.rawValue,
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

        return try InfrequentMenstrualCycleEventRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
