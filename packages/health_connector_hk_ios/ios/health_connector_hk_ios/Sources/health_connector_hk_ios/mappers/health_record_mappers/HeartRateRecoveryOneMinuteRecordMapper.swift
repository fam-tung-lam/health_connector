import Foundation
import HealthKit

extension HeartRateRecoveryOneMinuteRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHKQuantitySample() throws -> HKQuantitySample {
        guard #available(iOS 16.0, *) else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Heart Rate Recovery One Minute is only supported on iOS 16.0 and later",
                context: ["minimumIOSVersion": "16.0"]
            )
        }

        let type = try HKQuantityType.make(from: .heartRateRecoveryOneMinute)

        // Heart rate recovery is measured in beats per minute (count/minute)
        let unit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: unit, doubleValue: beatsPerMinute)
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

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `HeartRateRecoveryOneMinuteRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a heart rate recovery sample.
    func toHeartRateRecoveryOneMinuteRecordDto() throws -> HeartRateRecoveryOneMinuteRecordDto {
        guard #available(iOS 16.0, *) else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Heart Rate Recovery One Minute is only supported on iOS 16.0 and later",
                context: ["minimumIOSVersion": "16.0"]
            )
        }

        guard
            quantityType.identifier == HKQuantityTypeIdentifier.heartRateRecoveryOneMinute.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected heart rate recovery one minute quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.heartRateRecoveryOneMinute.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        // Heart rate recovery is measured in beats per minute (count/minute)
        let unit = HKUnit.count().unitDivided(by: .minute())
        let beatsPerMinute = quantity.doubleValue(for: unit)

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try HeartRateRecoveryOneMinuteRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset,
            metadata: builder.toMetadataDto(),
            beatsPerMinute: beatsPerMinute
        )
    }
}
