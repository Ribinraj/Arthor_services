import java.util.Properties
import java.io.FileInputStream
plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}
android {
    namespace = "com.example.arthor"
    compileSdk = flutter.compileSdkVersion

    // 🔹 FIX 1: Force NDK 27 (ignore flutter.ndkVersion here)
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11

        // 🔹 FIX 2: Enable core library desugaring
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

   defaultConfig {
    applicationId = "com.crisant.arthor"
    // 🔹 Force minSdk 23 to satisfy firebase_messaging
    minSdk = flutter.minSdkVersion
    targetSdk = flutter.targetSdkVersion
    versionCode = flutter.versionCode
    versionName = flutter.versionName
}
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
              signingConfig = signingConfigs.getByName("release")
        }
    }
}
// 🔹 NEW: Force all configs to use a safe androidx.core version
configurations.all {
    resolutionStrategy {
        force("androidx.core:core-ktx:1.13.1")
        force("androidx.core:core:1.13.1")
    }
}

flutter {
    source = "../.."
}

// 🔹 FIX 3: Add desugaring dependency (add to existing dependencies {} if you already have one)
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // Use a version that has EditorInfoCompat.setStylusHandwritingEnabled
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.core:core:1.13.1")

    implementation("com.google.android.material:material:1.12.0")
}

