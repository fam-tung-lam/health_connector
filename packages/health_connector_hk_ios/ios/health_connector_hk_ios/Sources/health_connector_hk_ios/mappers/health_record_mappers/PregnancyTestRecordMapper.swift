import Foundation
import HealthKit

// MARK: - HKCategorySample to DTO

extension HKCategorySample {
    /// Converts a HealthKit pregnancy test category sample to `PregnancyTestRecordDto`.
    func toPregnancyTestRecordDto() throws -> PregnancyTestRecordDto {
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
            let hkResult = HKCategoryValuePregnancyTestResult(rawValue: value)
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid pregnancy test result value: \(value)"
            )
        }

        return try PregnancyTestRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            zoneOffsetSeconds: zoneOffset,
            result: hkResult.toPregnancyTestResultDto()
        )
    }
}

// MARK: - DTO to HealthKit

extension PregnancyTestRecordDto {
    /// Converts a `PregnancyTestRecordDto` to a HealthKit category sample.
    func toHealthKit() throws -> HKCategorySample {
        guard
            let categoryType = HKObjectType.categoryType(
                forIdentifier: .pregnancyTestResult
            )
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create category type for pregnancy test"
            )
        }

        let startDate = Date(timeIntervalSince1970: TimeInterval(time) / 1000)
        let endDate = startDate // Pregnancy test is an instant observation

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

extension HKCategoryValuePregnancyTestResult {
    /// Converts `HKCategoryValuePregnancyTestResult` to `PregnancyTestResultDto`.
    ///
    /// The `@unknown default` case handles future HealthKit versions that might add new
    /// result types, returning `.inconclusive` for unrecognized values.
    func toPregnancyTestResultDto() -> PregnancyTestResultDto {
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

extension PregnancyTestResultDto {
    /// Converts `PregnancyTestResultDto` to `HKCategoryValuePregnancyTestResult`.
    func toHealthKit() -> HKCategoryValuePregnancyTestResult {
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
