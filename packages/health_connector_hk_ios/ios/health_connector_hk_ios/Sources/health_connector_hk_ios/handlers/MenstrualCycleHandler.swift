import Foundation
import HealthKit

/**
 * Handler for Menstrual Cycle (Menstrual Flow) data.
 *
 * Characteristics:
 * - Category Sample Type: .menstrualFlow
 * - Maps to: MenstrualCycleRecordDto
 */
struct MenstrualCycleHandler: HealthKitSampleHandler {
    static var supportedType: HealthDataTypeDto {
        .menstrualCycle
    }

    static var category: HealthKitDataCategory {
        .categorySample
    }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto {
        guard let categorySample = sample as? HKCategorySample else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected HKCategorySample, got \(type(of: sample))"
            )
        }
        guard categorySample.categoryType.identifier == HKCategoryTypeIdentifier.menstrualFlow.rawValue else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected menstrual flow category, got \(categorySample.categoryType.identifier)"
            )
        }
        guard let dto = categorySample.toMenstrualCycleRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKCategorySample to MenstrualCycleRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let cycleDto = dto as? MenstrualCycleRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected MenstrualCycleRecordDto, got \(type(of: dto))"
            )
        }
        return try cycleDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKCategoryType.safeCategoryType(forIdentifier: .menstrualFlow)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let cycleDto = dto as? MenstrualCycleRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected MenstrualCycleRecordDto, got \(type(of: dto))"
            )
        }
        return cycleDto.endTime
    }
}
