import Foundation
import HealthKit

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `MoveTimeRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an apple move time sample.
    func toMoveTimeRecordDto() throws -> MoveTimeRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.appleMoveTime.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected apple move time quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.appleMoveTime.rawValue,
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

        return try MoveTimeRecordDto(
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
