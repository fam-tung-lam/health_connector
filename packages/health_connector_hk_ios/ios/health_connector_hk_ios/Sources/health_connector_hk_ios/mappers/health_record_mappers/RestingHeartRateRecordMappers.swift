import Foundation
import HealthKit

extension RestingHeartRateRecordDto {
    /*
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .restingHeartRate) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create resting heart rate quantity type"]
            )
        }

        let bpmUnit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: bpmUnit, doubleValue: beatsPerMinute.value)
        let date = Date(timeIntervalSince1970: TimeInterval(time) / 1000.0)

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
    /*
     * Converts this HealthKit sample to a `RestingHeartRateRecordDto`.
     *
     * Returns `nil` if this sample is not a resting heart rate sample.
     */
    func toRestingHeartRateRecordDto() -> RestingHeartRateRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.restingHeartRate.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        let bpmUnit = HKUnit.count().unitDivided(by: .minute())
        let beatsPerMinute = quantity.doubleValue(for: bpmUnit)

        return RestingHeartRateRecordDto(
            id: uuid.uuidString,
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            beatsPerMinute: NumericDto(unit: .numeric, value: beatsPerMinute),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
