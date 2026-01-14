import Foundation
import HealthKit

/// Extension to convert DistanceActivityRecordDto to HealthKit sample
extension DistanceActivityRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Returns: HKQuantitySample with the appropriate distance quantity type
    func toHealthKit() throws -> HKQuantitySample {
        let quantityTypeIdentifier = try activityType.toHealthKitIdentifier()
        let type = try HKQuantityType.make(from: quantityTypeIdentifier)

        let unit = HKUnit.meter()
        let quantity = HKQuantity(unit: unit, doubleValue: meters)
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
    }
}

/// Extension to convert DistanceActivityTypeDto to HKQuantityTypeIdentifier
extension DistanceActivityTypeDto {
    /// Maps to the corresponding HKQuantityTypeIdentifier.
    ///
    /// - Throws: HealthConnectorError.unsupportedOperation if the activity type is not supported on the current iOS
    /// version
    func toHealthKitIdentifier() throws -> HKQuantityTypeIdentifier {
        switch self {
        case .walkingRunning:
            .distanceWalkingRunning
        case .cycling:
            .distanceCycling
        case .swimming:
            .distanceSwimming
        case .wheelchair:
            .distanceWheelchair
        case .downhillSnowSports:
            .distanceDownhillSnowSports
        case .rowing:
            if #available(iOS 18.0, *) {
                .distanceRowing
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Rowing distance is only supported on iOS 18.0 and later",
                    context: ["activityType": "rowing", "minimumIOSVersion": "18.0"]
                )
            }
        case .paddleSports:
            if #available(iOS 18.0, *) {
                .distancePaddleSports
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Paddle sports distance is only supported on iOS 18.0 and later",
                    context: ["activityType": "paddleSports", "minimumIOSVersion": "18.0"]
                )
            }
        case .crossCountrySkiing:
            if #available(iOS 18.0, *) {
                .distanceCrossCountrySkiing
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message:
                    "Cross-country skiing distance is only supported on iOS 18.0 and later",
                    context: ["activityType": "crossCountrySkiing", "minimumIOSVersion": "18.0"]
                )
            }
        case .skatingSports:
            if #available(iOS 18.0, *) {
                .distanceSkatingSports
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Skating sports distance is only supported on iOS 18.0 and later",
                    context: ["activityType": "skatingSports", "minimumIOSVersion": "18.0"]
                )
            }
        case .sixMinuteWalkTest:
            .sixMinuteWalkTestDistance
        }
    }

    /// Creates from an HKQuantityTypeIdentifier.
    static func from(_ identifier: HKQuantityTypeIdentifier) throws -> DistanceActivityTypeDto {
        switch identifier {
        case .distanceWalkingRunning:
            return .walkingRunning
        case .distanceCycling:
            return .cycling
        case .distanceSwimming:
            return .swimming
        case .distanceWheelchair:
            return .wheelchair
        case .distanceDownhillSnowSports:
            return .downhillSnowSports
        case .sixMinuteWalkTestDistance:
            return .sixMinuteWalkTest
        // New in iOS 18.0+
        default:
            if #available(iOS 18.0, *) {
                switch identifier {
                case .distanceRowing:
                    return .rowing
                case .distancePaddleSports:
                    return .paddleSports
                case .distanceCrossCountrySkiing:
                    return .crossCountrySkiing
                case .distanceSkatingSports:
                    return .skatingSports
                default:
                    break
                }
            }

            throw HealthConnectorError.invalidArgument(
                message: "\(identifier) is not part of distance activity types",
                context: ["activityType": identifier]
            )
        }
    }
}

/// Extension to convert HKQuantitySample to DistanceActivityRecordDto
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `DistanceActivityRecordDto`.
    ///
    /// - Parameter distanceActivityType: The expected activity type for validation
    /// - Throws: `HealthConnectorError.invalidArgument` if the sample type doesn't match
    func toDistanceActivityRecordDto(
        distanceActivityType: DistanceActivityTypeDto
    ) throws -> DistanceActivityRecordDto {
        let expectedIdentifier = try distanceActivityType.toHealthKitIdentifier()
        guard quantityType.identifier == expectedIdentifier.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected \(expectedIdentifier.rawValue) quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": expectedIdentifier.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try DistanceActivityRecordDto(
            meters: quantity.doubleValue(for: HKUnit.meter()),
            activityType: distanceActivityType,
            endTime: endDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
