package com.phamtunglam.health_connector_hc_android.unit_tests.mappers

import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import io.kotest.matchers.maps.shouldContainKey
import io.kotest.matchers.maps.shouldNotContainKey
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for HealthConnectorExceptionMapper.
 *
 * Tests verify proper mapping between [HealthConnectorException] instances and
 * [HealthConnectorErrorDto]. Ensures that all exception details are correctly converted to a
 * format suitable for cross-platform communication.
 */
@DisplayName("HealthConnectorExceptionMapper")
@Suppress("UNCHECKED_CAST") // Suppressing unchecked cast warnings for details mapping
class HealthConnectorExceptionMapperTest {

    private companion object {
        const val TEST_MESSAGE = "Test error message"
        const val TEST_CONTEXT_KEY = "testKey"
        const val TEST_CONTEXT_VALUE = "testValue"
        const val CAUSE_MESSAGE = "Underlying cause message"
        const val NESTED_CAUSE_MESSAGE = "Nested cause message"
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("toDto")
    inner class ToDto {

        @ParameterizedTest(name = "exception={0} maps to code={1}")
        @MethodSource("provideAllExceptionTypes")
        @DisplayName(
            "GIVEN any HealthConnectorException → " +
                "WHEN toDto called → " +
                "THEN maps to correct error code",
        )
        fun whenAnyException_thenMapsToCorrectCode(
            exception: HealthConnectorException,
            expectedCode: HealthConnectorErrorCodeDto,
        ) {
            // When
            val result = exception.toDto()

            // Then
            result.code shouldBe expectedCode.name
        }

        @Test
        @DisplayName(
            "GIVEN exception with message → " +
                "WHEN toDto → " +
                "THEN includes message",
        )
        fun whenExceptionWithMessage_thenIncludesMessage() {
            // Given
            val exception = HealthConnectorException.InvalidArgument(
                message = TEST_MESSAGE,
            )

            // When
            val result = exception.toDto()

            // Then
            result.message shouldBe TEST_MESSAGE
        }

        @Test
        @DisplayName(
            "GIVEN exception with context → " +
                "WHEN toDto → " +
                "THEN includes context in details",
        )
        fun whenExceptionWithContext_thenIncludesContext() {
            // Given
            val context = mapOf(
                TEST_CONTEXT_KEY to TEST_CONTEXT_VALUE,
                "count" to 42,
                "enabled" to true,
            )
            val exception = HealthConnectorException.InvalidArgument(
                message = TEST_MESSAGE,
                context = context,
            )

            // When
            val result = exception.toDto()

            // Then
            result.details.shouldNotBeNull()
            val detailsMap = result.details as? Map<String, String>
            detailsMap.shouldNotBeNull()
            detailsMap shouldContainKey TEST_CONTEXT_KEY
            detailsMap[TEST_CONTEXT_KEY] shouldBe TEST_CONTEXT_VALUE
            detailsMap shouldContainKey "count"
            detailsMap["count"] shouldBe "42"
            detailsMap shouldContainKey "enabled"
            detailsMap["enabled"] shouldBe "true"
        }

        @Test
        @DisplayName(
            "GIVEN exception without context or cause → " +
                "WHEN toDto → " +
                "THEN details contains only debugDescription",
        )
        fun whenExceptionWithoutContextOrCause_thenDetailsContainsOnlyDebugDescription() {
            // Given
            val exception = HealthConnectorException.InvalidArgument(
                message = TEST_MESSAGE,
            )

            // When
            val result = exception.toDto()

            // Then
            result.details.shouldNotBeNull()
            val detailsMap = result.details as? Map<String, String>
            detailsMap.shouldNotBeNull()
            detailsMap shouldContainKey "debugDescription"
            detailsMap["debugDescription"] shouldContain "InvalidArgument"
            detailsMap["debugDescription"] shouldContain TEST_MESSAGE
        }

        @Test
        @DisplayName(
            "GIVEN exception with cause → " +
                "WHEN toDto → " +
                "THEN includes cause details",
        )
        fun whenExceptionWithCause_thenIncludesCauseDetails() {
            // Given
            val cause = IllegalArgumentException(CAUSE_MESSAGE)
            val exception = HealthConnectorException.HealthService(
                code = HealthConnectorErrorCodeDto.REMOTE_ERROR,
                message = TEST_MESSAGE,
                cause = cause,
            )

            // When
            val result = exception.toDto()

            // Then
            result.details.shouldNotBeNull()
            val detailsMap = result.details as? Map<String, String>
            detailsMap.shouldNotBeNull()
            detailsMap shouldContainKey "cause"
            detailsMap["cause"] shouldBe CAUSE_MESSAGE
            detailsMap shouldContainKey "causeType"
            detailsMap["causeType"] shouldBe "IllegalArgumentException"
        }

        @Test
        @DisplayName(
            "GIVEN exception with cause having stack trace → " +
                "WHEN toDto → " +
                "THEN includes formatted stack trace",
        )
        fun whenExceptionWithCauseHavingStackTrace_thenIncludesFormattedStackTrace() {
            // Given
            val cause = RuntimeException(CAUSE_MESSAGE)
            val exception = HealthConnectorException.Unknown(
                message = TEST_MESSAGE,
                cause = cause,
            )

            // When
            val result = exception.toDto()

            // Then
            result.details.shouldNotBeNull()
            val detailsMap = result.details as? Map<String, String>
            detailsMap.shouldNotBeNull()
            detailsMap shouldContainKey "causeStackTrace"
            val stackTrace = detailsMap["causeStackTrace"]
            stackTrace.shouldNotBeNull()
            stackTrace shouldContain "at "
        }

        @Test
        @DisplayName(
            "GIVEN exception with nested cause → " +
                "WHEN toDto → " +
                "THEN includes nested cause details",
        )
        fun whenExceptionWithNestedCause_thenIncludesNestedCauseDetails() {
            // Given
            val nestedCause = IllegalStateException(NESTED_CAUSE_MESSAGE)
            val cause = IllegalArgumentException(CAUSE_MESSAGE, nestedCause)
            val exception = HealthConnectorException.Authorization(
                code = HealthConnectorErrorCodeDto.PERMISSION_NOT_GRANTED,
                message = TEST_MESSAGE,
                cause = cause,
            )

            // When
            val result = exception.toDto()

            // Then
            result.details.shouldNotBeNull()
            val detailsMap = result.details as? Map<String, String>
            detailsMap.shouldNotBeNull()
            detailsMap shouldContainKey "nestedCause"
            detailsMap["nestedCause"] shouldBe NESTED_CAUSE_MESSAGE
            detailsMap shouldContainKey "nestedCauseType"
            detailsMap["nestedCauseType"] shouldBe "IllegalStateException"
        }

        @Test
        @DisplayName(
            "GIVEN exception with cause without message → " +
                "WHEN toDto → " +
                "THEN uses toString for cause",
        )
        fun whenExceptionWithCauseWithoutMessage_thenUsesToStringForCause() {
            // Given
            val cause = object : Throwable() {
                override fun toString() = "CustomThrowable"
            }
            val exception = HealthConnectorException.HealthService(
                code = HealthConnectorErrorCodeDto.REMOTE_ERROR,
                message = TEST_MESSAGE,
                cause = cause,
            )

            // When
            val result = exception.toDto()

            // Then
            result.details.shouldNotBeNull()
            val detailsMap = result.details as? Map<String, String>
            detailsMap.shouldNotBeNull()
            detailsMap shouldContainKey "cause"
            detailsMap["cause"] shouldBe "CustomThrowable"
        }

        @Test
        @DisplayName(
            "GIVEN exception with context and cause → " +
                "WHEN toDto → " +
                "THEN includes both in details",
        )
        fun whenExceptionWithContextAndCause_thenIncludesBothInDetails() {
            // Given
            val context = mapOf(TEST_CONTEXT_KEY to TEST_CONTEXT_VALUE)
            val cause = RuntimeException(CAUSE_MESSAGE)
            val exception = HealthConnectorException.Configuration(
                message = TEST_MESSAGE,
                context = context,
                cause = cause,
            )

            // When
            val result = exception.toDto()

            // Then
            result.details.shouldNotBeNull()
            val detailsMap = result.details as? Map<String, String>
            detailsMap.shouldNotBeNull()
            // Context
            detailsMap shouldContainKey TEST_CONTEXT_KEY
            detailsMap[TEST_CONTEXT_KEY] shouldBe TEST_CONTEXT_VALUE
            // Cause
            detailsMap shouldContainKey "cause"
            detailsMap["cause"] shouldBe CAUSE_MESSAGE
            detailsMap shouldContainKey "causeType"
            // Debug description
            detailsMap shouldContainKey "debugDescription"
        }

        @Test
        @DisplayName(
            "GIVEN exception with empty stack trace → " +
                "WHEN toDto → " +
                "THEN causeStackTrace is not included",
        )
        fun whenExceptionWithEmptyStackTrace_thenStackTraceNotIncluded() {
            // Given
            val cause = object : Throwable(CAUSE_MESSAGE) {
                override fun getStackTrace(): Array<StackTraceElement> = emptyArray()
            }
            val exception = HealthConnectorException.UnsupportedOperation(
                message = TEST_MESSAGE,
                cause = cause,
            )

            // When
            val result = exception.toDto()

            // Then
            result.details.shouldNotBeNull()
            val detailsMap = result.details as? Map<String, String>
            detailsMap.shouldNotBeNull()
            detailsMap shouldNotContainKey "causeStackTrace"
        }

        @Test
        @DisplayName(
            "GIVEN HealthPlatformNotInstalledOrUpdateRequired → " +
                "WHEN toDto → " +
                "THEN maps correctly",
        )
        fun whenHealthPlatformNotInstalledOrUpdateRequired_thenMapsCorrectly() {
            // Given
            val exception = HealthConnectorException.HealthServiceUnavailable(
                code = HealthConnectorErrorCodeDto.HEALTH_SERVICE_NOT_INSTALLED_OR_UPDATE_REQUIRED,
                message = "Health Connect not installed",
            )

            // When
            val result = exception.toDto()

            // Then
            result.code shouldBe
                HealthConnectorErrorCodeDto.HEALTH_SERVICE_NOT_INSTALLED_OR_UPDATE_REQUIRED.name
            result.message shouldBe "Health Connect not installed"
        }

        @Test
        @DisplayName(
            "GIVEN HealthPlatformUnavailable → " +
                "WHEN toDto → " +
                "THEN maps correctly",
        )
        fun whenHealthPlatformUnavailable_thenMapsCorrectly() {
            // Given
            val exception = HealthConnectorException.HealthServiceUnavailable(
                code = HealthConnectorErrorCodeDto.HEALTH_SERVICE_UNAVAILABLE,
                message = "Health service unavailable",
            )

            // When
            val result = exception.toDto()

            // Then
            result.code shouldBe HealthConnectorErrorCodeDto.HEALTH_SERVICE_UNAVAILABLE.name
            result.message shouldBe "Health service unavailable"
        }

        fun provideAllExceptionTypes(): List<Arguments> = listOf(
            Arguments.of(
                HealthConnectorException.HealthServiceUnavailable(
                    code =
                    HealthConnectorErrorCodeDto.HEALTH_SERVICE_NOT_INSTALLED_OR_UPDATE_REQUIRED,
                    message = TEST_MESSAGE,
                ),
                HealthConnectorErrorCodeDto.HEALTH_SERVICE_NOT_INSTALLED_OR_UPDATE_REQUIRED,
            ),
            Arguments.of(
                HealthConnectorException.HealthServiceUnavailable(
                    code = HealthConnectorErrorCodeDto.HEALTH_SERVICE_UNAVAILABLE,
                    message = TEST_MESSAGE,
                ),
                HealthConnectorErrorCodeDto.HEALTH_SERVICE_UNAVAILABLE,
            ),
            Arguments.of(
                HealthConnectorException.Configuration(
                    message = TEST_MESSAGE,
                ),
                HealthConnectorErrorCodeDto.PERMISSION_NOT_DECLARED,
            ),
            Arguments.of(
                HealthConnectorException.InvalidArgument(
                    message = TEST_MESSAGE,
                ),
                HealthConnectorErrorCodeDto.INVALID_ARGUMENT,
            ),
            Arguments.of(
                HealthConnectorException.UnsupportedOperation(
                    message = TEST_MESSAGE,
                ),
                HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION,
            ),
            Arguments.of(
                HealthConnectorException.Authorization(
                    code = HealthConnectorErrorCodeDto.PERMISSION_NOT_GRANTED,
                    message = TEST_MESSAGE,
                ),
                HealthConnectorErrorCodeDto.PERMISSION_NOT_GRANTED,
            ),
            Arguments.of(
                HealthConnectorException.HealthService(
                    code = HealthConnectorErrorCodeDto.REMOTE_ERROR,
                    message = TEST_MESSAGE,
                ),
                HealthConnectorErrorCodeDto.REMOTE_ERROR,
            ),
            Arguments.of(
                HealthConnectorException.Unknown(
                    message = TEST_MESSAGE,
                ),
                HealthConnectorErrorCodeDto.UNKNOWN_ERROR,
            ),
        )
    }
}
