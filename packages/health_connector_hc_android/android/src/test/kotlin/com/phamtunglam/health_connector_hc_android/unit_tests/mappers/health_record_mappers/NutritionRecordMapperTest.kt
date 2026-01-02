package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.MealType
import androidx.health.connect.client.records.NutritionRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.grams
import androidx.health.connect.client.units.kilocalories
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyDto
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MassDto
import com.phamtunglam.health_connector_hc_android.pigeon.MassUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.MealTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.NutritionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("NutritionRecordMapper")
class NutritionRecordMapperTest {

    private companion object {
        const val TEST_ID = "nutrition-id"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609462800000L
        const val TEST_FOOD_NAME = "Banana"
        const val TEST_ENERGY_KCAL = 105.0
        const val TEST_PROTEIN_GRAMS = 1.3
        const val TEST_CARBS_GRAMS = 27.0
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN NutritionRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = NutritionRecord(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
            name = TEST_FOOD_NAME,
            mealType = MealType.MEAL_TYPE_BREAKFAST,
            energy = TEST_ENERGY_KCAL.kilocalories,
            protein = TEST_PROTEIN_GRAMS.grams,
            totalCarbohydrate = TEST_CARBS_GRAMS.grams,
        )

        // When
        val result = record.toDto()

        // Then
        result.startTime shouldBe TEST_START_TIME
        result.endTime shouldBe TEST_END_TIME
        result.startZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.endZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.foodName shouldBe TEST_FOOD_NAME
        result.mealType shouldBe MealTypeDto.BREAKFAST
        result.energy?.value shouldBe TEST_ENERGY_KCAL
        result.energy?.unit shouldBe EnergyUnitDto.KILOCALORIES
        result.protein?.value shouldBe TEST_PROTEIN_GRAMS / 1000.0 // Convert grams to kgs
        result.protein?.unit shouldBe MassUnitDto.KILOGRAMS
        result.totalCarbohydrate?.value shouldBe TEST_CARBS_GRAMS / 1000.0 // Convert grams to kgs
        result.totalCarbohydrate?.unit shouldBe MassUnitDto.KILOGRAMS
        result.healthDataType shouldBe HealthDataTypeDto.NUTRITION
    }

    @Test
    @DisplayName("GIVEN NutritionRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = NutritionRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            healthDataType = HealthDataTypeDto.NUTRITION,
            foodName = TEST_FOOD_NAME,
            mealType = MealTypeDto.LUNCH,
            energy = EnergyDto(value = TEST_ENERGY_KCAL, unit = EnergyUnitDto.KILOCALORIES),
            protein = MassDto(value = TEST_PROTEIN_GRAMS, unit = MassUnitDto.GRAMS),
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        result.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        result.startZoneOffset shouldBe TEST_ZONE_OFFSET
        result.endZoneOffset shouldBe TEST_ZONE_OFFSET
        result.name shouldBe TEST_FOOD_NAME
        result.mealType shouldBe MealType.MEAL_TYPE_LUNCH
        result.energy?.inKilocalories shouldBe TEST_ENERGY_KCAL
        result.protein?.inGrams shouldBe TEST_PROTEIN_GRAMS
        result.metadata.id shouldBe TEST_ID
    }
}
