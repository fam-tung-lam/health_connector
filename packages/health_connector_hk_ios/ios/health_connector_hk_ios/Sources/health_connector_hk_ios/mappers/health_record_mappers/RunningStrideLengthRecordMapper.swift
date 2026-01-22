import Foundation
import HealthKit

/// Extension for mapping `RunningStrideLengthRecordDto` → `HKQuantitySample`.
extension RunningStrideLengthRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created or iOS version is unsupported.
    func toHKQuantitySample() throws -> HKQuantitySample {
        if #available(iOS 16.0, *) {
            let type = try HKQuantityType.make(from: .runningStrideLength)

            let quantity = HKQuantity(unit: .meter(), doubleValue: strideLength)
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
                message: "Running stride length is only supported on iOS 16.0 and later",
                context: ["dataType": "runningStrideLength", "minimumIOSVersion": "16.0"]
            )
        }
    }
}

/// Extension for mapping `HKQuantitySample` → `RunningStrideLengthRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `RunningStrideLengthRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a running stride length sample.
    func toRunningStrideLengthRecordDto() throws -> RunningStrideLengthRecordDto {
        if #available(iOS 16.0, *) {
            guard quantityType.identifier == HKQuantityTypeIdentifier.runningStrideLength.rawValue
            else {
                throw HealthConnectorError.invalidArgument(
                    message:
                    "Expected running stride length quantity type, got \(quantityType.identifier)",
                    context: [
                        "expected": HKQuantityTypeIdentifier.runningStrideLength.rawValue,
                        "actual": quantityType.identifier,
                    ]
                )
            }

            // Convert quantity to meters
            let length = quantity.doubleValue(for: .meter())

            // Create builder from HK metadata with source and device
            var builder = MetadataBuilder(
                fromHKMetadata: metadata ?? [:],
                source: sourceRevision.source,
                device: device
            )

            // Extract timezone offsets from metadata
            let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
            let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

            return try RunningStrideLengthRecordDto(
                id: uuid.uuidString,
                startTime: startDate.millisecondsSince1970,
                endTime: endDate.millisecondsSince1970,
                strideLength: length,
                metadata: builder.toMetadataDto(),
                startZoneOffsetSeconds: startZoneOffset,
                endZoneOffsetSeconds: endZoneOffset
            )
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Running stride length is only supported on iOS 16.0 and later",
                context: ["dataType": "runningStrideLength", "minimumIOSVersion": "16.0"]
            )
        }
    }
}
