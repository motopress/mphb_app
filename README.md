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

## Getting Started

1. [Install Flutter](https://docs.flutter.dev/get-started/install).
1. Clone this GitHub repository.
1. Run `flutter doctor` to show information about the installed tooling (optional).

## Development
1. Navigate to `/mphb_app/` dirrectory.
1. Run `flutter run -d web-server --web-port 9999` in the command-line tool to start a web server[^1].
1. Wait for dependencies, cache and application setup.
1. Navigate to `http://localhost:9999/` in your browser.
1. Enable Mobile view for better experience.
1. Make a change to app source in the `lib` folder.
1. Enter R to perform a hot reload. Reload you browser manually.

[^1]: `port` paramenter is set to save SharedPreferences for each session, [more](https://stackoverflow.com/questions/59503499/flutter-web-shared-preferences-not-available-when-tab-is-closed-and-reopened).

### iOS Simulator
1. Install and configure [Xcode](https://docs.flutter.dev/get-started/install/macos#ios-setup).
1. Run `open -a Simulator` in the command-line tool.
1. Run `flutter run` to launch the app in the Simulator.

### iOS Device
1. Using a USB cable, plug your phone into your computer.
1. Run `flutter run`.
1. Make sure your phone remain active until app launch.

### Android Emulator
1. Install Android SDK and build tools. Use [Android Studio](https://docs.flutter.dev/get-started/install/macos#set-up-the-android-emulator) or install SDK by [sdkmanager](https://developer.android.com/studio/command-line/sdkmanager).
1. Build and release an [Android app](https://docs.flutter.dev/deployment/android).
1. Install and create [emulator](https://gist.github.com/mrk-han/66ac1a724456cadf1c93f4218c6060ae).
1. Install an APK on an emulator or connected device with the install command `adb install path_to_apk`.

(TBD)

## Build and Release

### Build and Release for iOS

1. Run `flutter build ipa` to produce a build archive.
1. Open `[project]/build/ios/archive/MyApp.xcarchive` in Xcode.
1. Distribute app to App Store.

[more](https://docs.flutter.dev/deployment/ios)

### Build and Release for Android

1. Run `flutter build appbundle`.
1. Locate `[project]/build/app/outputs/bundle/release/app.aab`.
1. Distribute app to Google Play.

[more](https://docs.flutter.dev/deployment/android)

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
