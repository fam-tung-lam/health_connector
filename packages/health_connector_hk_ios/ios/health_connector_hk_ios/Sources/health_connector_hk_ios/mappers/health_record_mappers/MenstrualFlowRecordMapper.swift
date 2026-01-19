import Foundation
import HealthKit

// MARK: - HKCategorySample to DTO

/// Extension for mapping `HKCategorySample` → `MenstrualFlowRecordDto`.
extension HKCategorySample {
    /// Converts a HealthKit menstrual flow category sample to `MenstrualFlowRecordDto`.
    func toMenstrualFlowRecordDto() throws -> MenstrualFlowRecordDto {
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        // Extract isCycleStart from metadata (default to false if not present)
        let isCycleStart =
            (builder.metadataDict[HKMetadataKeyMenstrualCycleStart] as? Bool)
                ?? false

        // Remove menstrual cycle start from custom metadata since it's in DTO
        builder.remove(standardKey: HKMetadataKeyMenstrualCycleStart)

        return try MenstrualFlowRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset,
            flow: value.toMenstrualFlowDto(),
            isCycleStart: isCycleStart
        )
    }
}

// MARK: - DTO to HealthKit

/// Extension for mapping `MenstrualFlowRecordDto` → `HKCategorySample`.
extension MenstrualFlowRecordDto {
    /// Converts a `MenstrualFlowRecordDto` to a HealthKit category sample.
    func toHKCategorySample() throws -> HKCategorySample {
        guard
            let categoryType = HKObjectType.categoryType(
                forIdentifier: .menstrualFlow
            )
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create category type for menstrual flow"
            )
        }

        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000)

        // Build metadata using centralized builder
        var builder = try MetadataBuilder(from: metadata)

        // Add isCycleStart to metadata if true
        if isCycleStart {
            builder.set(standardKey: HKMetadataKeyMenstrualCycleStart, value: true)
        }

        return HKCategorySample(
            type: categoryType,
            value: flow.toHealthKit(),
            start: startDate,
            end: endDate,
            device: builder.healthDevice,
            metadata: builder.build()
        )
    }
}
