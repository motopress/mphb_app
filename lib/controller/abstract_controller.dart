import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

//TODO
class AbstractController {


	Future<List> get() async {

		//https://booking.loc/wp-json/mphb/v1/bookings?consumer_key=ck_1d9a5f63a7d95d69db24ea6d2a1a883cace7a127&consumer_secret=cs_993ee46f420b9472bc4b98aed6b2b1ca5e92b717
		//https://uglywebsites.org/booking-api/wp-json/mphb/v1/bookings?consumer_key=ck_09c4163541fb26930cf9531ba1601f711f5c1ab9&consumer_secret=cs_47fd90af2ca6ec49dcb9b5ad73766cd6545c25a8

		SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

		final queryDomain = sharedPreferences.getString('domain') ?? '';
		//final queryDomain = 'uglywebsites.org';

		final queryEndpoint = '/booking-api/wp-json/mphb/v1/bookings';

		final queryParameters = <String, String> {
			//'consumer_key': 'ck_09c4163541fb26930cf9531ba1601f711f5c1ab9',
			'consumer_key': sharedPreferences.getString('consumer_key') ?? '',
			//'consumer_secret': 'cs_47fd90af2ca6ec49dcb9b5ad73766cd6545c25a8'
			'consumer_secret': sharedPreferences.getString('consumer_secret') ?? '',
		};

		final uri = Uri.https(queryDomain, queryEndpoint, queryParameters);
		//print( uri.toString() );

		final response = await http.get( uri );

		if ( response.statusCode == HttpStatus.OK ) {

			return jsonDecode( response.body );

		} else {

			throw Exception('Request failed with status: ${response.statusCode}.');
		}

	}
}