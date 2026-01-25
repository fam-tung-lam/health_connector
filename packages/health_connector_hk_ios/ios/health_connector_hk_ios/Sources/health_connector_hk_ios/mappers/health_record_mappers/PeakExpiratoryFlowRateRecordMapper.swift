import Foundation
import HealthKit

/// Extension for mapping `PeakExpiratoryFlowRateRecordDto` → `HKQuantitySample`.
extension PeakExpiratoryFlowRateRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .peakExpiratoryFlowRate)
        let unit = HKUnit.liter().unitDivided(by: HKUnit.second())
        let quantity = HKQuantity(unit: unit, doubleValue: litersPerSecond)
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

/// Extension for mapping `HKQuantitySample` → `PeakExpiratoryFlowRateRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `PeakExpiratoryFlowRateRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a peak expiratory flow rate sample.
    func toPeakExpiratoryFlowRateRecordDto() throws -> PeakExpiratoryFlowRateRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.peakExpiratoryFlowRate.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected peak expiratory flow rate quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.peakExpiratoryFlowRate.rawValue,
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

        let unit = HKUnit.liter().unitDivided(by: HKUnit.second())
        let litersPerSecond = quantity.doubleValue(for: unit)

        return try PeakExpiratoryFlowRateRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: Int64(startDate.millisecondsSince1970),
            endTime: Int64(endDate.millisecondsSince1970),
            litersPerSecond: litersPerSecond,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
