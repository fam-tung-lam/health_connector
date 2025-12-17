import Foundation
import HealthKit

extension RestingHeartRateRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .restingHeartRate)

        let bpmUnit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: bpmUnit, doubleValue: beatsPerMinute.value)
        let date = Date(millisecondsSince1970: time)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `RestingHeartRateRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a resting heart rate sample.
    func toRestingHeartRateRecordDto() throws -> RestingHeartRateRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.restingHeartRate.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected resting heart rate quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.restingHeartRate.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        let bpmUnit = HKUnit.count().unitDivided(by: .minute())
        let beatsPerMinute = quantity.doubleValue(for: bpmUnit)

        return RestingHeartRateRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            beatsPerMinute: NumericDto(unit: .numeric, value: beatsPerMinute),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
