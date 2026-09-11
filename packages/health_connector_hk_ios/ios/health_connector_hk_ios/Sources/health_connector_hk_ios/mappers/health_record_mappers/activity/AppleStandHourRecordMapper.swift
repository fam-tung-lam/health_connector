import Foundation
import HealthKit

/// Maps an Apple Stand Hour category sample to its platform DTO.
extension HKCategorySample {
    func toAppleStandHourRecordDto() throws -> AppleStandHourRecordDto {
        guard categoryType.identifier == HKCategoryTypeIdentifier.appleStandHour.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected Apple Stand Hour category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.appleStandHour.rawValue,
                    "actual": categoryType.identifier,
                ]
            )
        }

        guard let standHourValue = HKCategoryValueAppleStandHour(rawValue: value) else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid Apple Stand Hour value: \(value)",
                context: ["value": value]
            )
        }

        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try AppleStandHourRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            status: AppleStandHourStatusDto(from: standHourValue),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}

private extension AppleStandHourStatusDto {
    init(from standHourValue: HKCategoryValueAppleStandHour) throws {
        switch standHourValue {
        case .stood:
            self = .stood
        case .idle:
            self = .idle
        @unknown default:
            throw HealthConnectorError.invalidArgument(
                message: "Unknown Apple Stand Hour value: \(standHourValue.rawValue)",
                context: ["value": standHourValue.rawValue]
            )
        }
    }
}
