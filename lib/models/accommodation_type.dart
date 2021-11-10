class Accommodation_Type {

	final int id;
	final String title;
	final String description;
	final String excerpt;

	final int adults;
	final int children;
	//final int total_capacity;
	final String bed_type;
	final int size;
	final String view;

	final List services;
	final List categories;
	final List tags;
	final List amenities;
	final List attributes;
	final List images;

	Accommodation_Type({
		required this.id,
		required this.title,
		required this.description,
		required this.excerpt,
		required this.adults,
		required this.children,
		//required this.total_capacity,
		required this.bed_type,
		required this.size,
		required this.view,
		required this.services,
		required this.categories,
		required this.tags,
		required this.amenities,
		required this.attributes,
		required this.images,
	});


	factory Accommodation_Type.fromJson(Map<String, dynamic> json) {
		return Accommodation_Type(
			id: json['id'],
			title: json['title'],
			description: json['description'],
			excerpt: json['excerpt'],
			adults: json['adults'],
			children: json['children'],
			//total_capacity: int.tryParse( json['total_capacity'] ) ?? json['total_capacity'],
			bed_type: json['bed_type'],
			size: json['size'],
			view: json['view'],
			services: json['services'],
			categories: json['categories'],
			tags: json['tags'],
			amenities: json['amenities'],
			attributes: json['attributes'],
			images: json['images'],
		);
	}

}