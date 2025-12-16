import Foundation
import HealthKit

/// Handler for composite blood pressure samples (correlation type)
final class BloodPressureHandler:
    HealthRecordHandler,
    MappableHealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler
{
    /// The HealthKit store for all operations
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var supportedType: HealthDataTypeDto {
        .bloodPressure
    }

    typealias RecordDto = BloodPressureRecordDto
    typealias SampleType = HKCorrelation

    /// Convert HealthKit sample to DTO
    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let correlation = sample as? HKCorrelation,
              correlation.correlationType.identifier
              == HKCorrelationTypeIdentifier.bloodPressure.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKCorrelation with bloodPressure type, got \(type(of: sample))"
            )
        }
        guard let dto = correlation.toBloodPressureRecordDto() else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to convert HKCorrelation to BloodPressureRecordDto"
            )
        }
        return dto
    }

    /// Convert DTO to HealthKit sample
    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let bpDto = dto as? BloodPressureRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected BloodPressureRecordDto but got \(type(of: dto))"
            )
        }
        return try bpDto.toHealthKitCorrelation()
    }

    /// Get the HKSampleType for queries
    func getSampleType() throws -> HKSampleType {
        try HKCorrelationType.make(from: .bloodPressure)
    }

    /// Deletes records by ID, including contained samples for correlations.
    func deleteRecords(ids: [String]) async throws {
        try await process(operation: "delete_records_by_ids", context: ["ids": ids]) {
            for id in ids {
                // For correlations, we need to fetch the actual object to get its contained samples
                guard let uuid = UUID(uuidString: id) else {
                    HealthConnectorLogger.warning(
                        tag: String(describing: Self.self),
                        operation: "delete_records_by_ids",
                        message: "Invalid UUID, skipping deletion",
                        context: ["id": id]
                    )
                    continue
                }

                let predicate = HKQuery.predicateForObject(with: uuid)
                let sampleType = try getSampleType()
                let samples = try await withCheckedThrowingContinuation {
                    (
                        continuation: CheckedContinuation<
                            [HKSample],
                            Error
                        >
                    ) in
                    let query = HKSampleQuery(
                        sampleType: sampleType,
                        predicate: predicate,
                        limit: 1,
                        sortDescriptors: nil
                    ) { _, samples, error in
                        if let error {
                            continuation.resume(throwing: error)
                        } else {
                            continuation.resume(returning: samples ?? [])
                        }
                    }
                    self.healthStore.execute(query)
                }

                guard let correlation = samples.first as? HKCorrelation else {
                    HealthConnectorLogger.warning(
                        tag: String(describing: Self.self),
                        operation: "delete_records_by_ids",
                        message: "Correlation not found or not a valid correlation",
                        context: ["id": id]
                    )
                    continue
                }

                // Collect objects to delete: the correlation itself + its contained objects
                var objectsToDelete: [HKObject] = [correlation]
                objectsToDelete.append(contentsOf: correlation.objects)

                // Execute deletion
                try await withCheckedThrowingContinuation {
                    (continuation: CheckedContinuation<Void, Error>) in
                    self.healthStore.delete(objectsToDelete) { success, error in
                        if let error {
                            continuation.resume(throwing: error)
                        } else if !success {
                            continuation.resume(
                                throwing: HealthConnectorError.unknown(
                                    message: "Failed to delete correlation"))
                        } else {
                            continuation.resume()
                        }
                    }
                }
            }
        }
    }
}
