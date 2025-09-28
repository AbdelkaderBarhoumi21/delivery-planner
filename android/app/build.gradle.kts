plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.flutter_ecommerce_app_v2"

    // Use versions provided by Flutter tooling
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // Base appId; flavors will suffix/override as needed
        applicationId = "com.yourcompany.dispatcher"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // ─────────────────────────────────────────────────────────────
    // Product Flavors (dev / prod)
    // ─────────────────────────────────────────────────────────────
    flavorDimensions += "env"

    productFlavors {
        create("dev") {
            dimension = "env"
            applicationIdSuffix = ".dev"       // -> com.yourcompany.dispatcher.dev
            versionNameSuffix = "-dev"
            // Launcher label
            resValue("string", "app_name", "Dispatcher Dev")
            // Optional: flavor-specific Maps key
            manifestPlaceholders["MAPS_API_KEY"] = "YOUR_DEV_MAPS_KEY"
        }
        create("prod") {
            dimension = "env"
            resValue("string", "app_name", "Dispatcher")
            manifestPlaceholders["MAPS_API_KEY"] = "YOUR_PROD_MAPS_KEY"
        }
    }

    buildTypes {
        // Debug must NOT shrink resources unless minify is on
        debug {
            isMinifyEnabled = false
            // This line is the fix for your error:
            isShrinkResources = false
            // Keep default debug signing
        }

        // Release: if you want resource shrinking, enable code shrinking too
        release {
            // For demo, keep using debug key so `flutter run --release` works.
            // Replace with your release signing config when publishing.
            signingConfig = signingConfigs.getByName("debug")

            // Turn on both together (R8 + resource shrink)
            isMinifyEnabled = true
            isShrinkResources = true

            // (Optional) keep rules if you have reflection/serialization libs
            // proguardFiles(
            //     getDefaultProguardFile("proguard-android-optimize.txt"),
            //     "proguard-rules.pro"
            // )
        }
    }
}

flutter {
    source = "../.."
}
