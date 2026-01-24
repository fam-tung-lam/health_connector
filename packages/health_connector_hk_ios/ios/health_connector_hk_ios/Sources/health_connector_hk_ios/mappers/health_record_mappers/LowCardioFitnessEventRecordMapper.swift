import Foundation
import HealthKit

extension HKCategorySample {
    func toLowCardioFitnessEventRecordDto() throws -> LowCardioFitnessEventRecordDto {
        guard categoryType.identifier == HKCategoryTypeIdentifier.lowCardioFitnessEvent.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected low cardio fitness event category type, got \(categoryType.identifier)",
                context: [
                    "expected": HKCategoryTypeIdentifier.lowCardioFitnessEvent.rawValue,
                    "actual": categoryType.identifier,
                ]
            )
        }

        var vo2MaxVal: Double?
        var thresholdVal: Double?

        if let vo2Max = metadata?[HKMetadataKeyVO2MaxValue] as? HKQuantity {
            vo2MaxVal = vo2Max.doubleValue(for: HKUnit(from: "ml/kg/min"))
        }

        if let threshold = metadata?[HKMetadataKeyLowCardioFitnessEventThreshold] as? HKQuantity {
            thresholdVal = threshold.doubleValue(for: HKUnit(from: "ml/kg/min"))
        }

        let builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        return try LowCardioFitnessEventRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            vo2MlPerMinPerKg: vo2MaxVal,
            vo2MlPerMinPerKgThreshold: thresholdVal,
            startZoneOffsetSeconds: StartTimeZoneOffsetKey.read(from: builder.metadataDict),
            endZoneOffsetSeconds: EndTimeZoneOffsetKey.read(from: builder.metadataDict)
        )
    }
}
