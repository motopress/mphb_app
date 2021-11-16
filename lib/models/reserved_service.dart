class Reserved_Service {

	final int id;
	final int? quantity;
	final int? adults;
	final num price;

	Reserved_Service({
		required this.id,
		required this.quantity,
		required this.adults,
		required this.price,
	});


	factory Reserved_Service.fromJson(Map<String, dynamic> json) {
		return Reserved_Service(
			id: json['id'] as int,
			quantity: json.containsKey( 'quantity' ) ? json['quantity'] : null,
			adults: json.containsKey( 'adults' ) ? json['adults'] : null,
			price: json['price'] as num,
		);
	}

}