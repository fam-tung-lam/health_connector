import Foundation
import HealthKit

/// Handler for systolic blood pressure (instant quantity type)
///
/// **Data Type:** Systolic Blood Pressure
/// **Record Pattern:** Instant (single timestamp)
/// **Aggregation:** Average, Min, Max
/// **HealthKit Type:** HKQuantityTypeIdentifier.bloodPressureSystolic
///
/// **Note:** When writing a SystolicBloodPressureRecord on iOS, it creates
/// a standalone quantity sample, not a correlation. For complete blood
/// pressure readings (systolic + diastolic together), use BloodPressureRecord.

struct SystolicBloodPressureHandler: HealthKitQuantityHandler {
    // MARK: - HealthKitTypeHandler

    static var supportedType: HealthDataTypeDto {
        return .systolicBloodPressure
    }

    static var category: HealthKitDataCategory {
        return .quantitySample
    }

    // MARK: - HealthKitSampleHandler

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        guard let quantitySample = sample as? HKQuantitySample else {
            return nil
        }
        return quantitySample.toSystolicBloodPressureRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let systolicDto = dto as? SystolicBloodPressureRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected SystolicBloodPressureRecordDto, got \(type(of: dto))"
            )
        }
        return try systolicDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        return HKQuantityType.quantityType(forIdentifier: .bloodPressureSystolic)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        guard let systolicDto = dto as? SystolicBloodPressureRecordDto else {
            return 0
        }
        return systolicDto.time
    }

    // MARK: - HealthKitQuantityHandler (Aggregation Support)

    static func supportedAggregations() -> [AggregationMetricDto] {
        return [.avg, .min, .max]
    }

    static func toStatisticsOptions(_ metric: AggregationMetricDto) -> HKStatisticsOptions {
        switch metric {
        case .avg:
            return .discreteAverage
        case .min:
            return .discreteMin
        case .max:
            return .discreteMax
        default:
            return []
        }
    }
}
