import Foundation
import HealthKit

/// Internal service responsible for managing HealthKit permissions.
struct HealthConnectorPermissionService: Sendable, Taggable {
    private let store: HKHealthStore

    init(store: HKHealthStore) {
        self.store = store
    }

    /// Requests HealthKit authorization.
    func requestAuthorization(
        for permissions: [HealthDataPermissionDto]
    ) async throws -> [HealthDataPermissionRequestResultDto] {
        HealthConnectorLogger.info(
            tag: Self.tag,
            operation: "request_permissions",
            message: "Requesting permissions for \(permissions.count) data types",
            context: [
                "permissions": permissions.map { "\($0.healthDataType.rawValue):\($0.accessType)" },
            ]
        )

        let readTypes = try buildReadTypes(from: permissions)
        let writeTypes = try buildWriteTypes(from: permissions)

        do {
            try await store.requestAuthorization(toShare: writeTypes, read: readTypes)

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: "request_authorization",
                message: "Authorization request completed successfully"
            )
        } catch let error as HKError {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: "request_authorization",
                message: "Authorization request failed",
                exception: error
            )

            throw HealthConnectorError.create(from: error)
        }

        return try permissions.map { permission in
            try buildPermissionResult(for: permission)
        }
    }

    /// Gets the current authorization status for a permission.
    func getPermissionStatus(
        for permission: HealthDataPermissionDto
    ) async throws -> PermissionStatusDto {
        let objectTypes = try permission.toHealthKit()
        var status: PermissionStatusDto = .unknown

        // Only check status for Write permissions (Read is always hidden by HealthKit)
        if permission.accessType == .write {
            let sampleTypes = objectTypes.compactMap { $0 as? HKSampleType }

            if !sampleTypes.isEmpty {
                let statuses = sampleTypes.map { store.authorizationStatus(for: $0) }

                // Permission Aggregation Logic:
                // 1. If ANY type is authorized, we consider the feature "granted" (Optimistic)
                // 2. If ALL types are denied, it is "denied"
                // 3. Otherwise (mixed or not determined), it remains "unknown"
                if statuses.contains(.sharingAuthorized) {
                    status = .granted
                } else if statuses.allSatisfy({ $0 == .sharingDenied }) {
                    status = .denied
                }
            }
        }

        return status
    }

    /// Builds set of HKObjectType for reading.
    func buildReadTypes(from permissions: [HealthDataPermissionDto]) throws -> Set<HKObjectType> {
        let types =
            try permissions
                .filter { $0.accessType == .read }
                .flatMap { try $0.toHealthKit() }

        return Set(types)
    }

    /// Builds set of HKSampleType for writing.
    func buildWriteTypes(from permissions: [HealthDataPermissionDto]) throws -> Set<HKSampleType> {
        let types =
            try permissions
                .filter { $0.accessType == .write }
                .flatMap { try $0.toHealthKit() }
                .compactMap { $0 as? HKSampleType } // Write requires HKSampleType specifically

        return Set(types)
    }

    /// Builds a permission result DTO with authorization status.
    private func buildPermissionResult(
        for permission: HealthDataPermissionDto
    ) throws -> HealthDataPermissionRequestResultDto {
        // We call the synchronous logic here since we are already in an async flow in requestAuthorization if needed,
        // but wait: buildPermissionResult was called synchronously in a map.
        // requestAuthorization is async.
        // However, getPermissionStatus logic is essentially synchronous (HKHealthStore.authorizationStatus is sync).
        // I made getPermissionStatus 'async' to satisfy the Client call site.
        // But here in buildPermissionResult, I can't easily await inside a sync map.
        //
        // I should probably duplicate the logic or make a sync private helper.
        // Let's make a sync private helper `_getPermissionStatus` and have both public async `getPermissionStatus` and
        // `buildPermissionResult` use it.

        let status = try _getPermissionStatus(for: permission)
        return HealthDataPermissionRequestResultDto(permission: permission, status: status)
    }

    private func _getPermissionStatus(
        for permission: HealthDataPermissionDto
    ) throws -> PermissionStatusDto {
        let objectTypes = try permission.toHealthKit()
        var status: PermissionStatusDto = .unknown

        // Only check status for Write permissions (Read is always hidden by HealthKit)
        if permission.accessType == .write {
            let sampleTypes = objectTypes.compactMap { $0 as? HKSampleType }

            if !sampleTypes.isEmpty {
                let statuses = sampleTypes.map { store.authorizationStatus(for: $0) }

                // Permission Aggregation Logic:
                // 1. If ANY type is authorized, we consider the feature "granted" (Optimistic)
                // 2. If ALL types are denied, it is "denied"
                // 3. Otherwise (mixed or not determined), it remains "unknown"
                if statuses.contains(.sharingAuthorized) {
                    status = .granted
                } else if statuses.allSatisfy({ $0 == .sharingDenied }) {
                    status = .denied
                }
            }
        }

        return status
    }
}
