import Foundation
import HealthKit

/// Extension for mapping `HKQuantitySample` → `WalkingAsymmetryPercentageRecordDto`.
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
            let placement = HKDevicePlacementSide(rawValue: placementValue) {
                placement.toDto()
            } else {
                .unknown
            }

        return try WalkingAsymmetryPercentageRecordDto(
            percentage: percentage,
            devicePlacementSide: devicePlacementSide,
            endTime: Int64(endDate.millisecondsSince1970),
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: Int64(startDate.millisecondsSince1970),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
