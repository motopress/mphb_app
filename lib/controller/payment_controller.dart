import 'dart:convert';
import 'dart:io';
import 'package:mphb_app/controller/api_exception.dart';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/payment.dart';

class PaymentController extends BasicController{

	final String _queryEndpoint = '/payments';

	/*
	 * https://domain.com/wp-json/mphb/v1/payments/ID
	 */
	Future<Payment> wpGetPayment( int paymentID ) async {

		var queryEndpoint = '$_queryEndpoint/${paymentID.toString()}';

		final response = await getRequest( queryEndpoint );

		if ( response.statusCode == HttpStatus.ok ) {

			return Payment.fromJson(jsonDecode(response.body));

		} else {

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}

	Future<Payment> wpUpdatePaymentStatus( Payment payment, String newStatus ) async {

		var paymentID = payment.id;

		final queryEndpoint = '$_queryEndpoint/${paymentID.toString()}';

		final response = await postRequest(
			queryEndpoint,
			jsonEncode(<String, String>{
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

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}

}
