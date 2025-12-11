import Foundation
import HealthKit

/**
 * Handler for composite blood pressure records using HKCorrelation.bloodPressure
 *
 * ## Overview
 *
 * In HealthKit, a blood pressure reading is represented using
 * `HKCorrelation.bloodPressure` type identifier that contains two `HKQuantitySample` objects:
 * - One for systolic
 * - And one for diastolic pressure.
 */
struct BloodPressureHandler: HealthKitCorrelationHandler {
    static var supportedType: HealthDataTypeDto {
        .bloodPressure
    }

    static var category: HealthKitDataCategory {
        .correlation
    }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto {
        guard let correlation = sample as? HKCorrelation,
              correlation.correlationType.identifier == HKCorrelationTypeIdentifier.bloodPressure.rawValue
        else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected HKCorrelation with bloodPressure type, got \(type(of: sample))"
            )
        }
        guard let dto = correlation.toBloodPressureRecordDto() else {
            throw HealthConnectorErrors
                .invalidArgument(message: "Failed to convert HKCorrelation to BloodPressureRecordDto")
        }
        return dto
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let bpDto = dto as? BloodPressureRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected BloodPressureRecordDto but got \(type(of: dto))"
            )
        }
        return try bpDto.toHealthKitCorrelation()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKCorrelationType.safeCorrelationType(forIdentifier: .bloodPressure)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let bpDto = dto as? BloodPressureRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected BloodPressureRecordDto, got \(type(of: dto))"
            )
        }
        return bpDto.time
    }

    /**
     * Deletes both correlation AND all contained samples
     */
    static func deleteCorrelation(_ correlation: HKCorrelation, from store: HKHealthStore) async throws {
        var objectsToDelete: [HKObject] = [correlation]
        objectsToDelete.append(contentsOf: correlation.objects)

        try await withCheckedThrowingContinuation {
            (continuation: CheckedContinuation<Void, Error>) in
            store.delete(objectsToDelete) {
                success, error in
                if let error {
                    if let nsError = error as NSError? {
                        continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                    } else {
                        continuation.resume(throwing: HealthConnectorErrors.unknown(
                            message: "Failed to delete blood pressure correlation and samples: \(error.localizedDescription)"
                        ))
                    }
                } else if success {
                    continuation.resume()
                } else {
                    continuation.resume(throwing: HealthConnectorErrors.unknown(
                        message: "Failed to delete blood pressure correlation and samples"
                    ))
                }
            }
        }
    }
}
