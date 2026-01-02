package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.BloodGlucose
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseUnitDto
import io.kotest.matchers.doubles.shouldBeGreaterThan
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

/**
 * Unit tests for Blood Glucose Mapper.
 *
 * Tests verify proper bidirectional mapping between [BloodGlucoseDto] and Health Connect
 * [BloodGlucose] objects, including unit conversions between millimoles/L and milligrams/dL.
 */
@DisplayName("BloodGlucoseMapper")
class BloodGlucoseMapperTest {

    private companion object {
        const val TEST_VALUE = 100.0
    }

    @Test
    @DisplayName(
        "GIVEN BloodGlucoseDto in millimoles/L → " +
            "WHEN toHealthConnect called → " +
            "THEN creates BloodGlucose with correct value",
    )
    fun whenMillimolesPerLiter_thenCreatesCorrectBloodGlucose() {
        // Given
        val dto = BloodGlucoseDto(
            value = TEST_VALUE,
            unit = BloodGlucoseUnitDto.MILLIMOLES_PER_LITER,
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.inMillimolesPerLiter shouldBe TEST_VALUE
    }

    @Test
    @DisplayName(
        "GIVEN BloodGlucoseDto in milligrams/dL → " +
            "WHEN toHealthConnect called → " +
            "THEN creates BloodGlucose with correct value",
    )
    fun whenMilligramsPerDeciliter_thenCreatesCorrectBloodGlucose() {
        // Given
        val dto = BloodGlucoseDto(
            value = TEST_VALUE,
            unit = BloodGlucoseUnitDto.MILLIGRAMS_PER_DECILITER,
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.inMilligramsPerDeciliter shouldBe TEST_VALUE
    }

    @Test
    @DisplayName(
        "GIVEN BloodGlucose object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in millimoles/L",
    )
    fun whenBloodGlucoseToDto_thenUsesMillimolesPerLiter() {
        // Given
        val bloodGlucose = BloodGlucose.millimolesPerLiter(TEST_VALUE)

        // When
        val result = bloodGlucose.toDto()

        // Then
        result.value shouldBe TEST_VALUE
        result.unit shouldBe BloodGlucoseUnitDto.MILLIMOLES_PER_LITER
    }

    @Test
    @DisplayName(
        "GIVEN BloodGlucose in milligrams/dL → " +
            "WHEN toDto called → " +
            "THEN converts to millimoles/L",
    )
    fun whenBloodGlucoseInMgDl_thenConvertsToMmolL() {
        // Given
        val bloodGlucose = BloodGlucose.milligramsPerDeciliter(180.0)

        // When
        val result = bloodGlucose.toDto()

        // Then
        result.unit shouldBe BloodGlucoseUnitDto.MILLIMOLES_PER_LITER
        result.value shouldBeGreaterThan 0.0 // Converted value should be positive
    }
}
