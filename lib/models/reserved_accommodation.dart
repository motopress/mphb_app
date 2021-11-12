import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/accommodation_type.dart';

class Reserved_Accommodation {

	final int accommodation;
	final int accommodation_type;
	final int rate;
	final int adults;
	final int children;
	final List services;
	//final List accommodation_price_per_days;
	final List fees;
	final Map taxes;
	final int discount;

	late Accommodation accommodationObject;
	late Accommodation_Type accommodationTypeObject;

	Reserved_Accommodation({
		required this.accommodation,
		required this.accommodation_type,
		required this.rate,
		required this.adults,
		required this.children,
		required this.services,
		//required this.accommodation_price_per_days,
		required this.fees,
		required this.taxes,
		required this.discount,
	});


	factory Reserved_Accommodation.fromJson(Map<String, dynamic> json) {
		return Reserved_Accommodation(
			accommodation: json['accommodation'],
			accommodation_type: json['accommodation_type'],
			rate: json['rate'],
			adults: json['adults'],
			children: json['children'],
			services: json['services'],
			//accommodation_price_per_days: json['accommodation_price_per_days'],
			fees: json['fees'],
			taxes: json['taxes'],
			discount: json['discount'],
		);
	}

}