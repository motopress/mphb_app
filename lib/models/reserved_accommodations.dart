import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/accommodation_type.dart';

class Reserved_Accommodations {

	static getAccommodationById( List accommodations, int id ) {
		for (var acc in accommodations) {
			if ( acc.id == id) {
				return acc;
			}
		}
		return null;
	}

	static getAccommodationTypeById( List accommodation_types, int id ) {
		for (var acc_type in accommodation_types) {
			if ( acc_type.id == id) {
				return acc_type;
			}
		}
		return null;
	}

	static fromJson(Map<String, dynamic> json) {

		var accommodations = [];
		var accommodation_types = [];

		if ( json['_embedded'] != null && json['_embedded']['accommodation'] != null ) {

			accommodations = json['_embedded']['accommodation'].cast<Map<String, dynamic>>().map<Accommodation>((json) => Accommodation.fromJson(json)).toList();
		}

		if ( json['_embedded'] != null && json['_embedded']['accommodation_type'] != null ) {

			accommodation_types = json['_embedded']['accommodation_type'].cast<Map<String, dynamic>>().map<Accommodation_Type>((json) => Accommodation_Type.fromJson(json)).toList();
		}

		var reserved_accommodations = json['reserved_accommodations'].cast<Map<String, dynamic>>().map<Reserved_Accommodation>((json) => Reserved_Accommodation.fromJson(json)).toList();

		for (var reserved_accommodation in reserved_accommodations) {

			var accommodationObject = getAccommodationById( accommodations, reserved_accommodation.accommodation );

			if ( accommodationObject != null ) {
				reserved_accommodation.accommodationObject = accommodationObject;
			}

			var accommodationTypeObject = getAccommodationTypeById( accommodation_types, reserved_accommodation.accommodation_type );

			if ( accommodationTypeObject != null ) {
				reserved_accommodation.accommodationTypeObject = accommodationTypeObject;
			}

		}

		return reserved_accommodations;

	}
	
}