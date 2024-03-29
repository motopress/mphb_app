import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/booking.dart';

class BookingController extends BasicController{

	final String _queryEndpoint = '/bookings';

	/*
	 * https://domain.com/wp-json/mphb/v1/bookings/ID
	 */
	Future<Booking> wpGetBooking( int bookingID ) async {

		final headers = super.getHeaders();

		final queryParameters = <String, String> {
			'_embed' : 'accommodation,accommodation_type,services,rate'
		};

		var queryEndpoint = '$_queryEndpoint/${bookingID.toString()}';

		final uri = super.getUriHttps( queryEndpoint, queryParameters);

		//print( Uri.decodeFull(uri.toString()) );
		final response = await http.get(
			uri,
			headers: headers,
		);

		//await Future.delayed(const Duration(milliseconds: 5000));

		if ( response.statusCode == HttpStatus.OK ) {

			return Booking.fromJson(jsonDecode(response.body));

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

	Future<Booking> wpUpdateBookingStatus( Booking booking, String newStatus ) async {

		var bookingID = booking.id;

		final headers = super.getHeaders();

		final queryEndpoint = '$_queryEndpoint/${bookingID.toString()}';

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

			Booking result = Booking.fromJson(jsonDecode(response.body));

			if ( result.status == newStatus ) {
				booking.status = newStatus;
			}

			return booking;

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

	Future<Booking> wpDeleteBooking( int bookingID ) async {

		final headers = super.getHeaders();

		final queryParameters = <String, String> {
			'_embed' : 'accommodation,accommodation_type,services,rate'
		};

		var queryEndpoint = '$_queryEndpoint/${bookingID.toString()}';

		final uri = super.getUriHttps( queryEndpoint, queryParameters);

		//print( Uri.decodeFull(uri.toString()) );
		final response = await http.delete(
			uri,
			headers: headers,
			body: jsonEncode(<String, bool>{
				'force': true,
			}),
		);

		if ( response.statusCode == HttpStatus.OK ) {

			return Booking.fromJson(jsonDecode(response.body));

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

}