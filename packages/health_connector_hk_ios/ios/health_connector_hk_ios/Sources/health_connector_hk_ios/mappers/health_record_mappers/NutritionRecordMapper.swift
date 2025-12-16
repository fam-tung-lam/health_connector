import Foundation
import HealthKit

private enum NutritionMetadataKeys {
    static let mealType = "com.phamtunglam.health_connector.meal_type"
}

extension HKCorrelation {
    /// Converts this food correlation to NutritionRecordDto
    func toNutritionRecordDto() -> NutritionRecordDto {
        let id = uuid.uuidString
        let startTime = startDate.millisecondsSince1970
        let endTime = endDate.millisecondsSince1970

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let metadataDto = metadataDict.toMetadataDto(
            source: sourceRevision.source,
            device: device
        )

        let foodName = metadataDict[HKMetadataKeyFoodType] as? String
        let mealType = metadataDict.extractMealType()

        return NutritionRecordDto(
            id: id,
            startTime: startTime,
            endTime: endTime,
            metadata: metadataDto,
            startZoneOffsetSeconds: zoneOffset,
            endZoneOffsetSeconds: zoneOffset,
            foodName: foodName,
            mealType: mealType,
            energy: extractEnergy(),
            protein: extractMass(for: .dietaryProtein),
            totalCarbohydrate: extractMass(for: .dietaryCarbohydrates),
            totalFat: extractMass(for: .dietaryFatTotal),
            saturatedFat: extractMass(for: .dietaryFatSaturated),
            monounsaturatedFat: extractMass(for: .dietaryFatMonounsaturated),
            polyunsaturatedFat: extractMass(for: .dietaryFatPolyunsaturated),
            cholesterol: extractMass(for: .dietaryCholesterol),
            dietaryFiber: extractMass(for: .dietaryFiber),
            sugar: extractMass(for: .dietarySugar),
            vitaminA: extractMass(for: .dietaryVitaminA),
            vitaminB6: extractMass(for: .dietaryVitaminB6),
            vitaminB12: extractMass(for: .dietaryVitaminB12),
            vitaminC: extractMass(for: .dietaryVitaminC),
            vitaminD: extractMass(for: .dietaryVitaminD),
            vitaminE: extractMass(for: .dietaryVitaminE),
            vitaminK: extractMass(for: .dietaryVitaminK),
            thiamin: extractMass(for: .dietaryThiamin),
            riboflavin: extractMass(for: .dietaryRiboflavin),
            niacin: extractMass(for: .dietaryNiacin),
            folate: extractMass(for: .dietaryFolate),
            biotin: extractMass(for: .dietaryBiotin),
            pantothenicAcid: extractMass(for: .dietaryPantothenicAcid),
            calcium: extractMass(for: .dietaryCalcium),
            iron: extractMass(for: .dietaryIron),
            magnesium: extractMass(for: .dietaryMagnesium),
            manganese: extractMass(for: .dietaryManganese),
            phosphorus: extractMass(for: .dietaryPhosphorus),
            potassium: extractMass(for: .dietaryPotassium),
            selenium: extractMass(for: .dietarySelenium),
            sodium: extractMass(for: .dietarySodium),
            zinc: extractMass(for: .dietaryZinc),
            caffeine: extractMass(for: .dietaryCaffeine)
        )
    }

    /// Extracts energy value from contained samples
    private func extractEnergy() -> EnergyDto? {
        guard let energyType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed),
              let sample = objects(for: energyType).first as? HKQuantitySample
        else {
            return nil
        }
        return sample.quantity.toEnergyDto()
    }

    /// Extracts mass value for a specific nutrient type from contained samples
    private func extractMass(for identifier: HKQuantityTypeIdentifier) -> MassDto? {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier),
              let sample = objects(for: quantityType).first as? HKQuantitySample
        else {
            return nil
        }
        return sample.quantity.toMassDto()
    }
}

extension NutritionRecordDto {
    /// Converts this DTO to an HKCorrelation for HealthKit
    func toHealthKitCorrelation() throws -> HKCorrelation {
        guard let foodType = HKCorrelationType.correlationType(forIdentifier: .food) else {
            throw HealthConnectorError.invalidArgument(
                message: "Food correlation type not available"
            )
        }

        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)

        // Build nutrient samples
        var samples: Set<HKSample> = []
        addEnergySample(to: &samples, for: energy, start: startDate, end: endDate)
        addMassSample(
            to: &samples, for: protein, type: .dietaryProtein, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: totalCarbohydrate, type: .dietaryCarbohydrates, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: totalFat, type: .dietaryFatTotal, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: saturatedFat, type: .dietaryFatSaturated, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples,
            for: monounsaturatedFat,
            type: .dietaryFatMonounsaturated,
            start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples,
            for: polyunsaturatedFat,
            type: .dietaryFatPolyunsaturated,
            start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: cholesterol, type: .dietaryCholesterol, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: dietaryFiber, type: .dietaryFiber, start: startDate, end: endDate
        )
        addMassSample(to: &samples, for: sugar, type: .dietarySugar, start: startDate, end: endDate)
        addMassSample(
            to: &samples, for: vitaminA, type: .dietaryVitaminA, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminB6, type: .dietaryVitaminB6, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminB12, type: .dietaryVitaminB12, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminC, type: .dietaryVitaminC, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminD, type: .dietaryVitaminD, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminE, type: .dietaryVitaminE, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminK, type: .dietaryVitaminK, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: thiamin, type: .dietaryThiamin, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: riboflavin, type: .dietaryRiboflavin, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: niacin, type: .dietaryNiacin, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: folate, type: .dietaryFolate, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: biotin, type: .dietaryBiotin, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: pantothenicAcid, type: .dietaryPantothenicAcid, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: calcium, type: .dietaryCalcium, start: startDate, end: endDate
        )
        addMassSample(to: &samples, for: iron, type: .dietaryIron, start: startDate, end: endDate)
        addMassSample(
            to: &samples, for: magnesium, type: .dietaryMagnesium, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: manganese, type: .dietaryManganese, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: phosphorus, type: .dietaryPhosphorus, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: potassium, type: .dietaryPotassium, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: selenium, type: .dietarySelenium, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: sodium, type: .dietarySodium, start: startDate, end: endDate
        )
        addMassSample(to: &samples, for: zinc, type: .dietaryZinc, start: startDate, end: endDate)
        addMassSample(
            to: &samples, for: caffeine, type: .dietaryCaffeine, start: startDate, end: endDate
        )

        // Build metadata
        let timeZone: TimeZone? = startZoneOffsetSeconds.flatMap {
            TimeZone(secondsFromGMT: Int($0))
        }
        var hkMetadata = metadata.toHealthKitMetadata(timeZone: timeZone)
        if let foodName {
            hkMetadata[HKMetadataKeyFoodType] = foodName
        }
        if let mealType {
            hkMetadata[NutritionMetadataKeys.mealType] = mealType.toString()
        }

        return HKCorrelation(
            type: foodType,
            start: startDate,
            end: endDate,
            objects: samples,
            device: metadata.toHealthKitDevice(),
            metadata: hkMetadata
        )
    }

    /// Creates an energy sample for the correlation
    private func createEnergySample(_ energy: EnergyDto, start: Date, end: Date)
        -> HKQuantitySample?
    {
        guard let energyType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)
        else {
            return nil
        }
        let quantity = energy.toHealthKit()
        return HKQuantitySample(type: energyType, quantity: quantity, start: start, end: end)
    }

    /// Creates a mass sample for a specific nutrient type
    private func createMassSample(
        _ identifier: HKQuantityTypeIdentifier,
        _ mass: MassDto,
        start: Date,
        end: Date
    ) -> HKQuantitySample? {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            return nil
        }
        let quantity = mass.toHealthKit()
        return HKQuantitySample(type: quantityType, quantity: quantity, start: start, end: end)
    }

    /// Adds an energy sample to the set if the DTO is present
    private func addEnergySample(
        to samples: inout Set<HKSample>,
        for dto: EnergyDto?,
        start: Date,
        end: Date
    ) {
        guard let dto,
              let sample = createEnergySample(dto, start: start, end: end)
        else {
            return
        }
        samples.insert(sample)
    }

    /// Adds a mass sample to the set if the DTO is present
    private func addMassSample(
        to samples: inout Set<HKSample>,
        for dto: MassDto?,
        type: HKQuantityTypeIdentifier,
        start: Date,
        end: Date
    ) {
        guard let dto,
              let sample = createMassSample(type, dto, start: start, end: end)
        else {
            return
        }
        samples.insert(sample)
    }
}
