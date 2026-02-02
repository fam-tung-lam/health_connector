import Foundation
import HealthKit

/// Capability protocol for handlers that support writing health records to HealthKit.
///
/// This protocol declares `writeRecord(_:)` as a requirement so that calls made
/// through a `WritableHealthRecordHandler`-typed reference use dynamic dispatch.
/// A default implementation is provided in the protocol extension below for
/// standard record types that can be written via `HealthRecordDto.toHKSample()`.
///
/// Batch write operations are handled atomically at the `HealthConnectorClient`
/// level to ensure all-or-nothing semantics across different record types.
protocol WritableHealthRecordHandler: HealthRecordHandler {
    /// Writes a single health record to HealthKit.
    ///
    /// Conforming types can override this requirement to customize write behavior
    /// for special HealthKit types (e.g., heartbeat series) while still benefiting
    /// from the default implementation provided in the protocol extension.
    ///
    /// - Parameter dto: The health record DTO to write. Must match this handler's
    ///                  `RecordDto` associated type.
    /// - Returns: The UUID string of the created HealthKit sample.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if the DTO type doesn't match
    ///           the handler's expected type.
    /// - Throws: `HealthConnectorError` if the HealthKit save operation fails.
    func writeRecord(_ dto: HealthRecordDto) async throws -> String
}

extension WritableHealthRecordHandler {
    /// Writes a single health record to HealthKit.
    ///
    /// - Parameter dto: The health record DTO to write. Must match this handler's
    ///                  `RecordDto` associated type.
    /// - Returns: The UUID string of the created HealthKit sample.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if the DTO type doesn't match
    ///          the handler's expected type.
    /// - Throws: `HealthConnectorError` if the HealthKit save operation fails.
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

        let tag = String(describing: type(of: self))
        let operation = "write_record"
        let context: [String: Any] = ["data_type": Self.dataType.rawValue]

        return try await process(operation: operation, context: context) {
            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Preparing to write record",
                context: context
            )

            let sample = try dto.toHKSample()
            try await self.healthStore.save(sample)
            let recordId = sample.uuid.uuidString

            HealthConnectorLogger.info(
                tag: tag,
                operation: operation,
                message: "Record written successfully",
                context: context
            )

            return recordId
        }
    }
}
