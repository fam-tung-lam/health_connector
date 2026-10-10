package com.phamtunglam.health_connector_hc_android.unit_tests

import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.testing.FakeHealthConnectClient
import androidx.health.connect.client.testing.FakePermissionController
import androidx.health.connect.client.units.Volume
import com.phamtunglam.health_connector_hc_android.HealthConnectorClient
import com.phamtunglam.health_connector_hc_android.handlers.HealthRecordHandlerRegistry
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataSyncResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataSyncTokenDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HydrationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.SortOrderDto
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorDataOriginService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorDataSyncService
import com.phamtunglam.health_connector_hc_android.utils.MainDispatcherExtension
import com.phamtunglam.health_connector_hc_android.utils.TestDispatcherProvider
import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import io.mockk.coEvery
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import java.time.Instant
import kotlin.coroutines.cancellation.CancellationException
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@DisplayName("HealthConnectorClient — source display names")
@ExtendWith(MainDispatcherExtension::class)
class HealthConnectorDataOriginClientTest {

    private val testDispatcher = StandardTestDispatcher()
    private lateinit var fakeHealthConnectClient: FakeHealthConnectClient
    private lateinit var packageManager: PackageManager
    private lateinit var syncService: HealthConnectorDataSyncService
    private lateinit var systemUnderTest: HealthConnectorClient

    @BeforeEach
    fun setUp() {
        HealthConnectorLogger.isEnabled = false
        fakeHealthConnectClient = FakeHealthConnectClient(
            packageName = PACKAGE_NAME,
            permissionController = FakePermissionController(grantAll = true),
        )
        packageManager = mockk()
        val appInfo = mockk<ApplicationInfo>()
        every { packageManager.getApplicationInfo(PACKAGE_NAME, 0) } returns appInfo
        every { packageManager.getApplicationLabel(appInfo) } returns "Health App"
        syncService = mockk()
        val dispatchers = TestDispatcherProvider(testDispatcher)
        systemUnderTest = HealthConnectorClient(
            dispatchers = dispatchers,
            client = fakeHealthConnectClient,
            manifestService = mockk(),
            featureService = mockk(),
            permissionService = mockk(),
            syncService = syncService,
            recordHandlerRegistry = HealthRecordHandlerRegistry(
                dispatchers,
                fakeHealthConnectClient,
            ),
            dataOriginService = HealthConnectorDataOriginService(packageManager),
            supportsHealthConnectSdkExtension21 = false,
        )
    }

    @Test
    @DisplayName("GIVEN a stored record → WHEN reading by ID → THEN includes the source name")
    fun `single record reads include the resolved name`() = runTest(testDispatcher) {
        // Given
        val id = fakeHealthConnectClient.insertRecords(
            listOf(waterRecord(0.25)),
        ).recordIdsList.single()

        // When
        // The SDK fake resolves client IDs into its package-prefixed record IDs.
        val record = systemUnderTest.readRecord(
            ReadRecordRequestDto("water-0", HealthDataTypeDto.HYDRATION),
        ) as HydrationRecordDto

        // Then
        record.id shouldBe id
        record.liters shouldBe 0.25
        record.metadata.dataOrigin shouldBe PACKAGE_NAME
        record.metadata.dataOriginDisplayName shouldBe "Health App"
    }

    @Test
    @DisplayName(
        "GIVEN paginated records → WHEN reading each page → " +
            "THEN preserves pagination and adds source names",
    )
    fun `pages retain their records tokens and source names`() = runTest(testDispatcher) {
        // Given
        fakeHealthConnectClient.insertRecords(listOf(waterRecord(0.25), waterRecord(0.5, 60)))
        val request = ReadRecordsRequestDto(
            dataType = HealthDataTypeDto.HYDRATION,
            startTime = START_TIME.toEpochMilli(),
            endTime = START_TIME.plusSeconds(180).toEpochMilli(),
            pageSize = 1,
            dataOriginPackageNames = emptyList(),
            sortOrder = SortOrderDto.TIME_ASCENDING,
        )

        // When
        val firstPage = systemUnderTest.readRecords(request)
        val secondPage = systemUnderTest.readRecords(
            request.copy(pageToken = firstPage.nextPageToken.shouldNotBeNull()),
        )

        // Then
        val first = firstPage.records.single() as HydrationRecordDto
        val second = secondPage.records.single() as HydrationRecordDto
        first.liters shouldBe 0.25
        second.liters shouldBe 0.5
        first.metadata.dataOriginDisplayName shouldBe "Health App"
        second.metadata.dataOriginDisplayName shouldBe "Health App"
        secondPage.nextPageToken shouldBe null
    }

    @Test
    @DisplayName(
        "GIVEN synchronization changes → WHEN returning upserts → " +
            "THEN adds names and preserves deletions and sync state",
    )
    fun `synchronization preserves state while enriching upserts`() = runTest(testDispatcher) {
        // Given
        val token = HealthDataSyncTokenDto(
            token = "next-token",
            dataTypes = listOf(HealthDataTypeDto.HYDRATION),
            createdAtMillis = START_TIME.toEpochMilli(),
        )
        val dto = HydrationRecordDto(
            id = "upserted-water",
            startTime = START_TIME.toEpochMilli(),
            endTime = START_TIME.plusSeconds(30).toEpochMilli(),
            liters = 0.25,
            metadata = MetadataDto(
                dataOrigin = PACKAGE_NAME,
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )
        coEvery { syncService.synchronize(any(), any()) } returns HealthDataSyncResultDto(
            upsertedRecords = listOf(dto),
            deletedRecordIds = listOf("deleted-water"),
            hasMore = true,
            nextSyncToken = token,
        )

        // When
        val result = systemUnderTest.synchronize(listOf(HealthDataTypeDto.HYDRATION), null)

        // Then
        val record = result.upsertedRecords.single() as HydrationRecordDto
        record.id shouldBe "upserted-water"
        record.metadata.dataOriginDisplayName shouldBe "Health App"
        result.deletedRecordIds shouldBe listOf("deleted-water")
        result.hasMore shouldBe true
        result.nextSyncToken shouldBe token
    }

    @Test
    @DisplayName(
        "GIVEN a cancelled health operation → WHEN synchronizing → " +
            "THEN propagates cancellation without resolving labels",
    )
    fun `health operation cancellation remains a failure`() = runTest(testDispatcher) {
        // Given
        coEvery { syncService.synchronize(any(), any()) } throws CancellationException("cancelled")

        // When / Then
        shouldThrow<CancellationException> {
            systemUnderTest.synchronize(listOf(HealthDataTypeDto.HYDRATION), null)
        }
        verify(exactly = 0) { packageManager.getApplicationInfo(any<String>(), any<Int>()) }
    }

    private fun waterRecord(liters: Double, offsetSeconds: Long = 0): HydrationRecord =
        HydrationRecord(
            startTime = START_TIME.plusSeconds(offsetSeconds),
            endTime = START_TIME.plusSeconds(offsetSeconds + 30),
            startZoneOffset = null,
            endZoneOffset = null,
            volume = Volume.liters(liters),
            metadata = Metadata.manualEntry(clientRecordId = "water-$offsetSeconds"),
        )

    private companion object {
        const val PACKAGE_NAME = "com.example.health"
        val START_TIME: Instant = Instant.parse("2026-01-01T12:00:00Z")
    }
}
