package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseSessionRecord
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseTypeDto

/**
 * Maps [ExerciseTypeDto] to Health Connect exercise type integer constant.
 *
 * @throws IllegalArgumentException if the exercise type is not supported on Android Health Connect
 */
internal fun ExerciseTypeDto.toHealthConnectExerciseType(): Int = when (this) {
    // Cardio & Walking/Running
    ExerciseTypeDto.RUNNING -> ExerciseSessionRecord.EXERCISE_TYPE_RUNNING
    ExerciseTypeDto.RUNNING_TREADMILL -> ExerciseSessionRecord.EXERCISE_TYPE_RUNNING_TREADMILL
    ExerciseTypeDto.WALKING -> ExerciseSessionRecord.EXERCISE_TYPE_WALKING
    ExerciseTypeDto.CYCLING -> ExerciseSessionRecord.EXERCISE_TYPE_BIKING
    ExerciseTypeDto.CYCLING_STATIONARY -> ExerciseSessionRecord.EXERCISE_TYPE_BIKING_STATIONARY
    ExerciseTypeDto.HIKING -> ExerciseSessionRecord.EXERCISE_TYPE_HIKING

    // Water Sports
    ExerciseTypeDto.SWIMMING_OPEN_WATER -> ExerciseSessionRecord.EXERCISE_TYPE_SWIMMING_OPEN_WATER
    ExerciseTypeDto.SWIMMING_POOL -> ExerciseSessionRecord.EXERCISE_TYPE_SWIMMING_POOL
    ExerciseTypeDto.SURFING -> ExerciseSessionRecord.EXERCISE_TYPE_SURFING
    ExerciseTypeDto.WATER_POLO -> ExerciseSessionRecord.EXERCISE_TYPE_WATER_POLO
    ExerciseTypeDto.ROWING -> ExerciseSessionRecord.EXERCISE_TYPE_ROWING
    ExerciseTypeDto.SAILING -> ExerciseSessionRecord.EXERCISE_TYPE_SAILING
    ExerciseTypeDto.PADDLING -> ExerciseSessionRecord.EXERCISE_TYPE_PADDLING
    ExerciseTypeDto.DIVING -> ExerciseSessionRecord.EXERCISE_TYPE_SCUBA_DIVING

    // Strength Training
    ExerciseTypeDto.STRENGTH_TRAINING -> ExerciseSessionRecord.EXERCISE_TYPE_STRENGTH_TRAINING
    ExerciseTypeDto.WEIGHTLIFTING -> ExerciseSessionRecord.EXERCISE_TYPE_WEIGHTLIFTING
    ExerciseTypeDto.CALISTHENICS -> ExerciseSessionRecord.EXERCISE_TYPE_CALISTHENICS

    // Team Sports
    ExerciseTypeDto.BASKETBALL -> ExerciseSessionRecord.EXERCISE_TYPE_BASKETBALL
    ExerciseTypeDto.SOCCER -> ExerciseSessionRecord.EXERCISE_TYPE_SOCCER
    ExerciseTypeDto.AMERICAN_FOOTBALL -> ExerciseSessionRecord.EXERCISE_TYPE_FOOTBALL_AMERICAN
    ExerciseTypeDto.FRISBEE_DISC -> ExerciseSessionRecord.EXERCISE_TYPE_FRISBEE_DISC
    ExerciseTypeDto.AUSTRALIAN_FOOTBALL -> ExerciseSessionRecord.EXERCISE_TYPE_FOOTBALL_AUSTRALIAN
    ExerciseTypeDto.BASEBALL -> ExerciseSessionRecord.EXERCISE_TYPE_BASEBALL
    ExerciseTypeDto.SOFTBALL -> ExerciseSessionRecord.EXERCISE_TYPE_SOFTBALL
    ExerciseTypeDto.VOLLEYBALL -> ExerciseSessionRecord.EXERCISE_TYPE_VOLLEYBALL
    ExerciseTypeDto.RUGBY -> ExerciseSessionRecord.EXERCISE_TYPE_RUGBY
    ExerciseTypeDto.CRICKET -> ExerciseSessionRecord.EXERCISE_TYPE_CRICKET
    ExerciseTypeDto.HANDBALL -> ExerciseSessionRecord.EXERCISE_TYPE_HANDBALL
    ExerciseTypeDto.ICE_HOCKEY -> ExerciseSessionRecord.EXERCISE_TYPE_ICE_HOCKEY
    ExerciseTypeDto.ROLLER_HOCKEY -> ExerciseSessionRecord.EXERCISE_TYPE_ROLLER_HOCKEY
    ExerciseTypeDto.HOCKEY -> ExerciseSessionRecord.EXERCISE_TYPE_ICE_HOCKEY

    // Racquet Sports
    ExerciseTypeDto.TENNIS -> ExerciseSessionRecord.EXERCISE_TYPE_TENNIS
    ExerciseTypeDto.TABLE_TENNIS -> ExerciseSessionRecord.EXERCISE_TYPE_TABLE_TENNIS
    ExerciseTypeDto.BADMINTON -> ExerciseSessionRecord.EXERCISE_TYPE_BADMINTON
    ExerciseTypeDto.SQUASH -> ExerciseSessionRecord.EXERCISE_TYPE_SQUASH
    ExerciseTypeDto.RACQUETBALL -> ExerciseSessionRecord.EXERCISE_TYPE_RACQUETBALL

    // Winter Sports
    ExerciseTypeDto.SKIING -> ExerciseSessionRecord.EXERCISE_TYPE_SKIING
    ExerciseTypeDto.SNOWBOARDING -> ExerciseSessionRecord.EXERCISE_TYPE_SNOWBOARDING
    ExerciseTypeDto.SNOWSHOEING -> ExerciseSessionRecord.EXERCISE_TYPE_SNOWSHOEING
    ExerciseTypeDto.SKATING -> ExerciseSessionRecord.EXERCISE_TYPE_SKATING

    // Martial Arts & Combat Sports
    ExerciseTypeDto.BOXING -> ExerciseSessionRecord.EXERCISE_TYPE_BOXING
    ExerciseTypeDto.KICKBOXING -> ExerciseSessionRecord.EXERCISE_TYPE_MARTIAL_ARTS
    ExerciseTypeDto.MARTIAL_ARTS -> ExerciseSessionRecord.EXERCISE_TYPE_MARTIAL_ARTS
    ExerciseTypeDto.WRESTLING -> ExerciseSessionRecord.EXERCISE_TYPE_MARTIAL_ARTS
    ExerciseTypeDto.FENCING -> ExerciseSessionRecord.EXERCISE_TYPE_FENCING

    // Dance & Gymnastics
    ExerciseTypeDto.DANCING -> ExerciseSessionRecord.EXERCISE_TYPE_DANCING
    ExerciseTypeDto.GYMNASTICS -> ExerciseSessionRecord.EXERCISE_TYPE_GYMNASTICS

    // Fitness & Conditioning
    ExerciseTypeDto.YOGA -> ExerciseSessionRecord.EXERCISE_TYPE_YOGA
    ExerciseTypeDto.PILATES -> ExerciseSessionRecord.EXERCISE_TYPE_PILATES
    ExerciseTypeDto.HIGH_INTENSITY_INTERVAL_TRAINING ->
        ExerciseSessionRecord.EXERCISE_TYPE_HIGH_INTENSITY_INTERVAL_TRAINING
    ExerciseTypeDto.ELLIPTICAL -> ExerciseSessionRecord.EXERCISE_TYPE_ELLIPTICAL
    ExerciseTypeDto.EXERCISE_CLASS -> ExerciseSessionRecord.EXERCISE_TYPE_EXERCISE_CLASS
    ExerciseTypeDto.BOOT_CAMP -> ExerciseSessionRecord.EXERCISE_TYPE_BOOT_CAMP
    ExerciseTypeDto.GUIDED_BREATHING -> ExerciseSessionRecord.EXERCISE_TYPE_GUIDED_BREATHING
    ExerciseTypeDto.STAIR_CLIMBING -> ExerciseSessionRecord.EXERCISE_TYPE_STAIR_CLIMBING
    ExerciseTypeDto.FLEXIBILITY -> ExerciseSessionRecord.EXERCISE_TYPE_STRETCHING

    // Golf & Precision Sports
    ExerciseTypeDto.GOLF -> ExerciseSessionRecord.EXERCISE_TYPE_GOLF

    // Outdoor & Adventure
    ExerciseTypeDto.PARAGLIDING -> ExerciseSessionRecord.EXERCISE_TYPE_PARAGLIDING
    ExerciseTypeDto.CLIMBING -> ExerciseSessionRecord.EXERCISE_TYPE_ROCK_CLIMBING

    // Wheelchair Activities
    ExerciseTypeDto.WHEELCHAIR -> ExerciseSessionRecord.EXERCISE_TYPE_WHEELCHAIR

    // Unknown fallback
    ExerciseTypeDto.OTHER -> ExerciseSessionRecord.EXERCISE_TYPE_OTHER_WORKOUT
}

/**
 * Maps Health Connect exercise type integer to [ExerciseTypeDto].
 *
 * @return The corresponding ExerciseTypeDto, or UNKNOWN for unrecognized types
 */
internal fun Int.toExerciseTypeDto(): ExerciseTypeDto = when (this) {
    // Cardio & Walking/Running
    ExerciseSessionRecord.EXERCISE_TYPE_RUNNING -> ExerciseTypeDto.RUNNING
    ExerciseSessionRecord.EXERCISE_TYPE_RUNNING_TREADMILL -> ExerciseTypeDto.RUNNING_TREADMILL
    ExerciseSessionRecord.EXERCISE_TYPE_WALKING -> ExerciseTypeDto.WALKING
    ExerciseSessionRecord.EXERCISE_TYPE_BIKING -> ExerciseTypeDto.CYCLING
    ExerciseSessionRecord.EXERCISE_TYPE_BIKING_STATIONARY -> ExerciseTypeDto.CYCLING_STATIONARY
    ExerciseSessionRecord.EXERCISE_TYPE_HIKING -> ExerciseTypeDto.HIKING

    // Water Sports
    ExerciseSessionRecord.EXERCISE_TYPE_SWIMMING_POOL -> ExerciseTypeDto.SWIMMING_POOL
    ExerciseSessionRecord.EXERCISE_TYPE_SWIMMING_OPEN_WATER -> ExerciseTypeDto.SWIMMING_OPEN_WATER
    ExerciseSessionRecord.EXERCISE_TYPE_SURFING -> ExerciseTypeDto.SURFING
    ExerciseSessionRecord.EXERCISE_TYPE_WATER_POLO -> ExerciseTypeDto.WATER_POLO
    ExerciseSessionRecord.EXERCISE_TYPE_ROWING -> ExerciseTypeDto.ROWING
    ExerciseSessionRecord.EXERCISE_TYPE_SAILING -> ExerciseTypeDto.SAILING
    ExerciseSessionRecord.EXERCISE_TYPE_PADDLING -> ExerciseTypeDto.PADDLING
    ExerciseSessionRecord.EXERCISE_TYPE_SCUBA_DIVING -> ExerciseTypeDto.DIVING

    // Strength Training
    ExerciseSessionRecord.EXERCISE_TYPE_STRENGTH_TRAINING -> ExerciseTypeDto.STRENGTH_TRAINING
    ExerciseSessionRecord.EXERCISE_TYPE_WEIGHTLIFTING -> ExerciseTypeDto.WEIGHTLIFTING
    ExerciseSessionRecord.EXERCISE_TYPE_CALISTHENICS -> ExerciseTypeDto.CALISTHENICS

    // Team Sports
    ExerciseSessionRecord.EXERCISE_TYPE_BASKETBALL -> ExerciseTypeDto.BASKETBALL
    ExerciseSessionRecord.EXERCISE_TYPE_SOCCER -> ExerciseTypeDto.SOCCER
    ExerciseSessionRecord.EXERCISE_TYPE_FOOTBALL_AMERICAN -> ExerciseTypeDto.AMERICAN_FOOTBALL
    ExerciseSessionRecord.EXERCISE_TYPE_FRISBEE_DISC -> ExerciseTypeDto.FRISBEE_DISC
    ExerciseSessionRecord.EXERCISE_TYPE_FOOTBALL_AUSTRALIAN -> ExerciseTypeDto.AUSTRALIAN_FOOTBALL
    ExerciseSessionRecord.EXERCISE_TYPE_BASEBALL -> ExerciseTypeDto.BASEBALL
    ExerciseSessionRecord.EXERCISE_TYPE_SOFTBALL -> ExerciseTypeDto.SOFTBALL
    ExerciseSessionRecord.EXERCISE_TYPE_VOLLEYBALL -> ExerciseTypeDto.VOLLEYBALL
    ExerciseSessionRecord.EXERCISE_TYPE_RUGBY -> ExerciseTypeDto.RUGBY
    ExerciseSessionRecord.EXERCISE_TYPE_CRICKET -> ExerciseTypeDto.CRICKET
    ExerciseSessionRecord.EXERCISE_TYPE_HANDBALL -> ExerciseTypeDto.HANDBALL
    ExerciseSessionRecord.EXERCISE_TYPE_ICE_HOCKEY -> ExerciseTypeDto.ICE_HOCKEY
    ExerciseSessionRecord.EXERCISE_TYPE_ROLLER_HOCKEY -> ExerciseTypeDto.ROLLER_HOCKEY

    // Racquet Sports
    ExerciseSessionRecord.EXERCISE_TYPE_TENNIS -> ExerciseTypeDto.TENNIS
    ExerciseSessionRecord.EXERCISE_TYPE_TABLE_TENNIS -> ExerciseTypeDto.TABLE_TENNIS
    ExerciseSessionRecord.EXERCISE_TYPE_BADMINTON -> ExerciseTypeDto.BADMINTON
    ExerciseSessionRecord.EXERCISE_TYPE_SQUASH -> ExerciseTypeDto.SQUASH
    ExerciseSessionRecord.EXERCISE_TYPE_RACQUETBALL -> ExerciseTypeDto.RACQUETBALL

    // Winter Sports
    ExerciseSessionRecord.EXERCISE_TYPE_SKIING -> ExerciseTypeDto.SKIING
    ExerciseSessionRecord.EXERCISE_TYPE_SNOWBOARDING -> ExerciseTypeDto.SNOWBOARDING
    ExerciseSessionRecord.EXERCISE_TYPE_SNOWSHOEING -> ExerciseTypeDto.SNOWSHOEING
    ExerciseSessionRecord.EXERCISE_TYPE_SKATING -> ExerciseTypeDto.SKATING
    ExerciseSessionRecord.EXERCISE_TYPE_ICE_SKATING -> ExerciseTypeDto.SKATING

    // Martial Arts & Combat Sports
    ExerciseSessionRecord.EXERCISE_TYPE_BOXING -> ExerciseTypeDto.BOXING
    ExerciseSessionRecord.EXERCISE_TYPE_MARTIAL_ARTS -> ExerciseTypeDto.MARTIAL_ARTS
    ExerciseSessionRecord.EXERCISE_TYPE_FENCING -> ExerciseTypeDto.FENCING

    // Dance & Gymnastics
    ExerciseSessionRecord.EXERCISE_TYPE_DANCING -> ExerciseTypeDto.DANCING
    ExerciseSessionRecord.EXERCISE_TYPE_GYMNASTICS -> ExerciseTypeDto.GYMNASTICS

    // Fitness & Conditioning
    ExerciseSessionRecord.EXERCISE_TYPE_YOGA -> ExerciseTypeDto.YOGA
    ExerciseSessionRecord.EXERCISE_TYPE_PILATES -> ExerciseTypeDto.PILATES
    ExerciseSessionRecord.EXERCISE_TYPE_HIGH_INTENSITY_INTERVAL_TRAINING ->
        ExerciseTypeDto.HIGH_INTENSITY_INTERVAL_TRAINING
    ExerciseSessionRecord.EXERCISE_TYPE_ELLIPTICAL -> ExerciseTypeDto.ELLIPTICAL
    ExerciseSessionRecord.EXERCISE_TYPE_EXERCISE_CLASS -> ExerciseTypeDto.EXERCISE_CLASS
    ExerciseSessionRecord.EXERCISE_TYPE_BOOT_CAMP -> ExerciseTypeDto.BOOT_CAMP
    ExerciseSessionRecord.EXERCISE_TYPE_STAIR_CLIMBING -> ExerciseTypeDto.STAIR_CLIMBING
    ExerciseSessionRecord.EXERCISE_TYPE_STRETCHING -> ExerciseTypeDto.FLEXIBILITY

    // Golf & Precision Sports
    ExerciseSessionRecord.EXERCISE_TYPE_GOLF -> ExerciseTypeDto.GOLF

    // Outdoor & Adventure
    ExerciseSessionRecord.EXERCISE_TYPE_PARAGLIDING -> ExerciseTypeDto.PARAGLIDING
    ExerciseSessionRecord.EXERCISE_TYPE_ROCK_CLIMBING -> ExerciseTypeDto.CLIMBING

    // Wheelchair Activities
    ExerciseSessionRecord.EXERCISE_TYPE_WHEELCHAIR -> ExerciseTypeDto.WHEELCHAIR

    // Fallback for unknown types
    else -> throw IllegalArgumentException("Unsupported exercise type: $this")
}
