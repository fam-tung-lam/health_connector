import Foundation
import HealthKit

private let kMetadataKeyMealType = "com.healthconnect.sync.mealType"
private let kMetadataKeySpecimenSource = "com.healthconnect.sync.specimenSource"
private let kMetadataKeyRelationToMeal = "com.healthconnect.sync.relationToMeal"

extension BloodGlucoseRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .bloodGlucose) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Failed to create blood glucose quantity type",
                ]
            )
        }

        let quantity = bloodGlucose.toHealthKit()
        let date = Date(timeIntervalSince1970: TimeInterval(time) / 1000.0)

        // Base metadata
        var metadataDict = metadata.toHealthKitMetadata() ?? [:]

        // Add Custom Metadata Keys for full fidelity
        if let relation = relationToMeal {
            metadataDict[kMetadataKeyRelationToMeal] = relation.rawValue
        }
        if let source = specimenSource {
            metadataDict[kMetadataKeySpecimenSource] = source.rawValue
        }
        if let meal = mealType {
            metadataDict[kMetadataKeyMealType] = meal.rawValue
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
    func toBloodGlucoseRecordDto() -> BloodGlucoseRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bloodGlucose.rawValue else {
            return nil
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
                if let customRelationRaw = metadataDict[kMetadataKeyRelationToMeal] as? Int {
                    relation =
                        BloodGlucoseRelationToMealDto(rawValue: customRelationRaw) ?? .unknown
                }
            }
        } else {
            // No native key, check custom key
            if let customRelationRaw = metadataDict[kMetadataKeyRelationToMeal] as? Int {
                relation = BloodGlucoseRelationToMealDto(rawValue: customRelationRaw) ?? .unknown
            }
        }

        // 2. Specimen Source
        if let customSourceRaw = metadataDict[kMetadataKeySpecimenSource] as? Int {
            source = BloodGlucoseSpecimenSourceDto(rawValue: customSourceRaw) ?? .unknown
        }

        // 3. Meal Type
        if let customMealRaw = metadataDict[kMetadataKeyMealType] as? Int {
            meal = MealTypeDto(rawValue: customMealRaw) ?? .unknown
        }

        return BloodGlucoseRecordDto(
            id: uuid.uuidString,
            time: Int64(startDate.timeIntervalSince1970 * 1000),
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
