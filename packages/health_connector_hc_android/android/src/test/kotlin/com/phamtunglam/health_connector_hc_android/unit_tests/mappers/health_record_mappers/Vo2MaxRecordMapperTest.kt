package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.Vo2MaxRecord
import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.Vo2MaxMeasurementMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.Vo2MaxRecordDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("Vo2MaxRecordMapper")
class Vo2MaxRecordMapperTest {

    private companion object {
        const val TEST_ID = "vo2max-id"
        const val TEST_TIME = 1609459200000L
        const val TEST_VO2 = 45.0
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN Vo2MaxRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = Vo2MaxRecord(
            time = Instant.ofEpochMilli(TEST_TIME),
            zoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
            vo2MillilitersPerMinuteKilogram = TEST_VO2,
            measurementMethod = Vo2MaxRecord.MEASUREMENT_METHOD_COOPER_TEST,
        )

        // When
        val result = record.toDto()

        // Then
        result.millilitersPerKilogramPerMinute shouldBe TEST_VO2
        result.time shouldBe TEST_TIME
        result.zoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.measurementMethod shouldBe Vo2MaxMeasurementMethodDto.COOPER_TEST
    }

    @Test
    @DisplayName("GIVEN Vo2MaxRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = Vo2MaxRecordDto(
            id = TEST_ID,
            time = TEST_TIME,
            zoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            millilitersPerKilogramPerMinute = TEST_VO2,
            measurementMethod = Vo2MaxMeasurementMethodDto.METABOLIC_CART,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.vo2MillilitersPerMinuteKilogram shouldBe TEST_VO2
        result.time shouldBe Instant.ofEpochMilli(TEST_TIME)
        result.zoneOffset shouldBe TEST_ZONE_OFFSET
        result.measurementMethod shouldBe Vo2MaxRecord.MEASUREMENT_METHOD_METABOLIC_CART
        result.metadata.id shouldBe TEST_ID
    }
}
