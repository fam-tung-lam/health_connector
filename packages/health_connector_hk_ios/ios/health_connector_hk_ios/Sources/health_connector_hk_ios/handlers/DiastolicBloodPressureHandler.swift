import Foundation
import HealthKit

/// Handler for diastolic blood pressure (instant quantity type)
///
/// **Data Type:** Diastolic Blood Pressure
/// **Record Pattern:** Instant (single timestamp)
/// **Aggregation:** Average, Min, Max
/// **HealthKit Type:** HKQuantityTypeIdentifier.bloodPressureDiastolic
///
/// **Note:** When writing a DiastolicBloodPressureRecord on iOS, it creates
/// a standalone quantity sample, not a correlation. For complete blood
/// pressure readings (systolic + diastolic together), use BloodPressureRecord.

struct DiastolicBloodPressureHandler: HealthKitQuantityHandler {
    // MARK: - HealthKitTypeHandler

    static var supportedType: HealthDataTypeDto {
        return .diastolicBloodPressure
    }

    static var category: HealthKitDataCategory {
        return .quantitySample
    }

    // MARK: - HealthKitSampleHandler

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        guard let quantitySample = sample as? HKQuantitySample else {
            return nil
        }
        return quantitySample.toDiastolicBloodPressureRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let diastolicDto = dto as? DiastolicBloodPressureRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected DiastolicBloodPressureRecordDto, got \(type(of: dto))"
            )
        }
        return try diastolicDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        return HKQuantityType.quantityType(forIdentifier: .bloodPressureDiastolic)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        guard let diastolicDto = dto as? DiastolicBloodPressureRecordDto else {
            return 0
        }
        return diastolicDto.time
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
