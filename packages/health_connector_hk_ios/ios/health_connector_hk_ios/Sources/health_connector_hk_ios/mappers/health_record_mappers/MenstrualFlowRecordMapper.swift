import Foundation
import HealthKit

// MARK: - HKCategorySample to DTO

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
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset,
            flow: value.toMenstrualFlowTypeDto(),
            isCycleStart: isCycleStart
        )
    }
}

// MARK: - DTO to HealthKit

extension MenstrualFlowRecordDto {
    /// Converts a `MenstrualFlowRecordDto` to a HealthKit category sample.
    func toHealthKit() throws -> HKCategorySample {
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
