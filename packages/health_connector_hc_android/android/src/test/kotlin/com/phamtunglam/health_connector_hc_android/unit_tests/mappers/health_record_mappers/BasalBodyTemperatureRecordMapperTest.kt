package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.BasalBodyTemperatureRecord
import androidx.health.connect.client.records.BodyTemperatureMeasurementLocation
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Temperature
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BasalBodyTemperatureMeasurementLocationDto
import com.phamtunglam.health_connector_hc_android.pigeon.BasalBodyTemperatureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("BasalBodyTemperatureRecordMapper")
class BasalBodyTemperatureRecordMapperTest {

    private companion object {
        const val TEST_ID = "basal-temp-id"
        const val TEST_TIME = 1609459200000L
        const val TEST_TEMPERATURE_CELSIUS = 36.5
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN BasalBodyTemperatureRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = BasalBodyTemperatureRecord(
            temperature = Temperature.celsius(TEST_TEMPERATURE_CELSIUS),
            measurementLocation = BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_MOUTH,
            time = Instant.ofEpochMilli(TEST_TIME),
            zoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.celsius shouldBe TEST_TEMPERATURE_CELSIUS
        result.measurementLocation shouldBe BasalBodyTemperatureMeasurementLocationDto.MOUTH
        result.time shouldBe TEST_TIME
        result.zoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
    }

    @Test
    @DisplayName(
        "GIVEN BasalBodyTemperatureRecordDto → WHEN toHealthConnect → THEN creates correctly",
    )
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = BasalBodyTemperatureRecordDto(
            id = TEST_ID,
            time = TEST_TIME,
            zoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            celsius = TEST_TEMPERATURE_CELSIUS,
            measurementLocation = BasalBodyTemperatureMeasurementLocationDto.MOUTH,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.temperature.inCelsius shouldBe TEST_TEMPERATURE_CELSIUS
        result.measurementLocation shouldBe
            BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_MOUTH
        result.time shouldBe Instant.ofEpochMilli(TEST_TIME)
        result.zoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }
}
