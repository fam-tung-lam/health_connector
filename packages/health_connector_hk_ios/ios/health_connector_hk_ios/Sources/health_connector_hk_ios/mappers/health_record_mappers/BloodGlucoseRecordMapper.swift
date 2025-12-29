import Foundation
import HealthKit

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

        // Build metadata using centralized builder
        var builder = try MetadataBuilder(
            from: metadata)

        // Store all enum values using type-safe custom keys
        if let relation = relationToMeal {
            builder.set(BloodGlucoseRelationToMealKey.self, value: relation)

            // Also set native HealthKit key for compatibility with Apple Health
            if relation == .beforeMeal {
                builder.set(
                    standardKey: HKMetadataKeyBloodGlucoseMealTime,
                    value: HKBloodGlucoseMealTime.preprandial.rawValue
                )
            } else if relation == .afterMeal {
                builder.set(
                    standardKey: HKMetadataKeyBloodGlucoseMealTime,
                    value: HKBloodGlucoseMealTime.postprandial.rawValue
                )
            }
        }

        if let source = specimenSource {
            builder.set(BloodGlucoseSpecimenSourceKey.self, value: source)
        }

        if let meal = mealType {
            builder.set(BloodGlucoseMealTypeKey.self, value: meal)
        }

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant record
            device: builder.healthDevice,
            metadata: builder.build()
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

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        // Extract Relation To Meal with priority: Custom -> Native HK -> Default
        var relation: BloodGlucoseRelationToMealDto = .unknown
        if let customRelation = BloodGlucoseRelationToMealKey.read(from: builder.metadataDict) {
            relation = customRelation
        } else if let nativeMealTimeRaw = builder.metadataDict[HKMetadataKeyBloodGlucoseMealTime]
            as? Int,
            let nativeMealTime = HKBloodGlucoseMealTime(rawValue: nativeMealTimeRaw)
        {
            switch nativeMealTime {
            case .preprandial:
                relation = .beforeMeal
            case .postprandial:
                relation = .afterMeal
            @unknown default:
                relation = .unknown
            }
        }

        // Specimen source - only available in custom metadata
        let source = BloodGlucoseSpecimenSourceKey.readOrDefault(from: builder.metadataDict)

        // Meal type - only available in custom metadata
        let meal = BloodGlucoseMealTypeKey.readOrDefault(from: builder.metadataDict)

        return try BloodGlucoseRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            bloodGlucose: quantity.toBloodGlucoseDto(),
            mealType: meal,
            relationToMeal: relation,
            specimenSource: source,
            zoneOffsetSeconds: zoneOffset
        )
    }
}
