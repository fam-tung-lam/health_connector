import Foundation
import HealthKit

/**
 * Handler for lean body mass data (instant quantity type)
 */
struct LeanBodyMassHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto {
        .leanBodyMass
    }

    static var category: HealthKitDataCategory {
        .quantitySample
    }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorErrors.invalidArgument(message: "Expected HKQuantitySample, got \(type(of: sample))")
        }
        guard let dto = quantitySample.toLeanBodyMassRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKQuantitySample to LeanBodyMassRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let leanMassDto = dto as? LeanBodyMassRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected LeanBodyMassRecordDto, got \(type(of: dto))"
            )
        }
        return try leanMassDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .leanBodyMass)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let leanMassDto = dto as? LeanBodyMassRecordDto else {
            throw HealthConnectorErrors.invalidArgument(message: "Expected LeanBodyMassRecordDto, got \(type(of: dto))")
        }
        return leanMassDto.time
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        throw HealthConnectorErrors.invalidArgument(
            message: "Aggregation metric '\(metric)' not supported for lean body mass",
            details: "Individual measurements should be tracked over time instead"
        )
    }

    static func extractAggregateValue(
        from _: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        throw HealthConnectorErrors.invalidArgument(
            message: "Aggregation metric '\(metric)' not supported for lean body mass",
            details: "Individual measurements should be tracked over time instead"
        )
    }
}
