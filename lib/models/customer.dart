class Customer {

    String first_name;
    String last_name;
    String email;
    String phone;
    String country;
    String state;
    String city;
    String zip;
    String address1;

	Customer({
		required this.email,
		required this.first_name,
		required this.last_name,
		required this.phone,
		required this.country,
		required this.state,
		required this.city,
		required this.zip,
		required this.address1,
	});

	factory Customer.fromJson(Map<String, dynamic> json) {
		return Customer(
			first_name: json['first_name'] as String,
			last_name: json['last_name'] as String,
			email: json['email'] as String,
			phone: json['phone'] as String,
			country: json['country'] as String,
			state: json['state'] as String,
			city: json['city'] as String,
			zip: json['zip'] as String,
			address1: json['address1'] as String,
		);
	}

	Customer.empty() :
		email = '',
		first_name = '',
		last_name = '',
		phone = '',
		country = '',
		state = '',
		city = '',
		zip = '',
		address1 = '';

	bool isEmpty() {
		return(
			email == '' &&
			first_name == '' &&
			last_name == '' &&
			phone == '' &&
			country == '' &&
			state == '' &&
			city == '' &&
			zip == '' &&
			address1 == ''
		);
	}

}
