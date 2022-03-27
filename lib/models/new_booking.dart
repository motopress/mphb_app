import 'package:flutter/material.dart';
import 'package:mphb_app/models/accommodation.dart';
import 'package:mphb_app/models/reserved_accommodation.dart';

class NewBooking extends Notification {

	String state = 'initial';

	static const String INITIAL = 'initial';
	static const String CHECKOUT = 'checkout';

	final List<Accommodation> accommodations = [];

	final List<Reserved_Accommodation> reserved_accommodations = [];

	String check_in_date = '';
	String check_out_date = '';

	NewBooking();

}
