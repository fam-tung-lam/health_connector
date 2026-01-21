import Foundation
import HealthKit

/// Extension for mapping `HKQuantitySample` → `WalkingHeartRateAverageRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `WalkingHeartRateAverageRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a walking heart rate average sample.
    func toWalkingHeartRateAverageRecordDto() throws -> WalkingHeartRateAverageRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.walkingHeartRateAverage.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected walking heart rate average quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.walkingHeartRateAverage.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        // Unit for Heart Rate is count/min
        let bpmUnit = HKUnit.count().unitDivided(by: .minute())
        let beatsPerMinute = quantity.doubleValue(for: bpmUnit)

        return try WalkingHeartRateAverageRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            beatsPerMinute: beatsPerMinute,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
