package com.phamtunglam.health_connector_hc_android.unit_tests.services

import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorManifestService
import io.kotest.assertions.throwables.shouldNotThrowAny
import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.string.shouldContain
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.unmockkAll
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test

/**
 * Unit tests for [HealthConnectorManifestService].
 *
 * Tests verify proper handling of declared/missing permissions and edge cases.
 */
@DisplayName("HealthConnectorManifestService")
class HealthConnectorManifestServiceTest {

    // region Test Fixtures

    @MockK
    private lateinit var context: Context

    @MockK
    private lateinit var packageManager: PackageManager

    private lateinit var packageInfo: PackageInfo
    private lateinit var systemUnderTest: HealthConnectorManifestService

    // endregion

    // region Setup

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        packageInfo = PackageInfo()

        every { context.packageManager } returns packageManager
        every { context.packageName } returns TEST_PACKAGE_NAME
        every {
            packageManager.getPackageInfo(
                TEST_PACKAGE_NAME,
                PackageManager.GET_PERMISSIONS,
            )
        } returns packageInfo

        systemUnderTest = HealthConnectorManifestService(context)
    }

    @AfterEach
    fun tearDown() {
        unmockkAll()
    }

    // endregion

    // region Test Cases

    @Nested
    inner class GivenPermissionsAreDeclared {

        @Test
        @DisplayName(
            "GIVEN permissions are declared in manifest → " +
                "WHEN checking empty permission set → " +
                "THEN should not throw exception",
        )
        fun whenCheckingEmptyPermissionSet_thenShouldNotThrowException() {
            // Given
            packageInfo.requestedPermissions = arrayOf(PERMISSION_READ_STEPS)

            // When & Then
            shouldNotThrowAny {
                systemUnderTest.checkPermissionsDeclared(emptySet())
            }
        }

        @Test
        @DisplayName(
            "GIVEN single permission is declared → " +
                "WHEN checking that permission → " +
                "THEN should not throw exception",
        )
        fun whenCheckingSingleDeclaredPermission_thenShouldNotThrowException() {
            // Given
            packageInfo.requestedPermissions = arrayOf(PERMISSION_READ_STEPS)

            // When & Then
            shouldNotThrowAny {
                systemUnderTest.checkPermissionsDeclared(setOf(PERMISSION_READ_STEPS))
            }
        }

        @Test
        @DisplayName(
            "GIVEN multiple permissions are declared → " +
                "WHEN checking all those permissions → " +
                "THEN should not throw exception",
        )
        fun whenCheckingMultipleDeclaredPermissions_thenShouldNotThrowException() {
            // Given
            val declaredPermissions = setOf(
                PERMISSION_READ_STEPS,
                PERMISSION_WRITE_STEPS,
                PERMISSION_READ_HEART_RATE,
            )
            packageInfo.requestedPermissions = declaredPermissions.toTypedArray()

            // When & Then
            shouldNotThrowAny {
                systemUnderTest.checkPermissionsDeclared(declaredPermissions)
            }
        }

        @Test
        @DisplayName(
            "GIVEN manifest has extra permissions beyond requested → " +
                "WHEN checking subset of permissions → " +
                "THEN should not throw exception",
        )
        fun whenManifestHasExtraPermissions_thenShouldNotThrowException() {
            // Given
            packageInfo.requestedPermissions = arrayOf(
                PERMISSION_READ_STEPS,
                PERMISSION_WRITE_STEPS,
                PERMISSION_READ_HEART_RATE,
                "android.permission.INTERNET",
            )

            // When & Then
            shouldNotThrowAny {
                systemUnderTest.checkPermissionsDeclared(setOf(PERMISSION_READ_STEPS))
            }
        }
    }

    @Nested
    inner class GivenPermissionsAreMissing {

        @Test
        @DisplayName(
            "GIVEN permission is not declared in manifest → " +
                "WHEN checking that permission → " +
                "THEN should throw INVALID_CONFIGURATION",
        )
        fun whenCheckingSingleMissingPermission_thenThrowsInvalidConfiguration() {
            // Given
            packageInfo.requestedPermissions = arrayOf(
                PERMISSION_READ_HEART_RATE,
            )

            // // When && Then
            shouldThrow<HealthConnectorException.InvalidConfiguration> {
                systemUnderTest.checkPermissionsDeclared(setOf(PERMISSION_READ_STEPS))
            }
        }

        @Test
        @DisplayName(
            "GIVEN multiple permissions are not declared → " +
                "WHEN checking those permissions → " +
                "THEN should throw with all missing permissions listed",
        )
        fun whenCheckingMultipleMissingPermissions_thenShouldThrowWithAllListed() {
            // Given
            packageInfo.requestedPermissions = emptyArray()
            val missingPermissions = setOf(PERMISSION_READ_STEPS, PERMISSION_WRITE_STEPS)

            // When
            val exception = shouldThrow<HealthConnectorException.InvalidConfiguration> {
                systemUnderTest.checkPermissionsDeclared(missingPermissions)
            }

            // Then
            exception.message shouldContain PERMISSION_READ_STEPS
            exception.message shouldContain PERMISSION_WRITE_STEPS
        }

        @Test
        @DisplayName(
            "GIVEN some permissions declared and others missing → " +
                "WHEN checking all permissions → " +
                "THEN should throw with missing ones listed",
        )
        fun whenSomePermissionsDeclaredAndOthersMissing_thenThrowsWithMissing() {
            // Given
            packageInfo.requestedPermissions = arrayOf(PERMISSION_READ_STEPS)

            // When
            val exception = shouldThrow<HealthConnectorException.InvalidConfiguration> {
                systemUnderTest.checkPermissionsDeclared(
                    setOf(
                        PERMISSION_READ_STEPS,
                        PERMISSION_WRITE_STEPS,
                    ),
                )
            }

            // Then
            exception.message shouldContain PERMISSION_WRITE_STEPS
        }
    }

    @Nested
    inner class GivenEdgeCaseScenarios {

        @Test
        @DisplayName(
            "GIVEN PackageInfo returns null requestedPermissions → " +
                "WHEN checking empty permission set → " +
                "THEN should not throw exception",
        )
        fun whenPackageInfoReturnsNullAndCheckingEmptySet_thenShouldNotThrow() {
            // Given
            packageInfo.requestedPermissions = null

            // When & Then
            shouldNotThrowAny {
                systemUnderTest.checkPermissionsDeclared(emptySet())
            }
        }

        @Test
        @DisplayName(
            "GIVEN PackageInfo returns empty array → " +
                "WHEN checking empty permission set → " +
                "THEN should not throw exception",
        )
        fun whenPackageInfoReturnsEmptyArrayAndCheckingEmptySet_thenShouldNotThrow() {
            // Given
            packageInfo.requestedPermissions = emptyArray()

            // When & Then
            shouldNotThrowAny {
                systemUnderTest.checkPermissionsDeclared(emptySet())
            }
        }

        @Test
        @DisplayName(
            "GIVEN permission with different case in manifest → " +
                "WHEN checking permission with standard case → " +
                "THEN should throw due to case sensitivity",
        )
        fun whenPermissionCaseDiffers_thenShouldThrowDueToCaseSensitivity() {
            // Given
            packageInfo.requestedPermissions = arrayOf("android.permission.health.read_steps")

            // // When && Then
            val exception = shouldThrow<HealthConnectorException.InvalidConfiguration> {
                systemUnderTest.checkPermissionsDeclared(setOf(PERMISSION_READ_STEPS))
            }
        }
    }

    // endregion

    // region Test Constants

    private companion object {
        const val TEST_PACKAGE_NAME = "com.test.app"
        const val PERMISSION_READ_STEPS = "android.permission.health.READ_STEPS"
        const val PERMISSION_WRITE_STEPS = "android.permission.health.WRITE_STEPS"
        const val PERMISSION_READ_HEART_RATE = "android.permission.health.READ_HEART_RATE"
    }

    // endregion
}
