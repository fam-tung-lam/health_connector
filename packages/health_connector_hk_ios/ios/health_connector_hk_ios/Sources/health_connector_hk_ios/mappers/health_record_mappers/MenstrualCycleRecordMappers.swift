import Foundation
import HealthKit

/**
 * Mappers for converting MenstrualCycleRecordDto to HKCategorySample
 */
extension MenstrualCycleRecordDto {
    /**
     * Convert MenstrualCycleRecordDto to HKCategorySample
     */
    func toHealthKit() throws -> HKCategorySample {
        let categoryType = try HKCategoryType.safeCategoryType(forIdentifier: .menstrualFlow)

        let value = try MenstrualFlowDto.toHealthKitValue(from: flow)
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

        var metadataDict = metadata.toHealthKitMetadata(timeZone: TimeZone.current)

        // Handle "Start of Cycle" metadata
        if isStartOfCycle {
            metadataDict[HKMetadataKeyMenstrualCycleStart] = true
        }

        if let startOffset = startZoneOffsetSeconds {
            metadataDict[HKMetadataKeyTimeZone] = TimeZone(secondsFromGMT: Int(startOffset))?.identifier
        }

        // If end offset differs from start (unlikely for flow samples but consistent with interval records)
        if let endOffset = endZoneOffsetSeconds,
           endOffset != startZoneOffsetSeconds
        {
            metadataDict["EndTimeZoneOffset"] = endOffset
        }

        return HKCategorySample(
            type: categoryType,
            value: value,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadataDict
        )
    }
}

/**
 * Mappers for HKCategorySample (MenstrualFlow) to MenstrualCycleRecordDto
 */
extension HKCategorySample {
    /**
     * Convert HKCategorySample to MenstrualCycleRecordDto
     * Returns nil if sample type is not menstrual flow
     */
    func toMenstrualCycleRecordDto() -> MenstrualCycleRecordDto? {
        guard categoryType.identifier == HKCategoryTypeIdentifier.menstrualFlow.rawValue else {
            return nil
        }

        // Extract flow value
        let flowDto = MenstrualFlowDto.fromHealthKitValue(value)

        // Extract Start of Cycle metadata
        let metadataDict = metadata ?? [:]
        let isStart = (metadataDict[HKMetadataKeyMenstrualCycleStart] as? Bool) ?? false
        let startZoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let endZoneOffset = metadataDict.extractTimeZoneOffset(for: endDate)

        return MenstrualCycleRecordDto(
            id: uuid.uuidString,
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            flow: flowDto,
            isStartOfCycle: isStart,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}

/**
 * Mappers for MenstrualFlowDto to HealthKit Value (Int)
 */
extension MenstrualFlowDto {
    static func toHealthKitValue(from dto: MenstrualFlowDto) throws -> Int {
        switch dto {
        case .unknown:
            HKCategoryValueMenstrualFlow.unspecified.rawValue
        case .light:
            HKCategoryValueMenstrualFlow.light.rawValue
        case .medium:
            HKCategoryValueMenstrualFlow.medium.rawValue
        case .heavy:
            HKCategoryValueMenstrualFlow.heavy.rawValue
        }
    }

    static func fromHealthKitValue(_ value: Int) -> MenstrualFlowDto {
        // Safe conversion if value is valid
        if let flowValue = HKCategoryValueMenstrualFlow(rawValue: value) {
            switch flowValue {
            case .unspecified:
                return .unknown
            case .light:
                return .light
            case .medium:
                return .medium
            case .heavy:
                return .heavy
            case .none:
                // "None" usually means no flow. Map to unknown or handle?
                // Core doesn't express "None" in Enum.
                return .unknown
            @unknown default:
                return .unknown
            }
        }
        return .unknown
    }
}
