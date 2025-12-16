import Foundation

/// Extensions for HealthRecordDto to provide common utility methods
extension HealthRecordDto {
    /// Extracts the timestamp from any HealthRecordDto for pagination purposes.
    ///
    /// This method handles different DTO types that store timestamps in different properties:
    /// - Most interval DTOs use `endTime`
    /// - Nutrient DTOs use `time`
    /// - Nutrition correlation DTOs use `endTime`
    ///
    /// - Returns: Timestamp in milliseconds since epoch
    /// - Throws: HealthConnectorError.invalidArgument if DTO type is unknown
    func extractTimestamp() throws -> Int64 {
        switch self {
        // Interval-based DTOs with endTime
        case let dto as StepRecordDto:
            return dto.endTime
        case let dto as ActiveCaloriesBurnedRecordDto:
            return dto.endTime
        case let dto as DistanceRecordDto:
            return dto.endTime
        case let dto as FloorsClimbedRecordDto:
            return dto.endTime
        case let dto as WheelchairPushesRecordDto:
            return dto.endTime
        case let dto as HydrationRecordDto:
            return dto.endTime
        case let dto as SleepStageRecordDto:
            return dto.endTime
        case let dto as NutritionRecordDto:
            return dto.endTime
        // Instant measurement DTOs with time
        case let dto as WeightRecordDto:
            return dto.time
        case let dto as HeightRecordDto:
            return dto.time
        case let dto as BodyFatPercentageRecordDto:
            return dto.time
        case let dto as BodyTemperatureRecordDto:
            return dto.time
        case let dto as LeanBodyMassRecordDto:
            return dto.time
        case let dto as HeartRateMeasurementRecordDto:
            return dto.time
        case let dto as RestingHeartRateRecordDto:
            return dto.time
        case let dto as OxygenSaturationRecordDto:
            return dto.time
        case let dto as RespiratoryRateRecordDto:
            return dto.time
        case let dto as Vo2MaxRecordDto:
            return dto.time
        case let dto as BloodGlucoseRecordDto:
            return dto.time
        case let dto as BloodPressureRecordDto:
            return dto.time
        case let dto as SystolicBloodPressureRecordDto:
            return dto.time
        case let dto as DiastolicBloodPressureRecordDto:
            return dto.time
        case let dto as EnergyNutrientRecordDto:
            return dto.time
        case let dto as CaffeineNutrientRecordDto:
            return dto.time
        case let dto as ProteinNutrientRecordDto:
            return dto.time
        case let dto as TotalCarbohydrateNutrientRecordDto:
            return dto.time
        case let dto as TotalFatNutrientRecordDto:
            return dto.time
        case let dto as SaturatedFatNutrientRecordDto:
            return dto.time
        case let dto as MonounsaturatedFatNutrientRecordDto:
            return dto.time
        case let dto as PolyunsaturatedFatNutrientRecordDto:
            return dto.time
        case let dto as CholesterolNutrientRecordDto:
            return dto.time
        case let dto as DietaryFiberNutrientRecordDto:
            return dto.time
        case let dto as SugarNutrientRecordDto:
            return dto.time
        case let dto as VitaminANutrientRecordDto:
            return dto.time
        case let dto as VitaminB6NutrientRecordDto:
            return dto.time
        case let dto as VitaminB12NutrientRecordDto:
            return dto.time
        case let dto as VitaminCNutrientRecordDto:
            return dto.time
        case let dto as VitaminDNutrientRecordDto:
            return dto.time
        case let dto as VitaminENutrientRecordDto:
            return dto.time
        case let dto as VitaminKNutrientRecordDto:
            return dto.time
        case let dto as ThiaminNutrientRecordDto:
            return dto.time
        case let dto as RiboflavinNutrientRecordDto:
            return dto.time
        case let dto as NiacinNutrientRecordDto:
            return dto.time
        case let dto as FolateNutrientRecordDto:
            return dto.time
        case let dto as BiotinNutrientRecordDto:
            return dto.time
        case let dto as PantothenicAcidNutrientRecordDto:
            return dto.time
        case let dto as CalciumNutrientRecordDto:
            return dto.time
        case let dto as IronNutrientRecordDto:
            return dto.time
        case let dto as MagnesiumNutrientRecordDto:
            return dto.time
        case let dto as ManganeseNutrientRecordDto:
            return dto.time
        case let dto as PhosphorusNutrientRecordDto:
            return dto.time
        case let dto as PotassiumNutrientRecordDto:
            return dto.time
        case let dto as SeleniumNutrientRecordDto:
            return dto.time
        case let dto as SodiumNutrientRecordDto:
            return dto.time
        case let dto as ZincNutrientRecordDto:
            return dto.time
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Unimplemented HealthRecordDto type: \(type(of: self))"
            )
        }
    }
}
