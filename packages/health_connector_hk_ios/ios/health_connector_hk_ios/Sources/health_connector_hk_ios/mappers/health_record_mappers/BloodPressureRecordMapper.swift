import Foundation
import HealthKit

/// Extension for mapping `HKCorrelation` → `BloodPressureRecordDto`.
extension HKCorrelation {
    /// Converts a blood pressure correlation to a `BloodPressureRecordDto`.
    ///
    /// - Returns: The corresponding `BloodPressureRecordDto`
    /// - Throws: `HealthConnectorError.invalidArgument` if this correlation is not a blood pressure correlation or
    /// missing required values.
    func toBloodPressureRecordDto() throws -> BloodPressureRecordDto {
        guard correlationType.identifier == HKCorrelationTypeIdentifier.bloodPressure.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected blood pressure correlation type, got \(correlationType.identifier)",
                context: [
                    "expected": HKCorrelationTypeIdentifier.bloodPressure.rawValue,
                    "actual": correlationType.identifier,
                ]
            )
        }

        var systolicValue: Double?
        var diastolicValue: Double?
        let mmHgUnit = HKUnit.millimeterOfMercury()

        for object in objects {
            guard let sample = object as? HKQuantitySample else { continue }

            if sample.quantityType.identifier
                == HKQuantityTypeIdentifier.bloodPressureSystolic.rawValue
            {
                systolicValue = sample.quantity.doubleValue(for: mmHgUnit)
            } else if sample.quantityType.identifier
                == HKQuantityTypeIdentifier.bloodPressureDiastolic.rawValue
            {
                diastolicValue = sample.quantity.doubleValue(for: mmHgUnit)
            }
        }

        // Validate that both values are present
        guard let systolic = systolicValue, let diastolic = diastolicValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Blood pressure correlation missing required values",
                context: [
                    "hasSystolic": systolicValue != nil,
                    "hasDiastolic": diastolicValue != nil,
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

        // Extract body position and measurement location from custom metadata
        let bodyPosition = BodyPositionKey.read(from: builder.metadataDict) ?? .unknown
        let measurementLocation =
            MeasurementLocationKey.read(from: builder.metadataDict) ?? .unknown

        return try BloodPressureRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            systolicInMillimetersOfMercury: systolic,
            diastolicInMillimetersOfMercury: diastolic,
            bodyPosition: bodyPosition,
            measurementLocation: measurementLocation,
            zoneOffsetSeconds: zoneOffset
        )
    }
}

/// Extension for mapping `BloodPressureRecordDto` → `HKCorrelation`.
extension BloodPressureRecordDto {
    /// Converts this DTO to a HealthKit blood pressure correlation.
    ///
    /// - Returns: The corresponding `HKCorrelation`
    /// - Throws: `HealthConnectorError` if conversion fails
    func toHKCorrelation() throws -> HKCorrelation {
        let systolicType = try HKQuantityType.make(from: .bloodPressureSystolic)
        let diastolicType = try HKQuantityType.make(from: .bloodPressureDiastolic)
        let correlationType = try HKCorrelationType.make(from: .bloodPressure)

        let date = Date(millisecondsSince1970: time)
        let mmHgUnit = HKUnit.millimeterOfMercury()

        let systolicQuantity = HKQuantity(
            unit: mmHgUnit, doubleValue: systolicInMillimetersOfMercury
        )
        let diastolicQuantity = HKQuantity(
            unit: mmHgUnit, doubleValue: diastolicInMillimetersOfMercury
        )

        // Create builder with timezone offset
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: zoneOffsetSeconds
        )

        // Store body position and measurement location in custom metadata
        builder.set(BodyPositionKey.self, value: bodyPosition)
        builder.set(MeasurementLocationKey.self, value: measurementLocation)

        let systolicSample = HKQuantitySample(
            type: systolicType,
            quantity: systolicQuantity,
            start: date,
            end: date,
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )

        let diastolicSample = HKQuantitySample(
            type: diastolicType,
            quantity: diastolicQuantity,
            start: date,
            end: date,
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )

        return HKCorrelation(
            type: correlationType,
            start: date,
            end: date,
            objects: Set([systolicSample, diastolicSample]),
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `SystolicBloodPressureRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a systolic blood pressure sample.
    func toSystolicBloodPressureRecordDto() throws -> SystolicBloodPressureRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bloodPressureSystolic.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected systolic blood pressure quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.bloodPressureSystolic.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let mmHgUnit = HKUnit.millimeterOfMercury()
        let value = quantity.doubleValue(for: mmHgUnit)

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        // Extract body position and measurement location from custom metadata
        let bodyPosition = BodyPositionKey.read(from: builder.metadataDict) ?? .unknown
        let measurementLocation =
            MeasurementLocationKey.read(from: builder.metadataDict) ?? .unknown

        return try SystolicBloodPressureRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            millimetersOfMercury: value,
            bodyPosition: bodyPosition,
            measurementLocation: measurementLocation,
            zoneOffsetSeconds: zoneOffset
        )
    }

    /// Converts this HealthKit sample to a `DiastolicBloodPressureRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a diastolic blood pressure sample.
    func toDiastolicBloodPressureRecordDto() throws -> DiastolicBloodPressureRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bloodPressureDiastolic.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected diastolic blood pressure quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.bloodPressureDiastolic.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let mmHgUnit = HKUnit.millimeterOfMercury()
        let value = quantity.doubleValue(for: mmHgUnit)

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        // Extract body position and measurement location from custom metadata
        let bodyPosition = BodyPositionKey.read(from: builder.metadataDict) ?? .unknown
        let measurementLocation =
            MeasurementLocationKey.read(from: builder.metadataDict) ?? .unknown

        return try DiastolicBloodPressureRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            millimetersOfMercury: value,
            bodyPosition: bodyPosition,
            measurementLocation: measurementLocation,
            zoneOffsetSeconds: zoneOffset
        )
    }
}

extension SystolicBloodPressureRecordDto {
    /// Converts this DTO to a HealthKit quantity sample.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bloodPressureSystolic)

        let mmHgUnit = HKUnit.millimeterOfMercury()
        let quantity = HKQuantity(unit: mmHgUnit, doubleValue: millimetersOfMercury)
        let date = Date(millisecondsSince1970: time)

        // Create builder with timezone offset
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: zoneOffsetSeconds
        )

        // Store body position and measurement location in custom metadata
        builder.set(BodyPositionKey.self, value: bodyPosition)
        builder.set(MeasurementLocationKey.self, value: measurementLocation)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date,
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )
    }
}

extension DiastolicBloodPressureRecordDto {
    /// Converts this DTO to a HealthKit quantity sample.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bloodPressureDiastolic)

        let mmHgUnit = HKUnit.millimeterOfMercury()
        let quantity = HKQuantity(unit: mmHgUnit, doubleValue: millimetersOfMercury)
        let date = Date(millisecondsSince1970: time)

        // Create builder with timezone offset
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: zoneOffsetSeconds
        )

        // Store body position and measurement location in custom metadata
        builder.set(BodyPositionKey.self, value: bodyPosition)
        builder.set(MeasurementLocationKey.self, value: measurementLocation)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date,
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )
    }
}
