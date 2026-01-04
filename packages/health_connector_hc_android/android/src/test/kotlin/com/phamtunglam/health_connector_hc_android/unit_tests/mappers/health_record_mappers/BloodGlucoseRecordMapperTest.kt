package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.BloodGlucoseRecord
import androidx.health.connect.client.records.MealType
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.BloodGlucose
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseRelationToMealDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseSpecimenSourceDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MealTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("BloodGlucoseRecordMapper")
class BloodGlucoseRecordMapperTest {

    private companion object {
        const val TEST_ID = "blood-glucose-id"
        const val TEST_TIME = 1609459200000L
        const val TEST_GLUCOSE_MMOL = 5.5
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN BloodGlucoseRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = BloodGlucoseRecord(
            level = BloodGlucose.millimolesPerLiter(TEST_GLUCOSE_MMOL),
            specimenSource = BloodGlucoseRecord.SPECIMEN_SOURCE_PLASMA,
            mealType = MealType.MEAL_TYPE_LUNCH,
            relationToMeal = BloodGlucoseRecord.RELATION_TO_MEAL_AFTER_MEAL,
            time = Instant.ofEpochMilli(TEST_TIME),
            zoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.bloodGlucose.millimolesPerLiter shouldBe TEST_GLUCOSE_MMOL
        result.specimenSource shouldBe BloodGlucoseSpecimenSourceDto.PLASMA
        result.mealType shouldBe MealTypeDto.LUNCH
        result.relationToMeal shouldBe BloodGlucoseRelationToMealDto.AFTER_MEAL
        result.time shouldBe TEST_TIME
        result.zoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
    }

    @Test
    @DisplayName("GIVEN BloodGlucoseRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = BloodGlucoseRecordDto(
            id = TEST_ID,
            time = TEST_TIME,
            zoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            bloodGlucose = BloodGlucoseDto(
                millimolesPerLiter = TEST_GLUCOSE_MMOL,
            ),
            specimenSource = BloodGlucoseSpecimenSourceDto.PLASMA,
            mealType = MealTypeDto.LUNCH,
            relationToMeal = BloodGlucoseRelationToMealDto.AFTER_MEAL,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.level.inMillimolesPerLiter shouldBe TEST_GLUCOSE_MMOL
        result.specimenSource shouldBe BloodGlucoseRecord.SPECIMEN_SOURCE_PLASMA
        result.mealType shouldBe MealType.MEAL_TYPE_LUNCH
        result.relationToMeal shouldBe BloodGlucoseRecord.RELATION_TO_MEAL_AFTER_MEAL
        result.time shouldBe Instant.ofEpochMilli(TEST_TIME)
        result.zoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }
}
