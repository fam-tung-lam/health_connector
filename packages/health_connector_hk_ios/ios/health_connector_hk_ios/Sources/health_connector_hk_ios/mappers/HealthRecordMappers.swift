import Foundation
import HealthKit

// ==================== ACTIVE CALORIES BURNED RECORD MAPPERS ====================

extension ActiveCaloriesBurnedRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */

    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create active energy burned quantity type"]
            )
        }

        let quantity = energy.toHealthKit()
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata(timeZone: TimeZone.current)
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to an `ActiveCaloriesBurnedRecordDto`.
     *
     * Returns `nil` if this sample is not an active energy burned sample.
     */

    func toActiveCaloriesBurnedRecordDto() -> ActiveCaloriesBurnedRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.activeEnergyBurned.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let startZoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let endZoneOffset = metadataDict.extractTimeZoneOffset(for: endDate)
        
        return ActiveCaloriesBurnedRecordDto(
            energy: quantity.toEnergyDto(),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endZoneOffsetSeconds: endZoneOffset,
            startZoneOffsetSeconds: startZoneOffset
        )
    }
}

// ==================== DISTANCE RECORD MAPPERS ====================

extension DistanceRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */

    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create distance quantity type"]
            )
        }

        let quantity = distance.toHealthKit()
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata(timeZone: TimeZone.current)
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `DistanceRecordDto`.
     *
     * Returns `nil` if this sample is not a distance walking/running sample.
     */

    func toDistanceRecordDto() -> DistanceRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let startZoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let endZoneOffset = metadataDict.extractTimeZoneOffset(for: endDate)
        
        return DistanceRecordDto(
            distance: quantity.toLengthDto(),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endZoneOffsetSeconds: endZoneOffset,
            startZoneOffsetSeconds: startZoneOffset
        )
    }
}

// ==================== FLOORS CLIMBED RECORD MAPPERS ====================

extension FloorsClimbedRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */

    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create flights climbed quantity type"]
            )
        }

        let quantity = HKQuantity(unit: .count(), doubleValue: floors.value)
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata(timeZone: TimeZone.current)
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `FloorsClimbedRecordDto`.
     *
     * Returns `nil` if this sample is not a flights climbed sample.
     */

    func toFloorsClimbedRecordDto() -> FloorsClimbedRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.flightsClimbed.rawValue else {
            return nil
        }

        let unit = HKUnit.count()
        let value = quantity.doubleValue(for: unit)

        let metadataDict = metadata ?? [:]
        let startZoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let endZoneOffset = metadataDict.extractTimeZoneOffset(for: endDate)
        
        return FloorsClimbedRecordDto(
            floors: NumericDto(unit: NumericUnitDto.numeric, value: value),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endZoneOffsetSeconds: endZoneOffset,
            startZoneOffsetSeconds: startZoneOffset
        )
    }
}

// ==================== STEP RECORD MAPPERS ====================

extension StepRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */

    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create step count quantity type"]
            )
        }

        let quantity = HKQuantity(unit: .count(), doubleValue: count.value)
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata(timeZone: TimeZone.current)
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `StepRecordDto`.
     *
     * Returns `nil` if this sample is not a step count sample.
     */

    func toStepRecordDto() -> StepRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.stepCount.rawValue else {
            return nil
        }

        let count = Int64(quantity.doubleValue(for: .count()))

        let metadataDict = metadata ?? [:]
        let startZoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let endZoneOffset = metadataDict.extractTimeZoneOffset(for: endDate)
        
        return StepRecordDto(
            count: count.toNumericDto(),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endZoneOffsetSeconds: endZoneOffset,
            startZoneOffsetSeconds: startZoneOffset
        )
    }
}

// ==================== WEIGHT RECORD MAPPERS ====================

extension WeightRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */

    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .bodyMass) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create body mass quantity type"]
            )
        }

        let quantity = weight.toHealthKit()
        let date = Date(timeIntervalSince1970: TimeInterval(time) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `WeightRecordDto`.
     *
     * Returns `nil` if this sample is not a body mass sample.
     */

    func toWeightRecordDto() -> WeightRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bodyMass.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        
        return WeightRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            weight: quantity.toMassDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}

// ==================== LEAN BODY MASS RECORD MAPPERS ====================

extension LeanBodyMassRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */

    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .leanBodyMass) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create lean body mass quantity type"]
            )
        }

        let quantity = mass.toHealthKit()
        let date = Date(timeIntervalSince1970: TimeInterval(time) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `LeanBodyMassRecordDto`.
     *
     * Returns `nil` if this sample is not a lean body mass sample.
     */

    func toLeanBodyMassRecordDto() -> LeanBodyMassRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.leanBodyMass.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        
        return LeanBodyMassRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            mass: quantity.toMassDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}

// ==================== HEIGHT RECORD MAPPERS ====================

extension HeightRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */

    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .height) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create height quantity type"]
            )
        }

        let quantity = height.toHealthKit()
        let date = Date(timeIntervalSince1970: TimeInterval(time) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `HeightRecordDto`.
     *
     * Returns `nil` if this sample is not a height sample.
     */

    func toHeightRecordDto() -> HeightRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.height.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        
        return HeightRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            height: quantity.toLengthDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}

// ==================== BODY FAT PERCENTAGE RECORD MAPPERS ====================

extension BodyFatPercentageRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */

    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create body fat percentage quantity type"]
            )
        }

        let quantity = percentage.toHealthKit()
        let date = Date(timeIntervalSince1970: TimeInterval(time) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `BodyFatPercentageRecordDto`.
     *
     * Returns `nil` if this sample is not a body fat percentage sample.
     */

    func toBodyFatPercentageRecordDto() -> BodyFatPercentageRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bodyFatPercentage.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        
        return BodyFatPercentageRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            percentage: quantity.toPercentageDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}

// ==================== BODY TEMPERATURE RECORD MAPPERS ====================

extension BodyTemperatureRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */

    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .bodyTemperature) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create body temperature quantity type"]
            )
        }

        let quantity = HKQuantity(unit: .degreeCelsius(), doubleValue: temperature.value)
        let date = Date(timeIntervalSince1970: TimeInterval(time) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `BodyTemperatureRecordDto`.
     *
     * Returns `nil` if this sample is not a body temperature sample.
     */

    func toBodyTemperatureRecordDto() -> BodyTemperatureRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bodyTemperature.rawValue else {
            return nil
        }

        let unit = HKUnit.degreeCelsius()
        let value = quantity.doubleValue(for: unit)

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        
        return BodyTemperatureRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            temperature: TemperatureDto(unit: TemperatureUnitDto.celsius, value: value),
            zoneOffsetSeconds: zoneOffset
        )
    }
}

// ==================== WHEELCHAIR PUSHES RECORD MAPPERS ====================

extension WheelchairPushesRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */

    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .pushCount) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create push count quantity type"]
            )
        }

        let quantity = HKQuantity(unit: .count(), doubleValue: pushes.value)
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata(timeZone: TimeZone.current)
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `WheelchairPushesRecordDto`.
     *
     * Returns `nil` if this sample is not a push count sample.
     */

    func toWheelchairPushesRecordDto() -> WheelchairPushesRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.pushCount.rawValue else {
            return nil
        }

        let unit = HKUnit.count()
        let value = quantity.doubleValue(for: unit)

        let metadataDict = metadata ?? [:]
        let startZoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let endZoneOffset = metadataDict.extractTimeZoneOffset(for: endDate)
        
        return WheelchairPushesRecordDto(
            pushes: NumericDto(unit: NumericUnitDto.numeric, value: value),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endZoneOffsetSeconds: endZoneOffset,
            startZoneOffsetSeconds: startZoneOffset
        )
    }
}

// ==================== HYDRATION RECORD MAPPERS ====================

extension HydrationRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .dietaryWater) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create dietary water quantity type"]
            )
        }

        let quantity = volume.toHealthKit()
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata(timeZone: TimeZone.current)
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `HydrationRecordDto`.
     *
     * Returns `nil` if this sample is not a dietary water sample.
     */
    func toHydrationRecordDto() -> HydrationRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryWater.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let startZoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let endZoneOffset = metadataDict.extractTimeZoneOffset(for: endDate)
        
        return HydrationRecordDto(
            id: uuid.uuidString,
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            volume: quantity.toVolumeDto(),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}

// ==================== HEART RATE MEASUREMENT RECORD MAPPERS ====================

extension HeartRateMeasurementRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create heart rate quantity type"]
            )
        }

        // Heart rate is measured in beats per minute (count/minute)
        let unit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: unit, doubleValue: measurement.beatsPerMinute.value)
        let date = Date(timeIntervalSince1970: TimeInterval(measurement.time) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /**
     * Converts this HealthKit sample to a `HeartRateMeasurementRecordDto`.
     *
     * Returns `nil` if this sample is not a heart rate sample.
     */
    func toHeartRateMeasurementRecordDto() -> HeartRateMeasurementRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.heartRate.rawValue else {
            return nil
        }

        // Heart rate is in beats per minute (count/minute)
        let unit = HKUnit.count().unitDivided(by: .minute())
        let bpmValue = quantity.doubleValue(for: unit)

        let measurement = HeartRateMeasurementDto(
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            beatsPerMinute: NumericDto(unit: NumericUnitDto.numeric, value: bpmValue)
        )

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        
        return HeartRateMeasurementRecordDto(
            id: uuid.uuidString,
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            measurement: measurement,
            zoneOffsetSeconds: zoneOffset
        )
    }
}


