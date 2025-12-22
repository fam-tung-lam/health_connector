import Foundation
import HealthKit

/// Extension to convert SpeedActivityRecordDto to HealthKit sample
extension SpeedActivityRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Returns: HKQuantitySample with the appropriate speed quantity type
    func toHealthKit() throws -> HKQuantitySample {
        let quantityTypeIdentifier = try activityType.toHealthKitIdentifier()
        let type = try HKQuantityType.make(from: quantityTypeIdentifier)

        let quantity = speed.toHealthKit()
        let date = Date(millisecondsSince1970: time)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

/// Extension to convert SpeedActivityTypeDto to HKQuantityTypeIdentifier
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

/// Extension to convert HKQuantitySample to SpeedActivityRecordDto
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

        let metadataDict = metadata ?? [:]

        return SpeedActivityRecordDto(
            speed: quantity.toVelocityDto(),
            activityType: speedActivityType,
            time: startDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            zoneOffsetSeconds: nil
        )
    }
}
