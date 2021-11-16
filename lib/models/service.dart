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
		return Service(
			id: json['id'],
			title: json['title'],
			description: json['description'],
			price: json['price'],
			periodicity: json['periodicity'],
			repeatability: json['repeatability'],
		);
	}

}
