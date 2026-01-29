package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseLap
import androidx.health.connect.client.records.ExerciseSegment
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSegmentTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionLapEventDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionSegmentEventDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("ExerciseSessionEventMapper")
class ExerciseSessionEventMapperTest {

    private companion object {
        const val TEST_START_TIME = 1609459200000L // 2021-01-01 00:00:00 UTC
        const val TEST_END_TIME = 1609459260000L // 2021-01-01 00:01:00 UTC
        const val TEST_REPETITIONS = 10
        const val TEST_DISTANCE_METERS = 100.0
    }

    @Test
    @DisplayName("GIVEN ExerciseSegment → WHEN toDto → THEN converts correctly")
    fun whenExerciseSegmentToDto_thenConvertsCorrectly() {
        // Given
        val segment = ExerciseSegment(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            segmentType = ExerciseSegment.EXERCISE_SEGMENT_TYPE_RUNNING,
            repetitions = TEST_REPETITIONS,
        )

        // When
        val dto = segment.toDto()

        // Then
        dto.startTime shouldBe TEST_START_TIME
        dto.endTime shouldBe TEST_END_TIME
        dto.segmentType shouldBe ExerciseSegmentTypeDto.RUNNING
        dto.repetitions shouldBe TEST_REPETITIONS.toLong()
    }

    @Test
    @DisplayName("GIVEN ExerciseSegment with 0 repetitions → WHEN toDto → THEN repetitions is null")
    fun whenExerciseSegmentWithZeroRepetitionsToDto_thenRepetitionsIsNull() {
        // Given
        val segment = ExerciseSegment(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            segmentType = ExerciseSegment.EXERCISE_SEGMENT_TYPE_WALKING,
            repetitions = 0,
        )

        // When
        val dto = segment.toDto()

        // Then
        dto.repetitions shouldBe null
    }

    @Test
    @DisplayName("GIVEN ExerciseLap → WHEN toDto → THEN converts correctly")
    fun whenExerciseLapToDto_thenConvertsCorrectly() {
        // Given
        val lap = ExerciseLap(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            length = Length.meters(TEST_DISTANCE_METERS),
        )

        // When
        val dto = lap.toDto()

        // Then
        dto.startTime shouldBe TEST_START_TIME
        dto.endTime shouldBe TEST_END_TIME
        dto.distanceMeters shouldBe TEST_DISTANCE_METERS
    }

    @Test
    @DisplayName(
        "GIVEN ExerciseSessionSegmentEventDto → WHEN toHealthConnect → THEN converts correctly",
    )
    fun whenExerciseSessionSegmentEventDtoToHealthConnect_thenConvertsCorrectly() {
        // Given
        val dto = ExerciseSessionSegmentEventDto(
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            segmentType = ExerciseSegmentTypeDto.SQUAT,
            repetitions = TEST_REPETITIONS.toLong(),
        )

        // When
        val segment = dto.toHealthConnect()

        // Then
        segment.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        segment.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        segment.segmentType shouldBe ExerciseSegment.EXERCISE_SEGMENT_TYPE_SQUAT
        segment.repetitions shouldBe TEST_REPETITIONS
    }

    @Test
    @DisplayName(
        "GIVEN ExerciseSessionSegmentEventDto with null repetitions → " +
            "WHEN toHealthConnect → THEN repetitions is 0",
    )
    fun whenExerciseSessionSegmentEventWithNullRepetitionsToHealthConnect_thenRepetitionsIsZero() {
        // Given
        val dto = ExerciseSessionSegmentEventDto(
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            segmentType = ExerciseSegmentTypeDto.BIKING,
            repetitions = null,
        )

        // When
        val segment = dto.toHealthConnect()

        // Then
        segment.repetitions shouldBe 0
    }

    @Test
    @DisplayName(
        "GIVEN ExerciseSessionLapEventDto → WHEN toHealthConnect → THEN converts correctly",
    )
    fun whenExerciseSessionLapEventDtoToHealthConnect_thenConvertsCorrectly() {
        // Given
        val dto = ExerciseSessionLapEventDto(
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            distanceMeters = TEST_DISTANCE_METERS,
        )

        // When
        val lap = dto.toHealthConnect()

        // Then
        lap.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        lap.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        lap.length shouldBe Length.meters(TEST_DISTANCE_METERS)
    }
}
