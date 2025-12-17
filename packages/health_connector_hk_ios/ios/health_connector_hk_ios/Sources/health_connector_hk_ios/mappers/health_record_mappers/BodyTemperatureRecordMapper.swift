import Foundation
import HealthKit

extension BodyTemperatureRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bodyTemperature)

        let quantity = HKQuantity(unit: .degreeCelsius(), doubleValue: temperature.value)
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
    /// Converts this HealthKit sample to a `BodyTemperatureRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a body temperature sample.
    func toBodyTemperatureRecordDto() throws -> BodyTemperatureRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bodyTemperature.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected body temperature quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.bodyTemperature.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let unit = HKUnit.degreeCelsius()
        let value = quantity.doubleValue(for: unit)

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return BodyTemperatureRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: startDate.millisecondsSince1970,
            temperature: TemperatureDto(unit: TemperatureUnitDto.celsius, value: value),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
