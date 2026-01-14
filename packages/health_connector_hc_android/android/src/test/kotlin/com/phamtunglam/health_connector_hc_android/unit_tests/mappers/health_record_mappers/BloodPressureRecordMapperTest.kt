package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Pressure
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyPositionDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementLocationDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("BloodPressureRecordMapper")
class BloodPressureRecordMapperTest {

    private companion object {
        const val TEST_ID = "blood-pressure-id"
        const val TEST_TIME = 1609459200000L
        const val TEST_SYSTOLIC = 120.0
        const val TEST_DIASTOLIC = 80.0
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN BloodPressureRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = BloodPressureRecord(
            systolic = Pressure.millimetersOfMercury(TEST_SYSTOLIC),
            diastolic = Pressure.millimetersOfMercury(TEST_DIASTOLIC),
            bodyPosition = BloodPressureRecord.BODY_POSITION_SITTING_DOWN,
            measurementLocation = BloodPressureRecord.MEASUREMENT_LOCATION_LEFT_UPPER_ARM,
            time = Instant.ofEpochMilli(TEST_TIME),
            zoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.systolicInMillimetersOfMercury shouldBe TEST_SYSTOLIC
        result.diastolicInMillimetersOfMercury shouldBe TEST_DIASTOLIC
        result.bodyPosition shouldBe BodyPositionDto.SITTING_DOWN
        result.measurementLocation shouldBe MeasurementLocationDto.LEFT_UPPER_ARM
        result.time shouldBe TEST_TIME
        result.zoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
    }

    @Test
    @DisplayName("GIVEN BloodPressureRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = BloodPressureRecordDto(
            id = TEST_ID,
            time = TEST_TIME,
            zoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            systolicInMillimetersOfMercury = TEST_SYSTOLIC,
            diastolicInMillimetersOfMercury = TEST_DIASTOLIC,
            bodyPosition = BodyPositionDto.SITTING_DOWN,
            measurementLocation = MeasurementLocationDto.LEFT_UPPER_ARM,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.systolic.inMillimetersOfMercury shouldBe TEST_SYSTOLIC
        result.diastolic.inMillimetersOfMercury shouldBe TEST_DIASTOLIC
        result.bodyPosition shouldBe BloodPressureRecord.BODY_POSITION_SITTING_DOWN
        result.measurementLocation shouldBe BloodPressureRecord.MEASUREMENT_LOCATION_LEFT_UPPER_ARM
        result.time shouldBe Instant.ofEpochMilli(TEST_TIME)
        result.zoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }
}
