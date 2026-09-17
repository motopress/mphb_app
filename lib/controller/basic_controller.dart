import 'dart:core';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mphb_app/controller/api_exception.dart';
import 'package:mphb_app/local_storage.dart';

class BasicController {

	static const Duration timeout = Duration(seconds: 20);

	final http.Client client;
	final String? domain;
	final String? consumerKey;
	final String? consumerSecret;

	BasicController({
		http.Client? client,
		this.domain,
		this.consumerKey,
		this.consumerSecret,
	}) : client = client ?? http.Client();

	String getAuthority() {

		Uri uri = Uri.parse( domain ?? LocalStorage().domain );

		return uri.authority;
	}

	/*
	 * https://domain.com/wp-json/mphb/v1
	 */
	String getPath( [ String pathSegment = '' ] ) {

		Uri uri = Uri.parse( domain ?? LocalStorage().domain );
		String sitePath = uri.path;

		String finalPath = sitePath + '/' + pathSegment + '/';
		finalPath = finalPath.replaceAll( '//', '/' );

		return finalPath;
	}

	Uri getUriHttps( [ String pathSegment = '', Map<String, dynamic>? queryParameters ] ) {

		Uri uriHttps = Uri.https(
			getAuthority(),
			getPath( pathSegment ),
			queryParameters
		);

		return uriHttps;
	}

	Map<String, String> getHeaders() {

		String username = consumerKey ?? LocalStorage().consumer_key;
		String password = consumerSecret ?? LocalStorage().consumer_secret;
		String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

		final headers = <String, String>{
			'authorization': basicAuth,
			'Content-Type': 'application/json; charset=UTF-8',
		};

		return headers;
	}

	Future<http.Response> getRequest(
		String pathSegment, [
		Map<String, dynamic>? queryParameters,
	]) {
		return _send(() {
			return client.get(
				getUriHttps(pathSegment, queryParameters),
				headers: getHeaders(),
			);
		});
	}

	Future<http.Response> postRequest(
		String pathSegment, [
		Object? body,
		Map<String, dynamic>? queryParameters,
	]) {
		return _send(() {
			return client.post(
				getUriHttps(pathSegment, queryParameters),
				headers: getHeaders(),
				body: body,
			);
		});
	}

	Future<http.Response> deleteRequest(
		String pathSegment, [
		Object? body,
		Map<String, dynamic>? queryParameters,
	]) {
		return _send(() {
			return client.delete(
				getUriHttps(pathSegment, queryParameters),
				headers: getHeaders(),
				body: body,
			);
		});
	}

	Future<http.Response> _send(Future<http.Response> Function() request) async {
		try {
			return await request().timeout(timeout);
		} on TimeoutException {
			throw ApiException('The request timed out. Check your website connection and try again.');
		} on SocketException {
			throw ApiException('Could not connect to the website. Check the domain and network connection.');
		} on FormatException {
			throw ApiException('The API URL is not valid.');
		} on HandshakeException {
			throw ApiException('Could not establish a secure connection to the website.');
		}
	}

	static String normalizeDomain(String value) {
		String domain = value.trim();

		while (domain.endsWith('/')) {
			domain = domain.substring(0, domain.length - 1);
		}

		if (domain.endsWith('/wp-json/mphb/v1')) {
			return domain;
		}

		return domain + '/wp-json/mphb/v1';
	}

	static Future<void> validateCredentials({
		required String domain,
		required String consumerKey,
		required String consumerSecret,
	}) async {
		final controller = BasicController(
			domain: normalizeDomain(domain),
			consumerKey: consumerKey.trim(),
			consumerSecret: consumerSecret.trim(),
		);

		final response = await controller.getRequest('/bookings', {
			'per_page': '1',
			'offset': '0',
		});

		if (response.statusCode != HttpStatus.ok) {
			throw ApiException.fromStatusCode(response.statusCode, response.body);
		}
	}
}
