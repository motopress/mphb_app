import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mphb_app/l10n/app_localizations.dart';
import 'package:mphb_app/models/create_booking.dart';
import 'package:mphb_app/screens/bookings/create/create_booking_checkout.dart';

void main() {
  testWidgets(
    'booking creation offers confirmed and pending and preserves selection',
    (tester) async {
      final booking = Create_Booking();
      var updates = 0;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(
            body: NotificationListener<Create_Booking>(
              onNotification: (_) {
                updates++;
                return true;
              },
              child: CreateBookingCheckoutPage(booking: booking),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final radios = find.byType(RadioListTile<String>);
      expect(radios, findsNWidgets(2));
      expect(
        tester
            .widgetList<RadioListTile<String>>(radios)
            .map((tile) => tile.value),
        ['confirmed', 'pending'],
      );
      expect(
        tester
            .widget<RadioGroup<String>>(find.byType(RadioGroup<String>))
            .groupValue,
        'confirmed',
      );
      await tester.ensureVisible(find.text('Pending'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pending'));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<RadioGroup<String>>(find.byType(RadioGroup<String>))
            .groupValue,
        'pending',
      );
      expect(booking.status, 'pending');
      expect(booking.toApiParams()['status'], 'pending');
      expect(updates, 1);
      await tester.ensureVisible(find.text('Confirmed'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Confirmed').last);
      await tester.pumpAndSettle();
      expect(booking.toApiParams()['status'], 'confirmed');
    },
  );

  testWidgets(
    'customer fields are optional and email errors clear on deletion',
    (tester) async {
      final booking = Create_Booking();
      var updates = 0;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(
            body: NotificationListener<Create_Booking>(
              onNotification: (_) {
                updates++;
                return true;
              },
              child: CreateBookingCheckoutPage(booking: booking),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final fields = tester
          .widgetList<TextField>(find.byType(TextField))
          .toList();
      expect(fields, hasLength(4));
      for (final field in fields) {
        expect(field.decoration!.labelText, endsWith('(optional)'));
      }
      expect(
        find.text(
          'Enter an email address if the guest should receive booking emails.',
        ),
        findsOneWidget,
      );

      final email = find.byType(TextField).at(2);
      await tester.enterText(email, 'invalid');
      await tester.pump();
      expect(find.text('Enter a valid email address.'), findsOneWidget);
      expect(booking.hasValidCustomerEmail(), isFalse);

      await tester.enterText(email, 'guest@example.com');
      await tester.pump();
      expect(find.text('Enter a valid email address.'), findsNothing);
      expect(booking.customer.email, 'guest@example.com');

      await tester.enterText(email, '');
      await tester.pump();
      expect(find.text('Enter a valid email address.'), findsNothing);
      expect(booking.hasValidCustomerEmail(), isTrue);
      expect(updates, 3);
    },
  );
}
