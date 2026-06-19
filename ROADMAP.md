# Roadmap

## Current Baseline

This app is a Flutter mobile client for the MotoPress Hotel Booking WordPress plugin REST API. The first foundation pass modernized the local Flutter workflow to Flutter `3.24.5`, added shared REST request/error handling, validates credentials before login, migrates API credentials into secure storage, improves create-booking validation, updates calendar refresh behavior, adds booking delete confirmation, and replaces the default sample test with app-specific foundation tests.

Current verified commands:

- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter build web --no-pub`

## Next Priority: Manual API QA

Test the app against a real MotoPress Hotel Booking site before adding larger features.

- Log in with QR and manual credentials.
- Confirm invalid credentials fail before entering the app.
- Verify bookings, payments, calendar, filters, refresh, and detail screens.
- Create a booking and confirm it appears in bookings and calendar.
- Change booking and payment statuses.
- Delete a booking and verify the confirmation dialog and list/calendar updates.

## Product Backlog

1. Improve create booking
   - Add a review step before submission.
   - Support booking notes, internal notes, services, rates, and price preview if available in the plugin REST API.
   - Allow configurable initial booking status instead of always creating confirmed bookings.

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
   - Gradually update old plugin dependencies, especially `http`, `shared_preferences`, `package_info_plus`, `url_launcher`, `qr_code_scanner`, and `flutter_secure_storage`.
   - Remove dependency overrides once upstream constraints are modernized.

3. Testing
   - Add mocked HTTP controller tests for success, invalid credentials, missing API route, invalid JSON, timeout, and server errors.
   - Add widget tests for login validation, filter cancel flows, create-booking validation, and delete confirmation.

4. Platform setup
   - Complete Android Java/license setup.
   - Complete Xcode installation for iOS builds.
   - Update CocoaPods before testing iOS plugin builds.
