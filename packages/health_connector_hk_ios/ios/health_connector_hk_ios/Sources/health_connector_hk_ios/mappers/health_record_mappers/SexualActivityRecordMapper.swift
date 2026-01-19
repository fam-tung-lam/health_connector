import Foundation
import HealthKit

/// Extension for mapping `HKCategorySample` → `SexualActivityRecordDto`.
extension HKCategorySample {
    /// Converts a HealthKit sexual activity category sample to a `SexualActivityRecordDto`.
    func toSexualActivityRecordDto() throws -> SexualActivityRecordDto {
        let protectionUsed: SexualActivityProtectionUsedDto =
            (metadata?[HKMetadataKeySexualActivityProtectionUsed] as? Bool).map {
                $0 ? .protected : .unprotected
            } ?? .unknown

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try SexualActivityRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            zoneOffsetSeconds: zoneOffset,
            protectionUsed: protectionUsed
        )
    }
}

/// Extension for mapping `SexualActivityRecordDto` → `HKCategorySample`.
extension SexualActivityRecordDto {
    /// Converts a `SexualActivityRecordDto` to a HealthKit category sample.
    func toHKCategorySample() throws -> HKCategorySample {
        guard
            let categoryType = HKObjectType.categoryType(
                forIdentifier: .sexualActivity
            )
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create category type for sexual activity"
            )
        }

        let startDate = Date(timeIntervalSince1970: TimeInterval(time) / 1000)
        let endDate = startDate // Sexual activity is an instant event

        // Build metadata using centralized builder
        var builder = try MetadataBuilder(
            from: metadata)

        // Store in native key `HKMetadataKeySexualActivityProtectionUsed` for `protected` and
        // `unprotected`, remove for `unknown`
        switch protectionUsed {
        case .protected:
            builder.set(standardKey: HKMetadataKeySexualActivityProtectionUsed, value: true)
        case .unprotected:
            builder.set(standardKey: HKMetadataKeySexualActivityProtectionUsed, value: false)
        case .unknown:
            builder.remove(standardKey: HKMetadataKeySexualActivityProtectionUsed)
        }

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
