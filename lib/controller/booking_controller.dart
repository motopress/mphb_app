import 'dart:convert';
import 'dart:io';
import 'package:mphb_app/controller/api_exception.dart';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/booking.dart';

class BookingController extends BasicController{

	final String _queryEndpoint = '/bookings';

	/*
	 * https://domain.com/wp-json/mphb/v1/bookings/ID
	 */
	Future<Booking> wpGetBooking( int bookingID ) async {

		final queryParameters = <String, String> {
			'_embed' : 'accommodation,accommodation_type,services,rate'
		};

		var queryEndpoint = '$_queryEndpoint/${bookingID.toString()}';

		final response = await getRequest( queryEndpoint, queryParameters );

		if ( response.statusCode == HttpStatus.ok ) {

			return Booking.fromJson(jsonDecode(response.body));

		} else {

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}

	Future<Booking> wpUpdateBookingStatus( Booking booking, String newStatus ) async {

		var bookingID = booking.id;

		final queryEndpoint = '$_queryEndpoint/${bookingID.toString()}';

		final response = await postRequest(
			queryEndpoint,
			jsonEncode(<String, String>{
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

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}

	Future<Booking> wpDeleteBooking( int bookingID ) async {

		final queryParameters = <String, String> {
			'_embed' : 'accommodation,accommodation_type,services,rate'
		};

		var queryEndpoint = '$_queryEndpoint/${bookingID.toString()}';

		final response = await deleteRequest(
			queryEndpoint,
			jsonEncode(<String, bool>{
				'force': true,
			}),
			queryParameters,
		);

		if ( response.statusCode == HttpStatus.ok ) {

			return Booking.fromJson(jsonDecode(response.body));

		} else {

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}

}
