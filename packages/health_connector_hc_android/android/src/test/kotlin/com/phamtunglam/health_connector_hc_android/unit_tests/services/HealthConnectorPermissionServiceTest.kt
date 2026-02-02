package com.phamtunglam.health_connector_hc_android.unit_tests.services

import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultCallback
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.ActivityResultRegistry
import androidx.activity.result.contract.ActivityResultContract
import androidx.health.connect.client.contracts.ExerciseRouteRequestContract
import androidx.health.connect.client.records.ExerciseRoute
import androidx.health.connect.client.testing.FakePermissionController
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseRoutePermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseRoutePermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequest
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionAccessTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestsDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorPermissionService
import com.phamtunglam.health_connector_hc_android.utils.MainDispatcherExtension
import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.collections.shouldBeEmpty
import io.kotest.matchers.collections.shouldContainAll
import io.kotest.matchers.shouldBe
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.slot
import io.mockk.unmockkAll
import io.mockk.verify
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.api.extension.ExtendWith
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

@OptIn(ExperimentalCoroutinesApi::class)
@ExtendWith(MainDispatcherExtension::class)
@DisplayName("HealthConnectorPermissionService")
class HealthConnectorPermissionServiceTest {

    private companion object {
        // Health Connect Permission Strings
        const val STEPS_READ_PERMISSION = "android.permission.health.READ_STEPS"
        const val STEPS_WRITE_PERMISSION = "android.permission.health.WRITE_STEPS"
        const val READ_HISTORY_PERMISSION = "android.permission.health.READ_HEALTH_DATA_HISTORY"

        // Permission Request DTOs
        val STEPS_READ_PERMISSION_REQUEST = HealthDataPermissionRequestDto(
            accessType = PermissionAccessTypeDto.READ,
            healthDataType = HealthDataTypeDto.STEPS,
        )

        val STEPS_WRITE_PERMISSION_REQUEST = HealthDataPermissionRequestDto(
            accessType = PermissionAccessTypeDto.WRITE,
            healthDataType = HealthDataTypeDto.STEPS,
        )

        val READ_HISTORY_FEATURE_REQUEST = HealthPlatformFeaturePermissionRequest(
            feature = HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY,
        )

        // Helper functions to create permission result DTOs with dynamic status
        fun createHealthDataPermissionResult(
            request: HealthDataPermissionRequestDto,
            status: PermissionStatusDto,
        ) = HealthDataPermissionRequestResultDto(
            permission = request,
            status = status,
        )

        fun createFeaturePermissionResult(
            feature: HealthPlatformFeatureDto,
            status: PermissionStatusDto,
        ) = HealthPlatformFeaturePermissionRequestResultDto(
            feature = feature,
            status = status,
        )

        // Route consent request test constants
        const val TEST_EXERCISE_SESSION_ID = "exercise-session-123"
        const val TEST_ROUTE_TIME_1 = 1609459200000L
        const val TEST_ROUTE_TIME_2 = 1609459260000L
        const val TEST_ROUTE_LATITUDE_1 = 37.7749
        const val TEST_ROUTE_LONGITUDE_1 = -122.4194
        const val TEST_ROUTE_LATITUDE_2 = 37.7849
        const val TEST_ROUTE_LONGITUDE_2 = -122.4094
        const val TEST_ROUTE_ALTITUDE_METERS = 100.5
    }

    private lateinit var fakePermissionController: FakePermissionController
    private lateinit var systemUnderTest: HealthConnectorPermissionService

    @MockK
    private lateinit var activity: ComponentActivity

    @MockK
    private lateinit var activityResultRegistry: ActivityResultRegistry

    @MockK
    private lateinit var activityResultLauncher: ActivityResultLauncher<Set<String>>

    @MockK
    private lateinit var routeConsentLauncher: ActivityResultLauncher<String>

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        fakePermissionController = FakePermissionController(grantAll = false)
        systemUnderTest = HealthConnectorPermissionService(
            // `MainDispatcherExtension` sets `Dispatchers.Main` to `StandardTestDispatcher`, so
            // we can use `Dispatchers.Main.immediate` to get the test dispatcher.
            dispatcher = Dispatchers.Main.immediate,
            permissionClient = fakePermissionController,
        )

        every { activity.activityResultRegistry } returns activityResultRegistry
        every { activityResultLauncher.unregister() } returns Unit
        every { routeConsentLauncher.unregister() } returns Unit
    }

    @AfterEach
    fun tearDown() {
        unmockkAll()
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("requestPermissions")
    inner class RequestPermissions {
        @ParameterizedTest(
            name = "given permissionRequests={0}, grantedPermissions={1}, " +
                "expectedPermissionStatuses={2}",
        )
        @MethodSource("providePermissionRequests")
        @DisplayName(
            "GIVEN permission requests and user response → " +
                "WHEN requestPermissions called → " +
                "THEN returns correct statuses",
        )
        fun whenPermissionsRequested_thenReturnsCorrectStatuses(
            permissionRequests: List<PermissionRequestDto>,
            grantedPermissions: Set<String>,
            expectedPermissionStatuses: List<PermissionStatusDto>,
        ) = runTest {
            // Given
            val requestDto = PermissionRequestsDto(
                permissionRequests = permissionRequests,
            )
            val callbackSlot = slot<ActivityResultCallback<Set<String>>>()

            every {
                activityResultRegistry.register(
                    any(),
                    any<ActivityResultContract<Set<String>, Set<String>>>(),
                    capture(callbackSlot),
                )
            } returns activityResultLauncher
            every { activityResultLauncher.launch(any()) } answers {
                // Simulate user response
                callbackSlot.captured.onActivityResult(grantedPermissions)
            }

            // When
            val permissionRequestResults = systemUnderTest.requestPermissions(activity, requestDto)

            // Then
            permissionRequestResults.size shouldBe permissionRequests.size

            // Verify status matches expected
            permissionRequestResults.forEachIndexed { index, permissionRequestResult ->
                val permissionRequest = permissionRequests[index]
                val expectedPermissionStatus = expectedPermissionStatuses[index]

                when (permissionRequestResult) {
                    is HealthDataPermissionRequestResultDto -> {
                        val healthDataPermissionRequest =
                            permissionRequest as HealthDataPermissionRequestDto
                        permissionRequestResult.status shouldBe expectedPermissionStatus
                        permissionRequestResult.permission.healthDataType shouldBe
                            healthDataPermissionRequest.healthDataType
                        permissionRequestResult.permission.accessType shouldBe
                            healthDataPermissionRequest.accessType
                    }

                    is HealthPlatformFeaturePermissionRequestResultDto -> {
                        val featurePermissionRequest =
                            permissionRequest as HealthPlatformFeaturePermissionRequest
                        permissionRequestResult.status shouldBe expectedPermissionStatus
                        permissionRequestResult.feature shouldBe featurePermissionRequest.feature
                    }

                    is ExerciseRoutePermissionRequestResultDto -> {
                        val exerciseRoutePermissionRequest =
                            permissionRequest as ExerciseRoutePermissionRequestDto
                        permissionRequestResult.status shouldBe expectedPermissionStatus
                        permissionRequestResult.permission.accessType shouldBe
                            exerciseRoutePermissionRequest.accessType
                    }
                }
            }
            verify { activityResultLauncher.unregister() }
        }

        fun providePermissionRequests(): List<Arguments> = listOf(
            // Single Health Data - Granted
            Arguments.of(
                listOf(STEPS_READ_PERMISSION_REQUEST),
                setOf(STEPS_READ_PERMISSION),
                listOf(PermissionStatusDto.GRANTED),
            ),
            // Single Health Data - Denied
            Arguments.of(
                listOf(STEPS_READ_PERMISSION_REQUEST),
                emptySet<String>(),
                listOf(PermissionStatusDto.DENIED),
            ),
            // Single Feature - Granted
            Arguments.of(
                listOf(READ_HISTORY_FEATURE_REQUEST),
                setOf(READ_HISTORY_PERMISSION),
                listOf(PermissionStatusDto.GRANTED),
            ),
            // Single Feature - Denied
            Arguments.of(
                listOf(READ_HISTORY_FEATURE_REQUEST),
                emptySet<String>(),
                listOf(PermissionStatusDto.DENIED),
            ),
            // Multiple - All Granted
            Arguments.of(
                listOf(STEPS_READ_PERMISSION_REQUEST, READ_HISTORY_FEATURE_REQUEST),
                setOf(STEPS_READ_PERMISSION, READ_HISTORY_PERMISSION),
                listOf(PermissionStatusDto.GRANTED, PermissionStatusDto.GRANTED),
            ),
            // Multiple - All Denied
            Arguments.of(
                listOf(STEPS_READ_PERMISSION_REQUEST, READ_HISTORY_FEATURE_REQUEST),
                emptySet<String>(),
                listOf(PermissionStatusDto.DENIED, PermissionStatusDto.DENIED),
            ),
            // Multiple - Partial Grant (Steps Granted, History Denied)
            Arguments.of(
                listOf(STEPS_READ_PERMISSION_REQUEST, READ_HISTORY_FEATURE_REQUEST),
                setOf(STEPS_READ_PERMISSION),
                listOf(PermissionStatusDto.GRANTED, PermissionStatusDto.DENIED),
            ),
            // Write Permission - Granted
            Arguments.of(
                listOf(STEPS_WRITE_PERMISSION_REQUEST),
                setOf(STEPS_WRITE_PERMISSION),
                listOf(PermissionStatusDto.GRANTED),
            ),
            // Write Permission - Denied
            Arguments.of(
                listOf(STEPS_WRITE_PERMISSION_REQUEST),
                emptySet<String>(),
                listOf(PermissionStatusDto.DENIED),
            ),
            // Mixed Read/Write - All Granted
            Arguments.of(
                listOf(STEPS_READ_PERMISSION_REQUEST, STEPS_WRITE_PERMISSION_REQUEST),
                setOf(STEPS_READ_PERMISSION, STEPS_WRITE_PERMISSION),
                listOf(PermissionStatusDto.GRANTED, PermissionStatusDto.GRANTED),
            ),
            // Mixed Read/Write - Partial Grant (Read Granted, Write Denied)
            Arguments.of(
                listOf(STEPS_READ_PERMISSION_REQUEST, STEPS_WRITE_PERMISSION_REQUEST),
                setOf(STEPS_READ_PERMISSION),
                listOf(PermissionStatusDto.GRANTED, PermissionStatusDto.DENIED),
            ),
        )
    }

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("getGrantedPermissions")
    inner class GetGrantedPermissions {

        @Test
        @DisplayName(
            "GIVEN no permissions granted → " +
                "WHEN getGrantedPermissions called → " +
                "THEN returns empty list",
        )
        fun whenNoPermissionsGranted_thenReturnsEmpty() = runTest {
            // Given
            // fakePermissionController is initialized with grantAll = false

            // When
            val response = systemUnderTest.getGrantedPermissions()

            // Then
            response.shouldBeEmpty()
        }

        @ParameterizedTest(
            name = "given grantedPermissions={0}, expectedPermissionRequestResults={1}",
        )
        @MethodSource("providePermissionRequests")
        @DisplayName(
            "GIVEN permissions are granted in controller → " +
                "WHEN getGrantedPermissions called → " +
                "THEN returns those permissions as GRANTED",
        )
        fun whenPermissionsGranted_thenReturnsThem(
            grantedPermissions: Set<String>,
            expectedPermissionRequestResults: List<PermissionRequestResultDto>,
        ) = runTest {
            // Given
            fakePermissionController.grantPermissions(grantedPermissions.toSet())

            // When
            val response = systemUnderTest.getGrantedPermissions()

            // Then
            response.size shouldBe expectedPermissionRequestResults.size

            // Verify each expected permission is present (order-independent)
            response shouldContainAll expectedPermissionRequestResults
        }

        fun providePermissionRequests(): List<Arguments> = listOf(
            // Single Granted Health Data Permission (Read)
            Arguments.of(
                setOf(STEPS_READ_PERMISSION),
                listOf(
                    createHealthDataPermissionResult(
                        STEPS_READ_PERMISSION_REQUEST,
                        PermissionStatusDto.GRANTED,
                    ),
                ),
            ),
            // Single Granted Health Data Permission (Write)
            Arguments.of(
                setOf(STEPS_WRITE_PERMISSION),
                listOf(
                    createHealthDataPermissionResult(
                        STEPS_WRITE_PERMISSION_REQUEST,
                        PermissionStatusDto.GRANTED,
                    ),
                ),
            ),
            // Single Granted Feature Permission
            Arguments.of(
                setOf(READ_HISTORY_PERMISSION),
                listOf(
                    createFeaturePermissionResult(
                        HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY,
                        PermissionStatusDto.GRANTED,
                    ),
                ),
            ),
            // Multiple Granted Permissions
            Arguments.of(
                setOf(STEPS_READ_PERMISSION, READ_HISTORY_PERMISSION),
                listOf(
                    createHealthDataPermissionResult(
                        STEPS_READ_PERMISSION_REQUEST,
                        PermissionStatusDto.GRANTED,
                    ),
                    createFeaturePermissionResult(
                        HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY,
                        PermissionStatusDto.GRANTED,
                    ),
                ),
            ),
        )
    }

    @Nested
    @DisplayName("getPermissionStatus")
    inner class GetPermissionStatus {

        @Test
        @DisplayName(
            "GIVEN permission granted → " +
                "WHEN getPermissionStatus called → " +
                "THEN returns GRANTED",
        )
        fun whenPermissionGranted_thenReturnsGranted() = runTest {
            // Given
            fakePermissionController.grantPermission(STEPS_READ_PERMISSION)

            val requestDto = STEPS_READ_PERMISSION_REQUEST

            // When
            val result = systemUnderTest.getPermissionStatus(requestDto)

            // Then
            result shouldBe PermissionStatusDto.GRANTED
        }

        @Test
        @DisplayName(
            "GIVEN permission denied → " +
                "WHEN getPermissionStatus called → " +
                "THEN returns DENIED",
        )
        fun whenPermissionDenied_thenReturnsDenied() = runTest {
            // Given
            // No permissions granted

            val requestDto = STEPS_READ_PERMISSION_REQUEST

            // When
            val result = systemUnderTest.getPermissionStatus(requestDto)

            // Then
            result shouldBe PermissionStatusDto.DENIED
        }
    }

    @Nested
    @DisplayName("revokeAllPermissions")
    inner class RevokeAllPermissions {

        @Test
        @DisplayName(
            "GIVEN permissions granted → " +
                "WHEN revokeAllPermissions called → " +
                "THEN all permissions are revoked",
        )
        fun whenRevokeCalled_thenPermissionsRevoked() = runTest {
            // Given
            fakePermissionController.grantPermission(STEPS_READ_PERMISSION)

            // Verify initial state is correct
            fakePermissionController.getGrantedPermissions()
                .contains(STEPS_READ_PERMISSION) shouldBe true

            // When
            systemUnderTest.revokeAllPermissions()

            // Then
            fakePermissionController.getGrantedPermissions().shouldBeEmpty()
        }

        @Test
        @DisplayName(
            "GIVEN multiple permissions granted → " +
                "WHEN revokeAllPermissions called → " +
                "THEN getGrantedPermissions returns empty",
        )
        fun whenMultiplePermissionsRevokedThenAllRemoved() = runTest {
            // Given
            fakePermissionController.grantPermissions(
                setOf(STEPS_READ_PERMISSION, STEPS_WRITE_PERMISSION),
            )
            fakePermissionController.getGrantedPermissions().size shouldBe 2

            // When
            systemUnderTest.revokeAllPermissions()

            // Then
            val response = systemUnderTest.getGrantedPermissions()
            response.shouldBeEmpty()
        }

        @Test
        @DisplayName(
            "GIVEN no permissions granted → " +
                "WHEN revokeAllPermissions called → " +
                "THEN completes without error",
        )
        fun whenNoPermissionsGrantedAndRevokeCalled_thenCompletesWithoutError() = runTest {
            // Given (no permissions granted)
            fakePermissionController.getGrantedPermissions().shouldBeEmpty()

            // When & Then (should not throw)
            systemUnderTest.revokeAllPermissions()

            // Verify still empty
            fakePermissionController.getGrantedPermissions().shouldBeEmpty()
        }
    }

    @Nested
    @DisplayName("Error Handling")
    inner class ErrorHandling {

        @Test
        @DisplayName(
            "GIVEN ActivityNotFoundException occurs → " +
                "WHEN requestPermissions called → " +
                "THEN throws HealthConnectorErrorDto with UNKNOWN_ERROR code",
        )
        fun whenActivityNotFound_thenThrowsUnknownError() = runTest {
            // Given
            val requestDto = PermissionRequestsDto(
                permissionRequests = listOf(STEPS_READ_PERMISSION_REQUEST),
            )
            val callbackSlot = slot<ActivityResultCallback<Set<String>>>()

            every {
                activityResultRegistry.register(
                    any(),
                    any<ActivityResultContract<Set<String>, Set<String>>>(),
                    capture(callbackSlot),
                )
            } returns activityResultLauncher

            every { activityResultLauncher.launch(any()) } throws
                android.content.ActivityNotFoundException("Health Connect not found")

            // When
            shouldThrow<HealthConnectorException.Unknown> {
                systemUnderTest.requestPermissions(activity, requestDto)
            }

            // Then
            verify { activityResultLauncher.unregister() }
        }
    }

    @Nested
    @DisplayName("Edge Cases")
    inner class EdgeCases {

        @Test
        @DisplayName(
            "GIVEN empty permission request list → " +
                "WHEN requestPermissions called → " +
                "THEN returns empty result list",
        )
        fun whenEmptyPermissionRequest_thenReturnsEmptyList() = runTest {
            // Given
            val requestDto = PermissionRequestsDto(
                permissionRequests = emptyList(),
            )
            val callbackSlot = slot<ActivityResultCallback<Set<String>>>()

            every {
                activityResultRegistry.register(
                    any(),
                    any<ActivityResultContract<Set<String>, Set<String>>>(),
                    capture(callbackSlot),
                )
            } returns activityResultLauncher
            every { activityResultLauncher.launch(any()) } answers {
                // Simulate user response with empty set
                callbackSlot.captured.onActivityResult(emptySet())
            }

            // When
            val result = systemUnderTest.requestPermissions(activity, requestDto)

            // Then
            result.shouldBeEmpty()
            verify { activityResultLauncher.unregister() }
        }
    }

    @Nested
    @DisplayName("launchRouteConsentRequest")
    inner class LaunchRouteConsentRequest {

        @Test
        @DisplayName(
            "GIVEN route consent granted → " +
                "WHEN launchRouteConsentRequest called → " +
                "THEN returns ExerciseRoute",
        )
        fun whenRouteConsentGranted_thenReturnsExerciseRoute() = runTest {
            // Given
            val expectedRoute = ExerciseRoute(
                route = listOf(
                    ExerciseRoute.Location(
                        time = java.time.Instant.ofEpochMilli(TEST_ROUTE_TIME_1),
                        latitude = TEST_ROUTE_LATITUDE_1,
                        longitude = TEST_ROUTE_LONGITUDE_1,
                        altitude = Length.meters(TEST_ROUTE_ALTITUDE_METERS),
                    ),
                    ExerciseRoute.Location(
                        time = java.time.Instant.ofEpochMilli(TEST_ROUTE_TIME_2),
                        latitude = TEST_ROUTE_LATITUDE_2,
                        longitude = TEST_ROUTE_LONGITUDE_2,
                    ),
                ),
            )
            val callbackSlot = slot<ActivityResultCallback<ExerciseRoute?>>()

            every {
                activityResultRegistry.register(
                    any(),
                    any<ExerciseRouteRequestContract>(),
                    capture(callbackSlot),
                )
            } returns routeConsentLauncher
            every { routeConsentLauncher.launch(any()) } answers {
                // Simulate user granting consent
                callbackSlot.captured.onActivityResult(expectedRoute)
            }

            // When
            val result = systemUnderTest.launchRouteConsentRequest(
                activity,
                TEST_EXERCISE_SESSION_ID,
            )

            // Then
            result shouldBe expectedRoute
            result?.route?.size shouldBe 2
            result?.route?.get(0)?.latitude shouldBe TEST_ROUTE_LATITUDE_1
            result?.route?.get(0)?.longitude shouldBe TEST_ROUTE_LONGITUDE_1
            result?.route?.get(1)?.latitude shouldBe TEST_ROUTE_LATITUDE_2
            result?.route?.get(1)?.longitude shouldBe TEST_ROUTE_LONGITUDE_2
            verify { routeConsentLauncher.unregister() }
        }

        @Test
        @DisplayName(
            "GIVEN route consent denied → " +
                "WHEN launchRouteConsentRequest called → " +
                "THEN returns null",
        )
        fun whenRouteConsentDenied_thenReturnsNull() = runTest {
            // Given
            val callbackSlot = slot<ActivityResultCallback<ExerciseRoute?>>()

            every {
                activityResultRegistry.register(
                    any(),
                    any<ExerciseRouteRequestContract>(),
                    capture(callbackSlot),
                )
            } returns routeConsentLauncher
            every { routeConsentLauncher.launch(any()) } answers {
                // Simulate user denying consent
                callbackSlot.captured.onActivityResult(null)
            }

            // When
            val result = systemUnderTest.launchRouteConsentRequest(
                activity,
                TEST_EXERCISE_SESSION_ID,
            )

            // Then
            result shouldBe null
            verify { routeConsentLauncher.unregister() }
        }

        @Test
        @DisplayName(
            "GIVEN ActivityNotFoundException occurs → " +
                "WHEN launchRouteConsentRequest called → " +
                "THEN throws HealthConnectorException.Unknown",
        )
        fun whenActivityNotFound_thenThrowsUnknownError() = runTest {
            // Given
            val callbackSlot = slot<ActivityResultCallback<ExerciseRoute?>>()

            every {
                activityResultRegistry.register(
                    any(),
                    any<ExerciseRouteRequestContract>(),
                    capture(callbackSlot),
                )
            } returns routeConsentLauncher

            every { routeConsentLauncher.launch(any()) } throws
                android.content.ActivityNotFoundException("Health Connect not found")

            // When & Then
            shouldThrow<HealthConnectorException.Unknown> {
                systemUnderTest.launchRouteConsentRequest(
                    activity,
                    TEST_EXERCISE_SESSION_ID,
                )
            }

            // Verify cleanup still happens
            verify { routeConsentLauncher.unregister() }
        }
    }
}
