import Foundation
import HealthKit

/// Extension for mapping `HKQuantitySample` → `ExerciseTimeRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `ExerciseTimeRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an apple exercise time sample.
    func toExerciseTimeRecordDto() throws -> ExerciseTimeRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.appleExerciseTime.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected apple exercise time quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.appleExerciseTime.rawValue,
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

        return try ExerciseTimeRecordDto(
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
