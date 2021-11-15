import 'dart:core';
import 'dart:convert';
import 'package:mphb_app/local_storage.dart';

class BasicController {

	String getAuthority() {

		Uri uri = Uri.parse( LocalStorage().domain );

		return uri.authority;
	}

	/*
	 * https://booking.loc/wp-json/mphb/v1
	 * https://uglywebsites.org/booking-api/wp-json/mphb/v1
	 */
	String getPath( [ String pathSegment = '' ] ) {

		Uri uri = Uri.parse( LocalStorage().domain );
		String sitePath = uri.path;

		String finalPath = sitePath + '/' + pathSegment + '/';
		finalPath = finalPath.replaceAll( '//', '/' );

		return finalPath;
	}

	Uri getUriHttps( [ String pathSegment = '', Map<String, String>? queryParameters ] ) {

		Uri uriHttps = Uri.https(
			getAuthority(),
			getPath( pathSegment ),
			queryParameters
		);

		return uriHttps;
	}

	Map<String, String> getHeaders() {

		String username = LocalStorage().consumer_key;
		String password = LocalStorage().consumer_secret;
		String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

		final headers = <String, String>{
			'authorization': basicAuth,
			'Content-Type': 'application/json; charset=UTF-8',
		};

		return headers;
	}
}