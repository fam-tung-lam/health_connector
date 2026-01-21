import Foundation
import HealthKit

/// Extension for mapping `ForcedExpiratoryVolumeRecordDto` → `HKQuantitySample`.
extension ForcedExpiratoryVolumeRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .forcedExpiratoryVolume1)
        let unit = HKUnit.liter()
        let quantity = HKQuantity(unit: unit, doubleValue: liters)
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)

        let builder = try MetadataBuilder(
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

/// Extension for mapping `HKQuantitySample` → `ForcedExpiratoryVolumeRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `ForcedExpiratoryVolumeRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a heart rate sample.
    func toForcedExpiratoryVolumeRecordDto() throws -> ForcedExpiratoryVolumeRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.forcedExpiratoryVolume1.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected forced expiratory volume 1 quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.forcedExpiratoryVolume1.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try ForcedExpiratoryVolumeRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: Int64(startDate.millisecondsSince1970),
            endTime: Int64(endDate.millisecondsSince1970),
            liters: quantity.doubleValue(for: HKUnit.liter()),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
