import Foundation
import HealthKit

/// Capability for handlers that support updating health records.
///
/// HealthKit doesn't support true updates - we delete the old record and create a new one.
/// This capability combines Readable and Writable capabilities to implement update logic.
///
/// Implementation Strategy:
/// 1. Read the existing record to get the HKSample object
/// 2. Delete the old record
/// 3. Write the new record
///
/// Handlers automatically get this capability by conforming to both
/// ReadableHealthRecordHandler and WritableHealthRecordHandler.
protocol UpdatableHealthRecordHandler: HealthRecordHandler, ReadableHealthRecordHandler, WritableHealthRecordHandler {
}

extension UpdatableHealthRecordHandler where Self: ReadableHealthRecordHandler & WritableHealthRecordHandler {
    /// Updates a record by deleting the old version and creating a new one
    ///
    /// - Parameters:
    ///   - dto: The updated health record DTO (must have valid ID)
    /// - Throws: HealthConnectorError if update fails
    func updateRecord(_ dto: HealthRecordDto) async throws {
        try await process(operation: "update_record", context: nil) {
            // Validate ID is present
            guard let idDto = dto.id else {
                throw HealthConnectorError.invalidArgument(
                    message: "Cannot update record without ID"
                )
            }

            // Can call readRecord because of ReadableHealthRecordHandler constraint
            let existingDto = try await readRecord(id: idDto)
            let existingSample = try existingDto.toHealthKit()

            // Delete the old record
            try await self.healthStore.delete(existingSample)

            // Write the new record
            let newSample = try dto.toHealthKit()
            try await self.healthStore.save(newSample)
        }
    }
}
