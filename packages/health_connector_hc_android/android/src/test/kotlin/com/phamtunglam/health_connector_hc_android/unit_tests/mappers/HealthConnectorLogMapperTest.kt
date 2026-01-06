package com.phamtunglam.health_connector_hc_android.unit_tests.mappers

import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toExceptionInfoDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorLogLevelDto
import io.kotest.matchers.nulls.shouldBeNull
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
 * Unit tests for HealthConnectorLogMapper.
 *
 * Tests verify proper mapping between:
 * - [HealthConnectorLogger.LogLevel] and [HealthConnectorLogLevelDto]
 * - [Throwable] and [HealthConnectorExceptionDto]
 *
 * Ensures that all log levels and exceptions are correctly converted for cross-platform
 * communication via Pigeon.
 */
@DisplayName("HealthConnectorLogMapper")
class HealthConnectorLogMapperTest {

    private companion object {
        const val TEST_MESSAGE = "Test error message"
        const val CAUSE_MESSAGE = "Underlying cause message"
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("LogLevel.toDto")
    inner class LogLevelToDto {

        @ParameterizedTest(name = "logLevel={0} maps to dto={1}")
        @MethodSource("provideAllLogLevels")
        @DisplayName(
            "GIVEN any LogLevel → " +
                "WHEN toDto called → " +
                "THEN maps to correct HealthConnectorLogLevelDto",
        )
        fun whenAnyLogLevel_thenMapsToCorrectDto(
            logLevel: HealthConnectorLogger.LogLevel,
            expectedDto: HealthConnectorLogLevelDto,
        ) {
            // When
            val result = logLevel.toDto()

            // Then
            result shouldBe expectedDto
        }

        fun provideAllLogLevels(): List<Arguments> = listOf(
            Arguments.of(
                HealthConnectorLogger.LogLevel.DEBUG,
                HealthConnectorLogLevelDto.DEBUG,
            ),
            Arguments.of(
                HealthConnectorLogger.LogLevel.INFO,
                HealthConnectorLogLevelDto.INFO,
            ),
            Arguments.of(
                HealthConnectorLogger.LogLevel.WARNING,
                HealthConnectorLogLevelDto.WARNING,
            ),
            Arguments.of(
                HealthConnectorLogger.LogLevel.ERROR,
                HealthConnectorLogLevelDto.ERROR,
            ),
        )
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Throwable.toExceptionInfoDto")
    inner class ThrowableToExceptionInfoDto {

        @ParameterizedTest(name = "exception={0} maps to code={1}")
        @MethodSource("provideHealthConnectorExceptions")
        @DisplayName(
            "GIVEN HealthConnectorException → " +
                "WHEN toExceptionInfoDto called → " +
                "THEN maps with correct error code",
        )
        fun whenHealthConnectorException_thenMapsWithCorrectCode(
            exception: HealthConnectorException,
            expectedCode: HealthConnectorErrorCodeDto,
        ) {
            // When
            val result = exception.toExceptionInfoDto()

            // Then
            result.code shouldBe expectedCode
        }

        @Test
        @DisplayName(
            "GIVEN HealthConnectorException with message → " +
                "WHEN toExceptionInfoDto → " +
                "THEN includes message",
        )
        fun whenHealthConnectorExceptionWithMessage_thenIncludesMessage() {
            // Given
            val exception = HealthConnectorException.InvalidArgument(
                message = TEST_MESSAGE,
            )

            // When
            val result = exception.toExceptionInfoDto()

            // Then
            result.message shouldBe TEST_MESSAGE
        }

        @Test
        @DisplayName(
            "GIVEN HealthConnectorException with cause → " +
                "WHEN toExceptionInfoDto → " +
                "THEN includes cause message",
        )
        fun whenHealthConnectorExceptionWithCause_thenIncludesCauseMessage() {
            // Given
            val cause = IllegalArgumentException(CAUSE_MESSAGE)
            val exception = HealthConnectorException.RemoteError(
                message = TEST_MESSAGE,
                cause = cause,
            )

            // When
            val result = exception.toExceptionInfoDto()

            // Then
            result.cause shouldBe CAUSE_MESSAGE
        }

        @Test
        @DisplayName(
            "GIVEN HealthConnectorException without cause → " +
                "WHEN toExceptionInfoDto → " +
                "THEN cause is null",
        )
        fun whenHealthConnectorExceptionWithoutCause_thenCauseIsNull() {
            // Given
            val exception = HealthConnectorException.NotAuthorized(
                message = TEST_MESSAGE,
            )

            // When
            val result = exception.toExceptionInfoDto()

            // Then
            result.cause.shouldBeNull()
        }

        @Test
        @DisplayName(
            "GIVEN non-HealthConnectorException → " +
                "WHEN toExceptionInfoDto → " +
                "THEN maps with UNKNOWN error code",
        )
        fun whenNonHealthConnectorException_thenMapsWithUnknownCode() {
            // Given
            val exception = RuntimeException("Generic runtime error")

            // When
            val result = exception.toExceptionInfoDto()

            // Then
            result.code shouldBe HealthConnectorErrorCodeDto.UNKNOWN
            result.message shouldBe "Generic runtime error"
        }

        @Test
        @DisplayName(
            "GIVEN non-HealthConnectorException without message → " +
                "WHEN toExceptionInfoDto → " +
                "THEN uses default message",
        )
        fun whenNonHealthConnectorExceptionWithoutMessage_thenUsesDefaultMessage() {
            // Given
            val exception = object : Throwable() {
                override val message: String? = null
            }

            // When
            val result = exception.toExceptionInfoDto()

            // Then
            result.code shouldBe HealthConnectorErrorCodeDto.UNKNOWN
            result.message shouldBe "Unknown error"
        }

        @Test
        @DisplayName(
            "GIVEN non-HealthConnectorException with cause → " +
                "WHEN toExceptionInfoDto → " +
                "THEN includes cause message",
        )
        fun whenNonHealthConnectorExceptionWithCause_thenIncludesCauseMessage() {
            // Given
            val cause = NullPointerException(CAUSE_MESSAGE)
            val exception = IllegalStateException("State error", cause)

            // When
            val result = exception.toExceptionInfoDto()

            // Then
            result.code shouldBe HealthConnectorErrorCodeDto.UNKNOWN
            result.message shouldBe "State error"
            result.cause shouldBe CAUSE_MESSAGE
        }

        @Test
        @DisplayName(
            "GIVEN HealthConnectorException without message → " +
                "WHEN toExceptionInfoDto → " +
                "THEN uses default message",
        )
        fun whenHealthConnectorExceptionWithoutMessage_thenUsesDefaultMessage() {
            // Given
            val exception = HealthConnectorException.Unknown(
                message = "",
            )

            // When
            val result = exception.toExceptionInfoDto()

            // Then
            result.message shouldBe "Unknown error"
        }

        @Test
        @DisplayName(
            "GIVEN exception with cause without message → " +
                "WHEN toExceptionInfoDto → " +
                "THEN uses cause toString",
        )
        fun whenExceptionWithCauseWithoutMessage_thenUsesToString() {
            // Given
            val cause = object : Throwable() {
                override val message: String? = null
                override fun toString() = "CustomThrowableType"
            }
            val exception = HealthConnectorException.Unknown(
                message = TEST_MESSAGE,
                cause = cause,
            )

            // When
            val result = exception.toExceptionInfoDto()

            // Then
            result.cause.shouldNotBeNull()
            result.cause shouldContain "CustomThrowableType"
        }

        fun provideHealthConnectorExceptions(): List<Arguments> = listOf(
            Arguments.of(
                HealthConnectorException.HealthPlatformNotInstalledOrUpdateRequired(TEST_MESSAGE),
                HealthConnectorErrorCodeDto.HEALTH_PLATFORM_NOT_INSTALLED_OR_UPDATE_REQUIRED,
            ),
            Arguments.of(
                HealthConnectorException.HealthPlatformUnavailable(TEST_MESSAGE),
                HealthConnectorErrorCodeDto.HEALTH_PLATFORM_UNAVAILABLE,
            ),
            Arguments.of(
                HealthConnectorException.InvalidConfiguration(TEST_MESSAGE),
                HealthConnectorErrorCodeDto.INVALID_CONFIGURATION,
            ),
            Arguments.of(
                HealthConnectorException.InvalidArgument(TEST_MESSAGE),
                HealthConnectorErrorCodeDto.INVALID_ARGUMENT,
            ),
            Arguments.of(
                HealthConnectorException.UnsupportedOperation(TEST_MESSAGE),
                HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION,
            ),
            Arguments.of(
                HealthConnectorException.NotAuthorized(TEST_MESSAGE),
                HealthConnectorErrorCodeDto.NOT_AUTHORIZED,
            ),
            Arguments.of(
                HealthConnectorException.RemoteError(TEST_MESSAGE),
                HealthConnectorErrorCodeDto.REMOTE_ERROR,
            ),
            Arguments.of(
                HealthConnectorException.Unknown(TEST_MESSAGE),
                HealthConnectorErrorCodeDto.UNKNOWN,
            ),
        )
    }
}
