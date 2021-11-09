import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:mphb_app/local_storage.dart';

class BookingController {

	BookingController();

	static String queryEndpoint = '/booking-api/wp-json/mphb/v1/bookings';

	static Future<Map> wpGetBooking( int bookingID ) async {

		//https://booking.loc/wp-json/mphb/v1/bookings/6827?_embed=accommodation,accommodation_type&consumer_key=ck_1d9a5f63a7d95d69db24ea6d2a1a883cace7a127&consumer_secret=cs_993ee46f420b9472bc4b98aed6b2b1ca5e92b717

		final queryDomain = LocalStorage().domain;

		final queryParameters = <String, String> {
			'consumer_key': LocalStorage().consumer_key,
			'consumer_secret': LocalStorage().consumer_secret,
			'_embed' : 'accommodation,accommodation_type'
		};

		var queryEndpoint = BookingController.queryEndpoint + '/' + bookingID.toString();

		final uri = Uri.https(queryDomain, queryEndpoint, queryParameters);

		final response = await http.get( uri );

		if ( response.statusCode == HttpStatus.OK ) {

			return json.decode(response.body);

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

}