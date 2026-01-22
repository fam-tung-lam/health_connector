package com.phamtunglam.health_connector_hc_android.unit_tests.handlers

import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.testing.AggregationResult
import androidx.health.connect.client.testing.FakeHealthConnectClient
import androidx.health.connect.client.testing.FakePermissionController
import androidx.health.connect.client.testing.stubs.stub
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.SleepSessionHandler
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.StandardAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.utils.MainDispatcherExtension
import io.kotest.matchers.shouldBe
import io.mockk.unmockkAll
import java.time.Instant
import kotlin.time.Duration.Companion.hours
import kotlin.time.toJavaDuration
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@DisplayName("SleepSessionHandler")
@ExtendWith(MainDispatcherExtension::class)
class SleepSessionHandlerTest {

    private lateinit var fakePermissionController: FakePermissionController
    private lateinit var fakeHealthConnectClient: FakeHealthConnectClient
    private lateinit var systemUnderTest: SleepSessionHandler

    @BeforeEach
    fun setUp() {
        HealthConnectorLogger.isEnabled = false
        fakePermissionController = FakePermissionController(grantAll = true)
        fakeHealthConnectClient = FakeHealthConnectClient(
            packageName = FAKE_PACKAGE_NAME,
            permissionController = fakePermissionController,
        )
        systemUnderTest = SleepSessionHandler(
            dispatcher = Dispatchers.Main.immediate,
            client = fakeHealthConnectClient,
        )
    }

    @AfterEach
    fun tearDown() {
        unmockkAll()
    }

    @Nested
    @DisplayName(
        "GIVEN aggregation → ",
    )
    inner class Aggregation {

        @Test
        @DisplayName(
            "WHEN aggregating SUM → " +
                "THEN returns correct duration in SECONDS",
        )
        fun `aggregate sum for sleep duration returns seconds`() = runTest {
            val startTime = FIXED_NOW.minusSeconds(86400)
            val endTime = FIXED_NOW
            val sleepDuration = 8.hours // 8 hours = 28800 seconds

            val result = AggregationResult(
                metrics = buildMap {
                    put(
                        SleepSessionRecord.SLEEP_DURATION_TOTAL,
                        sleepDuration.toJavaDuration(),
                    )
                },
            )
            fakeHealthConnectClient.overrides.aggregate = stub(result)

            val request = StandardAggregateRequestDto(
                dataType = HealthDataTypeDto.SLEEP_SESSION,
                aggregationMetric = AggregationMetricDto.SUM,
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
            )

            val response = systemUnderTest.aggregate(request)

            // 8 hours in seconds is 28800.0
            response shouldBe 28800.0
        }
    }

    private companion object Companion {
        const val FAKE_PACKAGE_NAME = "com.test"
        val FIXED_NOW: Instant = Instant.parse("2026-01-01T12:00:00Z")
    }
}
