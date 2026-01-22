import Foundation
import HealthKit

/// Extension for mapping `InsulinDeliveryRecordDto` → `HKQuantitySample`.
extension InsulinDeliveryRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .insulinDelivery)

        let quantity = HKQuantity(unit: .internationalUnit(), doubleValue: units)
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)

        // Create builder with timezone offsets
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: startZoneOffsetSeconds,
            endTimeZoneOffset: endZoneOffsetSeconds
        )

        // Add insulin delivery reason to metadata
        builder.set(
            standardKey: HKMetadataKeyInsulinDeliveryReason,
            value: reason.toHKInsulinDeliveryReason.rawValue
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

/// Extension for mapping `HKQuantitySample` → `InsulinDeliveryRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to an `InsulinDeliveryRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an insulin delivery sample.
    func toInsulinDeliveryRecordDto() throws -> InsulinDeliveryRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.insulinDelivery.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected insulin delivery quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.insulinDelivery.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let units = quantity.doubleValue(for: .internationalUnit())

        // Create builder from HK metadata with source and device
        let builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract insulin delivery reason from metadata (defaults to basal if missing)
        let reasonRawValue =
            metadata?[HKMetadataKeyInsulinDeliveryReason] as? Int
                ?? HKInsulinDeliveryReason.basal.rawValue
        let reason = InsulinDeliveryReasonDto.from(
            hkInsulinDeliveryReason: HKInsulinDeliveryReason(rawValue: reasonRawValue) ?? .basal)

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try InsulinDeliveryRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            units: units,
            reason: reason,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
