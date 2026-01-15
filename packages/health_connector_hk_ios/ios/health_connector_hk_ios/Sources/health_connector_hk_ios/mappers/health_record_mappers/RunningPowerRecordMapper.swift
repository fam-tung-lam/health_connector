import Foundation
import HealthKit

extension RunningPowerRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        if #available(iOS 16.0, *) {
            let type = try HKQuantityType.make(from: .runningPower)

            let quantity = HKQuantity(unit: .watt(), doubleValue: watts)
            let date = Date(millisecondsSince1970: time)

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
                message: "Running power is only supported on iOS 16.0 and later",
                context: ["dataType": "runningPower", "minimumIOSVersion": "16.0"]
            )
        }
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `RunningPowerRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a running power sample.
    func toRunningPowerRecordDto() throws -> RunningPowerRecordDto {
        if #available(iOS 16.0, *) {
            guard quantityType.identifier == HKQuantityTypeIdentifier.runningPower.rawValue else {
                throw HealthConnectorError.invalidArgument(
                    message: "Expected running power quantity type, got \(quantityType.identifier)",
                    context: [
                        "expected": HKQuantityTypeIdentifier.runningPower.rawValue,
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

            // Extract timezone offset from metadata
            let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

            return try RunningPowerRecordDto(
                id: uuid.uuidString,
                metadata: builder.toMetadataDto(),
                time: startDate.millisecondsSince1970,
                watts: quantity.doubleValue(for: HKUnit.watt()),
                zoneOffsetSeconds: zoneOffset
            )
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Running power is only supported on iOS 16.0 and later",
                context: ["dataType": "runningPower", "minimumIOSVersion": "16.0"]
            )
        }
    }
}
