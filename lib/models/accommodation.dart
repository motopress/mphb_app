class Accommodation {

	final int id;
	final String status;
	final int accommodation_type_id;
	final String title;
	final String excerpt;

	Accommodation({
		required this.id,
		required this.status,
		required this.accommodation_type_id,
		required this.title,
		required this.excerpt,
	});

	factory Accommodation.fromJson(Map<String, dynamic> json) {

		return Accommodation(

			id: json.containsKey('id') ? json['id'] : 0,
			status: json.containsKey('status') ? json['status'] : '',
			accommodation_type_id: json.containsKey('accommodation_type_id') ?
										json['accommodation_type_id'] : 0,
			title: json.containsKey('title') ? json['title'] : '',
			excerpt: json.containsKey('excerpt') ? json['excerpt'] : '',
		);
	}

}