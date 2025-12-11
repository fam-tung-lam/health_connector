import Foundation
import HealthKit

/**
 * Handler for body temperature data (instant quantity type)
 */
struct BodyTemperatureHandler: HealthKitQuantityHandler {
    static var supportedType: HealthDataTypeDto {
        .bodyTemperature
    }

    static var category: HealthKitDataCategory {
        .quantitySample
    }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorErrors.invalidArgument(message: "Expected HKQuantitySample, got \(type(of: sample))")
        }
        guard let dto = quantitySample.toBodyTemperatureRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKQuantitySample to BodyTemperatureRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let temperatureDto = dto as? BodyTemperatureRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected BodyTemperatureRecordDto, got \(type(of: dto))"
            )
        }
        return try temperatureDto.toHealthKit()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKQuantityType.safeQuantityType(forIdentifier: .bodyTemperature)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let temperatureDto = dto as? BodyTemperatureRecordDto else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Expected BodyTemperatureRecordDto, got \(type(of: dto))")
        }
        return temperatureDto.time
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        // Body temperature aggregations are not medically meaningful
        // Individual readings at specific times are what matters
        throw HealthConnectorErrors.invalidArgument(
            message: "Aggregation metric '\(metric)' not supported for body temperature",
            details: "Individual readings at specific times should be used instead"
        )
    }

    static func extractAggregateValue(
        from _: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        throw HealthConnectorErrors.invalidArgument(
            message: "Aggregation metric '\(metric)' not supported for body temperature",
            details: "Individual readings at specific times should be used instead"
        )
    }
}
