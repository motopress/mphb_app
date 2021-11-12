import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:mphb_app/local_storage.dart';
import 'package:mphb_app/models/booking.dart';

class BookingController {

	BookingController();

	final String _queryEndpoint = '/booking-api/wp-json/mphb/v1/bookings';

	Future<Booking> wpGetBooking( int bookingID ) async {

		//https://booking.loc/wp-json/mphb/v1/bookings/6827?&consumer_key=ck_1d9a5f63a7d95d69db24ea6d2a1a883cace7a127&consumer_secret=cs_993ee46f420b9472bc4b98aed6b2b1ca5e92b717

		final queryDomain = LocalStorage().domain;

		String username = LocalStorage().consumer_key;
		String password = LocalStorage().consumer_secret;
		String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

		final queryParameters = <String, String> {
			'_embed' : 'accommodation,accommodation_type'
		};

		var queryEndpoint = _queryEndpoint + '/' + bookingID.toString();

		final uri = Uri.https(queryDomain, queryEndpoint, queryParameters);

		print(uri.toString());
		final response = await http.get(
			uri,
			headers: {
				'authorization': basicAuth
			},
		);

		if ( response.statusCode == HttpStatus.OK ) {

			//return json.decode(response.body);
			return Booking.fromJson(jsonDecode(response.body));

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

	Future<Booking> wpUpdateBookingStatus( Booking booking, String newStatus ) async {

		var bookingID = booking.id;
		final queryDomain = LocalStorage().domain;

		String username = LocalStorage().consumer_key;
		String password = LocalStorage().consumer_secret;
		String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

		var queryEndpoint = _queryEndpoint + '/' + bookingID.toString();

		final uri = Uri.https(queryDomain, queryEndpoint);

		print(uri.toString());
		final response = await http.post(
			uri,
			headers: <String, String>{
				'Content-Type': 'application/json; charset=UTF-8',
				'authorization': basicAuth
			},
			body: jsonEncode(<String, String>{
				'status': newStatus,
			}),
		);

		if (response.statusCode == 200) {

			Booking result = Booking.fromJson(jsonDecode(response.body));

			if ( result.status == newStatus ) {
				booking.status = newStatus;
			}

			return booking;

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

}