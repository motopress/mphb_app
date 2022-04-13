import 'package:mphb_app/models/rate.dart';
import 'package:mphb_app/models/payment.dart';
import 'package:mphb_app/models/service.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/accommodation_type.dart';

class BookingEmbeded {

	final List<Payment>? payments;
	final List<Accommodation>? accommodations;
	final List<Accommodation_Type>? accommodation_types;
	final List<Service>? services;
	final List<Rate>? rates;

	BookingEmbeded({
		required this.payments,
		required this.accommodations,
		required this.accommodation_types,
		required this.services,
		required this.rates,
	});

	factory BookingEmbeded.fromJson(Map<String, dynamic> json) {

		return BookingEmbeded(

			payments: json.containsKey( 'payments' ) ?
				json['payments'].cast<Map<String, dynamic>>().
					map<Payment>((json) => Payment.fromJson(json)).toList() : null,

			accommodations: json.containsKey( 'accommodation' ) ?
				json['accommodation'].cast<Map<String, dynamic>>().
					map<Accommodation>((json) => Accommodation.fromJson(json)).toList() : null,


			accommodation_types: json.containsKey( 'accommodation_type' ) ?
				json['accommodation_type'].cast<Map<String, dynamic>>().
					map<Accommodation_Type>((json) => Accommodation_Type.fromJson(json)).toList() : null,

			services: json.containsKey( 'services' ) ?
				json['services'].cast<Map<String, dynamic>>().
					map<Service>((json) => Service.fromJson(json)).toList() : null,

			rates: json.containsKey( 'rate' ) ?
				json['rate'].cast<Map<String, dynamic>>().
					map<Rate>((json) => Rate.fromJson(json)).toList() : null,
		);
	}

}
