import Foundation
import HealthKit

/**
 * Handler for sleep stage data (category sample type)
 *
 * ## Category samples do NOT support aggregation
 *
 * Unlike quantity samples (steps, weight), category samples represent
 * discrete states or events, not measurable quantities.
 *
 * To analyze sleep patterns, apps typically:
 * 1. Read all sleep stage records for a time range
 * 2. Process them in Dart/Flutter to calculate:
 *    - Total sleep duration
 *    - Time in each stage (light, deep, REM)
 *    - Sleep efficiency
 *    - Number of awakenings
 */
struct SleepStageHandler: HealthKitSampleHandler {
    static var supportedType: HealthDataTypeDto {
        .sleepStageRecord
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
        guard categorySample.categoryType.identifier == HKCategoryTypeIdentifier.sleepAnalysis.rawValue else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected sleep analysis category, got \(categorySample.categoryType.identifier)"
            )
        }
        guard let dto = categorySample.toSleepStageRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKCategorySample to SleepStageRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let sleepDto = dto as? SleepStageRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected SleepStageRecordDto, got \(type(of: dto))"
            )
        }
        return try sleepDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKCategoryType.safeCategoryType(forIdentifier: .sleepAnalysis)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let sleepDto = dto as? SleepStageRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected SleepStageRecordDto, got \(type(of: dto))"
            )
        }
        return sleepDto.endTime
    }
}
