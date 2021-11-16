class Service {

    final int id;
    final String title;
    final String description;
    final num price;
    final Map periodicity;
    final String repeatability;

	Service({
		required this.id,
		required this.title,
		required this.description,
		required this.price,
		required this.periodicity,
		required this.repeatability,
	});

	factory Service.fromJson(Map<String, dynamic> json) {
		return Payment(
			id: json['id'] as int,
			title: json['title'] as String,
			description: json['description'] as String,
			price: json['price'] as num,
			periodicity: json['periodicity'] as Map,
			repeatability: json['repeatability'] as String,
		);
	}

}
