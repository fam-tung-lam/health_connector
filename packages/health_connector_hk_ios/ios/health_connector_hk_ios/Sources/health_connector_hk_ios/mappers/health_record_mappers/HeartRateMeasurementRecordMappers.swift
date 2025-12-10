import Foundation
import HealthKit

extension HeartRateMeasurementRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create heart rate quantity type"]
            )
        }

        // Heart rate is measured in beats per minute (count/minute)
        let unit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: unit, doubleValue: measurement.beatsPerMinute.value)
        let date = Date(timeIntervalSince1970: TimeInterval(measurement.time) / 1000.0)

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
    /**
     * Converts this HealthKit sample to a `HeartRateMeasurementRecordDto`.
     *
     * Returns `nil` if this sample is not a heart rate sample.
     */
    func toHeartRateMeasurementRecordDto() -> HeartRateMeasurementRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.heartRate.rawValue else {
            return nil
        }

        // Heart rate is in beats per minute (count/minute)
        let unit = HKUnit.count().unitDivided(by: .minute())
        let bpmValue = quantity.doubleValue(for: unit)

        let measurement = HeartRateMeasurementDto(
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            beatsPerMinute: NumericDto(unit: NumericUnitDto.numeric, value: bpmValue)
        )

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return HeartRateMeasurementRecordDto(
            id: uuid.uuidString,
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            measurement: measurement,
            zoneOffsetSeconds: zoneOffset
        )
    }
}
