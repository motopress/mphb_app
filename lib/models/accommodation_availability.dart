import 'package:mphb_app/models/accommodation.dart';

class Accommodation_Availability {

	final int accommodation_type;
	final String title;
	final num base_price;
	final List<Accommodation> accommodations;

	Accommodation_Availability({
		required this.accommodation_type,
		required this.title,
		required this.base_price,
		required this.accommodations,
	});


	factory Accommodation_Availability.fromJson(Map<String, dynamic> json) {

		// fix to add accommodation_type_id to each available accommodation
		for (var accommodation in json['accommodations']) {
			accommodation['accommodation_type_id'] = json['accommodation_type'];
		}

		return Accommodation_Availability(

			accommodation_type: json['accommodation_type'],
			title: json['title'],
			base_price: json['base_price'],
			accommodations: json['accommodations'].cast<Map<String, dynamic>>().map<Accommodation>(
				(json) => Accommodation.fromJson(json)).toList(),
		);
	}

}