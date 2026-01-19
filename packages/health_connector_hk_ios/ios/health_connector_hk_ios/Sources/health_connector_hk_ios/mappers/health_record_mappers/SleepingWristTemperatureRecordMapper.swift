import Foundation
import HealthKit

extension SleepingWristTemperatureRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        if #available(iOS 16.0, *) {
            let type = try HKQuantityType.make(from: .appleSleepingWristTemperature)

            let quantity = HKQuantity(unit: .degreeCelsius(), doubleValue: temperatureCelsius)
            let startDate = Date(millisecondsSince1970: startTime)
            let endDate = Date(millisecondsSince1970: endTime)

            // Create builder with timezone offsets
            var builder = try MetadataBuilder(
                from: metadata,
                startTimeZoneOffset: startZoneOffsetSeconds,
                endTimeZoneOffset: endZoneOffsetSeconds
            )

            return HKQuantitySample(
                type: type,
                quantity: quantity,
                start: startDate,
                end: endDate,
                device: builder.healthDevice,
                metadata: builder.metadataDict
            )
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Sleeping wrist temperature is only supported on iOS 16.0 and later",
                context: ["dataType": "sleepingWristTemperature", "minimumIOSVersion": "16.0"]
            )
        }
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `SleepingWristTemperatureRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a sleeping wrist temperature sample.
    func toSleepingWristTemperatureRecordDto() throws -> SleepingWristTemperatureRecordDto {
        if #available(iOS 16.0, *) {
            guard
                quantityType.identifier
                == HKQuantityTypeIdentifier.appleSleepingWristTemperature.rawValue
            else {
                throw HealthConnectorError.invalidArgument(
                    message:
                    "Expected sleeping wrist temperature quantity type, got \(quantityType.identifier)",
                    context: [
                        "expected": HKQuantityTypeIdentifier.appleSleepingWristTemperature.rawValue,
                        "actual": quantityType.identifier,
                    ]
                )
            }

            let unit = HKUnit.degreeCelsius()
            let value = quantity.doubleValue(for: unit)

            // Create builder from HK metadata with source and device
            var builder = MetadataBuilder(
                fromHKMetadata: metadata ?? [:],
                source: sourceRevision.source,
                device: device
            )

            // Extract timezone offsets from metadata
            let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
            let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

            return try SleepingWristTemperatureRecordDto(
                id: uuid.uuidString,
                startTime: startDate.millisecondsSince1970,
                endTime: endDate.millisecondsSince1970,
                metadata: builder.toMetadataDto(),
                temperatureCelsius: value,
                startZoneOffsetSeconds: startZoneOffset,
                endZoneOffsetSeconds: endZoneOffset
            )
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Sleeping wrist temperature is only supported on iOS 16.0 and later",
                context: ["dataType": "sleepingWristTemperature", "minimumIOSVersion": "16.0"]
            )
        }
    }
}
