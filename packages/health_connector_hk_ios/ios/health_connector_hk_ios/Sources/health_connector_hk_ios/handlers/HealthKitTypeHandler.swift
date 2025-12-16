import Foundation
import HealthKit

/// Protocol that associates handlers with their specific DTO and HKSample types.
protocol HealthKitTypeMapper {
    /// The specific DTO type this handler works with
    associatedtype RecordDto: HealthRecordDto

    /// The specific HKSample subclass this handler works with
    associatedtype SampleType: HKSample

    /// Convert HealthKit sample to DTO
    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto

    /// Convert DTO to HealthKit sample
    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample

    /// Extract timestamp from DTO for pagination
    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64
}

/// Base protocol for all health data type handlers.
///
/// This protocol defines the minimal interface that all handlers must implement.
protocol HealthKitTypeHandler: AnyObject {
    /// The HealthKit store for all operations
    var healthStore: HKHealthStore { get }

    /// The HealthDataTypeDto enum case this handler supports
    static var supportedType: HealthDataTypeDto { get }

    /// The HealthKit data category (determines API usage patterns)
    static var category: HealthKitDataCategory { get }

    /**
     * Centralized error handling wrapper for handler operations.
     *
     * This method wraps handler operations with consistent exception handling,
     * mapping HealthKit errors to HealthConnectorError with appropriate error codes
     * and logging all operations and errors.
     *
     * - Parameters:
     *   - operation: Human-readable operation name for logging (e.g., "read_record", "write_records")
     *   - context: Additional context for logging (e.g., recordId, time range)
     *   - block: The async throwing operation to execute
     * - Returns: The result of the block if successful
     * - Throws: HealthConnectorError with appropriate error code
     */
    func process<T>(
        operation: String,
        context: [String: Any]?,
        block: () async throws -> T
    ) async throws -> T
}

/// Default implementation of the `process()` error handling wrapper.
extension HealthKitTypeHandler {
    func process<T>(
        operation: String,
        context: [String: Any]? = nil,
        block: () async throws -> T
    ) async throws -> T {
        let tag = String(describing: type(of: self))

        // Log operation start
        var startContext = context ?? [:]
        startContext["data_type"] = Self.supportedType.rawValue

        HealthConnectorLogger.debug(
            tag: tag,
            operation: operation,
            message: "Starting \(operation) for \(Self.supportedType.rawValue)",
            context: startContext
        )

        do {
            // Execute the operation
            let result = try await block()

            // Log successful completion
            var completeContext = context ?? [:]
            completeContext["data_type"] = Self.supportedType.rawValue

            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Completed \(operation) for \(Self.supportedType.rawValue)",
                context: completeContext
            )

            return result

        } catch let error as HealthConnectorError {
            // Already a HealthConnectorError, just log and re-throw
            HealthConnectorLogger.error(
                tag: tag,
                operation: operation,
                message:
                    "Handler operation failed for \(Self.supportedType.rawValue): \(error.message ?? "<no message>")",
                context: context,
                exception: error
            )
            throw error

        } catch let error as NSError {
            // Map NSError (including HKError) to HealthConnectorError
            HealthConnectorLogger.error(
                tag: tag,
                operation: operation,
                message: "Handler operation failed for \(Self.supportedType.rawValue)",
                context: context,
                exception: error
            )

            // Use existing mapHealthKitError function from HealthConnectorClient
            let mappedError = HealthConnectorClient.mapHealthKitError(error)
            throw mappedError

        } catch {
            // Catch-all for any other error types
            HealthConnectorLogger.error(
                tag: tag,
                operation: operation,
                message:
                    "Handler operation failed for \(Self.supportedType.rawValue): \(error.localizedDescription)",
                context: context,
                exception: error as NSError
            )

            throw HealthConnectorError.unknown(
                message: "Unexpected error during \(operation) for \(Self.supportedType.rawValue)",
                cause: nil,
                context: ["details": error.localizedDescription]
            )
        }
    }
}
