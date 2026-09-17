import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:io';
import 'package:mphb_app/controller/api_exception.dart';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/payment.dart';
import 'package:mphb_app/models/payments_filters.dart';

/*
 * A function that converts a response body into a List<Payment>.
 * compute can only take a top-level function, but not instance or static methods.
 */
List<Payment>PaymentsController_parsePayments(String responseBody) {

	final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

	return parsed.map<Payment>((json) => Payment.fromJson(json)).toList();
}

class PaymentsController extends BasicController{

	final String _queryEndpoint = '/payments';

	/*
	 * https://domain.com/wp-json/mphb/v1/payments
	 */
	Future<List<Payment>> wpGetPayments( int offset, int limit, Payments_Filters filters ) async {

		final queryParameters = <String, String> {
			'per_page': limit.toString(),
			'offset': offset.toString()
		};

		final response = await getRequest( _queryEndpoint, {
			...queryParameters,
			...filters.toMap(),
		});

		if ( response.statusCode == HttpStatus.ok ) {

			return compute( PaymentsController_parsePayments, response.body );

		} else {

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}

}
