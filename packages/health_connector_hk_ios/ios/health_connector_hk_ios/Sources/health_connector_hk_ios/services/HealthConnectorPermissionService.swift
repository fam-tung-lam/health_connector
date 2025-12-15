import Foundation
import HealthKit

/// Internal service responsible for managing HealthKit permissions.
///
/// This service encapsulates all logic related to requesting and checking HealthKit
/// authorization status, providing a clean separation of concerns from the main client.
///
/// ## Responsibilities
///
/// - Request authorization for read/write access to health data types
/// - Build sets of HKObjectType for authorization requests
/// - Check authorization status for specific data types
/// - Map HealthKit errors to HealthConnectorError
///
/// ## HealthKit Permission Model
///
/// HealthKit has special privacy considerations:
/// - **Read permissions:** Status is always `.unknown` to protect user privacy
/// - **Write permissions:** Status can be `.granted`, `.denied`, or `.notDetermined`
/// - Users can grant write permission without granting read permission
class HealthConnectorPermissionService: Taggable {
    // MARK: - Constants

    // MARK: - Properties

    /**
     * The HealthKit store instance for permission operations
     */
    private let store: HKHealthStore

    // MARK: - Initialization

    /**
     * Initializes the permission service
     *
     * - Parameter store: The HKHealthStore instance to use for permission operations
     */
    init(store: HKHealthStore) {
        self.store = store

        HealthConnectorLogger.debug(
            tag: Self.tag,
            operation: "init",
            message: "Initializing HealthConnectorPermissionService",
            context: ["store": String(describing: store)]
        )
    }

    // MARK: - Public Methods

    /**
     * Requests HealthKit authorization for specified data permissions
     *
     * This method processes the permission requests, separates them into read and write sets,
     * and requests authorization from HealthKit.
     *
     * - Parameters:
     *   - healthDataPermissions: Array of HealthDataPermissionDto to request access for
     *
     * - Returns: Array of HealthDataPermissionRequestResultDto with authorization status for each permission
     *
     * - Throws:
     *   - `HealthConnectorError` with code `INVALID_ARGUMENT` if data type conversion fails
     *   - `HealthConnectorError` with code `NOT_AUTHORIZED` if authorization is denied
     *   - `HealthConnectorError` with code `UNKNOWN` for other errors
     *
     * ## HealthKit Privacy Note
     *
     * Due to privacy protections, HealthKit never reveals read permission status.
     * All read permissions will return `.unknown` status, even if granted.
     */
    func requestAuthorization(
        for healthDataPermissions: [HealthDataPermissionDto]
    ) async throws -> [HealthDataPermissionRequestResultDto] {
        HealthConnectorLogger.info(
            tag: Self.tag,
            operation: "request_permissions",
            message: "Requesting permissions for \(healthDataPermissions.count) data types",
            context: [
                "data_types": healthDataPermissions.map(\.healthDataType.rawValue),
                "count": healthDataPermissions.count,
                "permission_count": healthDataPermissions.count,
                "permissions": healthDataPermissions.map {
                    "\($0.healthDataType.rawValue):\($0.accessType)"
                },
            ]
        )

        // Build read and write type sets
        let (readTypes, writeTypes) = try buildTypeSets(from: healthDataPermissions)

        HealthConnectorLogger.debug(
            tag: Self.tag,
            operation: "request_authorization",
            message: "Built type sets for authorization",
            context: [
                "read_types_count": readTypes.count,
                "write_types_count": writeTypes.count,
            ]
        )

        // Request authorization from HealthKit
        do {
            try await store.requestAuthorization(toShare: writeTypes, read: readTypes)

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: "request_authorization",
                message: "Authorization request completed successfully",
                context: nil
            )
        } catch let error as NSError {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: "request_authorization",
                message: "Authorization request failed",
                context: nil,
                exception: error
            )

            // Map HealthKit errors to HealthConnectorError
            throw HealthConnectorClient.mapHealthKitError(error)
        }

        // Build result DTOs with authorization status
        let results = try healthDataPermissions.map { permission in
            try buildPermissionResult(for: permission)
        }

        // Log results
        let grantedCount = results.filter { $0.status == .granted }.count
        let deniedCount = results.filter { $0.status == .denied }.count
        let unknownCount = results.filter { $0.status == .unknown }.count

        HealthConnectorLogger.info(
            tag: Self.tag,
            operation: "request_authorization",
            message:
            "Authorization results: granted=\(grantedCount), denied=\(deniedCount), unknown=\(unknownCount)",
            context: [
                "results": results.map { "\($0.permission.healthDataType.rawValue):\($0.status)" },
            ]
        )

        return results
    }

    /**
     * Builds set of HKObjectType for reading from permission DTOs
     *
     * This extracts all unique object types that require read access across
     * all the provided permissions.
     *
     * - Parameter healthDataPermissions: Array of HealthDataPermissionDto
     * - Returns: Set of HKObjectType that can be used in authorization request
     * - Throws: HealthConnectorError.invalidArgument if type cannot be constructed
     */
    func buildReadTypes(
        from healthDataPermissions: [HealthDataPermissionDto]
    ) throws -> Set<HKObjectType> {
        var types = Set<HKObjectType>()

        for permission in healthDataPermissions where permission.accessType == .read {
            do {
                let objectTypes = try permission.toHealthKitObjectTypes()
                types.formUnion(objectTypes)
            } catch {
                HealthConnectorLogger.warning(
                    tag: Self.tag,
                    operation: "build_read_types",
                    message: "Failed to convert permission to HealthKit types",
                    context: [
                        "permission": permission.healthDataType.rawValue,
                        "access_type": String(describing: permission.accessType),
                    ]
                )
                throw error
            }
        }

        return types
    }

    /**
     * Builds set of HKSampleType for writing from permission DTOs
     *
     * Note: Only sample types can be written. Characteristics are read-only.
     * This method filters out non-sample types automatically.
     *
     * - Parameter healthDataPermissions: Array of HealthDataPermissionDto
     * - Returns: Set of HKSampleType that can be used in authorization request
     * - Throws: HealthConnectorError.invalidArgument if type cannot be constructed
     */
    func buildWriteTypes(
        from healthDataPermissions: [HealthDataPermissionDto]
    ) throws -> Set<HKSampleType> {
        var types = Set<HKSampleType>()

        for permission in healthDataPermissions where permission.accessType == .write {
            do {
                let objectTypes = try permission.toHealthKitObjectTypes()

                // Filter to only sample types (characteristics can't be written)
                let sampleTypes = objectTypes.compactMap { $0 as? HKSampleType }
                types.formUnion(sampleTypes)

                if sampleTypes.count < objectTypes.count {
                    HealthConnectorLogger.debug(
                        tag: Self.tag,
                        operation: "build_write_types",
                        message: "Filtered out non-sample types for write permission",
                        context: [
                            "permission": permission.healthDataType.rawValue,
                            "total_types": objectTypes.count,
                            "sample_types": sampleTypes.count,
                        ]
                    )
                }
            } catch {
                HealthConnectorLogger.warning(
                    tag: Self.tag,
                    operation: "build_write_types",
                    message: "Failed to convert permission to HealthKit types",
                    context: [
                        "permission": permission.healthDataType.rawValue,
                        "access_type": String(describing: permission.accessType),
                    ]
                )
                throw error
            }
        }

        return types
    }

    /**
     * Checks the authorization status for a specific object type
     *
     * - Parameter objectType: The HKObjectType to check
     * - Returns: HKAuthorizationStatus for the object type
     */
    func checkAuthorizationStatus(for objectType: HKObjectType) -> HKAuthorizationStatus {
        if let sampleType = objectType as? HKSampleType {
            store.authorizationStatus(for: sampleType)
        } else {
            // Characteristic types don't have authorization status
            .notDetermined
        }
    }

    // MARK: - Private Methods

    /**
     * Builds read and write type sets from permission DTOs
     *
     * - Parameter healthDataPermissions: Array of permissions to process
     * - Returns: Tuple of (read types, write types)
     * - Throws: HealthConnectorError if type conversion fails
     */
    private func buildTypeSets(
        from healthDataPermissions: [HealthDataPermissionDto]
    ) throws -> (read: Set<HKObjectType>, write: Set<HKSampleType>) {
        var readTypes = Set<HKObjectType>()
        var writeTypes = Set<HKSampleType>()

        for permission in healthDataPermissions {
            let objectTypes = try permission.toHealthKitObjectTypes()

            for objectType in objectTypes {
                switch permission.accessType {
                case .read:
                    readTypes.insert(objectType)

                case .write:
                    // Only sample types can be written
                    if let sampleType = objectType as? HKSampleType {
                        writeTypes.insert(sampleType)
                    } else {
                        HealthConnectorLogger.debug(
                            tag: Self.tag,
                            operation: "build_type_sets",
                            message: "Skipping non-sample type for write permission",
                            context: [
                                "permission": permission.healthDataType.rawValue,
                                "type": String(describing: objectType),
                            ]
                        )
                    }
                }
            }
        }

        return (read: readTypes, write: writeTypes)
    }

    /**
     * Builds a permission result DTO with authorization status
     *
     * - Parameter permission: The permission to build result for
     * - Returns: HealthDataPermissionRequestResultDto with status
     * - Throws: HealthConnectorError if type conversion fails
     */
    private func buildPermissionResult(
        for permission: HealthDataPermissionDto
    ) throws -> HealthDataPermissionRequestResultDto {
        let objectTypes = try permission.toHealthKitObjectTypes()
        let status: PermissionStatusDto

        switch permission.accessType {
        case .read:
            // HealthKit never reveals read permission status for privacy reasons
            status = .unknown

        case .write:
            // Check authorization status for all object types
            let sampleTypes = objectTypes.compactMap { $0 as? HKSampleType }

            if sampleTypes.isEmpty {
                // No sample types (e.g., characteristic types can't be written)
                status = .unknown
            } else {
                let authStatuses = sampleTypes.map {
                    store.authorizationStatus(for: $0)
                }

                // Determine overall status
                let allAuthorized = authStatuses.allSatisfy { $0 == .sharingAuthorized }
                let allDenied = authStatuses.allSatisfy { $0 == .sharingDenied }

                if allAuthorized {
                    status = .granted
                } else if allDenied {
                    status = .denied
                } else {
                    // Mixed or not determined
                    status = .unknown
                }
            }
        }

        return HealthDataPermissionRequestResultDto(
            permission: permission,
            status: status
        )
    }
}
