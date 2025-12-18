import Foundation
import HealthKit

/// Capability for handlers that support writing health records.
protocol WritableHealthRecordHandler: HealthRecordHandler {
}

extension WritableHealthRecordHandler {
    /// Writes a single record to HealthKit
    ///
    /// - Parameters:
    ///   - dto: The health record DTO to write
    /// - Returns: The UUID of the created record
    /// - Throws: HealthConnectorError if write fails or if DTO type mismatch
    func writeRecord(_ dto: HealthRecordDto) async throws -> String {
        // Validate that the DTO is of the expected type for this handler
        guard dto is Self.RecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Type mismatch: expected \(Self.RecordDto.self), but got \(type(of: dto))",
                context: [
                    "expected_type": String(describing: Self.RecordDto.self),
                    "actual_type": String(describing: type(of: dto)),
                    "handler_type": String(describing: type(of: self)),
                ]
            )
        }

        return try await process(operation: "write_record", context: nil) {
            let sample = try dto.toHealthKit()
            try await self.healthStore.save(sample)
            return sample.uuid.uuidString
        }
    }

    /// Writes multiple records to HealthKit
    ///
    /// - Parameters:
    ///   - dtos: Array of health record DTOs to write
    /// - Returns: Array of UUIDs for the created records (in same order as input)
    /// - Throws: HealthConnectorError if any write fails or if any DTO type mismatch
    func writeRecords(_ dtos: [HealthRecordDto]) async throws -> [String] {
        // Validate that all DTOs are of the expected type for this handler
        for (index, dto) in dtos.enumerated() {
            guard dto is Self.RecordDto else {
                throw HealthConnectorError.invalidArgument(
                    message:
                    "Type mismatch at index \(index): expected \(Self.RecordDto.self), but got \(type(of: dto))",
                    context: [
                        "index": String(index),
                        "expected_type": String(describing: Self.RecordDto.self),
                        "actual_type": String(describing: type(of: dto)),
                        "handler_type": String(describing: type(of: self)),
                    ]
                )
            }
        }

        return try await process(
            operation: "write_records",
            context: ["count": dtos.count]
        ) {
            let samples = try dtos.map { dto in
                try dto.toHealthKit()
            }
            try await self.healthStore.save(samples)
            return samples.map(\.uuid.uuidString)
        }
    }
}
