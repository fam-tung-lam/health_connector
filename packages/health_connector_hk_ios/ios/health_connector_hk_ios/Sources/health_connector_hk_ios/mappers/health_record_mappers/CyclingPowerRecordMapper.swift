import Foundation
import HealthKit

/// Extension for mapping `CyclingPowerRecordDto` → `HKQuantitySample`.
extension CyclingPowerRecordDto {
    /// Converts this `CyclingPowerRecordDto` to its corresponding `HKQuantitySample`.
    ///
    /// - Returns: The corresponding `HKQuantitySample`
    /// - Throws: `HealthConnectorError` if the quantity type cannot be created or iOS version is unsupported
    func toHKQuantitySample() throws -> HKQuantitySample {
        if #available(iOS 17.0, *) {
            let type = try HKQuantityType.make(from: .cyclingPower)

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
                message: "Cycling power is only supported on iOS 17.0 and later",
                context: ["dataType": "cyclingPower", "minimumIOSVersion": "17.0"]
            )
        }
    }
}

/// Extension for mapping `HKQuantitySample` → `CyclingPowerRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `CyclingPowerRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a cycling power sample.
    func toCyclingPowerRecordDto() throws -> CyclingPowerRecordDto {
        if #available(iOS 17.0, *) {
            guard quantityType.identifier == HKQuantityTypeIdentifier.cyclingPower.rawValue else {
                throw HealthConnectorError.invalidArgument(
                    message: "Expected cycling power quantity type, got \(quantityType.identifier)",
                    context: [
                        "expected": HKQuantityTypeIdentifier.cyclingPower.rawValue,
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

            return try CyclingPowerRecordDto(
                id: uuid.uuidString,
                metadata: builder.toMetadataDto(),
                time: startDate.millisecondsSince1970,
                watts: quantity.doubleValue(for: HKUnit.watt()),
                zoneOffsetSeconds: zoneOffset
            )
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Cycling power is only supported on iOS 17.0 and later",
                context: ["dataType": "cyclingPower", "minimumIOSVersion": "17.0"]
            )
        }
    }
}
