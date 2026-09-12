import Foundation
import HealthKit

/// Maps an Apple Stand Hour category sample to its platform DTO.
extension HKCategorySample {
    func toAppleActivityCategoryRecordDto(for type: HealthDataTypeDto) throws -> HealthRecordDto {
        switch type {
        case .walkingSteadinessEvent:
            try toWalkingSteadinessEventRecordDto()
        case .appleStandHour:
            try toAppleStandHourRecordDto()
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Expected an Apple activity event data type",
                context: ["data_type": type.rawValue]
            )
        }
    }

    func toAppleStandHourRecordDto() throws -> AppleStandHourRecordDto {
        guard categoryType.identifier == HKCategoryTypeIdentifier.appleStandHour.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected Apple Stand Hour category type",
                context: ["data_type": "appleStandHour"]
            )
        }

        let status = try AppleStandHourStatusDto(standHourValue: value)

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
            status: status,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}

extension AppleStandHourStatusDto {
    init(standHourValue: Int) throws {
        switch standHourValue {
        case HKCategoryValueAppleStandHour.stood.rawValue:
            self = .stood
        case HKCategoryValueAppleStandHour.idle.rawValue:
            self = .idle
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Invalid Apple Stand Hour category value",
                context: ["data_type": "appleStandHour"]
            )
        }
    }
}
