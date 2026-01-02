package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.BoneMassRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Mass
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BoneMassRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MassDto
import com.phamtunglam.health_connector_hc_android.pigeon.MassUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("BoneMassRecordMapper")
class BoneMassRecordMapperTest {

    private companion object {
        const val TEST_ID = "bone-mass-id"
        const val TEST_TIME = 1609459200000L
        const val TEST_MASS_KG = 2.5
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN BoneMassRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = BoneMassRecord(
            mass = Mass.kilograms(TEST_MASS_KG),
            time = Instant.ofEpochMilli(TEST_TIME),
            zoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.mass.value shouldBe TEST_MASS_KG
        result.mass.unit shouldBe MassUnitDto.KILOGRAMS
        result.time shouldBe TEST_TIME
        result.zoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
    }

    @Test
    @DisplayName("GIVEN BoneMassRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = BoneMassRecordDto(
            id = TEST_ID,
            time = TEST_TIME,
            zoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            mass = MassDto(value = TEST_MASS_KG, unit = MassUnitDto.KILOGRAMS),
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.mass.inKilograms shouldBe TEST_MASS_KG
        result.time shouldBe Instant.ofEpochMilli(TEST_TIME)
        result.zoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }
}
