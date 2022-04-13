import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/booking.dart';
import 'package:mphb_app/models/accommodation_availability.dart';
import 'package:mphb_app/models/bookings_filters.dart';

/*
 * A function that converts a response body into a List<Booking>.
 * compute can only take a top-level function, but not instance or static methods.
 */
List<Booking>BookingsController_parseBookings(String responseBody) {

	final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

	return parsed.map<Booking>((json) => Booking.fromJson(json)).toList();
}

class BookingsController extends BasicController{

	final String _queryEndpoint = '/bookings';

	/*
	 * https://domain.com/wp-json/mphb/v1/bookings
	 */
	Future<List<Booking>> wpGetBookings( int offset, int limit, Bookings_Filters filters ) async {

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

		print( Uri.decodeFull(uri.toString()) );
		final response = await http.get(
			uri,
			headers: headers
		);

		if ( response.statusCode == HttpStatus.OK ) {

			return compute( BookingsController_parseBookings, response.body );

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

	Future<List<Accommodation_Availability>> wpCheckAvailability( Map<String, String> params ) async {

		final headers = super.getHeaders();

		final uri = super.getUriHttps( _queryEndpoint + '/availability', {
			   ...params,
			}
		);

		print( Uri.decodeFull(uri.toString()) );
		final response = await http.get(
			uri,
			headers: headers
		);

		if ( response.statusCode == HttpStatus.OK ) {

			final Map<String, dynamic> parsed = jsonDecode(response.body);
			final availability = parsed['availability'].cast<Map<String, dynamic>>();

			return availability.map<Accommodation_Availability>((json) =>
				Accommodation_Availability.fromJson(json)).toList();

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}


	Future<Booking> wpCreateBooking( Map params ) async {

		final headers = super.getHeaders();

		final uri = super.getUriHttps( _queryEndpoint );

		print( Uri.decodeFull(uri.toString()) );
		final response = await http.post(
			uri,
			headers: headers,
			body: jsonEncode(params),
		);

		if (response.statusCode == 201) {

			Booking booking = Booking.fromJson(jsonDecode(response.body));

			return booking;

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

}