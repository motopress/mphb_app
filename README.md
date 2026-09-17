# Hotel Booking Mobile Application (beta)

[Hotel Booking](https://motopress.com/products/hotel-booking/) is an all-in-one property management suite for rental property websites. List unlimited accommodations and services, accept direct online reservations, synchronize all bookings across OTAs and more.

With the Hotel Booking Application you can:

* View and manage your bookings.
* View and manage your payments.
* Create new bookings or make changes to existing ones on-the-go.
* See real time availability.

_Note: You will need a WordPress website and the Hotel Booking plugin from MotoPress to use this application._

## Screenshots

![Hotel Booking Mobile Application](assets/screenshots/screenshot.png?raw=true)

## Requirements

- Flutter **3.38.1 or later**, with Dart **3.10.0 or later, below 4.0.0** (see `pubspec.yaml`). The web workflow has been verified with Flutter 3.38.10 / Dart 3.10.9.
- A WordPress website served over HTTPS, with the MotoPress Hotel Booking REST API available and a consumer key/secret with permissions for the operations you use.
- Android development: JDK 17 and Android SDK Platform 36. The project uses Android Gradle Plugin 8.13.2, Gradle 8.13, and Kotlin 2.1.20. Android devices must run API 24 or later; compile and target SDK are 36.
- iOS development: macOS, Xcode, and CocoaPods. Device and release builds require Apple signing configuration.

## Getting Started

1. [Install Flutter](https://docs.flutter.dev/get-started/install) with the versions required above.
1. Clone this repository and navigate to its `mphb_app` directory.
1. Run `flutter doctor` and resolve issues for the platform you intend to use.
1. Run `flutter pub get` to install dependencies.
1. Run `flutter gen-l10n` to generate localization files.

Run commands below from the repository root. Use `flutter clean` only when troubleshooting stale build caches, then rerun `flutter pub get` and `flutter gen-l10n`.

## Development

### Web

```sh
flutter run -d web-server --web-port 9999
```

1. Wait until Flutter reports that the app is being served.
1. Open `http://localhost:9999/` in your browser. Browser device emulation is useful for checking the mobile layout.
1. Edit app source in `lib/`.
1. Use `r` for hot reload where supported, or `R` for hot restart. Refresh the browser manually if needed. See [Flutter hot reload](https://docs.flutter.dev/tools/hot-reload).

Keep the same hostname and port between sessions so browser storage uses the same origin. The domain is stored in SharedPreferences; API credentials use `flutter_secure_storage`. When upgrading from the old storage format, credentials are migrated from SharedPreferences when their secure-storage entries are empty.

The browser must be able to call the website's REST API; the website must allow the web app's origin and Authorization header through its CORS configuration. Use localhost for local development and HTTPS when hosting the web app, as required by [the web secure-storage implementation](https://pub.dev/documentation/flutter_secure_storage_web/latest/).

`web/index.html` uses Flutter's generated `flutter_bootstrap.js` and loads jsQR for browser QR scanning. See [Flutter web initialization](https://docs.flutter.dev/platform-integration/web/initialization). Camera scanning needs browser permission and access to the jsQR CDN.

### iOS Simulator

1. Install and configure Xcode and CocoaPods; check `flutter doctor`.
1. Run `open -a Simulator`.
1. Run `flutter devices` to find the simulator ID.
1. Run `flutter run -d <device-id>`, replacing `<device-id>` with that ID.

### iOS Device

1. Connect and trust the device, and configure signing in `ios/Runner.xcworkspace`.
1. Enable Developer Mode on the device if required by iOS.
1. Run `flutter devices`, then `flutter run -d <device-id>`.
1. Keep the device unlocked until the app launches.

### Android Emulator or Device

1. Install Android Studio, JDK 17, Android SDK Platform 36, and the required SDK tools. Run `flutter doctor --android-licenses` to review and accept the SDK licenses.
1. Create and start an emulator using Android Studio, or connect an Android device with USB debugging enabled. Use API 24 or later.
1. Run `flutter devices`, then `flutter run -d <device-id>`.

A release build is not required for emulator development.

### Localization and Dependencies

- Edit translations in `lib/l10n/*.arb`, then run `flutter gen-l10n`. Commit the updated generated `app_localizations*.dart` files alongside translation changes.
- The app imports localization classes from `package:mphb_app/l10n/app_localizations.dart`.
- `qr_code_scanner` is a local path dependency in `third_party/qr_code_scanner`, with Android and web compatibility fixes. Keep this directory when cloning or packaging the source.
- Keep dependency versions and overrides aligned with `pubspec.yaml` and `pubspec.lock`.

### Checks

```sh
flutter analyze
flutter test
flutter build web
```

The foundation tests cover API URL normalization, error messages, QR payload parsing, and create-booking validation. Also test login, bookings, payments, calendar refresh, booking creation, status changes, and deletion against a real Hotel Booking site before release. Login now checks API credentials before entering the app. When creating a booking, customer first name, last name, email, and phone are optional; an entered email must be valid. The booking status can be Confirmed (default) or Pending.

## Build and Release

### Prepare

1. Update the version name and build number in `pubspec.yaml`.
1. Run `flutter pub get` and `flutter gen-l10n`.
1. Run the checks above and verify the app on the target platform.
1. Configure platform signing. Keep credentials, signing keys, and local configuration out of version control.

### iOS

1. Configure the signing team and provisioning in `ios/Runner.xcworkspace`.
1. Run `flutter build ipa` to produce an archive and IPA.
1. Locate the archive at `build/ios/archive/Runner.xcarchive` and the exported IPA under `build/ios/ipa/`.
1. Validate and distribute the build using Apple's upload tools or Xcode Organizer.

See [Flutter's iOS release guide](https://docs.flutter.dev/deployment/ios).

### Android

The release build reads signing settings from `android/key.properties`. Create that local file with your keystore details:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=YOUR_KEY_ALIAS
storeFile=/absolute/path/to/upload-keystore.jks
```

`android/key.properties` and Android keystore files are ignored by Git. Use the appropriate upload key for the existing app. See [Flutter's Android signing guide](https://docs.flutter.dev/deployment/android#sign-the-app).

1. Run `flutter build appbundle`.
1. Locate `build/app/outputs/bundle/release/app-release.aab`.
1. Upload the bundle to Google Play Console for testing or release.

### Web

Run `flutter build web`. The deployable output is in `build/web/`.

## Misc

#### Launcher Icon

* Run `flutter pub run flutter_launcher_icons:main`.
* [Flutter Launcher Icons](https://github.com/fluttercommunity/flutter_launcher_icons).

#### App Name

* App [display name](https://stackoverflow.com/questions/49353199/how-can-i-change-the-app-display-name-build-with-flutter).

## Resources

1. https://docs.flutter.dev/get-started/install
1. https://fonts.google.com/icons
1. https://api.flutter.dev/flutter/material/Colors-class.html
1. https://motopress.github.io/hotel-booking-rest-api/

## Contributions

Anyone is welcome to contribute.

<p align="center">
    <br/>
    Made with 💙 by <a href="https://motopress.com/">MotoPress</a>.<br/>
</p>

---
All trademarks, logos and brand names are the property of their respective owners.
