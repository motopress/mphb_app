import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/payment.dart';
import 'package:mphb_app/models/enum/payment_status.dart';

class PaymentController extends BasicController{

	final String _queryEndpoint = '/payments';

	/*
	 * https://domain.com/wp-json/mphb/v1/payments/ID
	 */
	Future<Payment> wpGetPayment( int paymentID ) async {

		final headers = super.getHeaders();

		var queryEndpoint = '$_queryEndpoint/${paymentID.toString()}';

		final uri = super.getUriHttps( queryEndpoint );

		//print( Uri.decodeFull(uri.toString()) );
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

		//print( Uri.decodeFull(uri.toString()) );
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