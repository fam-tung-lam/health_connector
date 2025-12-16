import Foundation
import HealthKit

/// Handler for sleep stage data (category sample type)
final class SleepStageHandler:
    HealthKitTypeHandler,
    HealthKitTypeMapper,
    ReadableHealthKitTypeHandler,
    WritableHealthKitTypeHandler,
    UpdatableHealthKitTypeHandler,
    DeletableHealthKitTypeHandler
{
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var supportedType: HealthDataTypeDto {
        .sleepStageRecord
    }

    static var category: HealthKitDataCategory {
        .categorySample
    }

    typealias RecordDto = SleepStageRecordDto
    typealias SampleType = HKCategorySample

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let categorySample = sample as? HKCategorySample else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKCategorySample, got \(type(of: sample))"
            )
        }
        guard
            categorySample.categoryType.identifier
            == HKCategoryTypeIdentifier.sleepAnalysis.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected sleep analysis category, got \(categorySample.categoryType.identifier)"
            )
        }
        guard let dto = categorySample.toSleepStageRecordDto() else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to convert HKCategorySample to SleepStageRecordDto"
            )
        }
        return dto
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let sleepDto = dto as? SleepStageRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected SleepStageRecordDto, got \(type(of: dto))"
            )
        }
        return try sleepDto.toHealthKit()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let sleepDto = dto as? SleepStageRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected SleepStageRecordDto, got \(type(of: dto))"
            )
        }
        return sleepDto.endTime
    }

    func getSampleType() throws -> HKSampleType {
        try HKCategoryType.safeCategoryType(forIdentifier: .sleepAnalysis)
    }
}
