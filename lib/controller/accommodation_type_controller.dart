import 'dart:convert';
import 'dart:io';
import 'package:mphb_app/controller/api_exception.dart';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/accommodation_type.dart';

class AccommodationTypeController extends BasicController{

	final String _queryEndpoint = '/accommodation_types';

	/*
	 * https://domain.com/wp-json/mphb/v1/accommodation_types/ID
	 */
	Future<Accommodation_Type> wpGetAccommodationType( int accommodationTypeID ) async {

		final queryParameters = <String, String> {
			'_embed' : 'services,rate'
		};

		var queryEndpoint = '$_queryEndpoint/${accommodationTypeID.toString()}';

		final response = await getRequest( queryEndpoint, queryParameters );

		if ( response.statusCode == HttpStatus.ok ) {

			return Accommodation_Type.fromJson(jsonDecode(response.body));

		} else {

			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}

	}

}
