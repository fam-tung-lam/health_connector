import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android Gradle plugin.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    FileInputStream(keystorePropertiesFile).use(keystoreProperties::load)
}

val uploadStoreFile =
    System.getenv("HEALTH_CONNECTOR_UPLOAD_STORE_FILE")
        ?: keystoreProperties.getProperty("storeFile")
val uploadStorePassword =
    System.getenv("HEALTH_CONNECTOR_UPLOAD_STORE_PASSWORD")
        ?: keystoreProperties.getProperty("storePassword")
val uploadKeyAlias =
    System.getenv("HEALTH_CONNECTOR_UPLOAD_KEY_ALIAS")
        ?: keystoreProperties.getProperty("keyAlias")
val uploadKeyPassword =
    System.getenv("HEALTH_CONNECTOR_UPLOAD_KEY_PASSWORD")
        ?: keystoreProperties.getProperty("keyPassword")
val hasReleaseSigning =
    listOf(
        uploadStoreFile,
        uploadStorePassword,
        uploadKeyAlias,
        uploadKeyPassword,
    ).all { value -> !value.isNullOrBlank() }

val requestedReleaseBuild =
    gradle.startParameter.taskNames.any { taskName ->
        taskName.contains("release", ignoreCase = true)
    }

if (requestedReleaseBuild && !hasReleaseSigning) {
    throw GradleException(
        "Release signing requires upload-key environment variables or android/key.properties. " +
            "See store/RELEASE.md for the local setup.",
    )
}

android {
    namespace = "com.phamtunglam.healthconnector"
    compileSdk = flutter.compileSdkVersion
    compileSdkExtension = 19
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    defaultConfig {
        applicationId = "com.phamtunglam.healthconnector"
        minSdk = 28
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                keyAlias = requireNotNull(uploadKeyAlias)
                keyPassword = requireNotNull(uploadKeyPassword)
                storeFile = file(requireNotNull(uploadStoreFile))
                storePassword = requireNotNull(uploadStorePassword)
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.findByName("release")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11
    }
}

flutter {
    source = "../.."
}
