package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseSessionRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toExerciseTypeDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnectExerciseType
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseTypeDto
import io.kotest.matchers.shouldBe
import java.util.stream.Stream
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

@DisplayName("ExerciseTypeMapper")
class ExerciseTypeMapperTest {

    @ParameterizedTest
    @MethodSource("provideCyclingMappings")
    @DisplayName("GIVEN cycling DTO → WHEN mapped → THEN returns Health Connect type")
    fun whenCyclingDtoToHealthConnect_thenMapsCorrectly(
        dto: ExerciseTypeDto,
        expectedHealthConnectType: Int,
    ) {
        dto.toHealthConnectExerciseType() shouldBe expectedHealthConnectType
    }

    @ParameterizedTest
    @MethodSource("provideCyclingMappings")
    @DisplayName("GIVEN Health Connect cycling type → WHEN mapped → THEN returns DTO")
    fun whenHealthConnectCyclingToDto_thenMapsCorrectly(
        expectedDto: ExerciseTypeDto,
        healthConnectType: Int,
    ) {
        healthConnectType.toExerciseTypeDto() shouldBe expectedDto
    }

    companion object {
        @JvmStatic
        fun provideCyclingMappings(): Stream<Arguments> = Stream.of(
            Arguments.of(
                ExerciseTypeDto.CYCLING,
                ExerciseSessionRecord.EXERCISE_TYPE_BIKING,
            ),
            Arguments.of(
                ExerciseTypeDto.CYCLING_STATIONARY,
                ExerciseSessionRecord.EXERCISE_TYPE_BIKING_STATIONARY,
            ),
        )
    }
}
