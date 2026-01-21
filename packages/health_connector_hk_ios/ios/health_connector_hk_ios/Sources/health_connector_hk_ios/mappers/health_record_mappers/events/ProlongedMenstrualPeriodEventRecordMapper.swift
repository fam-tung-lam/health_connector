import Foundation
import HealthKit

/// Extension for mapping `HKCategorySample` → `ProlongedMenstrualPeriodEventRecordDto`.
extension HKCategorySample {
    /// Converts this HealthKit sample to an `ProlongedMenstrualPeriodEventRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a prolonged menstrual period event
    /// sample.
    @available(iOS 16.0, *)
    func toProlongedMenstrualPeriodEventRecordDto() throws -> ProlongedMenstrualPeriodEventRecordDto {
        guard categoryType.identifier == HKCategoryTypeIdentifier.prolongedMenstrualPeriods.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected prolonged menstrual period event category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.prolongedMenstrualPeriods.rawValue,
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

        return try ProlongedMenstrualPeriodEventRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
