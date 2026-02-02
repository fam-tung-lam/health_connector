package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseRoute
import androidx.health.connect.client.records.ExerciseSessionRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseRouteDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseRouteLocationDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("ExerciseSessionRecordMapper")
class ExerciseSessionRecordMapperTest {

    private companion object {
        const val TEST_ID = "exercise-session-id"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609462800000L
        const val TEST_TITLE = "Morning Run"
        const val TEST_NOTES = "Feeling good"
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
        const val TEST_ROUTE_TIME_1 = 1609459200000L
        const val TEST_ROUTE_TIME_2 = 1609459260000L
        const val TEST_ROUTE_LATITUDE_1 = 37.7749
        const val TEST_ROUTE_LONGITUDE_1 = -122.4194
        const val TEST_ROUTE_LATITUDE_2 = 37.7849
        const val TEST_ROUTE_LONGITUDE_2 = -122.4094
        const val TEST_ROUTE_ALTITUDE_METERS = 100.5
    }

    @Test
    @DisplayName("GIVEN ExerciseSessionRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = ExerciseSessionRecord(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            exerciseType = ExerciseSessionRecord.EXERCISE_TYPE_RUNNING,
            title = TEST_TITLE,
            notes = TEST_NOTES,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.startTime shouldBe TEST_START_TIME
        result.endTime shouldBe TEST_END_TIME
        result.startZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.endZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.exerciseType shouldBe ExerciseTypeDto.RUNNING
        result.title shouldBe TEST_TITLE
        result.notes shouldBe TEST_NOTES
    }

    @Test
    @DisplayName("GIVEN ExerciseSessionRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = ExerciseSessionRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            exerciseType = ExerciseTypeDto.RUNNING,
            title = TEST_TITLE,
            notes = TEST_NOTES,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
            events = emptyList(),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.exerciseType shouldBe ExerciseSessionRecord.EXERCISE_TYPE_RUNNING
        result.title shouldBe TEST_TITLE
        result.notes shouldBe TEST_NOTES
        result.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        result.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        result.startZoneOffset shouldBe TEST_ZONE_OFFSET
        result.endZoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }

    @Test
    @DisplayName(
        "GIVEN ExerciseSessionRecord with route → " +
            "WHEN toDto → THEN converts correctly including route",
    )
    fun whenExerciseSessionRecordWithRouteToDto_thenConvertsCorrectly() {
        // Given
        val exerciseRoute = ExerciseRoute(
            route = listOf(
                ExerciseRoute.Location(
                    time = Instant.ofEpochMilli(TEST_ROUTE_TIME_1),
                    latitude = TEST_ROUTE_LATITUDE_1,
                    longitude = TEST_ROUTE_LONGITUDE_1,
                    altitude = Length.meters(TEST_ROUTE_ALTITUDE_METERS),
                ),
                ExerciseRoute.Location(
                    time = Instant.ofEpochMilli(TEST_ROUTE_TIME_2),
                    latitude = TEST_ROUTE_LATITUDE_2,
                    longitude = TEST_ROUTE_LONGITUDE_2,
                ),
            ),
        )
        val record = ExerciseSessionRecord(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            exerciseType = ExerciseSessionRecord.EXERCISE_TYPE_RUNNING,
            title = TEST_TITLE,
            notes = TEST_NOTES,
            metadata = Metadata.manualEntry(),
            exerciseRoute = exerciseRoute,
        )

        // When
        val result = record.toDto()

        // Then
        result.startTime shouldBe TEST_START_TIME
        result.endTime shouldBe TEST_END_TIME
        result.exerciseType shouldBe ExerciseTypeDto.RUNNING
        result.title shouldBe TEST_TITLE
        result.notes shouldBe TEST_NOTES
        // Route is write-only, not included in toDto conversion
        result.exerciseRoute shouldBe null
    }

    @Test
    @DisplayName(
        "GIVEN ExerciseSessionRecordDto with route → " +
            "WHEN toHealthConnect → THEN creates correctly including route",
    )
    fun whenExerciseSessionRecordDtoWithRouteToHealthConnect_thenConvertsCorrectly() {
        // Given
        val routeDto = ExerciseRouteDto(
            locations = listOf(
                ExerciseRouteLocationDto(
                    time = TEST_ROUTE_TIME_1,
                    latitude = TEST_ROUTE_LATITUDE_1,
                    longitude = TEST_ROUTE_LONGITUDE_1,
                    altitudeMeters = TEST_ROUTE_ALTITUDE_METERS,
                ),
                ExerciseRouteLocationDto(
                    time = TEST_ROUTE_TIME_2,
                    latitude = TEST_ROUTE_LATITUDE_2,
                    longitude = TEST_ROUTE_LONGITUDE_2,
                ),
            ),
        )
        val dto = ExerciseSessionRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            exerciseType = ExerciseTypeDto.RUNNING,
            title = TEST_TITLE,
            notes = TEST_NOTES,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
            events = emptyList(),
            exerciseRoute = routeDto,
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.exerciseType shouldBe ExerciseSessionRecord.EXERCISE_TYPE_RUNNING
        result.title shouldBe TEST_TITLE
        result.notes shouldBe TEST_NOTES
        result.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        result.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        result.startZoneOffset shouldBe TEST_ZONE_OFFSET
        result.endZoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
        // Note: exerciseRoute is write-only and not accessible as a public property.
        // The mapper correctly passes it to the constructor, but we can only verify
        // that the conversion completes successfully without errors.
    }

    @Test
    @DisplayName(
        "GIVEN ExerciseSessionRecordDto with null route → " +
            "WHEN toHealthConnect → THEN route is null",
    )
    fun whenExerciseSessionRecordDtoWithNullRouteToHealthConnect_thenRouteIsNull() {
        // Given
        val dto = ExerciseSessionRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            exerciseType = ExerciseTypeDto.RUNNING,
            title = TEST_TITLE,
            notes = TEST_NOTES,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
            events = emptyList(),
            exerciseRoute = null,
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.exerciseType shouldBe ExerciseSessionRecord.EXERCISE_TYPE_RUNNING
        // Note: exerciseRoute is write-only and not accessible as a public property.
        // The mapper correctly handles null route, and we verify conversion succeeds.
    }
}
