import Foundation
import HealthKit

/**
 * Extension to convert `HealthDataTypeDto` to HealthKit types.
 */
extension HealthDataTypeDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantityType`.
     *
     * - Returns: The corresponding `HKQuantityType` for this health data type.
     */
    func toHealthKitQuantityType() -> HKQuantityType {
        switch self {
        case .activeCaloriesBurned:
            return HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        case .distance:
            return HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        case .floorsClimbed:
            return HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!
        case .height:
            return HKQuantityType.quantityType(forIdentifier: .height)!
        case .hydration:
            return HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
        case .leanBodyMass:
            return HKQuantityType.quantityType(forIdentifier: .leanBodyMass)!
        case .bodyFatPercentage:
            return HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!
        case .bodyTemperature:
            return HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!
        case .steps:
            return HKQuantityType.quantityType(forIdentifier: .stepCount)!
        case .weight:
            return HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        case .wheelchairPushes:
            return HKQuantityType.quantityType(forIdentifier: .pushCount)!
        case .heartRateMeasurementRecord:
            return HKQuantityType.quantityType(forIdentifier: .heartRate)!
        }
    }

    /**
     * Converts this DTO to a HealthKit `HKSampleType`.
     *
     * This method returns the sample type (which is a base class for quantity types, category types, etc.)
     * that can be used for queries and deletions.
     *
     * - Returns: The corresponding `HKSampleType` for this health data type.
     * - Throws: An error if the conversion fails (should not happen for supported types).
     */
    func toHealthKitSampleType() throws -> HKSampleType {
        // Since all current types are quantity types, we can use the quantity type method
        // and return it as HKSampleType (HKQuantityType is a subclass of HKSampleType)
        return toHealthKitQuantityType()
    }
}

