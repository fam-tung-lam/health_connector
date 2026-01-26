package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.SkinTemperatureRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Temperature
import androidx.health.connect.client.units.TemperatureDelta
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.SkinTemperatureDeltaSampleDto
import com.phamtunglam.health_connector_hc_android.pigeon.SkinTemperatureDeltaSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SkinTemperatureMeasurementLocationDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("SkinTemperatureDeltaSeriesRecordMapper")
class SkinTemperatureDeltaSeriesRecordMapperTest {

    private companion object {
        const val TEST_ID = "skin-temp-delta-id"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609462800000L
        const val TEST_DELTA_TIME_1 = 1609459200000L
        const val TEST_DELTA_TIME_2 = 1609460100000L
        const val TEST_TEMPERATURE_DELTA_CELSIUS_1 = 0.5
        const val TEST_TEMPERATURE_DELTA_CELSIUS_2 = -0.3
        const val TEST_BASELINE_CELSIUS = 36.5
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN SkinTemperatureRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = SkinTemperatureRecord(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
            deltas = listOf(
                SkinTemperatureRecord.Delta(
                    time = Instant.ofEpochMilli(TEST_DELTA_TIME_1),
                    delta = TemperatureDelta.celsius(TEST_TEMPERATURE_DELTA_CELSIUS_1),
                ),
                SkinTemperatureRecord.Delta(
                    time = Instant.ofEpochMilli(TEST_DELTA_TIME_2),
                    delta = TemperatureDelta.celsius(TEST_TEMPERATURE_DELTA_CELSIUS_2),
                ),
            ),
            baseline = Temperature.celsius(TEST_BASELINE_CELSIUS),
            measurementLocation = SkinTemperatureRecord.MEASUREMENT_LOCATION_WRIST,
        )

        // When
        val result = record.toDto()

        // Then
        result.startTime shouldBe TEST_START_TIME
        result.endTime shouldBe TEST_END_TIME
        result.startZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.endZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.samples.size shouldBe 2
        result.samples[0].time shouldBe TEST_DELTA_TIME_1
        result.samples[0].temperatureDeltaCelsius shouldBe TEST_TEMPERATURE_DELTA_CELSIUS_1
        result.samples[1].time shouldBe TEST_DELTA_TIME_2
        result.samples[1].temperatureDeltaCelsius shouldBe TEST_TEMPERATURE_DELTA_CELSIUS_2
        result.baselineCelsius shouldBe TEST_BASELINE_CELSIUS
        result.measurementLocation shouldBe SkinTemperatureMeasurementLocationDto.WRIST
    }

    @Test
    @DisplayName(
        "GIVEN SkinTemperatureDeltaSeriesRecordDto → WHEN toHealthConnect → THEN creates correctly",
    )
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = SkinTemperatureDeltaSeriesRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
            samples = listOf(
                SkinTemperatureDeltaSampleDto(
                    time = TEST_DELTA_TIME_1,
                    temperatureDeltaCelsius = TEST_TEMPERATURE_DELTA_CELSIUS_1,
                ),
                SkinTemperatureDeltaSampleDto(
                    time = TEST_DELTA_TIME_2,
                    temperatureDeltaCelsius = TEST_TEMPERATURE_DELTA_CELSIUS_2,
                ),
            ),
            baselineCelsius = TEST_BASELINE_CELSIUS,
            measurementLocation = SkinTemperatureMeasurementLocationDto.FINGER,
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        result.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        result.startZoneOffset shouldBe TEST_ZONE_OFFSET
        result.endZoneOffset shouldBe TEST_ZONE_OFFSET
        result.deltas.size shouldBe 2
        result.deltas[0].time shouldBe Instant.ofEpochMilli(TEST_DELTA_TIME_1)
        result.deltas[0].delta.inCelsius shouldBe TEST_TEMPERATURE_DELTA_CELSIUS_1
        result.deltas[1].time shouldBe Instant.ofEpochMilli(TEST_DELTA_TIME_2)
        result.deltas[1].delta.inCelsius shouldBe TEST_TEMPERATURE_DELTA_CELSIUS_2
        result.baseline?.inCelsius shouldBe TEST_BASELINE_CELSIUS
        result.measurementLocation shouldBe SkinTemperatureRecord.MEASUREMENT_LOCATION_FINGER
        result.metadata.id shouldBe TEST_ID
    }

    @Test
    @DisplayName(
        "GIVEN SkinTemperatureRecord with null baseline → WHEN toDto → THEN converts correctly",
    )
    fun whenRecordToDtoWithNullBaseline_thenConvertsCorrectly() {
        // Given
        val record = SkinTemperatureRecord(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
            deltas = listOf(
                SkinTemperatureRecord.Delta(
                    time = Instant.ofEpochMilli(TEST_DELTA_TIME_1),
                    delta = TemperatureDelta.celsius(TEST_TEMPERATURE_DELTA_CELSIUS_1),
                ),
            ),
            baseline = null,
            measurementLocation = SkinTemperatureRecord.MEASUREMENT_LOCATION_TOE,
        )

        // When
        val result = record.toDto()

        // Then
        result.baselineCelsius shouldBe null
        result.measurementLocation shouldBe SkinTemperatureMeasurementLocationDto.TOE
    }

    @Test
    @DisplayName(
        "GIVEN SkinTemperatureDeltaSeriesRecordDto with null baseline → WHEN toHealthConnect → THEN creates correctly",
    )
    fun whenDtoToHealthConnectWithNullBaseline_thenCreatesCorrectly() {
        // Given
        val dto = SkinTemperatureDeltaSeriesRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
            samples = listOf(
                SkinTemperatureDeltaSampleDto(
                    time = TEST_DELTA_TIME_1,
                    temperatureDeltaCelsius = TEST_TEMPERATURE_DELTA_CELSIUS_1,
                ),
            ),
            baselineCelsius = null,
            measurementLocation = SkinTemperatureMeasurementLocationDto.UNKNOWN,
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.baseline shouldBe null
        result.measurementLocation shouldBe SkinTemperatureRecord.MEASUREMENT_LOCATION_UNKNOWN
    }

    @Test
    @DisplayName(
        "GIVEN SkinTemperatureDeltaSeriesRecordDto with null measurementLocation → WHEN toHealthConnect → THEN defaults to UNKNOWN",
    )
    fun whenDtoToHealthConnectWithNullMeasurementLocation_thenDefaultsToUnknown() {
        // Given
        val dto = SkinTemperatureDeltaSeriesRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
            samples = emptyList(),
            baselineCelsius = null,
            measurementLocation = null,
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.measurementLocation shouldBe SkinTemperatureRecord.MEASUREMENT_LOCATION_UNKNOWN
    }
}
