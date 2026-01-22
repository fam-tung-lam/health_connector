import Foundation
import HealthKit

/// Extension for mapping `RunningGroundContactTimeRecordDto` → `HKQuantitySample`.
extension RunningGroundContactTimeRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created or iOS version is unsupported.
    func toHKQuantitySample() throws -> HKQuantitySample {
        if #available(iOS 16.0, *) {
            let type = try HKQuantityType.make(from: .runningGroundContactTime)

            let quantity = HKQuantity(unit: .second(), doubleValue: seconds)
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
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Running ground contact time is only supported on iOS 16.0 and later",
                context: ["dataType": "runningGroundContactTime", "minimumIOSVersion": "16.0"]
            )
        }
    }
}

/// Extension for mapping `HKQuantitySample` → `RunningGroundContactTimeRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `RunningGroundContactTimeRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a running ground contact time sample.
    func toRunningGroundContactTimeRecordDto() throws -> RunningGroundContactTimeRecordDto {
        if #available(iOS 16.0, *) {
            guard quantityType.identifier == HKQuantityTypeIdentifier.runningGroundContactTime.rawValue
            else {
                throw HealthConnectorError.invalidArgument(
                    message:
                    "Expected running ground contact time quantity type, got \(quantityType.identifier)",
                    context: [
                        "expected": HKQuantityTypeIdentifier.runningGroundContactTime.rawValue,
                        "actual": quantityType.identifier,
                    ]
                )
            }

            // Convert quantity to seconds
            let duration = quantity.doubleValue(for: .second())

            // Create builder from HK metadata with source and device
            var builder = MetadataBuilder(
                fromHKMetadata: metadata ?? [:],
                source: sourceRevision.source,
                device: device
            )

            // Extract timezone offsets from metadata
            let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
            let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

            return try RunningGroundContactTimeRecordDto(
                id: uuid.uuidString,
                startTime: startDate.millisecondsSince1970,
                endTime: endDate.millisecondsSince1970,
                seconds: duration,
                metadata: builder.toMetadataDto(),
                startZoneOffsetSeconds: startZoneOffset,
                endZoneOffsetSeconds: endZoneOffset
            )
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Running ground contact time is only supported on iOS 16.0 and later",
                context: ["dataType": "runningGroundContactTime", "minimumIOSVersion": "16.0"]
            )
        }
    }
}
