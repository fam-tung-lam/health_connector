import Foundation
import HealthKit

// MARK: - Metadata Keys for Nutrition Correlation

private extension String {
    static let mealTypeKey = "com.phamtunglam.health_connector.meal_type"
}

// MARK: - HKCorrelation → NutritionRecordDto

extension HKCorrelation {
    /// Converts this food correlation to NutritionRecordDto
    ///
    /// Extracts:
    /// - Food name from `HKMetadataKeyFoodType`
    /// - Meal type from custom metadata key
    /// - Individual nutrient values from contained `HKQuantitySample` objects

    func toNutritionRecordDto() -> NutritionRecordDto {
        let id = uuid.uuidString
        let startTime = Int64(startDate.timeIntervalSince1970 * 1000)
        let endTime = Int64(endDate.timeIntervalSince1970 * 1000)

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let metadataDto = metadataDict.toMetadataDto(
            source: sourceRevision.source,
            device: device
        )

        // Extract food name from standard HealthKit metadata key
        let foodName = metadataDict[HKMetadataKeyFoodType] as? String

        // Extract meal type from custom metadata key
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
        // Energy
            energy: extractEnergy(),
        // Macronutrients
            protein: extractMass(for: .dietaryProtein),
            totalCarbohydrate: extractMass(for: .dietaryCarbohydrates),
            totalFat: extractMass(for: .dietaryFatTotal),
            saturatedFat: extractMass(for: .dietaryFatSaturated),
            monounsaturatedFat: extractMass(for: .dietaryFatMonounsaturated),
            polyunsaturatedFat: extractMass(for: .dietaryFatPolyunsaturated),
            cholesterol: extractMass(for: .dietaryCholesterol),
            dietaryFiber: extractMass(for: .dietaryFiber),
            sugar: extractMass(for: .dietarySugar),
        // Vitamins
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
        // Minerals
            calcium: extractMass(for: .dietaryCalcium),
            iron: extractMass(for: .dietaryIron),
            magnesium: extractMass(for: .dietaryMagnesium),
            manganese: extractMass(for: .dietaryManganese),
            phosphorus: extractMass(for: .dietaryPhosphorus),
            potassium: extractMass(for: .dietaryPotassium),
            selenium: extractMass(for: .dietarySelenium),
            sodium: extractMass(for: .dietarySodium),
            zinc: extractMass(for: .dietaryZinc),
        // Other
            caffeine: extractMass(for: .dietaryCaffeine)
        )
    }

    /// Extracts energy value from contained samples

    private func extractEnergy() -> EnergyDto? {
        guard let energyType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed),
        let sample = objects(for: energyType).first as? HKQuantitySample else {
            return nil
        }
        return sample.quantity.toEnergyDto()
    }

    /// Extracts mass value for a specific nutrient type from contained samples

    private func extractMass(for identifier: HKQuantityTypeIdentifier) -> MassDto? {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier),
        let sample = objects(for: quantityType).first as? HKQuantitySample else {
            return nil
        }
        return sample.quantity.toMassDto()
    }
}

// MARK: - NutritionRecordDto → HKCorrelation

extension NutritionRecordDto {
    /// Converts this DTO to an HKCorrelation for HealthKit
    ///
    /// Creates an `HKCorrelation` of type `.food` containing:
    /// - Individual `HKQuantitySample` for each non-nil nutrient
    /// - Food name stored in `HKMetadataKeyFoodType`
    /// - Meal type stored in custom metadata key

    func toHealthKitCorrelation() throws -> HKCorrelation {
        guard let foodType = HKCorrelationType.correlationType(forIdentifier: .food) else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Food correlation type not available"
            )
        }

        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

        // Build nutrient samples
        var samples: Set<HKSample> = []

        // Energy
        if let energy = energy {
            if let sample = createEnergySample(energy, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }

        // Macronutrients
        if let protein = protein {
            if let sample = createMassSample(.dietaryProtein, protein, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let carbs = totalCarbohydrate {
            if let sample = createMassSample(.dietaryCarbohydrates, carbs, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let fat = totalFat {
            if let sample = createMassSample(.dietaryFatTotal, fat, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let saturatedFat = saturatedFat {
            if let sample = createMassSample(.dietaryFatSaturated, saturatedFat, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let monoFat = monounsaturatedFat {
            if let sample = createMassSample(.dietaryFatMonounsaturated, monoFat, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let polyFat = polyunsaturatedFat {
            if let sample = createMassSample(.dietaryFatPolyunsaturated, polyFat, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let cholesterol = cholesterol {
            if let sample = createMassSample(.dietaryCholesterol, cholesterol, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let fiber = dietaryFiber {
            if let sample = createMassSample(.dietaryFiber, fiber, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let sugar = sugar {
            if let sample = createMassSample(.dietarySugar, sugar, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }

        // Vitamins
        if let vitA = vitaminA {
            if let sample = createMassSample(.dietaryVitaminA, vitA, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let vitB6 = vitaminB6 {
            if let sample = createMassSample(.dietaryVitaminB6, vitB6, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let vitB12 = vitaminB12 {
            if let sample = createMassSample(.dietaryVitaminB12, vitB12, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let vitC = vitaminC {
            if let sample = createMassSample(.dietaryVitaminC, vitC, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let vitD = vitaminD {
            if let sample = createMassSample(.dietaryVitaminD, vitD, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let vitE = vitaminE {
            if let sample = createMassSample(.dietaryVitaminE, vitE, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let vitK = vitaminK {
            if let sample = createMassSample(.dietaryVitaminK, vitK, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let thiamin = thiamin {
            if let sample = createMassSample(.dietaryThiamin, thiamin, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let riboflavin = riboflavin {
            if let sample = createMassSample(.dietaryRiboflavin, riboflavin, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let niacin = niacin {
            if let sample = createMassSample(.dietaryNiacin, niacin, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let folate = folate {
            if let sample = createMassSample(.dietaryFolate, folate, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let biotin = biotin {
            if let sample = createMassSample(.dietaryBiotin, biotin, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let pantothenicAcid = pantothenicAcid {
            if let sample = createMassSample(.dietaryPantothenicAcid, pantothenicAcid, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }

        // Minerals
        if let calcium = calcium {
            if let sample = createMassSample(.dietaryCalcium, calcium, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let iron = iron {
            if let sample = createMassSample(.dietaryIron, iron, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let magnesium = magnesium {
            if let sample = createMassSample(.dietaryMagnesium, magnesium, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let manganese = manganese {
            if let sample = createMassSample(.dietaryManganese, manganese, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let phosphorus = phosphorus {
            if let sample = createMassSample(.dietaryPhosphorus, phosphorus, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let potassium = potassium {
            if let sample = createMassSample(.dietaryPotassium, potassium, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let selenium = selenium {
            if let sample = createMassSample(.dietarySelenium, selenium, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let sodium = sodium {
            if let sample = createMassSample(.dietarySodium, sodium, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }
        if let zinc = zinc {
            if let sample = createMassSample(.dietaryZinc, zinc, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }

        // Other
        if let caffeine = caffeine {
            if let sample = createMassSample(.dietaryCaffeine, caffeine, start: startDate, end: endDate) {
                samples.insert(sample)
            }
        }

        // Build metadata
        let timeZone: TimeZone? = startZoneOffsetSeconds.flatMap {
            TimeZone(secondsFromGMT: Int($0))
        }
        var hkMetadata = metadata.toHealthKitMetadata(timeZone: timeZone)

        // Store food name using standard HealthKit key
        if let foodName = foodName {
            hkMetadata[HKMetadataKeyFoodType] = foodName
        }

        // Store meal type using custom key
        if let mealType = mealType {
            hkMetadata[.mealTypeKey] = mealType.toString()
        }

        // Create correlation
        return HKCorrelation(
            type: foodType,
            start: startDate,
            end: endDate,
            objects: samples,
            device: metadata.toHealthKitDevice(),
            metadata: hkMetadata
        )
    }

    // MARK: - Helper Methods

    /// Creates an energy sample for the correlation

    private func createEnergySample(_ energy: EnergyDto, start: Date, end: Date) -> HKQuantitySample? {
        guard let energyType = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed) else {
            return nil
        }
        let quantity = energy.toHealthKit()
        return HKQuantitySample(type: energyType, quantity: quantity, start: start, end: end)
    }

    /// Creates a mass sample for a specific nutrient type

    private func createMassSample(_ identifier: HKQuantityTypeIdentifier,
    _ mass: MassDto,
    start: Date,
    end: Date) -> HKQuantitySample? {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            return nil
        }
        let quantity = mass.toHealthKit()
        return HKQuantitySample(type: quantityType, quantity: quantity, start: start, end: end)
    }
}
