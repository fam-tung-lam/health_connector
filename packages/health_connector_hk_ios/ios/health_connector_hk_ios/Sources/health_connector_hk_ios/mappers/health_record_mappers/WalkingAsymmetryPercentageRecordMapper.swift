import Foundation
import HealthKit

extension WalkingAsymmetryPercentageRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .walkingAsymmetryPercentage)

        let quantity = HKQuantity(unit: .percent(), doubleValue: percentage)
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

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `WalkingAsymmetryPercentageRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a walking asymmetry percentage sample.
    func toWalkingAsymmetryPercentageRecordDto() throws
        -> WalkingAsymmetryPercentageRecordDto
    {
        guard
            quantityType.identifier == HKQuantityTypeIdentifier.walkingAsymmetryPercentage.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                    "Expected walking asymmetry percentage quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.walkingAsymmetryPercentage
                        .rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        // Convert quantity to percentage (stored as decimal 0.0-1.0)
        let percentage = quantity.doubleValue(for: .percent())

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
                let placement = HKDevicePlacementSide(rawValue: placementValue)
            {
                placement.toDto()
            } else {
                .unknown
            }

        return WalkingAsymmetryPercentageRecordDto(
            percentage: percentage,
            devicePlacementSide: devicePlacementSide,
            endTime: Int64(endDate.millisecondsSince1970),
            id: uuid.uuidString,
            metadata: try builder.toMetadataDto(),
            startTime: Int64(startDate.millisecondsSince1970),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
