import Foundation
import HealthKit

/// Base protocol for all health data type handlers.
///
/// This protocol defines the minimal interface that all handlers must implement.
/// Conforming types must be `Sendable` to support Swift 6 strict concurrency.
protocol HealthRecordHandler: AnyObject, Sendable {
    /// The specific DTO type this handler works with
    associatedtype RecordDto: HealthRecordDto

    /// The specific HKSample subclass this handler works with
    associatedtype SampleType: HKSample

    /// The HealthKit store for all operations
    var healthStore: HKHealthStore { get }

    /// The HealthDataTypeDto enum case this handler supports
    static var dataType: HealthDataTypeDto { get }

    /// Centralized error handling wrapper for handler operations.
    ///
    /// This method wraps handler operations with consistent exception handling,
    /// mapping HealthKit errors to HealthConnectorError with appropriate error codes
    /// and logging all operations and errors.
    ///
    /// - Parameters:
    ///   - operation: Human-readable operation name for logging (e.g., "read_record", "write_records")
    ///   - context: Additional context for logging (e.g., recordId, time range)
    ///   - block: The async throwing operation to execute
    /// - Returns: The result of the block if successful
    /// - Throws: HealthConnectorError with appropriate error code
    func process<T>(
        operation: String,
        context: [String: Any]?,
        block: () async throws -> T
    ) async throws -> T

    /// Returns the HealthKit object type for this handler.
    ///
    /// This method allows handlers to customize which HealthKit type they use.
    /// Most handlers can use the default implementation which calls the type mapper,
    /// but some types (like exercise sessions) need to override this.
    ///
    /// - Returns: The corresponding HKObjectType
    /// - Throws: HealthConnectorError if type cannot be determined
    func healthKitType() throws -> HKObjectType
}

/// Default implementation of the `process()` error handling wrapper.
extension HealthRecordHandler {
    func process<T>(
        operation: String,
        context: [String: Any]? = nil,
        block: () async throws -> T
    ) async throws -> T {
        let tag = String(describing: type(of: self))

        // Log operation start
        var startContext = context ?? [:]
        startContext["data_type"] = Self.dataType.rawValue

        HealthConnectorLogger.debug(
            tag: tag,
            operation: operation,
            message: "Starting \(operation) for \(Self.dataType.rawValue)",
            context: startContext
        )

        do {
            // Execute the operation
            let result = try await block()

            // Log successful completion
            var completeContext = context ?? [:]
            completeContext["data_type"] = Self.dataType.rawValue

            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Completed \(operation) for \(Self.dataType.rawValue)",
                context: completeContext
            )

            return result

        } catch let error as HealthConnectorError {
            // Already a HealthConnectorError, just log and re-throw
            HealthConnectorLogger.error(
                tag: tag,
                operation: operation,
                message:
                "Handler operation failed for \(Self.dataType.rawValue): \(error.message ?? "<no message>")",
                context: context,
                exception: error
            )
            throw error

        } catch let error as HKError {
            // Map HKError to HealthConnectorError using factory method
            HealthConnectorLogger.error(
                tag: tag,
                operation: operation,
                message: "Handler operation failed for \(Self.dataType.rawValue)",
                context: context,
                exception: error
            )
            throw HealthConnectorError.create(from: error)

        } catch {
            HealthConnectorLogger.error(
                tag: tag,
                operation: operation,
                message:
                "Handler operation failed for \(Self.dataType.rawValue): \(error.localizedDescription)",
                context: context,
                exception: error as NSError
            )

            throw HealthConnectorError.unknown(
                message: "Unexpected error during \(operation) for \(Self.dataType.rawValue)",
                cause: nil,
                context: ["details": error.localizedDescription]
            )
        }
    }

    /// Default implementation uses the type mapper
    func healthKitType() throws -> HKObjectType {
        try Self.dataType.toHealthKit()
    }
}
