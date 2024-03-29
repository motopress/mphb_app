import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
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

		final headers = super.getHeaders();

		final queryParameters = <String, String> {
			'per_page': limit.toString(),
			'offset': offset.toString()
		};

		final uri = super.getUriHttps( _queryEndpoint, {
			   ...queryParameters,
			   ...filters.toMap(),
			}
		);

		//print( Uri.decodeFull(uri.toString()) );
		final response = await http.get(
			uri,
			headers: headers
		);

		if ( response.statusCode == HttpStatus.OK ) {

			return compute( PaymentsController_parsePayments, response.body );

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

}