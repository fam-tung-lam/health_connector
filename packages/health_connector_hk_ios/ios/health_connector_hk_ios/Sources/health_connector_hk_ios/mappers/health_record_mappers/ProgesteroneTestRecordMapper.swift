import Foundation
import HealthKit

// MARK: - HKCategorySample to DTO

extension HKCategorySample {
    /// Converts a HealthKit progesterone test category sample to `ProgesteroneTestRecordDto`.
    func toProgesteroneTestRecordDto() throws -> ProgesteroneTestRecordDto {
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        // Convert HealthKit category value to DTO
        guard
            let hkResult = HKCategoryValueProgesteroneTestResult(rawValue: value)
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid progesterone test result value: \(value)"
            )
        }

        return try ProgesteroneTestRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            zoneOffsetSeconds: zoneOffset,
            result: hkResult.toProgesteroneTestResultDto()
        )
    }
}

// MARK: - DTO to HealthKit

extension ProgesteroneTestRecordDto {
    /// Converts a `ProgesteroneTestRecordDto` to a HealthKit category sample.
    func toHealthKit() throws -> HKCategorySample {
        guard
            let categoryType = HKObjectType.categoryType(
                forIdentifier: .progesteroneTestResult
            )
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create category type for progesterone test"
            )
        }

        let startDate = Date(timeIntervalSince1970: TimeInterval(time) / 1000)
        let endDate = startDate // Progesterone test is an instant observation

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

extension HKCategoryValueProgesteroneTestResult {
    /// Converts `HKCategoryValueProgesteroneTestResult` to `ProgesteroneTestResultDto`.
    ///
    /// The `@unknown default` case handles future HealthKit versions that might add new
    /// result types, returning `.inconclusive` for unrecognized values.
    func toProgesteroneTestResultDto() -> ProgesteroneTestResultDto {
        switch self {
        case .positive:
            return .positive
        case .negative:
            return .negative
        case .indeterminate:
            return .inconclusive
        @unknown default:
            return .inconclusive
        }
    }
}

extension ProgesteroneTestResultDto {
    /// Converts `ProgesteroneTestResultDto` to `HKCategoryValueProgesteroneTestResult`.
    func toHealthKit() -> HKCategoryValueProgesteroneTestResult {
        switch self {
        case .positive:
            .positive
        case .negative:
            .negative
        case .inconclusive:
            .indeterminate
        }
    }
}
