import 'package:flutter/material.dart';

class NewBooking extends Notification {

	String state = 'initial';

	static const String INITIAL = 'initial';
	static const String CHECKOUT = 'checkout';

	final List accommodations = [];

	String check_in_date = '';
	String check_out_date = '';

	NewBooking();

}
