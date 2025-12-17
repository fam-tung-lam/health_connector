import Foundation
import HealthKit

private enum BloodGlucoseMetadataKeys {
    static let mealType = "com.healthconnect.sync.mealType"
    static let specimenSource = "com.healthconnect.sync.specimenSource"
    static let relationToMeal = "com.healthconnect.sync.relationToMeal"
}

extension BloodGlucoseRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bloodGlucose)

        let quantity = bloodGlucose.toHealthKit()
        let date = Date(millisecondsSince1970: time)

        // Base metadata
        var metadataDict = metadata.toHealthKitMetadata() ?? [:]

        // Add Custom Metadata Keys for full fidelity
        if let relation = relationToMeal {
            metadataDict[BloodGlucoseMetadataKeys.relationToMeal] = relation.rawValue
        }
        if let source = specimenSource {
            metadataDict[BloodGlucoseMetadataKeys.specimenSource] = source.rawValue
        }
        if let meal = mealType {
            metadataDict[BloodGlucoseMetadataKeys.mealType] = meal.rawValue
        }

        // Add Native Metadata Keys (Priority for UI/Legacy support)
        // HKMetadataKeyBloodGlucoseMealTime only supports Preprandial (Before Meal) and Postprandial (After Meal)
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
            end: date, // Instant record
            device: metadata.toHealthKitDevice(),
            metadata: metadataDict
        )
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `BloodGlucoseRecordDto`.
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

        // Extract Metadata
        var relation: BloodGlucoseRelationToMealDto = .unknown
        var source: BloodGlucoseSpecimenSourceDto = .unknown
        var meal: MealTypeDto = .unknown

        // 1. Relation To Meal Mapping Logic
        // Priority: Native Key > Custom Key > Default
        if let nativeMealTimeRaw = metadataDict[HKMetadataKeyBloodGlucoseMealTime] as? Int,
           let nativeMealTime = HKBloodGlucoseMealTime(rawValue: nativeMealTimeRaw)
        {
            switch nativeMealTime {
            case .preprandial:
                relation = .beforeMeal
            case .postprandial:
                relation = .afterMeal
            @unknown default:
                // Fallback to custom key
                if let customRelationRaw = metadataDict[BloodGlucoseMetadataKeys.relationToMeal]
                    as? Int
                {
                    relation =
                        BloodGlucoseRelationToMealDto(rawValue: customRelationRaw) ?? .unknown
                }
            }
        } else {
            // No native key, check custom key
            if let customRelationRaw = metadataDict[BloodGlucoseMetadataKeys.relationToMeal] as? Int {
                relation = BloodGlucoseRelationToMealDto(rawValue: customRelationRaw) ?? .unknown
            }
        }

        // 2. Specimen Source
        if let customSourceRaw = metadataDict[BloodGlucoseMetadataKeys.specimenSource] as? Int {
            source = BloodGlucoseSpecimenSourceDto(rawValue: customSourceRaw) ?? .unknown
        }

        // 3. Meal Type
        if let customMealRaw = metadataDict[BloodGlucoseMetadataKeys.mealType] as? Int {
            meal = MealTypeDto(rawValue: customMealRaw) ?? .unknown
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
