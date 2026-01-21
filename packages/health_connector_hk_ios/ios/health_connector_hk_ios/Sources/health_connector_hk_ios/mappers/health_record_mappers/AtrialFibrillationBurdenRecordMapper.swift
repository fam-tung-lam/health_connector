import Foundation
import HealthKit

/// Extension for mapping `HKQuantitySample` → `AtrialFibrillationBurdenRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `AtrialFibrillationBurdenRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an atrial fibrillation burden sample.
    @available(iOS 16.0, *)
    func toAtrialFibrillationBurdenRecordDto() throws -> AtrialFibrillationBurdenRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.atrialFibrillationBurden.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected atrial fibrillation burden quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.atrialFibrillationBurden.rawValue,
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

        return try AtrialFibrillationBurdenRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            percentage: percentage,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
