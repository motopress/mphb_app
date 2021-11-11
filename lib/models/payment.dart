class Payment {

    final int id;
    final String status;
    final num amount;
    final String currency;

	Payment({
		required this.id,
		required this.status,
		required this.amount,
		required this.currency,
	});

	factory Payment.fromJson(Map<String, dynamic> json) {
		return Payment(
			id: json['id'] as int,
			status: json['status'] as String,
			amount: json['amount'] as num,
			currency: json['currency'] as String,
		);
	}

}
