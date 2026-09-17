import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mphb_app/controller/api_exception.dart';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/create_booking.dart';
import 'package:mphb_app/models/form_model.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';

void main() {
  group('BasicController', () {
    test('normalizes site domains to the plugin REST API root', () {
      expect(
        BasicController.normalizeDomain('https://example.com/'),
        'https://example.com/wp-json/mphb/v1',
      );
      expect(
        BasicController.normalizeDomain('https://example.com/wp-json/mphb/v1'),
        'https://example.com/wp-json/mphb/v1',
      );
    });
  });

  group('ApiException', () {
    test('maps common status codes to useful messages', () {
      expect(
        ApiException.fromStatusCode(HttpStatus.unauthorized).toString(),
        contains('credentials'),
      );
      expect(
        ApiException.fromStatusCode(HttpStatus.notFound).toString(),
        contains('REST API'),
      );
    });
  });

  group('FormModel', () {
    test('parses QR payload data', () {
      final model = FormModel.fromRawData('https://example.com|ck_123|cs_456');

      expect(model.domain, 'https://example.com');
      expect(model.consumer_key, 'ck_123');
      expect(model.consumer_secret, 'cs_456');
    });

    test('rejects incomplete QR payload data', () {
      expect(
        () => FormModel.fromRawData('https://example.com|ck_123'),
        throwsException,
      );
    });
  });

  group('Create_Booking', () {
    late Create_Booking booking;
    setUp(() {
      booking = Create_Booking();
      booking.reserved_accommodations.add(
        Reserved_Accommodation(
          accommodation: 1,
          accommodation_type: 1,
          rate: 1,
          adults: 1,
          children: 0,
          guest_name: '',
          services: [],
          accommodation_price_per_days: [],
          fees: [],
          taxes: {},
          discount: 0,
        ),
      );
    });

    test(
      'creation payload defaults to confirmed and sends selected pending status',
      () {
        booking.check_in_date = '2026-10-01';
        booking.check_out_date = '2026-10-03';
        expect(booking.toApiParams()['status'], 'confirmed');
        booking.status = 'pending';
        expect(booking.toApiParams(), {
          'status': 'pending',
          'check_in_date': '2026-10-01',
          'check_out_date': '2026-10-03',
          'reserved_accommodations': [
            {'accommodation': 1, 'adults': 1, 'children': 0},
          ],
          'customer': {
            'first_name': '',
            'last_name': '',
            'email': '',
            'phone': '',
          },
        });
        booking.reset();
        expect(booking.status, 'pending');
        expect(Create_Booking().status, 'confirmed');
      },
    );

    test('allows a booking without any customer details', () {
      expect(booking.isReadyForSubmit(), isTrue);
    });

    test('still requires a reserved accommodation', () {
      booking.reserved_accommodations.clear();
      expect(booking.isReadyForSubmit(), isFalse);
    });

    test('accepts optional names and phone without email', () {
      booking.customer.first_name = 'Jane';
      booking.customer.last_name = 'Doe';
      booking.customer.phone = '+15551234567';
      expect(booking.isReadyForSubmit(), isTrue);
    });

    test('accepts empty or valid email without names or phone', () {
      for (final email in [
        '',
        '   ',
        'jane@example.com',
        ' jane+booking@example.co.uk ',
      ]) {
        booking.customer.email = email;
        expect(booking.isReadyForSubmit(), isTrue, reason: email);
      }
    });

    test('rejects malformed nonempty email and allows clearing it', () {
      for (final email in [
        'invalid',
        '@example.com',
        'jane@',
        'jane@example',
        'jane@@example.com',
        'jane doe@example.com',
        'jane@example..com',
      ]) {
        booking.customer.email = email;
        expect(booking.isReadyForSubmit(), isFalse, reason: email);
      }
      booking.customer.email = '';
      expect(booking.isReadyForSubmit(), isTrue);
    });
  });
}
