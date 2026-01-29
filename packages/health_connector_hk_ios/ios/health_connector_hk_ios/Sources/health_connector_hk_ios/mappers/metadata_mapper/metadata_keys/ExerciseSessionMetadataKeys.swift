import Foundation
import HealthKit

// MARK: - StringSerializable Conformance

extension ExerciseSegmentTypeDto: StringSerializable {
    private enum ExerciseSegmentTypeStrings {
        static let unknown = "unknown"
        static let armCurl = "armCurl"
        static let backExtension = "backExtension"
        static let ballSlam = "ballSlam"
        static let barbellShoulderPress = "barbellShoulderPress"
        static let benchPress = "benchPress"
        static let benchSitUp = "benchSitUp"
        static let biking = "biking"
        static let bikingStationary = "bikingStationary"
        static let burpee = "burpee"
        static let crunch = "crunch"
        static let deadlift = "deadlift"
        static let doubleArmTricepsExtension = "doubleArmTricepsExtension"
        static let dumbbellCurlLeftArm = "dumbbellCurlLeftArm"
        static let dumbbellCurlRightArm = "dumbbellCurlRightArm"
        static let dumbbellFrontRaise = "dumbbellFrontRaise"
        static let dumbbellLateralRaise = "dumbbellLateralRaise"
        static let dumbbellRow = "dumbbellRow"
        static let dumbbellTricepsExtensionLeftArm = "dumbbellTricepsExtensionLeftArm"
        static let dumbbellTricepsExtensionRightArm = "dumbbellTricepsExtensionRightArm"
        static let dumbbellTricepsExtensionTwoArm = "dumbbellTricepsExtensionTwoArm"
        static let elliptical = "elliptical"
        static let forwardTwist = "forwardTwist"
        static let frontRaise = "frontRaise"
        static let highIntensityIntervalTraining = "highIntensityIntervalTraining"
        static let hipThrust = "hipThrust"
        static let hulaHoop = "hulaHoop"
        static let jumpingJack = "jumpingJack"
        static let jumpRope = "jumpRope"
        static let kettlebellSwing = "kettlebellSwing"
        static let lateralRaise = "lateralRaise"
        static let latPullDown = "latPullDown"
        static let legCurl = "legCurl"
        static let legExtension = "legExtension"
        static let legPress = "legPress"
        static let legRaise = "legRaise"
        static let lunge = "lunge"
        static let mountainClimber = "mountainClimber"
        static let otherWorkout = "otherWorkout"
        static let pause = "pause"
        static let pilates = "pilates"
        static let plank = "plank"
        static let pullUp = "pullUp"
        static let punch = "punch"
        static let rest = "rest"
        static let rowingMachine = "rowingMachine"
        static let running = "running"
        static let runningTreadmill = "runningTreadmill"
        static let shoulderPress = "shoulderPress"
        static let singleArmTricepsExtension = "singleArmTricepsExtension"
        static let sitUp = "sitUp"
        static let squat = "squat"
        static let stairClimbing = "stairClimbing"
        static let stairClimbingMachine = "stairClimbingMachine"
        static let stretching = "stretching"
        static let swimmingBackstroke = "swimmingBackstroke"
        static let swimmingBreaststroke = "swimmingBreaststroke"
        static let swimmingButterfly = "swimmingButterfly"
        static let swimmingFreestyle = "swimmingFreestyle"
        static let swimmingMixed = "swimmingMixed"
        static let swimmingOpenWater = "swimmingOpenWater"
        static let swimmingOther = "swimmingOther"
        static let swimmingPool = "swimmingPool"
        static let upperTwist = "upperTwist"
        static let walking = "walking"
        static let weightlifting = "weightlifting"
        static let wheelchair = "wheelchair"
        static let yoga = "yoga"
    }

    func toMetadataString() -> String {
        switch self {
        case .unknown: ExerciseSegmentTypeStrings.unknown
        case .armCurl: ExerciseSegmentTypeStrings.armCurl
        case .backExtension: ExerciseSegmentTypeStrings.backExtension
        case .ballSlam: ExerciseSegmentTypeStrings.ballSlam
        case .barbellShoulderPress: ExerciseSegmentTypeStrings.barbellShoulderPress
        case .benchPress: ExerciseSegmentTypeStrings.benchPress
        case .benchSitUp: ExerciseSegmentTypeStrings.benchSitUp
        case .biking: ExerciseSegmentTypeStrings.biking
        case .bikingStationary: ExerciseSegmentTypeStrings.bikingStationary
        case .burpee: ExerciseSegmentTypeStrings.burpee
        case .crunch: ExerciseSegmentTypeStrings.crunch
        case .deadlift: ExerciseSegmentTypeStrings.deadlift
        case .doubleArmTricepsExtension: ExerciseSegmentTypeStrings.doubleArmTricepsExtension
        case .dumbbellCurlLeftArm: ExerciseSegmentTypeStrings.dumbbellCurlLeftArm
        case .dumbbellCurlRightArm: ExerciseSegmentTypeStrings.dumbbellCurlRightArm
        case .dumbbellFrontRaise: ExerciseSegmentTypeStrings.dumbbellFrontRaise
        case .dumbbellLateralRaise: ExerciseSegmentTypeStrings.dumbbellLateralRaise
        case .dumbbellRow: ExerciseSegmentTypeStrings.dumbbellRow
        case .dumbbellTricepsExtensionLeftArm: ExerciseSegmentTypeStrings.dumbbellTricepsExtensionLeftArm
        case .dumbbellTricepsExtensionRightArm: ExerciseSegmentTypeStrings.dumbbellTricepsExtensionRightArm
        case .dumbbellTricepsExtensionTwoArm: ExerciseSegmentTypeStrings.dumbbellTricepsExtensionTwoArm
        case .elliptical: ExerciseSegmentTypeStrings.elliptical
        case .forwardTwist: ExerciseSegmentTypeStrings.forwardTwist
        case .frontRaise: ExerciseSegmentTypeStrings.frontRaise
        case .highIntensityIntervalTraining: ExerciseSegmentTypeStrings.highIntensityIntervalTraining
        case .hipThrust: ExerciseSegmentTypeStrings.hipThrust
        case .hulaHoop: ExerciseSegmentTypeStrings.hulaHoop
        case .jumpingJack: ExerciseSegmentTypeStrings.jumpingJack
        case .jumpRope: ExerciseSegmentTypeStrings.jumpRope
        case .kettlebellSwing: ExerciseSegmentTypeStrings.kettlebellSwing
        case .lateralRaise: ExerciseSegmentTypeStrings.lateralRaise
        case .latPullDown: ExerciseSegmentTypeStrings.latPullDown
        case .legCurl: ExerciseSegmentTypeStrings.legCurl
        case .legExtension: ExerciseSegmentTypeStrings.legExtension
        case .legPress: ExerciseSegmentTypeStrings.legPress
        case .legRaise: ExerciseSegmentTypeStrings.legRaise
        case .lunge: ExerciseSegmentTypeStrings.lunge
        case .mountainClimber: ExerciseSegmentTypeStrings.mountainClimber
        case .otherWorkout: ExerciseSegmentTypeStrings.otherWorkout
        case .pause: ExerciseSegmentTypeStrings.pause
        case .pilates: ExerciseSegmentTypeStrings.pilates
        case .plank: ExerciseSegmentTypeStrings.plank
        case .pullUp: ExerciseSegmentTypeStrings.pullUp
        case .punch: ExerciseSegmentTypeStrings.punch
        case .rest: ExerciseSegmentTypeStrings.rest
        case .rowingMachine: ExerciseSegmentTypeStrings.rowingMachine
        case .running: ExerciseSegmentTypeStrings.running
        case .runningTreadmill: ExerciseSegmentTypeStrings.runningTreadmill
        case .shoulderPress: ExerciseSegmentTypeStrings.shoulderPress
        case .singleArmTricepsExtension: ExerciseSegmentTypeStrings.singleArmTricepsExtension
        case .sitUp: ExerciseSegmentTypeStrings.sitUp
        case .squat: ExerciseSegmentTypeStrings.squat
        case .stairClimbing: ExerciseSegmentTypeStrings.stairClimbing
        case .stairClimbingMachine: ExerciseSegmentTypeStrings.stairClimbingMachine
        case .stretching: ExerciseSegmentTypeStrings.stretching
        case .swimmingBackstroke: ExerciseSegmentTypeStrings.swimmingBackstroke
        case .swimmingBreaststroke: ExerciseSegmentTypeStrings.swimmingBreaststroke
        case .swimmingButterfly: ExerciseSegmentTypeStrings.swimmingButterfly
        case .swimmingFreestyle: ExerciseSegmentTypeStrings.swimmingFreestyle
        case .swimmingMixed: ExerciseSegmentTypeStrings.swimmingMixed
        case .swimmingOpenWater: ExerciseSegmentTypeStrings.swimmingOpenWater
        case .swimmingOther: ExerciseSegmentTypeStrings.swimmingOther
        case .swimmingPool: ExerciseSegmentTypeStrings.swimmingPool
        case .upperTwist: ExerciseSegmentTypeStrings.upperTwist
        case .walking: ExerciseSegmentTypeStrings.walking
        case .weightlifting: ExerciseSegmentTypeStrings.weightlifting
        case .wheelchair: ExerciseSegmentTypeStrings.wheelchair
        case .yoga: ExerciseSegmentTypeStrings.yoga
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case ExerciseSegmentTypeStrings.unknown: .unknown
        case ExerciseSegmentTypeStrings.armCurl: .armCurl
        case ExerciseSegmentTypeStrings.backExtension: .backExtension
        case ExerciseSegmentTypeStrings.ballSlam: .ballSlam
        case ExerciseSegmentTypeStrings.barbellShoulderPress: .barbellShoulderPress
        case ExerciseSegmentTypeStrings.benchPress: .benchPress
        case ExerciseSegmentTypeStrings.benchSitUp: .benchSitUp
        case ExerciseSegmentTypeStrings.biking: .biking
        case ExerciseSegmentTypeStrings.bikingStationary: .bikingStationary
        case ExerciseSegmentTypeStrings.burpee: .burpee
        case ExerciseSegmentTypeStrings.crunch: .crunch
        case ExerciseSegmentTypeStrings.deadlift: .deadlift
        case ExerciseSegmentTypeStrings.doubleArmTricepsExtension: .doubleArmTricepsExtension
        case ExerciseSegmentTypeStrings.dumbbellCurlLeftArm: .dumbbellCurlLeftArm
        case ExerciseSegmentTypeStrings.dumbbellCurlRightArm: .dumbbellCurlRightArm
        case ExerciseSegmentTypeStrings.dumbbellFrontRaise: .dumbbellFrontRaise
        case ExerciseSegmentTypeStrings.dumbbellLateralRaise: .dumbbellLateralRaise
        case ExerciseSegmentTypeStrings.dumbbellRow: .dumbbellRow
        case ExerciseSegmentTypeStrings.dumbbellTricepsExtensionLeftArm: .dumbbellTricepsExtensionLeftArm
        case ExerciseSegmentTypeStrings.dumbbellTricepsExtensionRightArm: .dumbbellTricepsExtensionRightArm
        case ExerciseSegmentTypeStrings.dumbbellTricepsExtensionTwoArm: .dumbbellTricepsExtensionTwoArm
        case ExerciseSegmentTypeStrings.elliptical: .elliptical
        case ExerciseSegmentTypeStrings.forwardTwist: .forwardTwist
        case ExerciseSegmentTypeStrings.frontRaise: .frontRaise
        case ExerciseSegmentTypeStrings.highIntensityIntervalTraining: .highIntensityIntervalTraining
        case ExerciseSegmentTypeStrings.hipThrust: .hipThrust
        case ExerciseSegmentTypeStrings.hulaHoop: .hulaHoop
        case ExerciseSegmentTypeStrings.jumpingJack: .jumpingJack
        case ExerciseSegmentTypeStrings.jumpRope: .jumpRope
        case ExerciseSegmentTypeStrings.kettlebellSwing: .kettlebellSwing
        case ExerciseSegmentTypeStrings.lateralRaise: .lateralRaise
        case ExerciseSegmentTypeStrings.latPullDown: .latPullDown
        case ExerciseSegmentTypeStrings.legCurl: .legCurl
        case ExerciseSegmentTypeStrings.legExtension: .legExtension
        case ExerciseSegmentTypeStrings.legPress: .legPress
        case ExerciseSegmentTypeStrings.legRaise: .legRaise
        case ExerciseSegmentTypeStrings.lunge: .lunge
        case ExerciseSegmentTypeStrings.mountainClimber: .mountainClimber
        case ExerciseSegmentTypeStrings.otherWorkout: .otherWorkout
        case ExerciseSegmentTypeStrings.pause: .pause
        case ExerciseSegmentTypeStrings.pilates: .pilates
        case ExerciseSegmentTypeStrings.plank: .plank
        case ExerciseSegmentTypeStrings.pullUp: .pullUp
        case ExerciseSegmentTypeStrings.punch: .punch
        case ExerciseSegmentTypeStrings.rest: .rest
        case ExerciseSegmentTypeStrings.rowingMachine: .rowingMachine
        case ExerciseSegmentTypeStrings.running: .running
        case ExerciseSegmentTypeStrings.runningTreadmill: .runningTreadmill
        case ExerciseSegmentTypeStrings.shoulderPress: .shoulderPress
        case ExerciseSegmentTypeStrings.singleArmTricepsExtension: .singleArmTricepsExtension
        case ExerciseSegmentTypeStrings.sitUp: .sitUp
        case ExerciseSegmentTypeStrings.squat: .squat
        case ExerciseSegmentTypeStrings.stairClimbing: .stairClimbing
        case ExerciseSegmentTypeStrings.stairClimbingMachine: .stairClimbingMachine
        case ExerciseSegmentTypeStrings.stretching: .stretching
        case ExerciseSegmentTypeStrings.swimmingBackstroke: .swimmingBackstroke
        case ExerciseSegmentTypeStrings.swimmingBreaststroke: .swimmingBreaststroke
        case ExerciseSegmentTypeStrings.swimmingButterfly: .swimmingButterfly
        case ExerciseSegmentTypeStrings.swimmingFreestyle: .swimmingFreestyle
        case ExerciseSegmentTypeStrings.swimmingMixed: .swimmingMixed
        case ExerciseSegmentTypeStrings.swimmingOpenWater: .swimmingOpenWater
        case ExerciseSegmentTypeStrings.swimmingOther: .swimmingOther
        case ExerciseSegmentTypeStrings.swimmingPool: .swimmingPool
        case ExerciseSegmentTypeStrings.upperTwist: .upperTwist
        case ExerciseSegmentTypeStrings.walking: .walking
        case ExerciseSegmentTypeStrings.weightlifting: .weightlifting
        case ExerciseSegmentTypeStrings.wheelchair: .wheelchair
        case ExerciseSegmentTypeStrings.yoga: .yoga
        default: nil
        }
    }
}

// MARK: - Exercise Session Metadata Keys

/// Custom metadata key for storing workout title.
///
/// ## Why this exists
///
/// HealthKit does not have a standard metadata key for workout titles.
/// We use a custom key to preserve user-entered titles across the platform bridge.
enum ExerciseSessionTitleKey: CustomMetadataKey {
    typealias Value = String

    static let keySuffix = "workout_title"

    static func serialize(_ value: String) -> Any { value }
    static func deserialize(_ rawValue: Any?) -> String? { rawValue as? String }
}

/// Custom metadata key for storing workout notes.
///
/// ## Why this exists
///
/// HealthKit does not have a standard metadata key for workout notes.
/// We use a custom key to preserve user-entered notes across the platform bridge.
enum ExerciseSessionNotesKey: CustomMetadataKey {
    typealias Value = String

    static let keySuffix = "workout_notes"

    static func serialize(_ value: String) -> Any { value }
    static func deserialize(_ rawValue: Any?) -> String? { rawValue as? String }
}

/// Custom metadata key for storing exercise segment type.
///
/// ## Why this exists
///
/// HealthKit HKWorkoutEvent with .segment type doesn't natively store segment type.
/// We use a custom key to preserve Android ExerciseSegment segmentType across platforms.
enum ExerciseSegmentTypeKey: StringEnumMetadataKey {
    typealias Value = ExerciseSegmentTypeDto

    static let keySuffix = "segment_type"
    static let defaultValue: ExerciseSegmentTypeDto = .unknown
}

/// Custom metadata key for storing segment repetitions.
///
/// ## Why this exists
///
/// HealthKit HKWorkoutEvent doesn't natively support repetition counts.
/// We use a custom key to preserve Android ExerciseSegment repetitions across platforms.
enum ExerciseSegmentRepetitionsKey: CustomMetadataKey {
    typealias Value = Int

    static let keySuffix = "repetitions"

    static func serialize(_ value: Int) -> Any { NSNumber(value: value) }
    static func deserialize(_ rawValue: Any?) -> Int? {
        (rawValue as? NSNumber)?.intValue
    }
}

/// Custom metadata key for storing lap distance.
///
/// ## Why this exists
///
/// HealthKit HKWorkoutEvent with .lap type doesn't natively store distance.
/// We use a custom key to preserve Android ExerciseLap length across platforms.
enum ExerciseLapDistanceKey: CustomMetadataKey {
    typealias Value = Double

    static let keySuffix = "lap_distance"

    static func serialize(_ value: Double) -> Any {
        HKQuantity(unit: .meter(), doubleValue: value)
    }

    static func deserialize(_ rawValue: Any?) -> Double? {
        (rawValue as? HKQuantity)?.doubleValue(for: .meter())
    }
}
