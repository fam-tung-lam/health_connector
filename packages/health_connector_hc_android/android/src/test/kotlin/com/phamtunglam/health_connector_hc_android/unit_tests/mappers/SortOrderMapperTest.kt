package com.phamtunglam.health_connector_hc_android.unit_tests.mappers

import com.phamtunglam.health_connector_hc_android.mappers.isAscending
import com.phamtunglam.health_connector_hc_android.pigeon.SortOrderDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for [SortOrderMapper].
 */
@DisplayName("SortOrderMapper")
class SortOrderMapperTest {

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("isAscending")
    inner class IsAscending {

        @ParameterizedTest(name = "sortOrder={0} maps to expectedResult={1}")
        @MethodSource("provideSortOrderMappings")
        @DisplayName(
            "GIVEN any SortOrderDto → " +
                "WHEN isAscending called → " +
                "THEN returns correct boolean value",
        )
        fun whenSortOrder_thenReturnsCorrectBoolean(
            sortOrder: SortOrderDto,
            expectedResult: Boolean,
        ) {
            // When
            val result = sortOrder.isAscending()

            // Then
            result shouldBe expectedResult
        }

        fun provideSortOrderMappings(): List<Arguments> = listOf(
            Arguments.of(SortOrderDto.TIME_ASCENDING, true),
            Arguments.of(SortOrderDto.TIME_DESCENDING, false),
        )
    }
}
