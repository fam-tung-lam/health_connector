import Foundation
import HealthKit

extension CyclingPedalingCadenceMeasurementRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKQuantitySample {
        if #available(iOS 17.0, *) {
            let type = try HKQuantityType.make(from: .cyclingCadence)

            // Cycling pedaling cadence is measured in revolutions per minute (count/minute)
            let unit = HKUnit.count().unitDivided(by: .minute())
            let quantity = HKQuantity(
                unit: unit, doubleValue: measurement.revolutionsPerMinute.toDouble()
            )
            let date = Date(millisecondsSince1970: measurement.time)

            // Create builder with timezone offset
            var builder = try MetadataBuilder(
                from: metadata,
                startTimeZoneOffset: zoneOffsetSeconds
            )

            return HKQuantitySample(
                type: type,
                quantity: quantity,
                start: date,
                end: date, // Instant records have same start and end
                device: builder.healthDevice,
                metadata: builder.metadataDict
            )
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Cycling pedaling cadence is only supported on iOS 17.0 and later",
                context: ["dataType": "cyclingPedalingCadence", "minimumIOSVersion": "17.0"]
            )
        }
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `CyclingPedalingCadenceMeasurementRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a cycling cadence sample.
    func toCyclingPedalingCadenceMeasurementRecordDto() throws
        -> CyclingPedalingCadenceMeasurementRecordDto
    {
        if #available(iOS 17.0, *) {
            guard quantityType.identifier == HKQuantityTypeIdentifier.cyclingCadence.rawValue else {
                throw HealthConnectorError.invalidArgument(
                    message:
                    "Expected cycling cadence quantity type, got \(quantityType.identifier)",
                    context: [
                        "expected": HKQuantityTypeIdentifier.cyclingCadence.rawValue,
                        "actual": quantityType.identifier,
                    ]
                )
            }

            // Cycling pedaling cadence is in revolutions per minute (count/minute)
            let unit = HKUnit.count().unitDivided(by: .minute())
            let rpmValue = quantity.doubleValue(for: unit)

            let measurement = CyclingPedalingCadenceMeasurementDto(
                time: startDate.millisecondsSince1970,
                revolutionsPerMinute: NumberDto(value: rpmValue)
            )

            // Create builder from HK metadata with source and device
            var builder = MetadataBuilder(
                fromHKMetadata: metadata ?? [:],
                source: sourceRevision.source,
                device: device
            )

            // Extract timezone offset from metadata
            let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

            return try CyclingPedalingCadenceMeasurementRecordDto(
                id: uuid.uuidString,
                time: startDate.millisecondsSince1970,
                metadata: builder.toMetadataDto(),
                measurement: measurement,
                zoneOffsetSeconds: zoneOffset
            )
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Cycling pedaling cadence is only supported on iOS 17.0 and later",
                context: ["dataType": "cyclingPedalingCadence", "minimumIOSVersion": "17.0"]
            )
        }
    }
}
