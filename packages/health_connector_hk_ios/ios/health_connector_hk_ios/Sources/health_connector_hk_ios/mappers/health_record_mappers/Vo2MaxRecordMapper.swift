import Foundation
import HealthKit

extension Vo2MaxRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .vo2Max)

        let unit = HKUnit.literUnit(with: .milli)
            .unitDivided(by: HKUnit.gramUnit(with: .kilo).unitMultiplied(by: .minute()))
        let quantity = HKQuantity(unit: unit, doubleValue: vo2Max.value)
        let date = Date(millisecondsSince1970: time)

        var metadataDict = metadata.toHealthKitMetadata() ?? [:]

        if let testType {
            metadataDict[HKMetadataKeyVO2MaxTestType] = testType.toHealthKitValue()
        }

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadataDict
        )
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `Vo2MaxRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a VO2 max sample.
    func toVo2MaxRecordDto() throws -> Vo2MaxRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.vo2Max.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected VO2 max quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.vo2Max.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        let unit = HKUnit.literUnit(with: .milli)
            .unitDivided(by: HKUnit.gramUnit(with: .kilo).unitMultiplied(by: .minute()))
        let value = quantity.doubleValue(for: unit)

        var testTypeDto: Vo2MaxTestTypeDto?
        if let testTypeRaw = metadataDict[HKMetadataKeyVO2MaxTestType] as? Int {
            testTypeDto = Vo2MaxTestTypeDto.fromHealthKitValue(testTypeRaw)
        }

        return Vo2MaxRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            vo2Max: Vo2MaxDto(unit: .millilitersPerKilogramPerMinute, value: value),
            testType: testTypeDto,
            zoneOffsetSeconds: zoneOffset
        )
    }
}

extension Vo2MaxTestTypeDto {
    func toHealthKitValue() -> Int {
        switch self {
        case .maxExercise:
            1 // HKVO2MaxTestType.maxExercise
        case .predictionSubMaxExercise:
            2 // HKVO2MaxTestType.predictionSubMaxExercise
        case .predictionNonExercise:
            3 // HKVO2MaxTestType.predictionNonExercise
        case .predictionStepTest:
            // Best effort mapping: HKVO2MaxTestType does not have a step test case.
            2 // HKVO2MaxTestType.predictionSubMaxExercise
        }
    }

    static func fromHealthKitValue(_ value: Int) -> Vo2MaxTestTypeDto? {
        switch value {
        case 1:
            .maxExercise
        case 2:
            .predictionSubMaxExercise
        case 3:
            .predictionNonExercise
        default:
            nil
        }
    }
}
