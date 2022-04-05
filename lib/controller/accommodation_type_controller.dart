import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:mphb_app/controller/basic_controller.dart';
import 'package:mphb_app/models/accommodation_type.dart';

class AccommodationTypeController extends BasicController{

	final String _queryEndpoint = '/accommodation_types';

	/*
	 * https://domain.com/wp-json/mphb/v1/accommodation_types/ID
	 */
	Future<Accommodation_Type> wpGetAccommodationType( int accommodationTypeID ) async {

		final headers = super.getHeaders();

		final queryParameters = <String, String> {
			'_embed' : 'services,rate'
		};

		var queryEndpoint = '$_queryEndpoint/${accommodationTypeID.toString()}';

		final uri = super.getUriHttps( queryEndpoint, queryParameters);

		print( Uri.decodeFull(uri.toString()) );
		final response = await http.get(
			uri,
			headers: headers,
		);

		if ( response.statusCode == HttpStatus.OK ) {

			return Accommodation_Type.fromJson(jsonDecode(response.body));

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}

}