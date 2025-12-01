import Foundation
import HealthKit

/// Handler for sleep stage data (category sample type)
///
/// **Data Type:** Sleep Stage
/// **Record Pattern:** Interval (has startTime and endTime)
/// **Aggregation:** None (category samples don't support aggregation)
/// **HealthKit Type:** HKCategoryTypeIdentifier.sleepAnalysis
///
/// **Usage:**
/// - Reading: Retrieves sleep stage samples over time ranges
/// - Writing: Records sleep stages for specific time intervals
/// - Aggregating: NOT supported (category samples have no numeric aggregation)
/// - Pagination: Uses endTime for cursor-based pagination
///
/// **Sleep Stage Types:**
/// iOS HealthKit supports the following sleep stages:
/// - `.inBed` - User is in bed but not yet asleep
/// - `.asleep` - Generic sleep (when detailed stage unknown)
/// - `.awake` - Awake in bed
/// - `.core` (iOS 16+) / light - Core/light sleep stage
/// - `.deep` - Deep sleep stage
/// - `.REM` - REM (Rapid Eye Movement) sleep stage
///
/// **Example:**
/// - Deep sleep from 11:30 PM to 1:00 AM
/// - startTime: 11:30 PM, endTime: 1:00 AM, stageType: .deep
///
/// **Compatibility:** iOS 15+
/// **Verified:** December 1, 2025
struct SleepStageHandler: HealthKitSampleHandler {
    // MARK: - HealthKitTypeHandler

    static var supportedType: HealthDataTypeDto {
        return .sleepStageRecord
    }

    static var category: HealthKitDataCategory {
        return .categorySample
    }

    // MARK: - HealthKitSampleHandler

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        // Type guard: Verify this is a category sample
        guard let categorySample = sample as? HKCategorySample else {
            return nil
        }

        // Verify it's a sleep analysis sample
        guard categorySample.categoryType.identifier == HKCategoryTypeIdentifier.sleepAnalysis.rawValue else {
            return nil
        }

        // Delegate to existing mapper extension
        // This mapper will be implemented in HKCategorySample+SleepStageMappers.swift
        return categorySample.toSleepStageRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        // Type guard: Verify this is a SleepStageRecordDto
        guard let sleepDto = dto as? SleepStageRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected SleepStageRecordDto, got \(type(of: dto))"
            )
        }

        // Delegate to existing mapper extension
        // This mapper will be implemented in SleepStageRecordDto+HealthKit.swift
        return try sleepDto.toHealthKit()
    }

    static func getSampleType() -> HKSampleType {
        // Sleep analysis uses the sleepAnalysis category type
        return HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        // Type guard: Verify this is a SleepStageRecordDto
        guard let sleepDto = dto as? SleepStageRecordDto else {
            return 0
        }

        // Interval records use endTime for pagination
        // This ensures records are ordered by when they completed
        return sleepDto.endTime
    }

    // MARK: - No Aggregation Support

    // Note: Category samples do NOT support aggregation.
    // Unlike quantity samples (steps, weight), category samples represent
    // discrete states or events, not measurable quantities.
    //
    // To analyze sleep patterns, apps typically:
    // 1. Read all sleep stage records for a time range
    // 2. Process them in Dart/Flutter to calculate:
    //    - Total sleep duration
    //    - Time in each stage (light, deep, REM)
    //    - Sleep efficiency
    //    - Number of awakenings
}
