import Foundation
import HealthKit

extension HKCorrelation {
    /// Converts a blood pressure correlation to a `BloodPressureRecordDto`.
    func toBloodPressureRecordDto() -> BloodPressureRecordDto? {
        guard correlationType.identifier == HKCorrelationTypeIdentifier.bloodPressure.rawValue
        else {
            return nil
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
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return BloodPressureRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: nil
            ),
            time: startDate.millisecondsSince1970,
            systolic: PressureDto(unit: .millimetersOfMercury, value: systolic),
            diastolic: PressureDto(unit: .millimetersOfMercury, value: diastolic),
            bodyPosition: .unknown, // Not supported by HealthKit
            measurementLocation: .unknown, // Not supported by HealthKit
            zoneOffsetSeconds: zoneOffset
        )
    }
}

extension BloodPressureRecordDto {
    /// Converts this DTO to a HealthKit blood pressure correlation.
    func toHealthKitCorrelation() throws -> HKCorrelation {
        let systolicType = try HKQuantityType.make(from: .bloodPressureSystolic)
        let diastolicType = try HKQuantityType.make(from: .bloodPressureDiastolic)
        let correlationType = try HKCorrelationType.make(from: .bloodPressure)

        let date = Date(millisecondsSince1970: time)
        let mmHgUnit = HKUnit.millimeterOfMercury()

        let systolicQuantity = HKQuantity(unit: mmHgUnit, doubleValue: systolic.value)
        let diastolicQuantity = HKQuantity(unit: mmHgUnit, doubleValue: diastolic.value)

        let systolicSample = HKQuantitySample(
            type: systolicType,
            quantity: systolicQuantity,
            start: date,
            end: date,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )

        let diastolicSample = HKQuantitySample(
            type: diastolicType,
            quantity: diastolicQuantity,
            start: date,
            end: date,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )

        return HKCorrelation(
            type: correlationType,
            start: date,
            end: date,
            objects: Set([systolicSample, diastolicSample]),
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `SystolicBloodPressureRecordDto`.
    func toSystolicBloodPressureRecordDto() -> SystolicBloodPressureRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bloodPressureSystolic.rawValue
        else {
            return nil
        }

        let mmHgUnit = HKUnit.millimeterOfMercury()
        let value = quantity.doubleValue(for: mmHgUnit)

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return SystolicBloodPressureRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: startDate.millisecondsSince1970,
            pressure: PressureDto(unit: .millimetersOfMercury, value: value),
            zoneOffsetSeconds: zoneOffset
        )
    }

    /// Converts this HealthKit sample to a `DiastolicBloodPressureRecordDto`.
    func toDiastolicBloodPressureRecordDto() -> DiastolicBloodPressureRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bloodPressureDiastolic.rawValue
        else {
            return nil
        }

        let mmHgUnit = HKUnit.millimeterOfMercury()
        let value = quantity.doubleValue(for: mmHgUnit)

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return DiastolicBloodPressureRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: startDate.millisecondsSince1970,
            pressure: PressureDto(unit: .millimetersOfMercury, value: value),
            zoneOffsetSeconds: zoneOffset
        )
    }
}

extension SystolicBloodPressureRecordDto {
    /// Converts this DTO to a HealthKit quantity sample.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bloodPressureSystolic)

        let mmHgUnit = HKUnit.millimeterOfMercury()
        let quantity = HKQuantity(unit: mmHgUnit, doubleValue: pressure.value)
        let date = Date(millisecondsSince1970: time)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension DiastolicBloodPressureRecordDto {
    /// Converts this DTO to a HealthKit quantity sample.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bloodPressureDiastolic)

        let mmHgUnit = HKUnit.millimeterOfMercury()
        let quantity = HKQuantity(unit: mmHgUnit, doubleValue: pressure.value)
        let date = Date(millisecondsSince1970: time)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}
