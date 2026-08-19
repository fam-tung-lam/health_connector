package com.phamtunglam.healthconnector

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle

/** Opens the Toolbox privacy policy from the Health Connect permission UI. */
class PrivacyPolicyActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val privacyPolicyIntent =
            Intent(
                Intent.ACTION_VIEW,
                Uri.parse(PRIVACY_POLICY_URL),
            )

        if (privacyPolicyIntent.resolveActivity(packageManager) != null) {
            startActivity(privacyPolicyIntent)
        }

        finish()
    }

    private companion object {
        const val PRIVACY_POLICY_URL =
            "https://health-connector.phamtunglam.com/legal/toolbox-privacy"
    }
}
