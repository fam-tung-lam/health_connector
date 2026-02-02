import Foundation
import HealthKit

/// Internal service responsible for managing HealthKit permissions.
struct HealthConnectorPermissionService: Sendable, Taggable {
    private let store: HKHealthStore

    init(store: HKHealthStore) {
        self.store = store
    }

    /// Requests HealthKit authorization for polymorphic permission requests.
    func requestAuthorization(
        for permissions: [PermissionRequestDto]
    ) async throws -> [PermissionRequestResultDto] {
        let operation = "request_permissions"
        let context: [String: Any] = [
            "permission_count": permissions.count,
        ]

        HealthConnectorLogger.info(
            tag: Self.tag,
            operation: operation,
            message: "Requesting permissions for \(permissions.count) types",
            context: context
        )

        let readTypes = try buildReadTypes(from: permissions)
        let writeTypes = try buildWriteTypes(from: permissions)

        do {
            try await store.requestAuthorization(toShare: writeTypes, read: readTypes)

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: operation,
                message: "Authorization request completed successfully"
            )
        } catch let error as HKError {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: operation,
                message: "Authorization request failed",
                exception: error
            )

            throw HealthConnectorError.create(from: error)
        }

        return try permissions.map { permission in
            try buildPermissionResult(for: permission)
        }
    }

    /// Gets the current authorization status for a polymorphic permission.
    func getPermissionStatus(
        for permission: PermissionRequestDto
    ) async throws -> PermissionStatusDto {
        switch permission {
        case let healthData as HealthDataPermissionRequestDto:
            return try getHealthDataPermissionStatus(for: healthData)
        case let exerciseRoute as ExerciseRoutePermissionRequestDto:
            return try getExerciseRoutePermissionStatus(for: exerciseRoute)
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Unknown permission type: \(type(of: permission))"
            )
        }
    }

    // MARK: - Health Data Permission Helpers

    private func getHealthDataPermissionStatus(
        for permission: HealthDataPermissionRequestDto
    ) throws -> PermissionStatusDto {
        let objectTypes = try permission.toHKSampleTypes()
        var status: PermissionStatusDto = .unknown

        // Only check status for Write permissions (Read is always hidden by HealthKit)
        if permission.accessType == .write {
            let sampleTypes = objectTypes.compactMap { $0 as? HKSampleType }

            if !sampleTypes.isEmpty {
                let statuses = sampleTypes.map { store.authorizationStatus(for: $0) }
                status = aggregatePermissionStatuses(statuses)
            }
        }

        return status
    }

    // MARK: - Exercise Route Permission Helpers

    private func getExerciseRoutePermissionStatus(
        for permission: ExerciseRoutePermissionRequestDto
    ) throws -> PermissionStatusDto {
        // On iOS, workout route is an HKSeriesType
        let routeType = HKSeriesType.workoutRoute()
        var status: PermissionStatusDto = .unknown

        // Only check status for Write permissions (Read is always hidden by HealthKit)
        if permission.accessType == .write {
            let authStatus = store.authorizationStatus(for: routeType)
            status = aggregatePermissionStatuses([authStatus])
        }

        return status
    }

    // MARK: - Permission Status Aggregation

    /// Aggregates multiple HKAuthorizationStatus values into a single PermissionStatusDto.
    ///
    /// Permission Aggregation Logic:
    /// 1. If ANY type is authorized, we consider the feature "granted" (Optimistic)
    /// 2. If ALL types are denied, it is "denied"
    /// 3. Otherwise (mixed or not determined), it remains "unknown"
    private func aggregatePermissionStatuses(
        _ statuses: [HKAuthorizationStatus]
    ) -> PermissionStatusDto {
        if statuses.contains(.sharingAuthorized) {
            return .granted
        } else if statuses.allSatisfy({ $0 == .sharingDenied }) {
            return .denied
        }
        return .unknown
    }

    // MARK: - Type Building

    /// Builds set of HKObjectType for reading from polymorphic permissions.
    func buildReadTypes(from permissions: [PermissionRequestDto]) throws -> Set<HKObjectType> {
        var types = Set<HKObjectType>()

        for permission in permissions {
            switch permission {
            case let healthData as HealthDataPermissionRequestDto where healthData.accessType == .read:
                let hkTypes = try healthData.toHKSampleTypes()
                types.formUnion(hkTypes)
            case let exerciseRoute as ExerciseRoutePermissionRequestDto where exerciseRoute.accessType == .read:
                types.insert(HKSeriesType.workoutRoute())
            default:
                continue
            }
        }

        return types
    }

    /// Builds set of HKSampleType for writing from polymorphic permissions.
    func buildWriteTypes(from permissions: [PermissionRequestDto]) throws -> Set<HKSampleType> {
        var types = Set<HKSampleType>()

        for permission in permissions {
            switch permission {
            case let healthData as HealthDataPermissionRequestDto where healthData.accessType == .write:
                let hkTypes = try healthData.toHKSampleTypes().compactMap { $0 as? HKSampleType }
                types.formUnion(hkTypes)
            case let exerciseRoute as ExerciseRoutePermissionRequestDto where exerciseRoute.accessType == .write:
                types.insert(HKSeriesType.workoutRoute())
            default:
                continue
            }
        }

        return types
    }

    /// Builds a polymorphic permission result DTO with authorization status.
    private func buildPermissionResult(
        for permission: PermissionRequestDto
    ) throws -> PermissionRequestResultDto {
        switch permission {
        case let healthData as HealthDataPermissionRequestDto:
            let status = try getHealthDataPermissionStatus(for: healthData)
            return HealthDataPermissionRequestResultDto(permission: healthData, status: status)
        case let exerciseRoute as ExerciseRoutePermissionRequestDto:
            let status = try getExerciseRoutePermissionStatus(for: exerciseRoute)
            return ExerciseRoutePermissionRequestResultDto(permission: exerciseRoute, status: status)
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Unknown permission type: \(type(of: permission))"
            )
        }
    }
}
