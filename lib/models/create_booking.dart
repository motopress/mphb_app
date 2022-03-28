import 'package:flutter/material.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';
import 'package:mphb_app/models/customer.dart';

class Create_Booking extends Notification {

	String state = 'initial';

	static const String INITIAL = 'initial';
	static const String CHECKOUT = 'checkout';
	static const String COMPLETE = 'complete';

	final List<Accommodation> accommodations = [];

	List<Reserved_Accommodation> reserved_accommodations = [];

	Customer customer = Customer.empty();

	String check_in_date = '';
	String check_out_date = '';

	Create_Booking();

	void reset() {

		reserved_accommodations = [];
	}

}
