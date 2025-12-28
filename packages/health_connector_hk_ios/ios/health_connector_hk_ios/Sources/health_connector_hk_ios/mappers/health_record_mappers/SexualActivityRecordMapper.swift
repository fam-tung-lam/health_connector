import Foundation
import HealthKit

extension HKCategorySample {
    /// Converts a HealthKit sexual activity category sample to a `SexualActivityRecordDto`.
    func toSexualActivityRecordDto() throws -> SexualActivityRecordDto {
        let protectionUsed: SexualActivityProtectionUsedTypeDto =
            (metadata?[HKMetadataKeySexualActivityProtectionUsed] as? Bool).map {
                $0 ? .protected : .unprotected
            } ?? .unknown

        let metadataDict = metadata ?? [:]

        return SexualActivityRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            zoneOffsetSeconds: Int64(
                TimeZone.current.secondsFromGMT(for: startDate)
            ),
            protectionUsed: protectionUsed
        )
    }
}

extension SexualActivityRecordDto {
    /// Converts a `SexualActivityRecordDto` to a HealthKit category sample.
    func toHealthKit() throws -> HKCategorySample {
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

        var hkMetadata = metadata.toHealthKitMetadata()

        // Store in native key `HKMetadataKeySexualActivityProtectionUsed` for `protected` and
        // `unprotected`, remove for `unknown`
        switch protectionUsed {
        case .protected:
            hkMetadata[HKMetadataKeySexualActivityProtectionUsed] = true
        case .unprotected:
            hkMetadata[HKMetadataKeySexualActivityProtectionUsed] = false
        case .unknown:
            // Remove key-value if it exists
            hkMetadata.removeValue(forKey: HKMetadataKeySexualActivityProtectionUsed)
        }

        return HKCategorySample(
            type: categoryType,
            value: HKCategoryValue.notApplicable.rawValue,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: hkMetadata.isEmpty ? nil : hkMetadata
        )
    }
}
