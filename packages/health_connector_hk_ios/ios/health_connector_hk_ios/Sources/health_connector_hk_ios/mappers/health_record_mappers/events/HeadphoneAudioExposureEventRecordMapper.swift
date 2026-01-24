import Foundation
import HealthKit

extension HKCategorySample {
    func toHeadphoneAudioExposureEventRecordDto() throws
        -> HeadphoneAudioExposureEventRecordDto
    {
        guard
            categoryType.identifier
            == HKCategoryTypeIdentifier.headphoneAudioExposureEvent.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected headphone audio exposure event category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.headphoneAudioExposureEvent.rawValue,
                    "actual": categoryType.identifier,
                ]
            )
        }

        let builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        return try HeadphoneAudioExposureEventRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            startZoneOffsetSeconds: StartTimeZoneOffsetKey.read(from: builder.metadataDict),
            endZoneOffsetSeconds: EndTimeZoneOffsetKey.read(from: builder.metadataDict)
        )
    }
}
