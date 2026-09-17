import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:io';
import 'package:mphb_app/controller/api_exception.dart';
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

		final queryParameters = <String, String> {
			'per_page': limit.toString(),
			'offset': offset.toString()
		};

		final response = await getRequest( _queryEndpoint, {
			...queryParameters,
			...filters.toMap(),
		});

		if ( response.statusCode == HttpStatus.ok ) {

			return compute( BookingsController_parseBookings, response.body );

		} else {

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}

	Future<List<Accommodation_Availability>> wpCheckAvailability( Map<String, String> params ) async {

		final response = await getRequest( _queryEndpoint + '/availability', {
			...params,
		});

		if ( response.statusCode == HttpStatus.ok ) {

			final Map<String, dynamic> parsed = jsonDecode(response.body);
			final availability = parsed['availability'].cast<Map<String, dynamic>>();

			return availability.map<Accommodation_Availability>((json) =>
				Accommodation_Availability.fromJson(json)).toList();

		} else {

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}


	Future<Booking> wpCreateBooking( Map params ) async {

		final response = await postRequest( _queryEndpoint, jsonEncode(params) );

		if (response.statusCode == 201) {

			Booking booking = Booking.fromJson(jsonDecode(response.body));

			return booking;

		} else {

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}

	/*
	 * https://domain.com/wp-json/mphb/v1/bookings
	 */
	Future<List<Booking>> wpGetAllBookings( int offset, int limit, Map filters ) async {

		final queryParameters = <String, String> {
			'per_page': limit.toString(),
			'offset': offset.toString(),
			'_embed' : 'accommodation'
		};

		final response = await getRequest( _queryEndpoint, {
			...queryParameters,
			...filters,
		});

		if ( response.statusCode == HttpStatus.ok ) {

			return compute( BookingsController_parseBookings, response.body );

		} else {

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}

}
