import 'package:mphb_app/models/reserved_service.dart';

class Reserved_Accommodation {

	final int accommodation;
	final int accommodation_type;
	final int rate;
	int adults;
	int children;
	String guest_name;
	final List<Reserved_Service> services;
	final List accommodation_price_per_days;
	final List fees;
	final Map taxes;
	final int discount;

	Reserved_Accommodation({
		required this.accommodation,
		required this.accommodation_type,
		required this.rate,
		required this.adults,
		required this.children,
		required this.guest_name,
		required this.services,
		required this.accommodation_price_per_days,
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
			guest_name: json.containsKey( 'guest_name' ) ? json['guest_name'] : '',
			services: json['services'].cast<Map<String, dynamic>>().
				map<Reserved_Service>((json) => Reserved_Service.fromJson(json)).toList(),
			accommodation_price_per_days: json['accommodation_price_per_days'],
			fees: json['fees'],
			taxes: json['taxes'],
			discount: json['discount'],
		);
	}

}