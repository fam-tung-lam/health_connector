package com.phamtunglam.health_connector_hc_android.unit_tests.utils

import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import com.phamtunglam.health_connector_hc_android.utils.toError
import io.kotest.matchers.nulls.shouldBeNull
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.EnumSource

/**
 * Unit tests for HealthConnectorError Extensions.
 *
 * Tests verify proper creation of [HealthConnectorErrorDto] instances from
 * [HealthConnectorErrorCodeDto] using the toError extension function.
 */
@DisplayName("HealthConnectorErrorExtensions")
class HealthConnectorErrorExtensionTest {

    @Nested
    @DisplayName("toError Extension")
    inner class ToErrorExtension {

        @ParameterizedTest(name = "errorCode={0}")
        @EnumSource(HealthConnectorErrorCodeDto::class)
        @DisplayName(
            "GIVEN any HealthConnectorErrorCodeDto → " +
                "WHEN toError called with no parameters → " +
                "THEN creates error with code name and null message/details",
        )
        fun whenAnyErrorCode_thenCreatesErrorWithCodeName(errorCode: HealthConnectorErrorCodeDto) {
            // When
            val result = errorCode.toError()

            // Then
            result.code shouldBe errorCode.name
            result.message.shouldBeNull()
            result.details.shouldBeNull()
        }

        @Test
        @DisplayName(
            "GIVEN HEALTH_PLATFORM_UNAVAILABLE error code → " +
                "WHEN toError called with message → " +
                "THEN creates error with code and message",
        )
        fun whenErrorCodeWithMessage_thenCreatesErrorWithMessage() {
            // Given
            val errorCode = HealthConnectorErrorCodeDto.HEALTH_PLATFORM_UNAVAILABLE
            val message = "Health Connect is not available on this device"

            // When
            val result = errorCode.toError(message = message)

            // Then
            result.code shouldBe "HEALTH_PLATFORM_UNAVAILABLE"
            result.message shouldBe message
            result.details.shouldBeNull()
        }

        @Test
        @DisplayName(
            "GIVEN NOT_AUTHORIZED error code → " +
                "WHEN toError called with message and details → " +
                "THEN creates error with all fields",
        )
        fun whenErrorCodeWithMessageAndDetails_thenCreatesErrorWithAllFields() {
            // Given
            val errorCode = HealthConnectorErrorCodeDto.NOT_AUTHORIZED
            val message = "Permission denied for steps data"
            val details = mapOf<String, Any>(
                "dataType" to "STEPS",
                "accessType" to "READ",
            )

            // When
            val result = errorCode.toError(message = message, details = details)

            // Then
            result.code shouldBe "NOT_AUTHORIZED"
            result.message shouldBe message
            result.details shouldBe details
        }

        @Test
        @DisplayName(
            "GIVEN error code → " +
                "WHEN toError called with only details → " +
                "THEN creates error with code and details, null message",
        )
        fun whenErrorCodeWithOnlyDetails_thenCreatesErrorWithDetailsAndNullMessage() {
            // Given
            val errorCode = HealthConnectorErrorCodeDto.INVALID_ARGUMENT
            val details = mapOf<String, Any>(
                "field" to "startTime",
                "value" to -1L,
                "reason" to "Start time cannot be negative",
            )

            // When
            val result = errorCode.toError(details = details)

            // Then
            result.code shouldBe "INVALID_ARGUMENT"
            result.message.shouldBeNull()
            result.details shouldBe details
        }

        @Nested
        @DisplayName("Details Map Contents")
        inner class DetailsMapContents {

            @Test
            @DisplayName(
                "GIVEN error with multiple detail entries → " +
                    "WHEN toError called → " +
                    "THEN preserves all detail entries",
            )
            fun whenMultipleDetailEntries_thenPreservesAllEntries() {
                // Given
                val errorCode = HealthConnectorErrorCodeDto.INVALID_ARGUMENT
                val details = mapOf(
                    "field1" to "value1",
                    "field2" to 123,
                    "field3" to true,
                    "field4" to listOf("a", "b", "c"),
                )

                // When
                val result = errorCode.toError(details = details)

                // Then
                result.details shouldBe details
            }

            @Test
            @DisplayName(
                "GIVEN error with empty details map → " +
                    "WHEN toError called → " +
                    "THEN creates error with empty details",
            )
            fun whenEmptyDetailsMap_thenCreatesErrorWithEmptyDetails() {
                // Given
                val errorCode = HealthConnectorErrorCodeDto.NOT_AUTHORIZED
                val details = emptyMap<String, Any>()

                // When
                val result = errorCode.toError(details = details)

                // Then
                result.details shouldBe details
            }

            @Test
            @DisplayName(
                "GIVEN error with complex detail values → " +
                    "WHEN toError called → " +
                    "THEN preserves complex values",
            )
            fun whenComplexDetailValues_thenPreservesValues() {
                // Given
                val errorCode = HealthConnectorErrorCodeDto.INVALID_ARGUMENT
                val nestedMap = mapOf("nested" to "value")
                val details = mapOf(
                    "string" to "test",
                    "number" to 42,
                    "boolean" to false,
                    "list" to listOf(1, 2, 3),
                    "map" to nestedMap,
                )

                // When
                val result = errorCode.toError(details = details)

                // Then
                result.details shouldBe details
            }
        }
    }
}
