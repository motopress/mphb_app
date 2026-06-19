import 'dart:io';

class ApiException implements Exception {
	final int? statusCode;
	final String message;

	ApiException(this.message, {this.statusCode});

	factory ApiException.fromStatusCode(int statusCode, [String? body]) {
		switch (statusCode) {
			case HttpStatus.unauthorized:
			case HttpStatus.forbidden:
				return ApiException(
					'API credentials are invalid or do not have access to this resource.',
					statusCode: statusCode,
				);
			case HttpStatus.notFound:
				return ApiException(
					'MotoPress Hotel Booking REST API was not found at this URL.',
					statusCode: statusCode,
				);
			case HttpStatus.internalServerError:
				return ApiException(
					'The website returned an internal server error.',
					statusCode: statusCode,
				);
			default:
				return ApiException(
					'Request failed with status: $statusCode.',
					statusCode: statusCode,
				);
		}
	}

	@override
	String toString() => message;
}
