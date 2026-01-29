package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseSegment
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toExerciseSegmentTypeDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSegmentTypeDto
import io.kotest.matchers.shouldBe
import java.util.stream.Stream
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

@DisplayName("ExerciseSegmentTypeMapper")
class ExerciseSegmentTypeMapperTest {

    @ParameterizedTest
    @MethodSource("provideExerciseSegmentTypeMappings")
    @DisplayName("GIVEN ExerciseSegmentTypeDto → WHEN toHealthConnect → THEN maps to correct Int")
    fun whenDtoToHealthConnect_thenMapsCorrectly(
        dto: ExerciseSegmentTypeDto,
        expectedHealthConnectType: Int,
    ) {
        dto.toHealthConnect() shouldBe expectedHealthConnectType
    }

    @ParameterizedTest
    @MethodSource("provideExerciseSegmentTypeMappings")
    @DisplayName(
        "GIVEN Health Connect Int → WHEN toExerciseSegmentTypeDto → THEN maps to correct Dto",
    )
    fun whenHealthConnectToDto_thenMapsCorrectly(
        expectedDto: ExerciseSegmentTypeDto,
        healthConnectType: Int,
    ) {
        healthConnectType.toExerciseSegmentTypeDto() shouldBe expectedDto
    }

    @Test
    @DisplayName("GIVEN valid mappings → WHEN mapping round trip → THEN returns original")
    fun testRoundTripMapping() {
        ExerciseSegmentTypeDto.values().forEach { dto ->
            // Skip mappings that might not be supported or have duplicate mappings if any.
            // Based on the source file, it looks like a clean 1:1 mapping.
            val healthConnectType = dto.toHealthConnect()
            val mappedBackDto = healthConnectType.toExerciseSegmentTypeDto()
            mappedBackDto shouldBe dto
        }
    }

    companion object {
        @JvmStatic
        fun provideExerciseSegmentTypeMappings(): Stream<Arguments> = Stream.of(
            Arguments.of(
                ExerciseSegmentTypeDto.UNKNOWN,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_UNKNOWN,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.ARM_CURL,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_ARM_CURL,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.BACK_EXTENSION,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_BACK_EXTENSION,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.BALL_SLAM,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_BALL_SLAM,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.BARBELL_SHOULDER_PRESS,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_BARBELL_SHOULDER_PRESS,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.BENCH_PRESS,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_BENCH_PRESS,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.BENCH_SIT_UP,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_BENCH_SIT_UP,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.BIKING,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_BIKING,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.BIKING_STATIONARY,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_BIKING_STATIONARY,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.BURPEE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_BURPEE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.CRUNCH,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_CRUNCH,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.DEADLIFT,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_DEADLIFT,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.DOUBLE_ARM_TRICEPS_EXTENSION,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_DOUBLE_ARM_TRICEPS_EXTENSION,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.DUMBBELL_CURL_LEFT_ARM,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_CURL_LEFT_ARM,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.DUMBBELL_CURL_RIGHT_ARM,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_CURL_RIGHT_ARM,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.DUMBBELL_FRONT_RAISE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_FRONT_RAISE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.DUMBBELL_LATERAL_RAISE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_LATERAL_RAISE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.DUMBBELL_ROW,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_ROW,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.DUMBBELL_TRICEPS_EXTENSION_LEFT_ARM,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_TRICEPS_EXTENSION_LEFT_ARM,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.DUMBBELL_TRICEPS_EXTENSION_RIGHT_ARM,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_TRICEPS_EXTENSION_RIGHT_ARM,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.DUMBBELL_TRICEPS_EXTENSION_TWO_ARM,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_DUMBBELL_TRICEPS_EXTENSION_TWO_ARM,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.ELLIPTICAL,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_ELLIPTICAL,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.FORWARD_TWIST,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_FORWARD_TWIST,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.FRONT_RAISE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_FRONT_RAISE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.HIGH_INTENSITY_INTERVAL_TRAINING,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_HIGH_INTENSITY_INTERVAL_TRAINING,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.HIP_THRUST,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_HIP_THRUST,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.HULA_HOOP,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_HULA_HOOP,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.JUMPING_JACK,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_JUMPING_JACK,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.JUMP_ROPE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_JUMP_ROPE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.KETTLEBELL_SWING,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_KETTLEBELL_SWING,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.LATERAL_RAISE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_LATERAL_RAISE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.LAT_PULL_DOWN,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_LAT_PULL_DOWN,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.LEG_CURL,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_CURL,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.LEG_EXTENSION,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_EXTENSION,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.LEG_PRESS,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_PRESS,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.LEG_RAISE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_LEG_RAISE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.LUNGE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_LUNGE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.MOUNTAIN_CLIMBER,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_MOUNTAIN_CLIMBER,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.OTHER_WORKOUT,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_OTHER_WORKOUT,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.PAUSE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_PAUSE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.PILATES,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_PILATES,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.PLANK,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_PLANK,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.PULL_UP,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_PULL_UP,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.PUNCH,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_PUNCH,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.REST,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_REST,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.ROWING_MACHINE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_ROWING_MACHINE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.RUNNING,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_RUNNING,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.RUNNING_TREADMILL,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_RUNNING_TREADMILL,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SHOULDER_PRESS,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SHOULDER_PRESS,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SINGLE_ARM_TRICEPS_EXTENSION,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SINGLE_ARM_TRICEPS_EXTENSION,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SIT_UP,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SIT_UP,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SQUAT,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SQUAT,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.STAIR_CLIMBING,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_STAIR_CLIMBING,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.STAIR_CLIMBING_MACHINE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_STAIR_CLIMBING_MACHINE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.STRETCHING,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_STRETCHING,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SWIMMING_BACKSTROKE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_BACKSTROKE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SWIMMING_BREASTSTROKE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_BREASTSTROKE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SWIMMING_BUTTERFLY,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_BUTTERFLY,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SWIMMING_FREESTYLE,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_FREESTYLE,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SWIMMING_MIXED,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_MIXED,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SWIMMING_OPEN_WATER,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_OPEN_WATER,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SWIMMING_OTHER,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_OTHER,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.SWIMMING_POOL,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_SWIMMING_POOL,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.UPPER_TWIST,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_UPPER_TWIST,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.WALKING,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_WALKING,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.WEIGHTLIFTING,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_WEIGHTLIFTING,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.WHEELCHAIR,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_WHEELCHAIR,
            ),
            Arguments.of(
                ExerciseSegmentTypeDto.YOGA,
                ExerciseSegment.EXERCISE_SEGMENT_TYPE_YOGA,
            ),
        )
    }
}
