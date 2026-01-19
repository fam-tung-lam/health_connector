import Foundation
import HealthKit

/// Extension for mapping `SpeedActivityRecordDto` → `HKQuantitySample`.
extension SpeedActivityRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Returns: HKQuantitySample with the appropriate speed quantity type
    func toHKQuantitySample() throws -> HKQuantitySample {
        let quantityTypeIdentifier = try activityType.toHealthKitIdentifier()
        let type = try HKQuantityType.make(from: quantityTypeIdentifier)

        let unit = HKUnit.meter().unitDivided(by: .second())
        let quantity = HKQuantity(unit: unit, doubleValue: metersPerSecond)
        let date = Date(millisecondsSince1970: time)

        // Create builder with timezone offset
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: zoneOffsetSeconds
        )

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date,
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )
    }
}

/// Extension for mapping `SpeedActivityTypeDto` → `HKQuantityTypeIdentifier`.
extension SpeedActivityTypeDto {
    /// Maps to the corresponding HKQuantityTypeIdentifier.
    ///
    /// - Throws: HealthConnectorError.unsupportedOperation if the activity type is not supported on the current iOS
    /// version
    func toHealthKitIdentifier() throws -> HKQuantityTypeIdentifier {
        if #available(iOS 16.0, *) {
            switch self {
            case .walking:
                .walkingSpeed
            case .running:
                .runningSpeed
            case .stairAscent:
                .stairAscentSpeed
            case .stairDescent:
                .stairDescentSpeed
            }
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Speed activities are only supported on iOS 16.0 and later",
                context: ["activityType": String(describing: self), "minimumIOSVersion": "16.0"]
            )
        }
    }

    /// Creates from an HKQuantityTypeIdentifier.
    static func from(_ identifier: HKQuantityTypeIdentifier) throws -> SpeedActivityTypeDto {
        if #available(iOS 16.0, *) {
            switch identifier {
            case .walkingSpeed:
                return .walking
            case .runningSpeed:
                return .running
            case .stairAscentSpeed:
                return .stairAscent
            case .stairDescentSpeed:
                return .stairDescent
            default:
                break
            }
        }

        throw HealthConnectorError.invalidArgument(
            message: "\(identifier) is not part of speed activity types",
            context: ["activityType": identifier]
        )
    }
}

/// Extension for mapping `HKQuantitySample` → `SpeedActivityRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `SpeedActivityRecordDto`.
    ///
    /// - Parameter speedActivityType: The expected activity type for validation
    /// - Throws: `HealthConnectorError.invalidArgument` if the sample type doesn't match
    func toSpeedActivityRecordDto(
        speedActivityType: SpeedActivityTypeDto
    ) throws -> SpeedActivityRecordDto {
        let expectedIdentifier = try speedActivityType.toHealthKitIdentifier()
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

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try SpeedActivityRecordDto(
            metersPerSecond: quantity.doubleValue(for: HKUnit.meter().unitDivided(by: .second())),
            activityType: speedActivityType,
            time: startDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
