import Foundation
import HealthKit

extension HeartRateMeasurementRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .heartRate)

        // Heart rate is measured in beats per minute (count/minute)
        let unit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: unit, doubleValue: measurement.beatsPerMinute.value)
        let date = Date(millisecondsSince1970: measurement.time)

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
    /// Converts this HealthKit sample to a `HeartRateMeasurementRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a heart rate sample.
    func toHeartRateMeasurementRecordDto() throws -> HeartRateMeasurementRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.heartRate.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected heart rate quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.heartRate.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        // Heart rate is in beats per minute (count/minute)
        let unit = HKUnit.count().unitDivided(by: .minute())
        let bpmValue = quantity.doubleValue(for: unit)

        let measurement = HeartRateMeasurementDto(
            time: startDate.millisecondsSince1970,
            beatsPerMinute: NumericDto(unit: NumericUnitDto.numeric, value: bpmValue)
        )

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return HeartRateMeasurementRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            measurement: measurement,
            zoneOffsetSeconds: zoneOffset
        )
    }
}
