package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseRoute
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseRouteDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseRouteLocationDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("ExerciseRouteMapper")
class ExerciseRouteMapperTest {

    private companion object {
        const val TEST_TIME_1 = 1609459200000L // 2021-01-01 00:00:00 UTC
        const val TEST_TIME_2 = 1609459260000L // 2021-01-01 00:01:00 UTC
        const val TEST_TIME_3 = 1609459320000L // 2021-01-01 00:02:00 UTC
        const val TEST_LATITUDE_1 = 37.7749
        const val TEST_LONGITUDE_1 = -122.4194
        const val TEST_LATITUDE_2 = 37.7849
        const val TEST_LONGITUDE_2 = -122.4094
        const val TEST_LATITUDE_3 = 37.7949
        const val TEST_LONGITUDE_3 = -122.3994
        const val TEST_ALTITUDE_METERS = 100.5
        const val TEST_HORIZONTAL_ACCURACY_METERS = 5.0
        const val TEST_VERTICAL_ACCURACY_METERS = 3.0
    }

    @Test
    @DisplayName("GIVEN ExerciseRoute → WHEN toDto → THEN converts correctly")
    fun whenExerciseRouteToDto_thenConvertsCorrectly() {
        // Given
        val route = ExerciseRoute(
            route = listOf(
                ExerciseRoute.Location(
                    time = Instant.ofEpochMilli(TEST_TIME_1),
                    latitude = TEST_LATITUDE_1,
                    longitude = TEST_LONGITUDE_1,
                    altitude = Length.meters(TEST_ALTITUDE_METERS),
                    horizontalAccuracy = Length.meters(TEST_HORIZONTAL_ACCURACY_METERS),
                    verticalAccuracy = Length.meters(TEST_VERTICAL_ACCURACY_METERS),
                ),
                ExerciseRoute.Location(
                    time = Instant.ofEpochMilli(TEST_TIME_2),
                    latitude = TEST_LATITUDE_2,
                    longitude = TEST_LONGITUDE_2,
                    altitude = Length.meters(TEST_ALTITUDE_METERS),
                    horizontalAccuracy = Length.meters(TEST_HORIZONTAL_ACCURACY_METERS),
                    verticalAccuracy = Length.meters(TEST_VERTICAL_ACCURACY_METERS),
                ),
                ExerciseRoute.Location(
                    time = Instant.ofEpochMilli(TEST_TIME_3),
                    latitude = TEST_LATITUDE_3,
                    longitude = TEST_LONGITUDE_3,
                ),
            ),
        )

        // When
        val result = route.toDto()

        // Then
        result.locations.size shouldBe 3
        result.locations[0].time shouldBe TEST_TIME_1
        result.locations[0].latitude shouldBe TEST_LATITUDE_1
        result.locations[0].longitude shouldBe TEST_LONGITUDE_1
        result.locations[0].altitudeMeters shouldBe TEST_ALTITUDE_METERS
        result.locations[0].horizontalAccuracyMeters shouldBe TEST_HORIZONTAL_ACCURACY_METERS
        result.locations[0].verticalAccuracyMeters shouldBe TEST_VERTICAL_ACCURACY_METERS

        result.locations[1].time shouldBe TEST_TIME_2
        result.locations[1].latitude shouldBe TEST_LATITUDE_2
        result.locations[1].longitude shouldBe TEST_LONGITUDE_2

        result.locations[2].time shouldBe TEST_TIME_3
        result.locations[2].latitude shouldBe TEST_LATITUDE_3
        result.locations[2].longitude shouldBe TEST_LONGITUDE_3
        result.locations[2].altitudeMeters shouldBe null
        result.locations[2].horizontalAccuracyMeters shouldBe null
        result.locations[2].verticalAccuracyMeters shouldBe null
    }

    @Test
    @DisplayName("GIVEN ExerciseRoute.Location → WHEN toDto → THEN converts correctly")
    fun whenExerciseRouteLocationToDto_thenConvertsCorrectly() {
        // Given
        val location = ExerciseRoute.Location(
            time = Instant.ofEpochMilli(TEST_TIME_1),
            latitude = TEST_LATITUDE_1,
            longitude = TEST_LONGITUDE_1,
            altitude = Length.meters(TEST_ALTITUDE_METERS),
            horizontalAccuracy = Length.meters(TEST_HORIZONTAL_ACCURACY_METERS),
            verticalAccuracy = Length.meters(TEST_VERTICAL_ACCURACY_METERS),
        )

        // When
        val result = location.toDto()

        // Then
        result.time shouldBe TEST_TIME_1
        result.latitude shouldBe TEST_LATITUDE_1
        result.longitude shouldBe TEST_LONGITUDE_1
        result.altitudeMeters shouldBe TEST_ALTITUDE_METERS
        result.horizontalAccuracyMeters shouldBe TEST_HORIZONTAL_ACCURACY_METERS
        result.verticalAccuracyMeters shouldBe TEST_VERTICAL_ACCURACY_METERS
    }

    @Test
    @DisplayName(
        "GIVEN ExerciseRoute.Location with null optional fields → " +
            "WHEN toDto → THEN converts correctly with null values",
    )
    fun whenExerciseRouteLocationToDtoWithNullOptionalFields_thenConvertsCorrectly() {
        // Given
        val location = ExerciseRoute.Location(
            time = Instant.ofEpochMilli(TEST_TIME_1),
            latitude = TEST_LATITUDE_1,
            longitude = TEST_LONGITUDE_1,
        )

        // When
        val result = location.toDto()

        // Then
        result.time shouldBe TEST_TIME_1
        result.latitude shouldBe TEST_LATITUDE_1
        result.longitude shouldBe TEST_LONGITUDE_1
        result.altitudeMeters shouldBe null
        result.horizontalAccuracyMeters shouldBe null
        result.verticalAccuracyMeters shouldBe null
    }

    @Test
    @DisplayName("GIVEN ExerciseRouteDto → WHEN toHealthConnect → THEN converts correctly")
    fun whenExerciseRouteDtoToHealthConnect_thenConvertsCorrectly() {
        // Given
        val dto = ExerciseRouteDto(
            locations = listOf(
                ExerciseRouteLocationDto(
                    time = TEST_TIME_1,
                    latitude = TEST_LATITUDE_1,
                    longitude = TEST_LONGITUDE_1,
                    altitudeMeters = TEST_ALTITUDE_METERS,
                    horizontalAccuracyMeters = TEST_HORIZONTAL_ACCURACY_METERS,
                    verticalAccuracyMeters = TEST_VERTICAL_ACCURACY_METERS,
                ),
                ExerciseRouteLocationDto(
                    time = TEST_TIME_2,
                    latitude = TEST_LATITUDE_2,
                    longitude = TEST_LONGITUDE_2,
                    altitudeMeters = TEST_ALTITUDE_METERS,
                    horizontalAccuracyMeters = TEST_HORIZONTAL_ACCURACY_METERS,
                    verticalAccuracyMeters = TEST_VERTICAL_ACCURACY_METERS,
                ),
                ExerciseRouteLocationDto(
                    time = TEST_TIME_3,
                    latitude = TEST_LATITUDE_3,
                    longitude = TEST_LONGITUDE_3,
                ),
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.route.size shouldBe 3
        result.route[0].time shouldBe Instant.ofEpochMilli(TEST_TIME_1)
        result.route[0].latitude shouldBe TEST_LATITUDE_1
        result.route[0].longitude shouldBe TEST_LONGITUDE_1
        result.route[0].altitude shouldBe Length.meters(TEST_ALTITUDE_METERS)
        result.route[0].horizontalAccuracy shouldBe Length.meters(TEST_HORIZONTAL_ACCURACY_METERS)
        result.route[0].verticalAccuracy shouldBe Length.meters(TEST_VERTICAL_ACCURACY_METERS)

        result.route[1].time shouldBe Instant.ofEpochMilli(TEST_TIME_2)
        result.route[1].latitude shouldBe TEST_LATITUDE_2
        result.route[1].longitude shouldBe TEST_LONGITUDE_2

        result.route[2].time shouldBe Instant.ofEpochMilli(TEST_TIME_3)
        result.route[2].latitude shouldBe TEST_LATITUDE_3
        result.route[2].longitude shouldBe TEST_LONGITUDE_3
        result.route[2].altitude shouldBe null
        result.route[2].horizontalAccuracy shouldBe null
        result.route[2].verticalAccuracy shouldBe null
    }

    @Test
    @DisplayName("GIVEN ExerciseRouteLocationDto → WHEN toHealthConnect → THEN converts correctly")
    fun whenExerciseRouteLocationDtoToHealthConnect_thenConvertsCorrectly() {
        // Given
        val dto = ExerciseRouteLocationDto(
            time = TEST_TIME_1,
            latitude = TEST_LATITUDE_1,
            longitude = TEST_LONGITUDE_1,
            altitudeMeters = TEST_ALTITUDE_METERS,
            horizontalAccuracyMeters = TEST_HORIZONTAL_ACCURACY_METERS,
            verticalAccuracyMeters = TEST_VERTICAL_ACCURACY_METERS,
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.time shouldBe Instant.ofEpochMilli(TEST_TIME_1)
        result.latitude shouldBe TEST_LATITUDE_1
        result.longitude shouldBe TEST_LONGITUDE_1
        result.altitude shouldBe Length.meters(TEST_ALTITUDE_METERS)
        result.horizontalAccuracy shouldBe Length.meters(TEST_HORIZONTAL_ACCURACY_METERS)
        result.verticalAccuracy shouldBe Length.meters(TEST_VERTICAL_ACCURACY_METERS)
    }

    @Test
    @DisplayName(
        "GIVEN ExerciseRouteLocationDto with null optional fields → " +
            "WHEN toHealthConnect → THEN converts correctly with null values",
    )
    fun whenExerciseRouteLocationDtoWithNullOptionalFieldsToHealthConnect_thenConvertsCorrectly() {
        // Given
        val dto = ExerciseRouteLocationDto(
            time = TEST_TIME_1,
            latitude = TEST_LATITUDE_1,
            longitude = TEST_LONGITUDE_1,
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.time shouldBe Instant.ofEpochMilli(TEST_TIME_1)
        result.latitude shouldBe TEST_LATITUDE_1
        result.longitude shouldBe TEST_LONGITUDE_1
        result.altitude shouldBe null
        result.horizontalAccuracy shouldBe null
        result.verticalAccuracy shouldBe null
    }
}
