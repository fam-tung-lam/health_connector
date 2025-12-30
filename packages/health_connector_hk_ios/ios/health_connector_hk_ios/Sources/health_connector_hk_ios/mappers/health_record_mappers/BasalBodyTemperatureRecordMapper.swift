import Foundation
import HealthKit

extension BasalBodyTemperatureRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .basalBodyTemperature)

        let quantity = HKQuantity(unit: .degreeCelsius(), doubleValue: temperature.value)
        let date = Date(millisecondsSince1970: time)

        // Create builder with timezone offset
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: zoneOffsetSeconds
        )

        // Store measurement location in custom metadata since HealthKit doesn't support it natively
        builder.set(
            BasalBodyTemperatureMeasurementLocationKey.self,
            value: measurementLocation
        )

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `BasalBodyTemperatureRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a basal body temperature sample.
    func toBasalBodyTemperatureRecordDto() throws -> BasalBodyTemperatureRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.basalBodyTemperature.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected basal body temperature quantity type, got \\(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.basalBodyTemperature.rawValue,
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

        // Extract timezone offset and measurement location from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let measurementLocation = BasalBodyTemperatureMeasurementLocationKey.readOrDefault(
            from: builder.metadataDict)

        return try BasalBodyTemperatureRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            temperature: TemperatureDto(unit: TemperatureUnitDto.celsius, value: value),
            measurementLocation: measurementLocation,
            zoneOffsetSeconds: zoneOffset
        )
    }
}
