# Repository Guidelines

## Project Structure & Module Organization

This is a Flutter client for the MotoPress Hotel Booking WordPress plugin. It uses the plugin REST API; when changing API-facing code, compare against a local plugin checkout. On the maintainer machine, that checkout is `/Users/admin/Documents/git/motopress-hotel-booking`. Core Dart code lives in `lib/`:

- `lib/main.dart` starts the app.
- `lib/screens/` contains UI screens and feature subfolders such as `bookings/`, `booking_detail/`, `calendar/`, and `payments/`.
- `lib/controller/` holds controller classes for bookings, payments, and data flows.
- `lib/models/` contains domain models and enums.
- `lib/l10n/` stores localization ARB files; `lib/l10n.yaml` configures generation.

Tests live in `test/`. Images and icons live in `assets/`. Platform projects are in `android/`, `ios/`, and `web/`.

## Build, Test, and Development Commands

- `flutter pub get`: install dependencies from `pubspec.yaml`.
- `flutter gen-l10n`: regenerate localization after editing `lib/l10n/*.arb`.
- `flutter analyze`: run Dart analyzer checks using `analysis_options.yaml`.
- `flutter test`: run widget and unit tests under `test/`.
- `flutter run -d web-server --web-port 9999`: run the web build locally.
- `flutter build appbundle`: create an Android release bundle.
- `flutter build ipa`: create an iOS release archive.

Run `flutter clean` when build caches appear stale.

## Coding Style & Naming Conventions

Follow `package:flutter_lints/flutter.yaml`. Run `dart format lib test` before submitting changes. Keep files in `snake_case.dart`; use `UpperCamelCase` for classes and widgets, `lowerCamelCase` for members, methods, and variables. Prefer small widgets under existing feature subdirectories.

## Testing Guidelines

Use `flutter_test` for tests. Place tests in `test/` and name files with the `_test.dart` suffix, for example `booking_detail_test.dart`. Add or update tests for changed UI, model parsing, and controller logic. Run `flutter analyze` and `flutter test` before a pull request.

## Commit & Pull Request Guidelines

Recent history uses short, imperative or release-oriented messages such as `update README.md`, `Android SDK Version 34`, and `v1.2.2 (#19)`.

Pull requests should include a summary, tests, linked issue or release context, and screenshots or recordings for UI changes. Mention localization updates when ARB files or generated strings change.

## Security & Configuration Tips

Do not commit credentials, signing keys, API tokens, or local environment files. Keep platform signing configuration outside the repository unless it is intentionally templated and documented.

## Backend API Notes

Treat the plugin REST API as the source of truth. Keep Dart models aligned with API fields, and avoid hard-coding behavior that belongs to the WordPress plugin.
