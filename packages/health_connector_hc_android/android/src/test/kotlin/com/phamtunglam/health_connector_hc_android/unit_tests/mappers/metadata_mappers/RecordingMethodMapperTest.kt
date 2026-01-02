package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.metadata_mappers

import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toRecordingMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for Recording Method Mapper.
 *
 * Tests verify proper mapping from Health Connect recording method constants to
 * [RecordingMethodDto], including edge case handling for unknown recording methods.
 */
@DisplayName("RecordingMethodMapper")
class RecordingMethodMapperTest {

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("toRecordingMethodDto")
    inner class ToRecordingMethodDto {

        @ParameterizedTest(name = "constant={0} maps to dto={1}")
        @MethodSource("provideRecordingMethodMappings")
        @DisplayName(
            "GIVEN any recording method constant → " +
                "WHEN toRecordingMethodDto called → " +
                "THEN maps to correct RecordingMethodDto",
        )
        fun whenAnyRecordingMethod_thenMapsToCorrectDto(
            constant: Int,
            expectedDto: RecordingMethodDto,
        ) {
            // When
            val result = constant.toRecordingMethodDto()

            // Then
            result shouldBe expectedDto
        }

        fun provideRecordingMethodMappings(): List<Arguments> = listOf(
            // Valid recording method constants
            Arguments.of(
                Metadata.RECORDING_METHOD_MANUAL_ENTRY,
                RecordingMethodDto.MANUAL_ENTRY,
            ),
            Arguments.of(
                Metadata.RECORDING_METHOD_AUTOMATICALLY_RECORDED,
                RecordingMethodDto.AUTOMATICALLY_RECORDED,
            ),
            Arguments.of(
                Metadata.RECORDING_METHOD_ACTIVELY_RECORDED,
                RecordingMethodDto.ACTIVELY_RECORDED,
            ),
            Arguments.of(
                Metadata.RECORDING_METHOD_UNKNOWN,
                RecordingMethodDto.UNKNOWN,
            ),

            // Edge cases: Invalid/unknown constants should default to UNKNOWN
            Arguments.of(0, RecordingMethodDto.UNKNOWN),
            Arguments.of(-1, RecordingMethodDto.UNKNOWN),
            Arguments.of(-100, RecordingMethodDto.UNKNOWN),
            Arguments.of(100, RecordingMethodDto.UNKNOWN),
            Arguments.of(999, RecordingMethodDto.UNKNOWN),
            Arguments.of(9999, RecordingMethodDto.UNKNOWN),
            Arguments.of(Int.MAX_VALUE, RecordingMethodDto.UNKNOWN),
            Arguments.of(Int.MIN_VALUE, RecordingMethodDto.UNKNOWN),
        )
    }
}
