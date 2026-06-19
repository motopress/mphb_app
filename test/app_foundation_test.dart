import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mphb_app/controller/api_exception.dart';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/create_booking.dart';
import 'package:mphb_app/models/form_model.dart';

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
		test('requires customer info and accommodations before submit', () {
			final booking = Create_Booking();

			expect(booking.isReadyForSubmit(), isFalse);

			booking.customer.first_name = 'Jane';
			booking.customer.last_name = 'Doe';
			booking.customer.email = 'jane@example.com';
			booking.customer.phone = '+15551234567';

			expect(booking.hasCustomerInfo(), isTrue);
			expect(booking.isReadyForSubmit(), isFalse);
		});
	});
}
