import Foundation

/// Extension providing common property access for `HealthRecordDto` protocol
///
/// Pigeon does not allow defining properties in base classes and interfaces, this extension
/// provides a computed property to access fields that exist in all `HealthRecordDto` implementations.
extension HealthRecordDto {
    /// Platform-assigned unique identifier for this health record
    var id: String? {
        switch self {
        case let record as ActiveCaloriesBurnedRecordDto:
            record.id
        case let record as DistanceActivityRecordDto:
            record.id
        case let record as FloorsClimbedRecordDto:
            record.id
        case let record as StepsRecordDto:
            record.id
        case let record as WeightRecordDto:
            record.id
        case let record as HeightRecordDto:
            record.id
        case let record as HydrationRecordDto:
            record.id
        case let record as LeanBodyMassRecordDto:
            record.id
        case let record as BodyFatPercentageRecordDto:
            record.id
        case let record as BodyTemperatureRecordDto:
            record.id
        case let record as WheelchairPushesRecordDto:
            record.id
        case let record as HeartRateMeasurementRecordDto:
            record.id
        case let record as SleepStageRecordDto:
            record.id
        case let record as SpeedActivityRecordDto:
            record.id
        default:
            nil
        }
    }

    /// Returns the data type of the record.
    var dataType: HealthDataTypeDto {
        get throws {
            switch self {
            case is StepsRecordDto:
                return .steps
            case is WeightRecordDto:
                return .weight
            case is HeightRecordDto:
                return .height
            case is BodyFatPercentageRecordDto:
                return .bodyFatPercentage
            case is BodyTemperatureRecordDto:
                return .bodyTemperature
            case is ActiveCaloriesBurnedRecordDto:
                return .activeCaloriesBurned
            case let record as DistanceActivityRecordDto:
                return switch record.activityType {
                case .walkingRunning: .walkingRunningDistance
                case .cycling: .cyclingDistance
                case .swimming: .swimmingDistance
                case .wheelchair: .wheelchairDistance
                case .downhillSnowSports: .downhillSnowSportsDistance
                case .rowing: .rowingDistance
                case .paddleSports: .paddleSportsDistance
                case .crossCountrySkiing: .crossCountrySkiingDistance
                case .skatingSports: .skatingSportsDistance
                case .sixMinuteWalkTest: .sixMinuteWalkTestDistance
                }
            case let record as SpeedActivityRecordDto:
                return switch record.activityType {
                case .walking: .walkingSpeed
                case .running: .runningSpeed
                case .stairAscent: .stairAscentSpeed
                case .stairDescent: .stairDescentSpeed
                }
            case is FloorsClimbedRecordDto:
                return .floorsClimbed
            case is WheelchairPushesRecordDto:
                return .wheelchairPushes
            case is HydrationRecordDto:
                return .hydration
            case is LeanBodyMassRecordDto:
                return .leanBodyMass
            case is HeartRateMeasurementRecordDto:
                return .heartRateMeasurementRecord
            case is RestingHeartRateRecordDto:
                return .restingHeartRate
            case is BloodPressureRecordDto:
                return .bloodPressure
            case is SystolicBloodPressureRecordDto:
                return .systolicBloodPressure
            case is DiastolicBloodPressureRecordDto:
                return .diastolicBloodPressure
            case is SleepStageRecordDto:
                return .sleepStageRecord
            case is EnergyNutrientRecordDto:
                return .energyNutrient
            case is CaffeineNutrientRecordDto:
                return .caffeine
            case is ProteinNutrientRecordDto:
                return .protein
            case is TotalCarbohydrateNutrientRecordDto:
                return .totalCarbohydrate
            case is TotalFatNutrientRecordDto:
                return .totalFat
            case is SaturatedFatNutrientRecordDto:
                return .saturatedFat
            case is MonounsaturatedFatNutrientRecordDto:
                return .monounsaturatedFat
            case is PolyunsaturatedFatNutrientRecordDto:
                return .polyunsaturatedFat
            case is CholesterolNutrientRecordDto:
                return .cholesterol
            case is DietaryFiberNutrientRecordDto:
                return .dietaryFiber
            case is SugarNutrientRecordDto:
                return .sugar
            case is VitaminANutrientRecordDto:
                return .vitaminA
            case is VitaminB6NutrientRecordDto:
                return .vitaminB6
            case is VitaminB12NutrientRecordDto:
                return .vitaminB12
            case is VitaminCNutrientRecordDto:
                return .vitaminC
            case is VitaminDNutrientRecordDto:
                return .vitaminD
            case is VitaminENutrientRecordDto:
                return .vitaminE
            case is VitaminKNutrientRecordDto:
                return .vitaminK
            case is ThiaminNutrientRecordDto:
                return .thiamin
            case is RiboflavinNutrientRecordDto:
                return .riboflavin
            case is NiacinNutrientRecordDto:
                return .niacin
            case is FolateNutrientRecordDto:
                return .folate
            case is BiotinNutrientRecordDto:
                return .biotin
            case is PantothenicAcidNutrientRecordDto:
                return .pantothenicAcid
            case is CalciumNutrientRecordDto:
                return .calcium
            case is IronNutrientRecordDto:
                return .iron
            case is MagnesiumNutrientRecordDto:
                return .magnesium
            case is ManganeseNutrientRecordDto:
                return .manganese
            case is PhosphorusNutrientRecordDto:
                return .phosphorus
            case is PotassiumNutrientRecordDto:
                return .potassium
            case is SeleniumNutrientRecordDto:
                return .selenium
            case is SodiumNutrientRecordDto:
                return .sodium
            case is ZincNutrientRecordDto:
                return .zinc
            case is NutritionRecordDto:
                return .nutrition
            case is BloodGlucoseRecordDto:
                return .bloodGlucose
            case is OxygenSaturationRecordDto:
                return .oxygenSaturation
            case is RespiratoryRateRecordDto:
                return .respiratoryRate
            case is Vo2MaxRecordDto:
                return .vo2Max
            default:
                throw HealthConnectorError.invalidArgument(
                    message: "Unimplemented HealthRecordDto type: \(type(of: self))"
                )
            }
        }
    }

    /// The timestamp used for pagination, in milliseconds since epoch.
    ///
    /// Handles platform-specific timestamp fields:
    /// - Interval records: `endTime`
    /// - Nutrients: `time`
    /// - Correlations: `endTime`
    ///
    /// - Returns: Pagination timestamp
    /// - Throws: `HealthConnectorError.invalidArgument` for unknown DTO types
    func extractTimestamp() throws -> Int64 {
        switch self {
        // Interval-based DTOs with endTime
        case let dto as StepsRecordDto:
            return dto.endTime
        case let dto as ActiveCaloriesBurnedRecordDto:
            return dto.endTime
        case let dto as DistanceActivityRecordDto:
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
        case let dto as SpeedActivityRecordDto:
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
