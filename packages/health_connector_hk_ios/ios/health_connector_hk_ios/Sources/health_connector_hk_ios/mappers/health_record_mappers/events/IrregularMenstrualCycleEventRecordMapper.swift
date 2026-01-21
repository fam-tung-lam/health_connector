import Foundation
import HealthKit

/// Extension for mapping `HKCategorySample` → `IrregularMenstrualCycleEventRecordDto`.
extension HKCategorySample {
    /// Converts this HealthKit sample to an `IrregularMenstrualCycleEventRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an irregular menstrual cycle event
    /// sample.
    @available(iOS 16.0, *)
    func toIrregularMenstrualCycleEventRecordDto() throws -> IrregularMenstrualCycleEventRecordDto {
        guard categoryType.identifier == HKCategoryTypeIdentifier.irregularMenstrualCycles.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected irregular menstrual cycle event category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.irregularMenstrualCycles.rawValue,
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

        return try IrregularMenstrualCycleEventRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
