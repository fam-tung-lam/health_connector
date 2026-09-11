package com.phamtunglam.health_connector_hc_android.unit_tests.utils

import android.os.Build
import com.phamtunglam.health_connector_hc_android.pigeon.AndroidSDKExtensionVersionDto
import com.phamtunglam.health_connector_hc_android.utils.SdkExtensionUtils
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("SdkExtensionUtils")
internal class SdkExtensionUtilsTest {
    @Test
    @DisplayName(
        "GIVEN API 29 → WHEN building a snapshot → THEN no extension versions are returned",
    )
    fun noExtensionVersionsBeforeAndroidR() {
        val result = SdkExtensionUtils.buildSdkExtensionSnapshot(apiLevel = 29)

        result shouldBe emptyList()
    }

    @Test
    @DisplayName("GIVEN API 30 with no R extension → WHEN building a snapshot → THEN it is omitted")
    fun omitUnavailableAndroidRExtension() {
        val result = SdkExtensionUtils.buildSdkExtensionSnapshot(
            apiLevel = Build.VERSION_CODES.R,
            androidRVersion = 0,
        )

        result shouldBe emptyList()
    }

    @Test
    @DisplayName(
        "GIVEN API 30 with an R extension → WHEN building a snapshot → THEN it is returned",
    )
    fun includeAvailableAndroidRExtension() {
        val result = SdkExtensionUtils.buildSdkExtensionSnapshot(
            apiLevel = Build.VERSION_CODES.R,
            androidRVersion = 13,
        )

        result shouldBe listOf(
            AndroidSDKExtensionVersionDto(
                androidApiLevel = Build.VERSION_CODES.R.toLong(),
                extensionVersion = 13,
            ),
        )
    }

    @Test
    @DisplayName(
        "GIVEN API 34 extension data → WHEN building a snapshot → " +
            "THEN valid versions are sorted and unsupported tracks are omitted",
    )
    fun filterAndSortExtensionVersions() {
        val result = SdkExtensionUtils.buildSdkExtensionSnapshot(
            apiLevel = Build.VERSION_CODES.UPSIDE_DOWN_CAKE,
            allVersions = mapOf(
                Build.VERSION_CODES.UPSIDE_DOWN_CAKE to 21,
                Build.VERSION_CODES.R to 13,
                Build.VERSION_CODES.S to 0,
                35 to 1,
                1_000_000 to 12,
            ),
        )

        result shouldBe listOf(
            AndroidSDKExtensionVersionDto(
                androidApiLevel = Build.VERSION_CODES.R.toLong(),
                extensionVersion = 13,
            ),
            AndroidSDKExtensionVersionDto(
                androidApiLevel = Build.VERSION_CODES.UPSIDE_DOWN_CAKE.toLong(),
                extensionVersion = 21,
            ),
        )
    }
}
