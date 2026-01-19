import Foundation
import HealthKit

// MARK: - HKCategorySample to DTO

/// Extension for mapping `HKCategorySample` → `OvulationTestRecordDto`.
extension HKCategorySample {
    /// Converts a HealthKit ovulation test category sample to `OvulationTestRecordDto`.
    func toOvulationTestRecordDto() throws -> OvulationTestRecordDto {
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        // Convert HealthKit category value to DTO
        guard let hkResult = HKCategoryValueOvulationTestResult(rawValue: value) else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid ovulation test result value: \(value)"
            )
        }

        return try OvulationTestRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            zoneOffsetSeconds: zoneOffset,
            result: hkResult.toOvulationTestResultDto()
        )
    }
}

// MARK: - DTO to HealthKit

/// Extension for mapping `OvulationTestRecordDto` → `HKCategorySample`.
extension OvulationTestRecordDto {
    /// Converts a `OvulationTestRecordDto` to a HealthKit category sample.
    func toHKCategorySample() throws -> HKCategorySample {
        guard
            let categoryType = HKObjectType.categoryType(
                forIdentifier: .ovulationTestResult
            )
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create category type for ovulation test"
            )
        }

        let startDate = Date(timeIntervalSince1970: TimeInterval(time) / 1000)
        let endDate = startDate // Ovulation test is an instant observation

        // Build metadata using centralized builder
        let builder = try MetadataBuilder(from: metadata)

        return HKCategorySample(
            type: categoryType,
            value: result.toHealthKit().rawValue,
            start: startDate,
            end: endDate,
            device: builder.healthDevice,
            metadata: builder.build()
        )
    }
}

// MARK: - Enum Mapping Helpers

extension HKCategoryValueOvulationTestResult {
    /// Converts `HKCategoryValueOvulationTestResult` to `OvulationTestResultDto`.
    ///
    /// The `@unknown default` case handles future HealthKit versions that might add new
    /// result types, throwing an error for unrecognized values.
    func toOvulationTestResultDto() -> OvulationTestResultDto {
        switch self {
        case .negative:
            return .negative
        case .indeterminate:
            return .inconclusive
        case .estrogenSurge:
            return .high
        case .luteinizingHormoneSurge:
            return .positive
        @unknown default:
            return .negative // Default to negative for unknown future values
        }
    }
}

extension OvulationTestResultDto {
    /// Converts `OvulationTestResultDto` to `HKCategoryValueOvulationTestResult`.
    func toHealthKit() -> HKCategoryValueOvulationTestResult {
        switch self {
        case .negative:
            .negative
        case .inconclusive:
            .indeterminate
        case .high:
            .estrogenSurge
        case .positive:
            .luteinizingHormoneSurge
        }
    }
}
