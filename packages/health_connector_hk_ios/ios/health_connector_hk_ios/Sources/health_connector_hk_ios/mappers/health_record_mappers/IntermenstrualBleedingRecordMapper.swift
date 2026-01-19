import Foundation
import HealthKit

// MARK: - HKCategorySample to DTO

/// Extension for mapping `HKCategorySample` → `IntermenstrualBleedingRecordDto`.
extension HKCategorySample {
    /// Converts a HealthKit intermenstrual bleeding category sample to `IntermenstrualBleedingRecordDto`.
    func toIntermenstrualBleedingRecordDto() throws -> IntermenstrualBleedingRecordDto {
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try IntermenstrualBleedingRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            zoneOffsetSeconds: zoneOffset
        )
    }
}

// MARK: - DTO to HealthKit

/// Extension for mapping `IntermenstrualBleedingRecordDto` → `HKCategorySample`.
extension IntermenstrualBleedingRecordDto {
    /// Converts a `IntermenstrualBleedingRecordDto` to a HealthKit category sample.
    func toHKCategorySample() throws -> HKCategorySample {
        guard
            let categoryType = HKObjectType.categoryType(
                forIdentifier: .intermenstrualBleeding
            )
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create category type for intermenstrual bleeding"
            )
        }

        let startDate = Date(timeIntervalSince1970: TimeInterval(time) / 1000)
        let endDate = startDate // Intermenstrual bleeding is an instant observation

        // Build metadata using centralized builder
        let builder = try MetadataBuilder(from: metadata)

        return HKCategorySample(
            type: categoryType,
            value: HKCategoryValue.notApplicable.rawValue,
            start: startDate,
            end: endDate,
            device: builder.healthDevice,
            metadata: builder.build()
        )
    }
}
