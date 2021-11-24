class Payment {

    final int id;
    String status;
    final num amount;
    final String currency;

	final String gateway_id; // ["manual", "test", "cash", "bank", "paypal", "2checkout", "stripe"]
	final String transaction_id;

	final String date_created;
	final String date_created_utc;
	final String date_modified;
	final String date_modified_utc;
	final String date_expiration;
	final String date_expiration_utc;

	final int booking_id;
	final String gateway_mode;

	final Map billing_info;

	Payment({
		required this.id,
		required this.status,
		required this.amount,
		required this.currency,

		required this.gateway_id,
		required this.transaction_id,

		required this.date_created,
		required this.date_created_utc,
		required this.date_modified,
		required this.date_modified_utc,
		required this.date_expiration,
		required this.date_expiration_utc,

		required this.booking_id,
		required this.gateway_mode,

		required this.billing_info,
	});

	factory Payment.fromJson(Map<String, dynamic> json) {
		return Payment(
			id: json['id'] as int,
			status: json['status'] as String,
			amount: json['amount'] as num,
			currency: json['currency'] as String,

			gateway_id: json.containsKey( 'gateway_id' ) ? json['gateway_id'] as String : '',
			transaction_id: json.containsKey( 'transaction_id' ) ? json['transaction_id'] as String : '',

			date_created: json.containsKey( 'date_created' ) ? json['date_created'] as String : '',
			date_created_utc: json.containsKey( 'date_created_utc' ) ? json['date_created_utc'] as String : '',
			date_modified: json.containsKey( 'date_modified' ) ? json['date_modified'] as String : '',
			date_modified_utc: json.containsKey( 'date_modified_utc' ) ? json['date_modified_utc'] as String : '',
			date_expiration: json.containsKey( 'date_expiration' ) ? json['date_expiration'] as String : '',
			date_expiration_utc: json.containsKey( 'gateway_id' ) ? json['gateway_id'] as String : '',
			booking_id: json.containsKey( 'booking_id' ) ? json['booking_id'] as int : 0,
			gateway_mode: json.containsKey( 'gateway_mode' ) ? json['gateway_mode'] as String : '',
			billing_info: json.containsKey( 'billing_info' ) ? json['billing_info'] as Map : {},

		);
	}

}


