import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:mphb_app/local_storage.dart';
import 'package:mphb_app/models/booking.dart';

class BookingsController {

	final Map<String, String> params;

	BookingsController({
		required this.params,
	});

	final String _queryEndpoint = '/booking-api/wp-json/mphb/v1/bookings';

	Future<List<Booking>> wpGetBookings() async {

		//https://booking.loc/wp-json/mphb/v1/bookings?consumer_key=ck_1d9a5f63a7d95d69db24ea6d2a1a883cace7a127&consumer_secret=cs_993ee46f420b9472bc4b98aed6b2b1ca5e92b717
		//https://uglywebsites.org/booking-api/wp-json/mphb/v1/bookings?consumer_key=ck_09c4163541fb26930cf9531ba1601f711f5c1ab9&consumer_secret=cs_47fd90af2ca6ec49dcb9b5ad73766cd6545c25a8

		final queryDomain = LocalStorage().domain;

		final queryParameters = <String, String> {
			'consumer_key': LocalStorage().consumer_key,
			'consumer_secret': LocalStorage().consumer_secret,
			'per_page': '5',
		};

		final uri = Uri.https(queryDomain, _queryEndpoint, queryParameters);

		final response = await http.get( uri );

		if ( response.statusCode == HttpStatus.OK ) {

			//print(response.headers.runtimeType);

			var xWPTotal = response.headers['x-wp-total'];
			var xWPTotalPages = response.headers['x-wp-totalpages'];

			//print(xWPTotal);
			//print(xWPTotalPages);

			//return jsonDecode( response.body );
			return compute( parseBookings, response.body );

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

	// A function that converts a response body into a List<Booking>.
	List<Booking> parseBookings(String responseBody) {
		final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

		return parsed.map<Booking>((json) => Booking.fromJson(json)).toList();
	}

}