import Foundation
import HealthKit

/// Extension for converting between `HKWorkoutActivityType` and `ExerciseTypeDto`.
///
/// This mapper implements the iOS HealthKit-specific mapping logic for exercise types
/// as defined in the core `ExerciseType` enum and the Dart iOS mapper logic.
///
/// ## Platform-Specific Behavior
///
/// Not all `ExerciseType` values are supported on iOS HealthKit:
/// - **Android-only types** (annotated with `@supportedOnHealthConnect` in core):
///   These types are NOT present in `ExerciseTypeDto` for iOS and should throw
///   `ArgumentError` if attempted to be used from Dart layer.
/// - **iOS-only types** (annotated with `@supportedOnAppleHealth` in core):
///   These types ARE present in `ExerciseTypeDto` and map to specific `HKWorkoutActivityType` values.
/// - **Cross-platform types**: Supported on both platforms with appropriate mappings.
/// Extension for mapping `HKWorkoutActivityType` ↔ `ExerciseTypeDto`.
extension HKWorkoutActivityType {
    /// Converts `HKWorkoutActivityType` to `ExerciseTypeDto`.
    func toDto() -> ExerciseTypeDto {
        switch self {
        // MARK: - Cardio & Walking/Running (Cross-platform)

        case .running:
            return .running
        case .walking:
            return .walking
        case .cycling:
            return .cycling
        case .hiking:
            return .hiking
        case .handCycling:
            return .handCycling
        case .trackAndField:
            return .trackAndField
        case .swimming:
            return .swimming
        case .surfingSports:
            return .surfing
        case .waterPolo:
            return .waterPolo
        case .rowing:
            return .rowing
        case .sailing:
            return .sailing
        case .paddleSports:
            return .paddling

        // MARK: - Strength Training
        // Cross-platform: strengthTraining (multiple HK types map to this)
        case .traditionalStrengthTraining:
            return .strengthTraining
        case .functionalStrengthTraining:
            return .strengthTraining

        // MARK: - Team Sports
        case .basketball:
            return .basketball
        case .soccer:
            return .soccer
        case .americanFootball:
            return .americanFootball
        case .australianFootball:
            return .australianFootball
        case .baseball:
            return .baseball
        case .softball:
            return .softball
        case .volleyball:
            return .volleyball
        case .rugby:
            return .rugby
        case .cricket:
            return .cricket
        case .handball:
            return .handball
        case .hockey:
            return .hockey
        case .lacrosse:
            return .lacrosse
        case .discSports:
            return .discSports

        // MARK: - Racquet Sports
        case .tennis:
            return .tennis
        case .tableTennis:
            return .tableTennis
        case .badminton:
            return .badminton
        case .squash:
            return .squash
        case .racquetball:
            return .racquetball
        case .pickleball:
            return .pickleball

        // MARK: - Winter Sports
        case .downhillSkiing:
            return .downhillSkiing
        case .crossCountrySkiing:
            return .crossCountrySkiing
        case .snowboarding:
            return .snowboarding
        // Cross-platform: skating (HK uses skatingSports)
        case .skatingSports:
            return .skating
        case .curling:
            return .curling
        case .snowSports:
            return .snowSports

        // MARK: - Martial Arts & Combat Sports
        case .boxing:
            return .boxing
        case .kickboxing:
            return .kickboxing
        case .martialArts:
            return .martialArts
        case .wrestling:
            return .wrestling
        case .fencing:
            return .fencing
        case .taiChi:
            return .taiChi

        // MARK: - Dance & Gymnastics
        // Note: .dance is deprecated in HK, map to .cardioDance
        case .dance:
            return .cardioDance
        case .gymnastics:
            return .gymnastics
        case .socialDance:
            return .socialDance
        case .cardioDance:
            return .cardioDance
        case .barre:
            return .barre

        // MARK: - Fitness & Conditioning
        case .yoga:
            return .yoga
        case .pilates:
            return .pilates
        case .highIntensityIntervalTraining:
            return .highIntensityIntervalTraining
        case .elliptical:
            return .elliptical
        // Cross-platform: stairClimbing (HK also has .stairs which maps to same)
        case .stairClimbing:
            return .stairClimbing
        case .stairs:
            return .stairClimbing
        case .flexibility:
            return .flexibility
        case .stepTraining:
            return .stepTraining
        case .fitnessGaming:
            return .fitnessGaming
        case .coreTraining:
            return .coreTraining
        case .cooldown:
            return .cooldown
        case .mixedCardio:
            return .mixedCardio
        case .crossTraining:
            return .crossTraining
        case .jumpRope:
            return .jumpRope
        case .mindAndBody:
            return .mindAndBody
        case .preparationAndRecovery:
            return .preparationAndRecovery

        // MARK: - Golf & Precision Sports
        case .golf:
            return .golf
        case .archery:
            return .archery
        case .bowling:
            return .bowling

        // MARK: - Outdoor & Adventure
        case .climbing:
            return .climbing
        case .equestrianSports:
            return .equestrianSports
        case .fishing:
            return .fishing
        case .hunting:
            return .hunting
        case .play:
            return .play

        // MARK: - Wheelchair Activities
        case .wheelchairRunPace:
            return .wheelchairRunPace
        case .wheelchairWalkPace:
            return .wheelchairWalkPace

        // MARK: - Multisport
        case .transition:
            if #available(iOS 16.0, *) {
                return .transition
            } else {
                return .other
            }
        case .swimBikeRun:
            if #available(iOS 16.0, *) {
                return .swimBikeRun
            } else {
                return .other
            }

        // MARK: - Other
        case .other:
            return .other
        @unknown default:
            return .other
        }
    }

    /// Converts `ExerciseTypeDto` to `HKWorkoutActivityType`.
    ///
    /// - Parameter dto: The exercise type DTO to convert
    /// - Returns: The corresponding HKWorkoutActivityType
    static func from(dto: ExerciseTypeDto) -> HKWorkoutActivityType {
        switch dto {
        // MARK: - Cardio & Walking/Running

        case .running:
            .running
        case .walking:
            .walking
        case .cycling:
            .cycling
        case .hiking:
            .hiking
        case .handCycling:
            .handCycling
        case .trackAndField:
            .trackAndField

        // MARK: - Water Sports
        case .swimming:
            .swimming
        case .surfing:
            .surfingSports
        case .waterPolo:
            .waterPolo
        case .rowing:
            .rowing
        case .sailing:
            .sailing
        case .paddling:
            .paddleSports
        case .diving:
            if #available(iOS 17.0, *) {
                .underwaterDiving
            } else {
                .other
            }
        case .waterFitness:
            .waterFitness
        case .waterSports:
            .waterSports

        // MARK: - Strength Training
        case .strengthTraining:
            .traditionalStrengthTraining // Use traditional as default

        // MARK: - Team Sports
        case .basketball:
            .basketball
        case .soccer:
            .soccer
        case .americanFootball:
            .americanFootball
        case .australianFootball:
            .australianFootball
        case .baseball:
            .baseball
        case .softball:
            .softball
        case .volleyball:
            .volleyball
        case .rugby:
            .rugby
        case .cricket:
            .cricket
        case .handball:
            .handball
        case .hockey:
            .hockey
        case .lacrosse:
            .lacrosse
        case .discSports:
            .discSports
        case .frisbeeDisc:
            .discSports

        // MARK: - Racquet Sports
        case .tennis:
            .tennis
        case .tableTennis:
            .tableTennis
        case .badminton:
            .badminton
        case .squash:
            .squash
        case .racquetball:
            .racquetball
        case .pickleball:
            .pickleball

        // MARK: - Winter Sports
        case .snowboarding:
            .snowboarding
        case .skating:
            .skatingSports
        case .crossCountrySkiing:
            .crossCountrySkiing
        case .curling:
            .curling
        case .downhillSkiing:
            .downhillSkiing
        case .snowSports:
            .snowSports

        // MARK: - Martial Arts & Combat Sports
        case .boxing:
            .boxing
        case .martialArts:
            .martialArts
        case .fencing:
            .fencing
        case .kickboxing:
            .kickboxing
        case .wrestling:
            .wrestling
        case .taiChi:
            .taiChi

        // MARK: - Dance & Gymnastics
        case .gymnastics:
            .gymnastics
        case .barre:
            .barre
        case .cardioDance:
            .cardioDance
        case .socialDance:
            .socialDance

        // MARK: - Fitness & Conditioning
        case .yoga:
            .yoga
        case .pilates:
            .pilates
        case .highIntensityIntervalTraining:
            .highIntensityIntervalTraining
        case .elliptical:
            .elliptical
        case .stairClimbing:
            .stairClimbing
        case .flexibility:
            .flexibility
        case .crossTraining:
            .crossTraining
        case .jumpRope:
            .jumpRope
        case .stepTraining:
            .stepTraining
        case .fitnessGaming:
            .fitnessGaming
        case .coreTraining:
            .coreTraining
        case .cooldown:
            .cooldown
        case .mixedCardio:
            .mixedCardio
        case .mindAndBody:
            .mindAndBody
        case .preparationAndRecovery:
            .preparationAndRecovery
        case .handCycling:
            .handCycling

        // MARK: - Golf & Precision Sports
        case .golf:
            .golf
        case .archery:
            .archery
        case .bowling:
            .bowling

        // MARK: - Outdoor & Adventure
        case .climbing:
            .climbing
        case .equestrianSports:
            .equestrianSports
        case .fishing:
            .fishing
        case .hunting:
            .hunting
        case .play:
            .play

        // MARK: - Wheelchair Activities
        case .wheelchairWalkPace:
            .wheelchairWalkPace
        case .wheelchairRunPace:
            .wheelchairRunPace

        // MARK: - Multisport
        case .transition:
            if #available(iOS 16.0, *) {
                .transition
            } else {
                .other
            }
        case .swimBikeRun:
            if #available(iOS 16.0, *) {
                .swimBikeRun
            } else {
                .other
            }

        // MARK: - Other
        case .other:
            .other
        }
    }
}
