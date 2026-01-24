import Foundation
import HealthKit

/// Extension for mapping `EnvironmentalAudioExposureRecordDto` → `HKQuantitySample`.
extension EnvironmentalAudioExposureRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .environmentalAudioExposure)

        let quantity = HKQuantity(unit: .decibelAWeightedSoundPressureLevel(), doubleValue: aWeightedDecibel)
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)

        // Create builder with timezone offsets
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: startZoneOffsetSeconds,
            endTimeZoneOffset: endZoneOffsetSeconds
        )

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )
    }
}

/// Extension for mapping `HKQuantitySample` → `EnvironmentalAudioExposureRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to an `EnvironmentalAudioExposureRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an environmental audio exposure sample.
    func toEnvironmentalAudioExposureRecordDto() throws -> EnvironmentalAudioExposureRecordDto {
        guard
            quantityType.identifier == HKQuantityTypeIdentifier.environmentalAudioExposure.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected environmental audio exposure quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.environmentalAudioExposure.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let aWeightedDecibel = quantity.doubleValue(for: .decibelAWeightedSoundPressureLevel())

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try EnvironmentalAudioExposureRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            aWeightedDecibel: aWeightedDecibel,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
