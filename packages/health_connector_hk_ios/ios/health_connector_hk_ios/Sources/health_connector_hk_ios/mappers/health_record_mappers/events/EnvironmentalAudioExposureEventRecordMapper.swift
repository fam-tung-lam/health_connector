import Foundation
import HealthKit

extension HKCategorySample {
    func toEnvironmentalAudioExposureEventRecordDto() throws
        -> EnvironmentalAudioExposureEventRecordDto
    {
        guard
            categoryType.identifier
            == HKCategoryTypeIdentifier.environmentalAudioExposureEvent.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected environmental audio exposure event category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.environmentalAudioExposureEvent.rawValue,
                    "actual": categoryType.identifier,
                ]
            )
        }

        var aWeightedDecibel: Double?
        if let quantity = metadata?[HKMetadataKeyAudioExposureLevel] as? HKQuantity {
            aWeightedDecibel = quantity.doubleValue(for: .decibelAWeightedSoundPressureLevel())
        }

        let builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        return try EnvironmentalAudioExposureEventRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            startZoneOffsetSeconds: StartTimeZoneOffsetKey.read(from: builder.metadataDict),
            endZoneOffsetSeconds: EndTimeZoneOffsetKey.read(from: builder.metadataDict),
            aWeightedDecibel: aWeightedDecibel
        )
    }
}
