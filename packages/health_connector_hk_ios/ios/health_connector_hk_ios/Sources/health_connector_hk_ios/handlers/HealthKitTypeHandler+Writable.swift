import Foundation
import HealthKit

/// Capability for handlers that support writing health records.
protocol WritableHealthKitTypeHandler: HealthKitTypeHandler, HealthKitTypeMapper {
}

extension WritableHealthKitTypeHandler where Self: HealthKitTypeMapper {
    /**
     * Writes a single record to HealthKit
     *
     * - Parameters:
     *   - dto: The health record DTO to write
     * - Returns: The UUID of the created record
     * - Throws: HealthConnectorError if write fails
     */
    func writeRecord(_ dto: HealthRecordDto) async throws -> String {
        try await process(operation: "write_record", context: nil) {
            let sample = try Self.mapToHealthKit(dto)
            try await self.healthStore.save(sample)
            return sample.uuid.uuidString
        }
    }

    /**
     * Writes multiple records to HealthKit
     *
     * - Parameters:
     *   - dtos: Array of health record DTOs to write
     * - Returns: Array of UUIDs for the created records (in same order as input)
     * - Throws: HealthConnectorError if any write fails
     */
    func writeRecords(_ dtos: [HealthRecordDto]) async throws -> [String] {
        try await process(
            operation: "write_records",
            context: ["count": dtos.count]
        ) {
            let samples = try dtos.map { try Self.mapToHealthKit($0) }
            try await self.healthStore.save(samples)
            return samples.map(\.uuid.uuidString)
        }
    }
}
