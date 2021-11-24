import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/payment.dart';

class PaymentController extends BasicController{

	final String _queryEndpoint = '/payments';

	/*
	 * https://booking.loc/wp-json/mphb/v1/payments/6827?&consumer_key=ck_1d9a5f63a7d95d69db24ea6d2a1a883cace7a127&consumer_secret=cs_993ee46f420b9472bc4b98aed6b2b1ca5e92b717
	 */
	Future<Payment> wpGetPayment( int paymentID ) async {

		final headers = super.getHeaders();

		final queryParameters = <String, String> {
			'_embed' : 'accommodation,accommodation_type,services,rate'
		};

		var queryEndpoint = '$_queryEndpoint/${paymentID.toString()}';

		final uri = super.getUriHttps( queryEndpoint, queryParameters);

		print( Uri.decodeFull(uri.toString()) );
		final response = await http.get(
			uri,
			headers: headers,
		);

		//await Future.delayed(const Duration(milliseconds: 5000));

		if ( response.statusCode == HttpStatus.OK ) {

			return Payment.fromJson(jsonDecode(response.body));

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

	Future<Payment> wpUpdatePaymentStatus( Payment payment, String newStatus ) async {

		var paymentID = payment.id;

		final headers = super.getHeaders();

		final queryEndpoint = '$_queryEndpoint/${paymentID.toString()}';

		final uri = super.getUriHttps( queryEndpoint );

		print( Uri.decodeFull(uri.toString()) );
		final response = await http.post(
			uri,
			headers: headers,
			body: jsonEncode(<String, String>{
				'status': newStatus,
			}),
		);

		if (response.statusCode == 200) {

			Payment result = Payment.fromJson(jsonDecode(response.body));

			if ( result.status == newStatus ) {
				payment.status = newStatus;
			}

			return payment;

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

}