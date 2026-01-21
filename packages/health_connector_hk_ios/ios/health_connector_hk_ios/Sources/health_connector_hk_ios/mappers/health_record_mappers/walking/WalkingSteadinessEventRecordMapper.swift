import Foundation
import HealthKit

/// Extension for mapping `HKCategorySample` → `WalkingSteadinessEventRecordDto`.
extension HKCategorySample {
    /// Converts this HealthKit sample to a `WalkingSteadinessEventRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a walking steadiness event sample.
    func toWalkingSteadinessEventRecordDto() throws -> WalkingSteadinessEventRecordDto {
        guard
            categoryType.identifier == HKCategoryTypeIdentifier.appleWalkingSteadinessEvent.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected walking steadiness event category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.appleWalkingSteadinessEvent.rawValue,
                    "actual": categoryType.identifier,
                ]
            )
        }

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        guard let eventType = HKCategoryValueAppleWalkingSteadinessEvent(rawValue: value) else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid walking steadiness event value: \(value)",
                context: ["value": value]
            )
        }
        let type = try WalkingSteadinessTypeDto(from: eventType)

        return try WalkingSteadinessEventRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            type: type,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}

private extension WalkingSteadinessTypeDto {
    init(from eventType: HKCategoryValueAppleWalkingSteadinessEvent) throws {
        switch eventType {
        case .initialLow:
            self = .initialLow
        case .initialVeryLow:
            self = .initialVeryLow
        case .repeatLow:
            self = .repeatLow
        case .repeatVeryLow:
            self = .repeatVeryLow
        @unknown default:
            throw HealthConnectorError.invalidArgument(
                message: "Unknown/unsupported walking steadiness event type: \(eventType.rawValue)",
                context: ["value": eventType.rawValue]
            )
        }
    }
}
