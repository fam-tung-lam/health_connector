package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseSegment
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSegmentTypeDto
import kotlin.jvm.Throws

/**
 * Maps [ExerciseSegmentTypeDto] to Health Connect exercise segment type integer constant.
 */
internal fun ExerciseSegmentTypeDto.toHealthConnect(): Int = when (this) {
    ExerciseSegmentTypeDto.UNKNOWN -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_UNKNOWN
    ExerciseSegmentTypeDto.ARM_CURL -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_ARM_CURL
    ExerciseSegmentTypeDto.BACK_EXTENSION -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_BACK_EXTENSION
    ExerciseSegmentTypeDto.BALL_SLAM -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_BALL_SLAM
    ExerciseSegmentTypeDto.BARBELL_SHOULDER_PRESS ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_BARBELL_SHOULDER_PRESS

    ExerciseSegmentTypeDto.BENCH_PRESS -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_BENCH_PRESS
    ExerciseSegmentTypeDto.BENCH_SIT_UP -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_BENCH_SIT_UP
    ExerciseSegmentTypeDto.BIKING -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_BIKING
    ExerciseSegmentTypeDto.BIKING_STATIONARY ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_BIKING_STATIONARY

    ExerciseSegmentTypeDto.BURPEE -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_BURPEE
    ExerciseSegmentTypeDto.CRUNCH -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_CRUNCH
    ExerciseSegmentTypeDto.DEADLIFT -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_DEADLIFT
    ExerciseSegmentTypeDto.DOUBLE_ARM_TRICEPS_EXTENSION ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_DOUBLE_ARM_TRICEPS_EXTENSION

    ExerciseSegmentTypeDto.DUMBBELL_CURL_LEFT_ARM ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_CURL_LEFT_ARM

    ExerciseSegmentTypeDto.DUMBBELL_CURL_RIGHT_ARM ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_CURL_RIGHT_ARM

    ExerciseSegmentTypeDto.DUMBBELL_FRONT_RAISE ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_FRONT_RAISE

    ExerciseSegmentTypeDto.DUMBBELL_LATERAL_RAISE ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_LATERAL_RAISE

    ExerciseSegmentTypeDto.DUMBBELL_ROW -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_ROW
    ExerciseSegmentTypeDto.DUMBBELL_TRICEPS_EXTENSION_LEFT_ARM ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_TRICEPS_EXTENSION_LEFT_ARM

    ExerciseSegmentTypeDto.DUMBBELL_TRICEPS_EXTENSION_RIGHT_ARM ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_TRICEPS_EXTENSION_RIGHT_ARM

    ExerciseSegmentTypeDto.DUMBBELL_TRICEPS_EXTENSION_TWO_ARM ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_TRICEPS_EXTENSION_TWO_ARM

    ExerciseSegmentTypeDto.ELLIPTICAL -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_ELLIPTICAL
    ExerciseSegmentTypeDto.FORWARD_TWIST -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_FORWARD_TWIST
    ExerciseSegmentTypeDto.FRONT_RAISE -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_FRONT_RAISE
    ExerciseSegmentTypeDto.HIGH_INTENSITY_INTERVAL_TRAINING ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_HIGH_INTENSITY_INTERVAL_TRAINING

    ExerciseSegmentTypeDto.HIP_THRUST -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_HIP_THRUST
    ExerciseSegmentTypeDto.HULA_HOOP -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_HULA_HOOP
    ExerciseSegmentTypeDto.JUMPING_JACK -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_JUMPING_JACK
    ExerciseSegmentTypeDto.JUMP_ROPE -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_JUMP_ROPE
    ExerciseSegmentTypeDto.KETTLEBELL_SWING ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_KETTLEBELL_SWING

    ExerciseSegmentTypeDto.LATERAL_RAISE -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_LATERAL_RAISE
    ExerciseSegmentTypeDto.LAT_PULL_DOWN -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_LAT_PULL_DOWN
    ExerciseSegmentTypeDto.LEG_CURL -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_CURL
    ExerciseSegmentTypeDto.LEG_EXTENSION -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_EXTENSION
    ExerciseSegmentTypeDto.LEG_PRESS -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_PRESS
    ExerciseSegmentTypeDto.LEG_RAISE -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_RAISE
    ExerciseSegmentTypeDto.LUNGE -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_LUNGE
    ExerciseSegmentTypeDto.MOUNTAIN_CLIMBER ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_MOUNTAIN_CLIMBER

    ExerciseSegmentTypeDto.OTHER_WORKOUT -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_OTHER_WORKOUT
    ExerciseSegmentTypeDto.PAUSE -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_PAUSE
    ExerciseSegmentTypeDto.PILATES -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_PILATES
    ExerciseSegmentTypeDto.PLANK -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_PLANK
    ExerciseSegmentTypeDto.PULL_UP -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_PULL_UP
    ExerciseSegmentTypeDto.PUNCH -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_PUNCH
    ExerciseSegmentTypeDto.REST -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_REST
    ExerciseSegmentTypeDto.ROWING_MACHINE -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_ROWING_MACHINE
    ExerciseSegmentTypeDto.RUNNING -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_RUNNING
    ExerciseSegmentTypeDto.RUNNING_TREADMILL ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_RUNNING_TREADMILL

    ExerciseSegmentTypeDto.SHOULDER_PRESS -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_SHOULDER_PRESS
    ExerciseSegmentTypeDto.SINGLE_ARM_TRICEPS_EXTENSION ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_SINGLE_ARM_TRICEPS_EXTENSION

    ExerciseSegmentTypeDto.SIT_UP -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_SIT_UP
    ExerciseSegmentTypeDto.SQUAT -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_SQUAT
    ExerciseSegmentTypeDto.STAIR_CLIMBING -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_STAIR_CLIMBING
    ExerciseSegmentTypeDto.STAIR_CLIMBING_MACHINE ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_STAIR_CLIMBING_MACHINE

    ExerciseSegmentTypeDto.STRETCHING -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_STRETCHING
    ExerciseSegmentTypeDto.SWIMMING_BACKSTROKE ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_BACKSTROKE

    ExerciseSegmentTypeDto.SWIMMING_BREASTSTROKE ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_BREASTSTROKE

    ExerciseSegmentTypeDto.SWIMMING_BUTTERFLY ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_BUTTERFLY

    ExerciseSegmentTypeDto.SWIMMING_FREESTYLE ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_FREESTYLE

    ExerciseSegmentTypeDto.SWIMMING_MIXED -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_MIXED
    ExerciseSegmentTypeDto.SWIMMING_OPEN_WATER ->
        ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_OPEN_WATER

    ExerciseSegmentTypeDto.SWIMMING_OTHER -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_OTHER
    ExerciseSegmentTypeDto.SWIMMING_POOL -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_POOL
    ExerciseSegmentTypeDto.UPPER_TWIST -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_UPPER_TWIST
    ExerciseSegmentTypeDto.WALKING -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_WALKING
    ExerciseSegmentTypeDto.WEIGHTLIFTING -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_WEIGHTLIFTING
    ExerciseSegmentTypeDto.WHEELCHAIR -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_WHEELCHAIR
    ExerciseSegmentTypeDto.YOGA -> ExerciseSegment.EXERCISE_SEGMENT_TYPE_YOGA
}

/**
 * Maps Health Connect exercise segment type integer constant to [ExerciseSegmentTypeDto].
 *
 * @throws IllegalArgumentException if the segment type is not supported
 */
@Throws(IllegalArgumentException::class)
internal fun Int.toExerciseSegmentTypeDto(): ExerciseSegmentTypeDto = when (this) {
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_UNKNOWN -> ExerciseSegmentTypeDto.UNKNOWN
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_ARM_CURL -> ExerciseSegmentTypeDto.ARM_CURL
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_BACK_EXTENSION -> ExerciseSegmentTypeDto.BACK_EXTENSION
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_BALL_SLAM -> ExerciseSegmentTypeDto.BALL_SLAM
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_BARBELL_SHOULDER_PRESS ->
        ExerciseSegmentTypeDto.BARBELL_SHOULDER_PRESS

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_BENCH_PRESS -> ExerciseSegmentTypeDto.BENCH_PRESS
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_BENCH_SIT_UP -> ExerciseSegmentTypeDto.BENCH_SIT_UP
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_BIKING -> ExerciseSegmentTypeDto.BIKING
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_BIKING_STATIONARY ->
        ExerciseSegmentTypeDto.BIKING_STATIONARY

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_BURPEE -> ExerciseSegmentTypeDto.BURPEE
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_CRUNCH -> ExerciseSegmentTypeDto.CRUNCH
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_DEADLIFT -> ExerciseSegmentTypeDto.DEADLIFT
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_DOUBLE_ARM_TRICEPS_EXTENSION ->
        ExerciseSegmentTypeDto.DOUBLE_ARM_TRICEPS_EXTENSION

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_CURL_LEFT_ARM ->
        ExerciseSegmentTypeDto.DUMBBELL_CURL_LEFT_ARM

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_CURL_RIGHT_ARM ->
        ExerciseSegmentTypeDto.DUMBBELL_CURL_RIGHT_ARM

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_FRONT_RAISE ->
        ExerciseSegmentTypeDto.DUMBBELL_FRONT_RAISE

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_LATERAL_RAISE ->
        ExerciseSegmentTypeDto.DUMBBELL_LATERAL_RAISE

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_ROW ->
        ExerciseSegmentTypeDto.DUMBBELL_ROW

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_TRICEPS_EXTENSION_LEFT_ARM ->
        ExerciseSegmentTypeDto.DUMBBELL_TRICEPS_EXTENSION_LEFT_ARM

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_TRICEPS_EXTENSION_RIGHT_ARM ->
        ExerciseSegmentTypeDto.DUMBBELL_TRICEPS_EXTENSION_RIGHT_ARM

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_TRICEPS_EXTENSION_TWO_ARM ->
        ExerciseSegmentTypeDto.DUMBBELL_TRICEPS_EXTENSION_TWO_ARM

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_ELLIPTICAL -> ExerciseSegmentTypeDto.ELLIPTICAL
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_FORWARD_TWIST -> ExerciseSegmentTypeDto.FORWARD_TWIST
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_FRONT_RAISE -> ExerciseSegmentTypeDto.FRONT_RAISE
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_HIGH_INTENSITY_INTERVAL_TRAINING ->
        ExerciseSegmentTypeDto.HIGH_INTENSITY_INTERVAL_TRAINING

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_HIP_THRUST -> ExerciseSegmentTypeDto.HIP_THRUST
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_HULA_HOOP -> ExerciseSegmentTypeDto.HULA_HOOP
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_JUMPING_JACK -> ExerciseSegmentTypeDto.JUMPING_JACK
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_JUMP_ROPE -> ExerciseSegmentTypeDto.JUMP_ROPE
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_KETTLEBELL_SWING ->
        ExerciseSegmentTypeDto.KETTLEBELL_SWING

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_LATERAL_RAISE -> ExerciseSegmentTypeDto.LATERAL_RAISE
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_LAT_PULL_DOWN -> ExerciseSegmentTypeDto.LAT_PULL_DOWN
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_CURL -> ExerciseSegmentTypeDto.LEG_CURL
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_EXTENSION -> ExerciseSegmentTypeDto.LEG_EXTENSION
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_PRESS -> ExerciseSegmentTypeDto.LEG_PRESS
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_RAISE -> ExerciseSegmentTypeDto.LEG_RAISE
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_LUNGE -> ExerciseSegmentTypeDto.LUNGE
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_MOUNTAIN_CLIMBER ->
        ExerciseSegmentTypeDto.MOUNTAIN_CLIMBER

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_OTHER_WORKOUT -> ExerciseSegmentTypeDto.OTHER_WORKOUT
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_PAUSE -> ExerciseSegmentTypeDto.PAUSE
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_PILATES -> ExerciseSegmentTypeDto.PILATES
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_PLANK -> ExerciseSegmentTypeDto.PLANK
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_PULL_UP -> ExerciseSegmentTypeDto.PULL_UP
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_PUNCH -> ExerciseSegmentTypeDto.PUNCH
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_REST -> ExerciseSegmentTypeDto.REST
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_ROWING_MACHINE ->
        ExerciseSegmentTypeDto.ROWING_MACHINE

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_RUNNING -> ExerciseSegmentTypeDto.RUNNING
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_RUNNING_TREADMILL ->
        ExerciseSegmentTypeDto.RUNNING_TREADMILL

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SHOULDER_PRESS ->
        ExerciseSegmentTypeDto.SHOULDER_PRESS

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SINGLE_ARM_TRICEPS_EXTENSION ->
        ExerciseSegmentTypeDto.SINGLE_ARM_TRICEPS_EXTENSION

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SIT_UP -> ExerciseSegmentTypeDto.SIT_UP
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SQUAT -> ExerciseSegmentTypeDto.SQUAT
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_STAIR_CLIMBING -> ExerciseSegmentTypeDto.STAIR_CLIMBING
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_STAIR_CLIMBING_MACHINE ->
        ExerciseSegmentTypeDto.STAIR_CLIMBING_MACHINE

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_STRETCHING -> ExerciseSegmentTypeDto.STRETCHING
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_BACKSTROKE ->
        ExerciseSegmentTypeDto.SWIMMING_BACKSTROKE

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_BREASTSTROKE ->
        ExerciseSegmentTypeDto.SWIMMING_BREASTSTROKE

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_BUTTERFLY ->
        ExerciseSegmentTypeDto.SWIMMING_BUTTERFLY

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_FREESTYLE ->
        ExerciseSegmentTypeDto.SWIMMING_FREESTYLE

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_MIXED -> ExerciseSegmentTypeDto.SWIMMING_MIXED
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_OPEN_WATER ->
        ExerciseSegmentTypeDto.SWIMMING_OPEN_WATER

    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_OTHER -> ExerciseSegmentTypeDto.SWIMMING_OTHER
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_POOL -> ExerciseSegmentTypeDto.SWIMMING_POOL
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_UPPER_TWIST -> ExerciseSegmentTypeDto.UPPER_TWIST
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_WALKING -> ExerciseSegmentTypeDto.WALKING
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_WEIGHTLIFTING -> ExerciseSegmentTypeDto.WEIGHTLIFTING
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_WHEELCHAIR -> ExerciseSegmentTypeDto.WHEELCHAIR
    ExerciseSegment.EXERCISE_SEGMENT_TYPE_YOGA -> ExerciseSegmentTypeDto.YOGA
    else -> throw IllegalArgumentException(
        "Unimplemented or unsupported exercise segment type: $this",
    )
}
