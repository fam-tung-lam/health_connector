import Foundation
import HealthKit

// MARK: - Custom Metadata Keys

private let bloodGlucoseMealTypeMetadataKey =
    "\(hkMetadataKeyPrefix)meal_type"
private let bloodGlucoseSpecimenSourceMetadataKey =
    "\(hkMetadataKeyPrefix)specimen_source"
private let bloodGlucoseRelationToMealMetadataKey =
    "\(hkMetadataKeyPrefix)relation_to_meal"
// MARK: - String Value Enums

/// String representations for blood glucose relation to meal values.
///
/// **Why string-based storage:**
/// While the Pigeon-generated `BloodGlucoseRelationToMealDto` is Int-backed,
/// we store string representations in HKMetadata for:
/// - Consistency with other mappers (e.g., CervicalMucusRecordMapper)
/// - Better debugging and readability in HealthKit metadata
/// - Future-proofing against schema changes
private enum BloodGlucoseRelationToMealValue: String {
    case unknown
    case general
    case fasting
    case beforeMeal
    case afterMeal
}

/// String representations for blood glucose specimen source values.
private enum BloodGlucoseSpecimenSourceValue: String {
    case unknown
    case interstitialFluid
    case capillaryBlood
    case plasma
    case serum
    case tears
    case wholeBlood
}

/// String representations for meal type values.
private enum MealTypeValue: String {
    case unknown
    case breakfast
    case lunch
    case dinner
    case snack
}

// MARK: - DTO to String Extensions

extension BloodGlucoseRelationToMealDto {
    /// Converts the DTO to a string for HKMetadata storage.
    func toMetadataString() -> String {
        switch self {
        case .unknown:
            BloodGlucoseRelationToMealValue.unknown.rawValue
        case .general:
            BloodGlucoseRelationToMealValue.general.rawValue
        case .fasting:
            BloodGlucoseRelationToMealValue.fasting.rawValue
        case .beforeMeal:
            BloodGlucoseRelationToMealValue.beforeMeal.rawValue
        case .afterMeal:
            BloodGlucoseRelationToMealValue.afterMeal.rawValue
        }
    }
}

extension BloodGlucoseSpecimenSourceDto {
    /// Converts the DTO to a string for HKMetadata storage.
    func toMetadataString() -> String {
        switch self {
        case .unknown:
            BloodGlucoseSpecimenSourceValue.unknown.rawValue
        case .interstitialFluid:
            BloodGlucoseSpecimenSourceValue.interstitialFluid.rawValue
        case .capillaryBlood:
            BloodGlucoseSpecimenSourceValue.capillaryBlood.rawValue
        case .plasma:
            BloodGlucoseSpecimenSourceValue.plasma.rawValue
        case .serum:
            BloodGlucoseSpecimenSourceValue.serum.rawValue
        case .tears:
            BloodGlucoseSpecimenSourceValue.tears.rawValue
        case .wholeBlood:
            BloodGlucoseSpecimenSourceValue.wholeBlood.rawValue
        }
    }
}

extension MealTypeDto {
    /// Converts the DTO to a string for HKMetadata storage.
    func toMetadataString() -> String {
        switch self {
        case .unknown:
            MealTypeValue.unknown.rawValue
        case .breakfast:
            MealTypeValue.breakfast.rawValue
        case .lunch:
            MealTypeValue.lunch.rawValue
        case .dinner:
            MealTypeValue.dinner.rawValue
        case .snack:
            MealTypeValue.snack.rawValue
        }
    }
}

// MARK: - String to DTO Extensions

extension String {
    /// Converts a metadata string to `BloodGlucoseRelationToMealDto`.
    func toBloodGlucoseRelationToMealDto() -> BloodGlucoseRelationToMealDto {
        guard let value = BloodGlucoseRelationToMealValue(rawValue: self) else {
            return .unknown
        }
        switch value {
        case .unknown:
            return .unknown
        case .general:
            return .general
        case .fasting:
            return .fasting
        case .beforeMeal:
            return .beforeMeal
        case .afterMeal:
            return .afterMeal
        }
    }

    /// Converts a metadata string to `BloodGlucoseSpecimenSourceDto`.
    func toBloodGlucoseSpecimenSourceDto() -> BloodGlucoseSpecimenSourceDto {
        guard let value = BloodGlucoseSpecimenSourceValue(rawValue: self) else {
            return .unknown
        }
        switch value {
        case .unknown:
            return .unknown
        case .interstitialFluid:
            return .interstitialFluid
        case .capillaryBlood:
            return .capillaryBlood
        case .plasma:
            return .plasma
        case .serum:
            return .serum
        case .tears:
            return .tears
        case .wholeBlood:
            return .wholeBlood
        }
    }

    /// Converts a metadata string to `MealTypeDto`.
    func toMealTypeDto() -> MealTypeDto {
        guard let value = MealTypeValue(rawValue: self) else {
            return .unknown
        }
        switch value {
        case .unknown:
            return .unknown
        case .breakfast:
            return .breakfast
        case .lunch:
            return .lunch
        case .dinner:
            return .dinner
        case .snack:
            return .snack
        }
    }
}

// MARK: - DTO to HealthKit

extension BloodGlucoseRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// **Storage Strategy:**
    /// - All DTO enum values are stored as strings in custom metadata keys
    /// - Native HealthKit keys are also populated when applicable for compatibility
    /// - String storage ensures consistency across all mappers and better debugging
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bloodGlucose)

        let quantity = bloodGlucose.toHealthKit()
        let date = Date(millisecondsSince1970: time)

        // Base metadata
        var metadataDict = metadata.toHealthKitMetadata() ?? [:]

        // Store all enum values as strings in custom metadata
        // This ensures no data loss and maintains consistency with other mappers
        if let relation = relationToMeal {
            metadataDict[bloodGlucoseRelationToMealMetadataKey] = relation.toMetadataString()
        }
        if let source = specimenSource {
            metadataDict[bloodGlucoseSpecimenSourceMetadataKey] = source.toMetadataString()
        }
        if let meal = mealType {
            metadataDict[bloodGlucoseMealTypeMetadataKey] = meal.toMetadataString()
        }

        // Add Native HealthKit metadata keys for compatibility with Apple Health app
        // HKMetadataKeyBloodGlucoseMealTime only supports preprandial and postprandial
        if let relation = relationToMeal {
            if relation == .beforeMeal {
                metadataDict[HKMetadataKeyBloodGlucoseMealTime] =
                    HKBloodGlucoseMealTime.preprandial.rawValue
            } else if relation == .afterMeal {
                metadataDict[HKMetadataKeyBloodGlucoseMealTime] =
                    HKBloodGlucoseMealTime.postprandial.rawValue
            }
        }

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date,  // Instant record
            device: metadata.toHealthKitDevice(),
            metadata: metadataDict
        )
    }
}

// MARK: - HealthKit to DTO

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `BloodGlucoseRecordDto`.
    ///
    /// **Reading Strategy:**
    /// - Priority 1: Custom metadata strings (written by our SDK, full fidelity)
    /// - Priority 2: Native HealthKit keys (written by Apple Health, partial support)
    /// - Priority 3: Default to `.unknown`
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a blood glucose sample.
    func toBloodGlucoseRecordDto() throws -> BloodGlucoseRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bloodGlucose.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected blood glucose quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.bloodGlucose.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        // Extract Metadata with priority: Custom String -> Native HealthKit -> Default
        var relation: BloodGlucoseRelationToMealDto = .unknown
        var source: BloodGlucoseSpecimenSourceDto = .unknown
        var meal: MealTypeDto = .unknown

        // 1. Relation To Meal
        // Priority 1: Check custom string metadata (our SDK)
        if let relationString = metadataDict[bloodGlucoseRelationToMealMetadataKey] as? String {
            relation = relationString.toBloodGlucoseRelationToMealDto()
        } else {
            // Priority 2: Check native HealthKit key (Apple Health or other apps)
            if let nativeMealTimeRaw = metadataDict[HKMetadataKeyBloodGlucoseMealTime] as? Int,
                let nativeMealTime = HKBloodGlucoseMealTime(rawValue: nativeMealTimeRaw)
            {
                switch nativeMealTime {
                case .preprandial:
                    relation = .beforeMeal
                case .postprandial:
                    relation = .afterMeal
                @unknown default:
                    // Future HealthKit values - remain .unknown
                    relation = .unknown
                }
            }
        }

        // 2. Specimen Source
        // Only available in custom metadata (no native HealthKit key)
        if let sourceString = metadataDict[bloodGlucoseSpecimenSourceMetadataKey] as? String {
            source = sourceString.toBloodGlucoseSpecimenSourceDto()
        }

        // 3. Meal Type
        // Only available in custom metadata (no native HealthKit key)
        if let mealString = metadataDict[bloodGlucoseMealTypeMetadataKey] as? String {
            meal = mealString.toMealTypeDto()
        }

        return BloodGlucoseRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            bloodGlucose: quantity.toBloodGlucoseDto(),
            mealType: meal,
            relationToMeal: relation,
            specimenSource: source,
            zoneOffsetSeconds: zoneOffset
        )
    }
}
