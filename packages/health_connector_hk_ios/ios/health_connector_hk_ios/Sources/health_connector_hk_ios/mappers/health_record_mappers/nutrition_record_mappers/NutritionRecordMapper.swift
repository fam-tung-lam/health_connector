import Foundation
import HealthKit

extension HKCorrelation {
    /// Converts this food correlation to NutritionRecordDto
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this correlation is not a food correlation.
    func toNutritionRecordDto() throws -> NutritionRecordDto {
        guard correlationType.identifier == HKCorrelationTypeIdentifier.food.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected food correlation type, got \(correlationType.identifier)",
                context: [
                    "expected": HKCorrelationTypeIdentifier.food.rawValue,
                    "actual": correlationType.identifier,
                ]
            )
        }
        let id = uuid.uuidString
        let startTime = startDate.millisecondsSince1970
        let endTime = endDate.millisecondsSince1970

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let metadataDto = try builder.toMetadataDto()

        let foodName = builder.metadataDict[HKMetadataKeyFoodType] as? String
        let mealType = NutrientMealTypeKey.read(from: builder.metadataDict)

        return NutritionRecordDto(
            id: id,
            startTime: startTime,
            endTime: endTime,
            metadata: metadataDto,
            startZoneOffsetSeconds: zoneOffset,
            endZoneOffsetSeconds: zoneOffset,
            foodName: foodName,
            mealType: mealType,
            energyKilocalories: extractEnergy(),
            proteinInGrams: extractMass(for: .dietaryProtein),
            totalCarbohydrateInGrams: extractMass(for: .dietaryCarbohydrates),
            totalFatInGrams: extractMass(for: .dietaryFatTotal),
            saturatedFatInGrams: extractMass(for: .dietaryFatSaturated),
            monounsaturatedFatInGrams: extractMass(for: .dietaryFatMonounsaturated),
            polyunsaturatedFatInGrams: extractMass(for: .dietaryFatPolyunsaturated),
            cholesterolInGrams: extractMass(for: .dietaryCholesterol),
            dietaryFiberInGrams: extractMass(for: .dietaryFiber),
            sugarInGrams: extractMass(for: .dietarySugar),
            vitaminAInGrams: extractMass(for: .dietaryVitaminA),
            vitaminB6InGrams: extractMass(for: .dietaryVitaminB6),
            vitaminB12InGrams: extractMass(for: .dietaryVitaminB12),
            vitaminCInGrams: extractMass(for: .dietaryVitaminC),
            vitaminDInGrams: extractMass(for: .dietaryVitaminD),
            vitaminEInGrams: extractMass(for: .dietaryVitaminE),
            vitaminKInGrams: extractMass(for: .dietaryVitaminK),
            thiaminInGrams: extractMass(for: .dietaryThiamin),
            riboflavinInGrams: extractMass(for: .dietaryRiboflavin),
            niacinInGrams: extractMass(for: .dietaryNiacin),
            folateInGrams: extractMass(for: .dietaryFolate),
            biotinInGrams: extractMass(for: .dietaryBiotin),
            pantothenicAcidInGrams: extractMass(for: .dietaryPantothenicAcid),
            calciumInGrams: extractMass(for: .dietaryCalcium),
            ironInGrams: extractMass(for: .dietaryIron),
            magnesiumInGrams: extractMass(for: .dietaryMagnesium),
            manganeseInGrams: extractMass(for: .dietaryManganese),
            phosphorusInGrams: extractMass(for: .dietaryPhosphorus),
            potassiumInGrams: extractMass(for: .dietaryPotassium),
            seleniumInGrams: extractMass(for: .dietarySelenium),
            sodiumInGrams: extractMass(for: .dietarySodium),
            zincInGrams: extractMass(for: .dietaryZinc),
            caffeineInGrams: extractMass(for: .dietaryCaffeine)
        )
    }

    /// Extracts energy value from contained samples
    private func extractEnergy() -> Double? {
        guard let energyType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed),
              let sample = objects(for: energyType).first as? HKQuantitySample
        else {
            return nil
        }
        return sample.quantity.doubleValue(for: .kilocalorie())
    }

    /// Extracts mass value for a specific nutrient type from contained samples
    private func extractMass(for identifier: HKQuantityTypeIdentifier) -> Double? {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier),
              let sample = objects(for: quantityType).first as? HKQuantitySample
        else {
            return nil
        }
        return sample.quantity.doubleValue(for: .gram())
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
        addEnergySample(to: &samples, for: energyKilocalories, start: startDate, end: endDate)
        addMassSample(
            to: &samples, for: proteinInGrams, type: .dietaryProtein, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: totalCarbohydrateInGrams, type: .dietaryCarbohydrates,
            start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: totalFatInGrams, type: .dietaryFatTotal, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: saturatedFatInGrams, type: .dietaryFatSaturated, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples,
            for: monounsaturatedFatInGrams,
            type: .dietaryFatMonounsaturated,
            start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples,
            for: polyunsaturatedFatInGrams,
            type: .dietaryFatPolyunsaturated,
            start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: cholesterolInGrams, type: .dietaryCholesterol, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: dietaryFiberInGrams, type: .dietaryFiber, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: sugarInGrams, type: .dietarySugar, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminAInGrams, type: .dietaryVitaminA, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminB6InGrams, type: .dietaryVitaminB6, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminB12InGrams, type: .dietaryVitaminB12, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminCInGrams, type: .dietaryVitaminC, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminDInGrams, type: .dietaryVitaminD, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminEInGrams, type: .dietaryVitaminE, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: vitaminKInGrams, type: .dietaryVitaminK, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: thiaminInGrams, type: .dietaryThiamin, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: riboflavinInGrams, type: .dietaryRiboflavin, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: niacinInGrams, type: .dietaryNiacin, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: folateInGrams, type: .dietaryFolate, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: biotinInGrams, type: .dietaryBiotin, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: pantothenicAcidInGrams, type: .dietaryPantothenicAcid,
            start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: calciumInGrams, type: .dietaryCalcium, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: ironInGrams, type: .dietaryIron, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: magnesiumInGrams, type: .dietaryMagnesium, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: manganeseInGrams, type: .dietaryManganese, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: phosphorusInGrams, type: .dietaryPhosphorus, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: potassiumInGrams, type: .dietaryPotassium, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: seleniumInGrams, type: .dietarySelenium, start: startDate,
            end: endDate
        )
        addMassSample(
            to: &samples, for: sodiumInGrams, type: .dietarySodium, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: zincInGrams, type: .dietaryZinc, start: startDate, end: endDate
        )
        addMassSample(
            to: &samples, for: caffeineInGrams, type: .dietaryCaffeine, start: startDate,
            end: endDate
        )

        // Build metadata with timezone offset
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: startZoneOffsetSeconds
        )

        // Add food-specific metadata
        if let mealType {
            builder.set(NutrientMealTypeKey.self, value: mealType)
        }

        var hkMetadata = builder.metadataDict
        if let foodName {
            hkMetadata[HKMetadataKeyFoodType] = foodName
        }

        return HKCorrelation(
            type: foodType,
            start: startDate,
            end: endDate,
            objects: samples,
            device: builder.healthDevice,
            metadata: hkMetadata
        )
    }

    /// Creates an energy sample for the correlation
    private func createEnergySample(_ energyKilocalories: Double, start: Date, end: Date)
        -> HKQuantitySample?
    {
        guard let energyType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)
        else {
            return nil
        }
        let quantity = HKQuantity(unit: .kilocalorie(), doubleValue: energyKilocalories)
        return HKQuantitySample(type: energyType, quantity: quantity, start: start, end: end)
    }

    /// Creates a mass sample for a specific nutrient type
    private func createMassSample(
        _ identifier: HKQuantityTypeIdentifier,
        _ mass: Double,
        start: Date,
        end: Date
    ) -> HKQuantitySample? {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            return nil
        }
        let quantity = HKQuantity(unit: .gram(), doubleValue: mass)
        return HKQuantitySample(type: quantityType, quantity: quantity, start: start, end: end)
    }

    /// Adds an energy sample to the set if the value is present
    private func addEnergySample(
        to samples: inout Set<HKSample>,
        for value: Double?,
        start: Date,
        end: Date
    ) {
        guard let value,
              let sample = createEnergySample(value, start: start, end: end)
        else {
            return
        }
        samples.insert(sample)
    }

    /// Adds a mass sample to the set if the value is present
    private func addMassSample(
        to samples: inout Set<HKSample>,
        for value: Double?,
        type: HKQuantityTypeIdentifier,
        start: Date,
        end: Date
    ) {
        guard let value,
              let sample = createMassSample(type, value, start: start, end: end)
        else {
            return
        }
        samples.insert(sample)
    }
}
