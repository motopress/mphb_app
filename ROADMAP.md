# Roadmap

## Current Baseline

This app is a Flutter client for the MotoPress Hotel Booking WordPress plugin REST API. See [README.md](README.md) for setup, development, and release instructions.

Implemented in this branch, including the current web fixes:

- Requires Flutter `>=3.38.1` and Dart `>=3.10.0 <4.0.0`; the web workflow was verified with Flutter `3.38.10` / Dart `3.10.9`.
- Adds shared REST request/error handling and checks API credentials before login.
- Stores API credentials with `flutter_secure_storage` and migrates legacy SharedPreferences credentials when the corresponding secure-storage entries are empty.
- Makes customer names, email, and phone optional when creating a booking, validating email only when entered.
- Offers Confirmed (default) and Pending when creating bookings, matching the plugin admin form.
- Improves calendar refresh behavior and booking deletion confirmation.
- Generates localization classes in `lib/l10n/` and imports them directly from the app package.
- Updates core dependencies, including `http`, `shared_preferences`, `package_info_plus`, `url_launcher`, and `flutter_secure_storage`.
- Uses a local `qr_code_scanner` dependency with Android compatibility changes and the web `dart:ui_web` registry fix.
- Replaces the old web startup script with Flutter's generated `flutter_bootstrap.js`.
- Modernizes Android to JDK 17, Android Gradle Plugin `8.13.2`, Gradle `8.13`, and Kotlin `2.1.20`, with minimum SDK 24 and compile/target SDK 36.
- Replaces the sample test with app-specific unit and widget tests, including optional customer details and email validation.

Verification completed in this session:

- `flutter pub get`
- `flutter test` — all thirteen tests pass.
- `flutter build web --no-pub`
- `flutter run -d web-server --web-port 9999 --no-pub` — compiles and serves successfully.
- `flutter analyze` — runs but reports one existing `unreachable_switch_default` warning in `lib/screens/calendar.dart`.

An Android release bundle is present at `build/app/outputs/bundle/release/app-release.aab`. Android release signing and device behavior still need release QA; iOS builds and live API flows have not been verified in this session.

## Next Priority: Manual API QA

Test the app against a real MotoPress Hotel Booking site before adding larger features.

- Log in with QR and manual credentials.
- Confirm invalid credentials fail before entering the app.
- Check credential persistence, migration from an older installation, and logout on Android, iOS, and web.
- Check browser QR camera permissions and API access from the development origin.
- Verify bookings, payments, calendar, filters, refresh, and detail screens.
- Create a booking and confirm it appears in bookings and calendar.
- Change booking and payment statuses.
- Delete a booking and verify the confirmation dialog and list/calendar updates.

## Product Backlog

1. Improve create booking
   - Add a review step before submission.
   - Support booking notes, internal notes, services, rates, and price preview if available in the plugin REST API.

2. Expand booking management
   - Add edit flows for customer information, notes, dates, accommodations, services, and prices where supported by REST.
   - Prefer trash/soft delete if the plugin API supports it; use force delete only when required.

3. Expand payment management
   - Add payment creation or manual payment recording if supported.
   - Add filtering by gateway, booking, amount/date range, and customer.
   - Validate allowed status transitions before sending updates.

4. Improve offline and error UX
   - Add consistent empty, loading, retry, and network-unavailable states.
   - Replace raw SnackBar errors with user-focused messages where possible.

## Technical Backlog

1. REST API alignment
   - Compare API-facing models and payloads with the local plugin checkout at `/Users/admin/Documents/git/motopress-hotel-booking`.
   - Document supported endpoints and request/response fields used by the app.

2. Dependency modernization
   - Evaluate a maintained replacement for the locally patched `qr_code_scanner` and verify scanning on all supported platforms.
   - Review remaining older dependencies, including `flutter_launcher_icons`, `flutter_lints`, `infinite_scroll_pagination`, and `rxdart`, with tests for behavior changes.
   - Remove dependency overrides once upstream constraints are modernized.

3. Testing
   - Add mocked HTTP controller tests for success, invalid credentials, missing API route, invalid JSON, timeout, and server errors.
   - Add widget tests for login validation, filter cancel flows, create-booking validation, and delete confirmation.
   - Add tests for secure-storage migration and logout.
   - Resolve the existing calendar analyzer warning.

4. Platform verification
   - Verify Android release signing with the intended upload key and test installation through a Google Play test track.
   - Test Android API 24 and current target-platform behavior, including camera permissions and secure storage.
   - Verify Xcode and CocoaPods setup, then build and test iOS on a simulator and physical device.
   - Verify web login and QR scanning in a browser against a real site; successful compilation alone does not cover these flows.
