import Foundation
import HealthKit

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `StandTimeRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an apple stand time sample.
    func toStandTimeRecordDto() throws -> StandTimeRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.appleStandTime.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected apple stand time quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.appleStandTime.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        // Convert quantity to seconds
        let seconds = quantity.doubleValue(for: .second())

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try StandTimeRecordDto(
            seconds: seconds,
            endTime: endDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
