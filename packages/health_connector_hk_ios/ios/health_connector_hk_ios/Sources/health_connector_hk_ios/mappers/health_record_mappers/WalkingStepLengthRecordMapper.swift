import Foundation
import HealthKit

/// Extension for mapping `WalkingStepLengthRecordDto` → `HKQuantitySample`.
extension WalkingStepLengthRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .walkingStepLength)

        let quantity = HKQuantity(unit: .meter(), doubleValue: meters)
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)

        // Create builder with timezone offsets
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: startZoneOffsetSeconds,
            endTimeZoneOffset: endZoneOffsetSeconds
        )

        // Add device placement side to metadata
        try builder.set(
            standardKey: HKMetadataKeyDevicePlacementSide,
            value: devicePlacementSide.toHealthKit().rawValue
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

/// Extension for mapping `HKQuantitySample` → `WalkingStepLengthRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `WalkingStepLengthRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a walking step length
    /// sample.
    func toWalkingStepLengthRecordDto() throws
        -> WalkingStepLengthRecordDto
    {
        guard
            quantityType.identifier
            == HKQuantityTypeIdentifier.walkingStepLength.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected walking step length quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.walkingStepLength
                        .rawValue,
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

        // Extract device placement side from metadata
        let devicePlacementSide: DevicePlacementSideDto =
            if let placementValue =
            metadata?[HKMetadataKeyDevicePlacementSide] as? Int,
            let placement = HKDevicePlacementSide(rawValue: placementValue) {
                placement.toDto()
            } else {
                .unknown
            }

        return try WalkingStepLengthRecordDto(
            meters: length,
            devicePlacementSide: devicePlacementSide,
            endTime: endDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
