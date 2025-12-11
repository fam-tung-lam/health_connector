import Foundation
import HealthKit

extension BodyTemperatureRecordDto {
    /*
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     */
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .bodyTemperature) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create body temperature quantity type"]
            )
        }

        let quantity = HKQuantity(unit: .degreeCelsius(), doubleValue: temperature.value)
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
     * Converts this HealthKit sample to a `BodyTemperatureRecordDto`.
     */
    func toBodyTemperatureRecordDto() -> BodyTemperatureRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bodyTemperature.rawValue else {
            return nil
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
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            temperature: TemperatureDto(unit: TemperatureUnitDto.celsius, value: value),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
