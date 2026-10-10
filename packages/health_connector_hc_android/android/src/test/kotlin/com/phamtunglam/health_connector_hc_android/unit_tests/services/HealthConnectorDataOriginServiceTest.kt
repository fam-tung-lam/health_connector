package com.phamtunglam.health_connector_hc_android.unit_tests.services

import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateSampleDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HydrationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MealTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.NutritionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorDataOriginService
import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.shouldBe
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import kotlin.coroutines.cancellation.CancellationException
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.ValueSource

@DisplayName("HealthConnectorDataOriginService")
class HealthConnectorDataOriginServiceTest {

    private lateinit var packageManager: PackageManager
    private lateinit var appInfo: ApplicationInfo
    private lateinit var systemUnderTest: HealthConnectorDataOriginService

    @BeforeEach
    fun setUp() {
        HealthConnectorLogger.isEnabled = false
        packageManager = mockk()
        appInfo = mockk()
        every { packageManager.getApplicationInfo(PACKAGE_NAME, 0) } returns appInfo
        every { packageManager.getApplicationLabel(appInfo) } returns " Santé Health "
        systemUnderTest = HealthConnectorDataOriginService(packageManager)
    }

    @Test
    @DisplayName(
        "GIVEN multiple record shapes → WHEN resolving names → " +
            "THEN preserves all record data and looks up each source once",
    )
    fun `names are added to instant interval series and nutrition records`() = runTest {
        // Given
        val metadata = metadata()
        val records = listOf(
            HeightRecordDto(id = "height", time = START_TIME, meters = 1.75, metadata = metadata),
            hydration(),
            HeartRateSeriesRecordDto(
                id = "heart-rate",
                startTime = START_TIME,
                endTime = END_TIME,
                metadata = metadata,
                samples = listOf(HeartRateSampleDto(time = START_TIME, beatsPerMinute = 72.0)),
            ),
            NutritionRecordDto(
                id = "nutrition",
                metadata = metadata,
                startTime = START_TIME,
                endTime = END_TIME,
                healthDataType = HealthDataTypeDto.NUTRITION,
                mealType = MealTypeDto.LUNCH,
                foodName = "Lunch",
                proteinInGrams = 20.0,
            ),
        )

        // When
        val results = systemUnderTest.withDisplayNames(records)

        // Then
        val height = results[0] as HeightRecordDto
        height.id shouldBe "height"
        height.time shouldBe START_TIME
        height.meters shouldBe 1.75
        height.metadata.dataOriginDisplayName shouldBe " Santé Health "
        val water = results[1] as HydrationRecordDto
        water.id shouldBe "water"
        water.liters shouldBe 0.25
        water.startZoneOffsetSeconds shouldBe 3600L
        water.endTime shouldBe END_TIME
        water.metadata.clientRecordId shouldBe "client-record"
        water.metadata.clientRecordVersion shouldBe 2L
        water.metadata.dataOrigin shouldBe PACKAGE_NAME
        water.metadata.dataOriginDisplayName shouldBe " Santé Health "
        val heartRate = results[2] as HeartRateSeriesRecordDto
        heartRate.samples.single().beatsPerMinute shouldBe 72.0
        heartRate.metadata.dataOriginDisplayName shouldBe " Santé Health "
        val nutrition = results[3] as NutritionRecordDto
        nutrition.foodName shouldBe "Lunch"
        nutrition.proteinInGrams shouldBe 20.0
        nutrition.metadata.dataOriginDisplayName shouldBe " Santé Health "
        metadata.dataOriginDisplayName shouldBe null
        verify(exactly = 1) { packageManager.getApplicationInfo(PACKAGE_NAME, 0) }
    }

    @Test
    @DisplayName(
        "GIVEN an unavailable source → WHEN reading repeated records → " +
            "THEN returns absent names and caches the failed lookup for the response",
    )
    fun `unavailable source names do not fail records`() = runTest {
        // Given
        every { packageManager.getApplicationInfo(PACKAGE_NAME, 0) } throws
            mockk<PackageManager.NameNotFoundException>(relaxed = true)

        // When
        val results = systemUnderTest.withDisplayNames(listOf(hydration(), hydration()))

        // Then
        results.map { (it as HydrationRecordDto).metadata.dataOriginDisplayName } shouldBe
            listOf(null, null)
        verify(exactly = 1) { packageManager.getApplicationInfo(PACKAGE_NAME, 0) }
    }

    @Test
    @DisplayName(
        "GIVEN label access denied → WHEN reading a record → THEN retains an unnamed source",
    )
    fun `denied label access does not fail the record`() = runTest {
        // Given
        every { packageManager.getApplicationLabel(appInfo) } throws SecurityException("denied")

        // When
        val record = systemUnderTest.withDisplayName(hydration()) as HydrationRecordDto

        // Then
        record.metadata.dataOrigin shouldBe PACKAGE_NAME
        record.metadata.dataOriginDisplayName shouldBe null
        record.liters shouldBe 0.25
    }

    @ParameterizedTest
    @ValueSource(strings = ["", " \t\n"])
    @DisplayName(
        "GIVEN a blank platform label → WHEN reading a record → THEN returns no display name",
    )
    fun `blank labels remain absent`(label: String) = runTest {
        // Given
        every { packageManager.getApplicationLabel(appInfo) } returns label

        // When
        val record = systemUnderTest.withDisplayName(hydration()) as HydrationRecordDto

        // Then
        record.metadata.dataOriginDisplayName shouldBe null
    }

    @Test
    @DisplayName("GIVEN a resolved source → WHEN reading again → THEN reuses the resolved name")
    fun `resolved display names are reused across responses`() = runTest {
        // Given
        systemUnderTest.withDisplayName(hydration())
        every { packageManager.getApplicationLabel(appInfo) } returns "Renamed Health"

        // When
        val record = systemUnderTest.withDisplayName(hydration()) as HydrationRecordDto

        // Then
        record.metadata.dataOriginDisplayName shouldBe " Santé Health "
        verify(exactly = 1) { packageManager.getApplicationInfo(PACKAGE_NAME, 0) }
    }

    @Test
    @DisplayName(
        "GIVEN a previously unavailable package → WHEN it becomes visible → " +
            "THEN a subsequent response includes its name",
    )
    fun `failed lookups are refreshed between responses`() = runTest {
        // Given
        every { packageManager.getApplicationInfo(PACKAGE_NAME, 0) } throws
            mockk<PackageManager.NameNotFoundException>(relaxed = true)
        systemUnderTest.withDisplayName(hydration())
        every { packageManager.getApplicationInfo(PACKAGE_NAME, 0) } returns appInfo

        // When
        val record = systemUnderTest.withDisplayName(hydration()) as HydrationRecordDto

        // Then
        record.metadata.dataOriginDisplayName shouldBe " Santé Health "
    }

    @Test
    @DisplayName(
        "GIVEN records from different apps → WHEN resolving a response → " +
            "THEN each source retains its own name",
    )
    fun `different sources have separate labels`() = runTest {
        // Given
        val otherInfo = mockk<ApplicationInfo>()
        every { packageManager.getApplicationInfo("com.other.health", 0) } returns otherInfo
        every { packageManager.getApplicationLabel(otherInfo) } returns "Other Health"
        val otherRecord = hydration().copy(
            metadata = metadata().copy(dataOrigin = "com.other.health"),
        )

        // When
        val records = systemUnderTest.withDisplayNames(listOf(hydration(), otherRecord))

        // Then
        (records[0] as HydrationRecordDto).metadata.dataOriginDisplayName shouldBe " Santé Health "
        (records[1] as HydrationRecordDto).metadata.dataOriginDisplayName shouldBe "Other Health"
    }

    @Test
    @DisplayName("GIVEN a cancelled lookup → WHEN reading a record → THEN propagates cancellation")
    fun `cancellation is not converted to a missing name`() = runTest {
        // Given
        every { packageManager.getApplicationInfo(PACKAGE_NAME, 0) } throws
            CancellationException("cancelled")

        // When / Then
        shouldThrow<CancellationException> { systemUnderTest.withDisplayName(hydration()) }
    }

    private fun metadata(): MetadataDto = MetadataDto(
        dataOrigin = PACKAGE_NAME,
        recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
        deviceType = DeviceTypeDto.PHONE,
        clientRecordId = "client-record",
        clientRecordVersion = 2L,
    )

    private fun hydration(): HydrationRecordDto = HydrationRecordDto(
        id = "water",
        startTime = START_TIME,
        endTime = END_TIME,
        startZoneOffsetSeconds = 3600L,
        metadata = metadata(),
        liters = 0.25,
    )

    private companion object {
        const val PACKAGE_NAME = "com.example.health"
        const val START_TIME = 1767268800000L
        const val END_TIME = 1767268860000L
    }
}
