import Foundation
import HealthKit

// MARK: - HKCategorySample to DTO

/// Extension for mapping `HKCategorySample` → `PregnancyRecordDto`.
extension HKCategorySample {
    /// Converts a HealthKit pregnancy category sample to `PregnancyRecordDto`.
    func toPregnancyRecordDto() throws -> PregnancyRecordDto {
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try PregnancyRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}

// MARK: - DTO to HealthKit

/// Extension for mapping `PregnancyRecordDto` → `HKCategorySample`.
extension PregnancyRecordDto {
    /// Converts a `PregnancyRecordDto` to a HealthKit category sample.
    func toHKCategorySample() throws -> HKCategorySample {
        guard
            let categoryType = HKObjectType.categoryType(
                forIdentifier: .pregnancy
            )
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create category type for pregnancy"
            )
        }

        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000)

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
