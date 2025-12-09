import Foundation
import HealthKit

/// Handler for composite blood pressure records using HKCorrelation.bloodPressure
///
/// This handler manages blood pressure readings that group systolic and diastolic
/// samples into a single correlation.
///
/// ## Overview
/// In HealthKit, a blood pressure reading is represented using `HKCorrelation`
/// with the `.bloodPressure` type identifier. This correlation contains two
/// `HKQuantitySample` objects: one for systolic and one for diastolic pressure.
///
/// ## Writing
/// When writing a `BloodPressureRecordDto`, this handler:
/// 1. Creates `HKQuantitySample` for systolic pressure
/// 2. Creates `HKQuantitySample` for diastolic pressure
/// 3. Groups them into an `HKCorrelation` with `.bloodPressure` type
///
/// ## Reading
/// When reading, the handler extracts systolic and diastolic values from
/// the contained samples within the correlation.
///
/// ## Body Position and Measurement Location
/// Note: HealthKit does not natively support body position or measurement
/// location for blood pressure. These fields will always return `.unknown`
/// when reading from HealthKit, and are ignored when writing.

struct BloodPressureHandler: HealthKitCorrelationHandler {

    static var supportedType: HealthDataTypeDto {
        .bloodPressure
    }

    static var category: HealthKitDataCategory {
        .correlation
    }

    // MARK: - HealthKitSampleHandler

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        guard let correlation = sample as? HKCorrelation,
            correlation.correlationType.identifier == HKCorrelationTypeIdentifier.bloodPressure.rawValue else {
            return nil
        }
        return correlation.toBloodPressureRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let bpDto = dto as? BloodPressureRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected BloodPressureRecordDto but got \(type(of: dto))"
            )
        }
        return try bpDto.toHealthKitCorrelation()
    }

    static func getSampleType() -> HKSampleType {
        return HKCorrelationType.correlationType(forIdentifier: .bloodPressure)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        guard let bpDto = dto as? BloodPressureRecordDto else {
            return 0
        }
        return bpDto.time
    }

    // MARK: - HealthKitCorrelationHandler

    static func deleteCorrelation(_ correlation: HKCorrelation, from store: HKHealthStore) async throws {
        // Critical: Must delete both correlation AND all contained samples
        var objectsToDelete: [HKObject] = [correlation]
        objectsToDelete.append(contentsOf: correlation.objects)

        try await withCheckedThrowingContinuation {
            (continuation: CheckedContinuation<Void, Error>) in
            store.delete(objectsToDelete) {
                success, error in
                if let error = error {
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
